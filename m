Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322976D82C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbjDEP53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbjDEP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A05A1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97DA763F21
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2973C433EF;
        Wed,  5 Apr 2023 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680710246;
        bh=Wf6yC9V68CXdRJzxScFYl/wiaFwWP6I9Y1bxabKUuHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ+CMtDmZoUKsWeow3qAnsJUNrmfxXeE/P8Z67h4jblTblFlW+qlhgNVXnzKqKx7C
         9AllNbLRwsyn93A/ZX1ke8VF1ScwhHG86FgDaeBXLAX7cjByu/Cv8JPvxe6tEKTGix
         2yuQ8J+Q/rtMZorSiAd37dWvZwjFssvALpsz30PtIFiDUNHiN6aRD7utITV/uQtglP
         bsj1F6BwfqhZkIAx+FBBT+Xyj7mbinxYim9bIeiztnQgh18umEU1mR1PXeukkX3OUK
         mplODYW1DhLoAv4WDqYiQVSvOyUbWYgzrquuETwxmBKlESEbm/x4BASP5JsG8k/UO+
         BfsIculAJUBXg==
Date:   Wed, 5 Apr 2023 08:57:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: convert to use sysfs_emit
Message-ID: <ZC2aZJFIJZclTkkK@google.com>
References: <20230331113305.77217-1-frank.li@vivo.com>
 <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Chao Yu wrote:
> On 2023/3/31 19:33, Yangtao Li wrote:
> > Let's use sysfs_emit.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   fs/f2fs/sysfs.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 9ddc6ee19433..2c0b2cb05a3a 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >   	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> >   		struct ckpt_req_control *cprc = &sbi->cprc_info;
> > -		int len = 0;
> >   		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
> >   		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
> > -		if (class == IOPRIO_CLASS_RT)
> > -			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
> > -		else if (class == IOPRIO_CLASS_BE)
> > -			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
> > -		else
> > +		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
> >   			return -EINVAL;
> > -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
> > -		return len;
> > +		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);
> 
> Exceed 80 columns.

Fixed and applied.

> 
> Thanks,
> 
> >   	}
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
