Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6075A6DB5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDGVb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGVbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:31:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA2BBA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:31:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680903112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+G7sS7XwDXRDKEcI+dA9jyAeEwvY7TO946zPY02gSY=;
        b=u/V5SGxNOmpCHeE1MX4M/SzhX+uikBJyvic43RqUXOoH8ohfiVPS3Icl5GCxx6s3NNcFta
        Rt7JTAca7KlAya7qdCIxzmk0f05sSejzpZyESF+WJ5WqwYONQX0G0z+mYvKEgn1xmAeCju
        rFYl/4lDOHg+euYsiEfNfFJyJuZjG/xzIm1qQFGFKtRkCaJie11bL+JOuU4XE+A/jfafc3
        U1OfA0ZTk4g4sTyTCaTPIPiSDt6XfXIj7K5tHp2SRVdqWDDVtrPU+OzV3F2SR803bsO/NC
        suCJ+c6CEAMNoxJhYANcu+OrkeojGY+apS+/YJsliAX37CDO/2OKm83luUoqhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680903112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+G7sS7XwDXRDKEcI+dA9jyAeEwvY7TO946zPY02gSY=;
        b=ZM8kvbj3YVZT3iIFyGQsyT9p1CAaybqOQvyj8dFWZSzxdO8WoIysEm1VtssXSBjBBxKEyL
        QKNoMRqw7mzTj0BA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
In-Reply-To: <CAHk-=whA+n+9_AzzPaoxMDgh9YHvif+LC0ZhFuUg-qED=oynHQ@mail.gmail.com>
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
 <dd933c50df674dd69f6e630a53cfee77@AcuMS.aculab.com>
 <CAHk-=whA+n+9_AzzPaoxMDgh9YHvif+LC0ZhFuUg-qED=oynHQ@mail.gmail.com>
Date:   Fri, 07 Apr 2023 23:31:51 +0200
Message-ID: <878rf3tm48.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus!

On Fri, Apr 07 2023 at 12:26, Linus Torvalds wrote:
> On Fri, Apr 7, 2023 at 5:25=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>>
>> I think it depends on why the driver is asking for more
>> interrupts than the hardware supports.
>> Potentially the driver could do:
>>         for (i =3D 0; i < 8; i++)
>>                 msix_tbl[i].entry =3D 2 * i;
>> if the hardware supports 8 interrupts perhaps it
>> should return 4?
>
> Hmm.
>
> Something like this might get that case right too. Again - entirely
> untested, but looks superficially sane to me.
>
> It just returns how many of the msix_entry[] entries can be used (or
> negative for error). So then the (only) caller can just say "is that
> still enough for what we required". Seems reasonable, and would get
> that non-contiguous case right, I think.

Probably, but the point is that a driver should not hand in invalid data
in the first place. Even if the hardware does not provide enough space
for the requested maximum range then the handed in entries array should
not contain any invalid data, right?

Ergo the hwsize check in that function is bogus. No idea what I was
thinking there.

So the simple and IMO correct solution is to drop that hwsize check from
the validation function and validate up to the

The point is that for a range allocation with and entries array, _all_
entries up to max_vec must be correct independent of the actual hardware
size.

So the fix is simply removing the hardware size check from the
validation function. The hardware size checking happens afterwards
anyway.

Let me write up a proper changelog for that.

Thanks,

	tglx
---
 drivers/pci/msi/msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -750,8 +750,7 @@ static int msix_capability_init(struct p
	return ret;
 }

-static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_ent=
ry *entries,
-				      int nvec, int hwsize)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_ent=
ry *entries, int nvev)
 {
	bool nogap;
	int i, j;
@@ -762,10 +761,6 @@ static bool pci_msix_validate_entries(st
	nogap =3D pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGA=
CY);

	for (i =3D 0; i < nvec; i++) {
-		/* Entry within hardware limit? */
-		if (entries[i].entry >=3D hwsize)
-			return false;
-
		/* Check for duplicate entries */
		for (j =3D i + 1; j < nvec; j++) {
			if (entries[i].entry =3D=3D entries[j].entry)
@@ -805,7 +800,7 @@ int __pci_enable_msix_range(struct pci_d
	if (hwsize < 0)
		return hwsize;

-	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
+	if (!pci_msix_validate_entries(dev, entries, nvec))
		return -EINVAL;

	if (hwsize < nvec) {
