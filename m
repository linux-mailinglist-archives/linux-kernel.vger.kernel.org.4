Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5CD6D3560
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDBDRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDBDR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:17:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35D1B7E0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 20:17:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x15so24291935pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680405446;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5rFwZN4arfT+quf2ScnUr6XHy1fT8u5eEhmQaaASlA=;
        b=UtJwdvLcUzjHvS4wnr5R9NIdmpRy6wBEEas5o3BT9o69hT5Vz08J0Zuf2ICuZD9XGG
         C5w0FvFlIKJYyQ1khXc2idyl4nDJpNL2DoxFyJH5saGIoyOr7OewMf1aCDzdN+iGeSx4
         qSaeYfjFQFmhgzZOrdkQtbU4RK/VJxaiY9Ch3UYq1v74Fu+IbGNMMAjkuPlt0y6hZ9+b
         v51xxp/pM2HcA5x/PHaLiqd1ryKNaiiqWZ4VeAXrpMYYykaBQ0N4whK64E8bz7Ec0dmH
         wcwh+nUVWttKWk1D7R+85oxMlbrqFLqnpn0nLSvAw852EkPidEIcGETuo7uXBHFspkIr
         U57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680405446;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5rFwZN4arfT+quf2ScnUr6XHy1fT8u5eEhmQaaASlA=;
        b=u183pnfk6oFgkKfXytQSTvs/ploz0BQCmdt4tMHkRMtTB7lgRTH/jGcs08RRrN6RIB
         ApZDqiu8heV64Bqu+fjU7SJq/38+PslJsAWZ6df1/CIywDFRbz2E9DysMk/YYSbxWY6t
         P52TjyUgCTzpzDNGgfQN7eBr3TPfWnceheSEwFythwVXKWRGniaqTb5b2VgV0szRojwU
         xVFwc/CYiMupZqjzhn8Ys1n+MOsFAeRVkay1pZAE7zraLKs0TUTcurKRBx+zXsGVeMCc
         PuR+jE0uhwuugiikWBhu0nXZQYZgySN3S6smjXetfObKW8Lok7QpI2i/h7JPK5XHmm5Z
         gbNg==
X-Gm-Message-State: AAQBX9cRSiayz9W1Izq6mt/mpLQZu0teMVWcgCq1dJDrszw4/xAHOk7P
        zt11J7l+k2PbIuKBX+/jpxM=
X-Google-Smtp-Source: AKy350YYP/el4R+46FhTkfdbpKa6uJ7uWQynmnEpS0NPC1S2v7kjvu2+wGLivgc7UCCGp6co5tmkaQ==
X-Received: by 2002:a17:903:1250:b0:1a2:55ca:6669 with SMTP id u16-20020a170903125000b001a255ca6669mr28198412plh.33.1680405446264;
        Sat, 01 Apr 2023 20:17:26 -0700 (PDT)
Received: from DESKTOPB5TBVBT ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id bd10-20020a170902830a00b001991f3d85acsm3989098plb.299.2023.04.01.20.17.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Apr 2023 20:17:25 -0700 (PDT)
From:   "Yohan Joung" <jyh429@gmail.com>
To:     "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc:     <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <oe-kbuild-all@lists.linux.dev>
References: <ZBzlJ36kO5KvxODB@google.com> <20230324130747.523-1-jyh429@gmail.com> <6db7be47-9455-c466-f99a-497f8fe8930a@kernel.org>
In-Reply-To: <6db7be47-9455-c466-f99a-497f8fe8930a@kernel.org>
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix align check for npo2
Date:   Sun, 2 Apr 2023 12:17:23 +0900
Message-ID: <004e01d96511$a65359b0$f2fa0d10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQF6XO6yHRdACLHpz3GwDztUEe2YOQJb5qXHAomEG4Svrj19UA==
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Chao Yu [mailto:chao@kernel.org]
> Sent: Saturday, April 1, 2023 10:49 AM
> To: Yohan Joung; jaegeuk@kernel.org
> Cc: lkp@intel.com; linux-kernel@vger.kernel.org; linux-f2fs-
> devel@lists.sourceforge.net; oe-kbuild-all@lists.linux.dev
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix align check for npo2
> 
> On 2023/3/24 21:07, Yohan Joung wrote:
> > Fix alignment check to be correct in npo2 as well
> >
> > Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> > ---
> >   fs/f2fs/segment.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> > 055e70e77aa2..f4a22a065277 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1842,6 +1842,7 @@ static int __f2fs_issue_discard_zone(struct
> f2fs_sb_info *sbi,
> >   	sector_t sector, nr_sects;
> >   	block_t lblkstart = blkstart;
> >   	int devi = 0;
> > +	u32 remainder = 0;
> >
> >   	if (f2fs_is_multi_device(sbi)) {
> >   		devi = f2fs_target_device_index(sbi, blkstart); @@ -1857,9
> +1858,9
> > @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
> >   	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
> >   		sector = SECTOR_FROM_BLOCK(blkstart);
> >   		nr_sects = SECTOR_FROM_BLOCK(blklen);
> > +		div_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);
> 
> Should use div64_u64_rem()? As both sector and return value of
> bdev_zone_sectors() are u64.
> 
> Thanks,
Upload based on your comments.
Thanks
> 
> >
> > -		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> > -				nr_sects != bdev_zone_sectors(bdev)) {
> > +		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
> >   			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted
> (block %x + %x)",
> >   				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
> >   				 blkstart, blklen);

