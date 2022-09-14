Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC65B81AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiINGuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiINGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:50:07 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 23:50:03 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358347B93
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:50:03 -0700 (PDT)
Received: (qmail 13895 invoked from network); 14 Sep 2022 06:43:39 -0000
Received: from p200300cf07104d0076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:710:4d00:76d4:35ff:feb7:be92]:42942 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <zeming@nfschina.com>; Wed, 14 Sep 2022 08:43:39 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Li zeming <zeming@nfschina.com>,
        James.Bottomley@hansenpartnership.com, Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Increase the usage check of kmalloc allocated object a
Date:   Wed, 14 Sep 2022 08:43:13 +0200
Message-ID: <1668528.WaZXzWfjLs@eto.sf-tec.de>
In-Reply-To: <f346579c-e6a3-d2bb-1c21-d914aeb9a77d@gmx.de>
References: <20220914060428.4039-1-zeming@nfschina.com> <f346579c-e6a3-d2bb-1c21-d914aeb9a77d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4636421.EM0ToxPilq"; micalg="pgp-sha1"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4636421.EM0ToxPilq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Sep 2022 08:43:13 +0200
Message-ID: <1668528.WaZXzWfjLs@eto.sf-tec.de>
In-Reply-To: <f346579c-e6a3-d2bb-1c21-d914aeb9a77d@gmx.de>
MIME-Version: 1.0

Am Mittwoch, 14. September 2022, 08:18:19 CEST schrieb Helge Deller:
> On 9/14/22 08:04, Li zeming wrote:
> > In the case of memory allocation failure, no alignment operation is
> > required.
> > 
> > Signed-off-by: Li zeming <zeming@nfschina.com>
> > ---
> > 
> >   drivers/parisc/iosapic.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
> > index 3a8c98615634..33de438916d3 100644
> > --- a/drivers/parisc/iosapic.c
> > +++ b/drivers/parisc/iosapic.c
> > @@ -229,7 +229,9 @@ static struct irt_entry *iosapic_alloc_irt(int
> > num_entries)> 
> >   	 * 4-byte alignment on 32-bit kernels
> >   	 */
> >   	
> >   	a = (unsigned long)kmalloc(sizeof(struct irt_entry) * num_entries 
+ 8,
> >   	GFP_KERNEL);> 
> > -	a = (a + 7UL) & ~7UL;
> > +	if (a)
> > +		a = (a + 7UL) & ~7UL;
> > +
> 
> As you said, the adjustment isn't required, but it's still ok.
> So I think the additional "if" isn't necessary and so I'm not
> applying your patch.
> 
> Anyway, thanks for your help to try to improve the code!

I was about to say the same, but from looking at the code I don't think what 
is in there is correct either. The comment seems outdated, because 
__assume_kmalloc_alignment, which is __alignof__(unsigned long long). This 
code is untouched for the entire git history, so maybe we can just change the 
whole thing to

  return kcalloc(num_entries, sizeof(struct irt_entry))

now?

And these functions end up propagating an allocation error in this file and it 
will never reach kernel/setup.c, which seems bad. But I guess the only point 
where this really can go wrong if the PDC returns an absurdly large number of 
entries.

Eike
--nextPart4636421.EM0ToxPilq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYyF4AQAKCRBcpIk+abn8
TmMrAJ9tzLMJcya2N1PiOENzBvcMciMbwgCbByM94VXUSX7X4mawEGbzvvELeEg=
=Lbg1
-----END PGP SIGNATURE-----

--nextPart4636421.EM0ToxPilq--



