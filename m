Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434673ACC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjFVWzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFVWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:55:52 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797D268E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:54:58 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7623bd6933eso59247385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687474497; x=1690066497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxwe4U/gR1Uh57JJuryfGWiZL12pc/O1PR213FsnSzs=;
        b=hSwmNvpRBq2zj34iM0jQw6Z8mK5vjR8IMexGxVAfLrqYymmg8adr8l2JicQpiux31n
         lQPsDO8rgKVNzAQ0fQYdmV59zzRfZ32kTw1qgcOK1rw/KgNU3V2mXmwgDAtIihAiqhst
         2LyvfYP1t21VlLdofTCsUoynNK0aP20ooVMUy2OyR/T0RJF1OcT6+KKYzGIf6QKEsDsO
         ejAHMRmB/3dTYgvzCd+vgZ2yv0YWamh0kP/MF4g6i1oHhY2NX9Dx0JSjFe1gnSgKD3XI
         6VZTW8+s2JWqxYAYGoajVMPAub1bJANh5bdClnpKhgd5vnyMtpbUI6NQkcMXqzibZVlV
         y/dQ==
X-Gm-Message-State: AC+VfDx7lQsge7td+7Z5BOEGOcRZJnONK+TMotrHPYmve3uS4jnMxY6J
        z86pvTGlxGAy3Rd5in7rqYpR
X-Google-Smtp-Source: ACHHUZ79bSHFD7FD+XGavRP6t/FT+fV0G63ZVlm9T0OEFJddU4uSU8havX2f8kv9D7oKLAm5A2IhIA==
X-Received: by 2002:ad4:5caf:0:b0:621:54d:23e1 with SMTP id q15-20020ad45caf000000b00621054d23e1mr29689752qvh.14.1687474497526;
        Thu, 22 Jun 2023 15:54:57 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id p18-20020a0ccb92000000b00621268e14efsm4352272qvk.55.2023.06.22.15.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:54:57 -0700 (PDT)
Date:   Thu, 22 Jun 2023 18:54:56 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     mpatocka@redhat.com, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] device-mapper: Check that target specs are
 sufficiently aligned
Message-ID: <ZJTRQP1XqlQAC2Xb@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-2-demi@invisiblethingslab.com>
 <ZJR2rGZw0Ddf3TFK@redhat.com>
 <ZJSmYgvwoSY6Gb4f@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJSmYgvwoSY6Gb4f@itl-email>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22 2023 at  3:51P -0400,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> On Thu, Jun 22, 2023 at 12:28:28PM -0400, Mike Snitzer wrote:
> > On Sat, Jun 03 2023 at 10:52P -0400,
> > Demi Marie Obenour <demi@invisiblethingslab.com> wrote:
> > 
> > > Otherwise subsequent code will dereference a misaligned
> > > `struct dm_target_spec *`, which is undefined behavior.
> > > 
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/md/dm-ioctl.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > > index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
> > > --- a/drivers/md/dm-ioctl.c
> > > +++ b/drivers/md/dm-ioctl.c
> > > @@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
> > >  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
> > >  		       struct dm_target_spec **spec, char **target_params)
> > >  {
> > > +	static_assert(_Alignof(struct dm_target_spec) <= 8,
> > > +		      "struct dm_target_spec has excessive alignment requirements");
> > 
> > Really not sure what you mean by "has excessive alignment requirements"...
> 
> This patch checks that struct dm_target_spec is 8-byte aligned.  That is
> okay if its alignment is 8 or less, but not if is 16 or more, so I added
> a static assert to check that struct dm_target_spec indeed requires at
> most 8-byte alignment.  That said, “excessive alignment requirements” is
> (as shown by you having to ask this question) a bad error message.
> Would “must not require more than 8-byte alignment” be better?

Yes, that's better, I've updated it to use that.
 
> > > +	if (next % 8) {
> > > +		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >  	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
> > >  	*target_params = (char *) (*spec + 1);
> > >  
> > 
> > But this patch and patches 2 and 3 need more review. I'd like Mikulas to review.
> > 
> > I did pick up patches 4-6 for the upcoming 6.5 merge window.
> 
> Thanks!
> 
> > Note, please prefix with "dm ioctl" instead of "device-mapper".
> 
> Good to know, thanks!  I have several additional patches written that
> require patch 4.  Should I send patches 1 through 3 in the same series
> as well?

I did end up picking up patches 1-3 and rebased so they are in front
of your patches 4-6 like you intended.

But I agree with Mikulas, I'm not seeing the point in tagging any of
these for stable@.

All commits are currently at the tip of dm-6.5, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.5

Mike
