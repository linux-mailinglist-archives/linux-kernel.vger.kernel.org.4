Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8D632748
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiKUPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKUPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:05:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E43C8462;
        Mon, 21 Nov 2022 06:53:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE6811F8A3;
        Mon, 21 Nov 2022 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669042393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acoJFp5IMk6I2OGDsUSsh5rB6BjsYh+Mppy2CcuaTP8=;
        b=ubrkClbfap/2YkTdJFU9ntiZxgQnojhyjjSM/KnifRuhCEH9o1iQMcoo4gCRHJIV9sJZMZ
        OXn5+PHv7JJ3WdtzyjQKiPU81bhv+DHc8FQsBFEwV0BDJtagBJJK+b4XKEMmXRs9QRgpRJ
        PCNCz/WW7R2TGr7klkPJYAtFbYgelXk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86E2C1377F;
        Mon, 21 Nov 2022 14:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r41tH9mQe2NvKwAAMHmgww
        (envelope-from <mwilck@suse.com>); Mon, 21 Nov 2022 14:53:13 +0000
Message-ID: <41c39c52cadcaa6a34126662b953ef96177f5bba.camel@suse.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   Martin Wilck <mwilck@suse.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>
Date:   Mon, 21 Nov 2022 15:53:12 +0100
In-Reply-To: <yq1k046kwyv.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
         <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
         <4a1da181-8a54-d2f8-6d19-d9c1982ab044@suse.de>
         <yq1k046kwyv.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-07 at 21:50 -0500, Martin K. Petersen wrote:
>=20
> Hannes,
>=20
> I have been contemplating this for a bit.
>=20
> > > Has it been considered instead of introducing a blacklist flag to
> > > not
> > > use the reported VPD page size if the device reports that the VPD
> > > page size is zero? I am not aware of any VPD pages for which zero
> > > is
> > > a valid size.
>=20
> That would also be my preferred approach, I think. I haven't received
> any bug reports about devices returning short VPD pages since this
> change was introduced. So I think I'd prefer falling back to a
> (hopefully small) default if a device returns a 0 page length.
>=20
> Now, my question is which VPD pages are actually supported by this
> device and how large are they?

I've tried to obtain an answer to this question from IBM, but they
couldn't come up with a concrete number for the page length. Especially
for VDASD devices, it's difficult to say, because these virtual devices
just pass the INQUIRY down to the backing device.

How do we proceed? Could we simply fall back to a page length of 255
bytes (like before c92a6b5d6335) if the reported page length is zero?

Regards,
Martin W.

>=20
> > But pre-SPC drives will ignore the VPD bit in the inquiry size. And
> > these devices do not set an additional length in the inquiry data
>=20
> Can you elaborate a bit on your experience with older devices? I
> checked
> SCSI-2 (1991) and don't see any indication this would be valid
> behavior
> even back then.
>=20

