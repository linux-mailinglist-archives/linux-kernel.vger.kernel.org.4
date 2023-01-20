Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B4675FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjATV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:56:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BF40C8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:56:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so5167795pgh.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNJEGDFz1cjsLBt+NNryYCoKoOF/RVQ/lQuQsch//k=;
        b=L/BW+mAyEV3p14j1f2jtadpvlBWh5uXc0b8JmkSWBPtboKDozKkyIdrNb5y0a68WIK
         BT0FnCbCEEQVW/qEjmNYRjIw6oFT28MOzOeyDUDgFQPebxWe2Jo9R+QGGKqwXWtF8obQ
         zt8GBAMSMcoHN+A1d8jTxpJAU4JnVPNzgIKvoCBK5qKKWO0c8UjhWooce7Tbsnx+0ZZ4
         hsKXYoFxdcB8zEZg5m5DM4TVrRQOCsq+SjEr2hIVGpSzoJ8tIx3E4WZ4lvR6BZv2sRgT
         vKMxwtkCmyoAkUYRhrPoZYruWKWTqagBlU5WSO5thbfg4V78+IQgmrF8i3XJ4z3miOi9
         CMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGNJEGDFz1cjsLBt+NNryYCoKoOF/RVQ/lQuQsch//k=;
        b=E8bO0IVPPXPDJo3R1PmvL6JC2mwt2j1B1wXcwEBxI4r+9/EteksQeAwHB+Wst9tAeU
         KWjWWcTKunc9o0lt8koFKft10MFZPY8I5ZUKiSXU+1TRFkXmAZpB+Xu21m5VmrxR0/Na
         FPi7ULy3VoxYgS93pofEmGPUl5Rwk05j8d41iqq3+XLDbYdlx/6sTewzPHOJ0NC/EpMc
         6bYDJILMRiWeLNBE+CHSPh9A1j9shzG63fO4Dn5ZzfNqlTEtlUs5hJRQea65Mx0jSxfe
         lvT5BCxTvXio5KdzoLEAusbxPnhUI9yi/ZA64lP3zyM4o3nuc5stu79hekG0qZ8fEIF3
         NVQw==
X-Gm-Message-State: AFqh2koriwlQApLpR+IaDx0fc0BWy1yBo49KqW4eF6AK3Q52AxVqIDu8
        FqbB6I5wIFgnKrOJW7fZtISdzg==
X-Google-Smtp-Source: AMrXdXs3PJMrbzdU0Ub/KNe+utb/Ewp35P7/JaGtlrIPnr6lTuko3xWlKIVKkMFnFWf9sDokVATMOA==
X-Received: by 2002:a62:1901:0:b0:582:5b8e:533 with SMTP id 1-20020a621901000000b005825b8e0533mr36698547pfz.16.1674251772955;
        Fri, 20 Jan 2023 13:56:12 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:bab1:9588:b389:30ad])
        by smtp.gmail.com with ESMTPSA id x10-20020aa79aca000000b0058a0e61136asm20535178pfp.66.2023.01.20.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:56:12 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:56:07 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        tim.gardner@canonical.com, lkp@intel.com, re@w6rz.net,
        nathan@kernel.org
Subject: Re: [PATCH linux-next] jffs2: reduce stack usage in
 jffs2_build_xattr_subsystem()
Message-ID: <Y8sN9+0BvZfsEq1v@google.com>
References: <20170509203003.11986-1-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509203003.11986-1-fabf@skynet.be>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2017 at 10:30:03PM +0200, Fabian Frederick wrote:
> Use kcalloc() for allocation/flush of 128 pointers table to
> reduce stack usage.
> 
> Function now returns -ENOMEM or 0 on success.
> 
> stackusage
> Before:
> ./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     1208
> dynamic,bounded
> 
> After:
> ./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     192
> dynamic,bounded
> 
> Also update definition when CONFIG_JFFS2_FS_XATTR is not enabled
> 
> Tested with an MTD mount point and some user set/getfattr.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Hi David,
Any chance this patch can get picked up? It LGTM, and I see multiple
reports of this issue on lore:
https://lore.kernel.org/lkml/?q=jffs2_build_xattr_subsystem

Reported-by: Tim Gardner <tim.gardner@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Ron Economos <re@w6rz.net>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/jffs2/build.c |  5 ++++-
>  fs/jffs2/xattr.c | 14 ++++++++++----
>  fs/jffs2/xattr.h |  4 ++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
> index b288c8a..f88e0bf 100644
> --- a/fs/jffs2/build.c
> +++ b/fs/jffs2/build.c
> @@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
>  		ic->scan_dents = NULL;
>  		cond_resched();
>  	}
> -	jffs2_build_xattr_subsystem(c);
> +	ret = jffs2_build_xattr_subsystem(c);
> +	if (ret)
> +		goto exit;
> +
>  	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
>  
>  	dbg_fsbuild("FS build complete\n");
> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index da3e185..95c0496 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
>  }
>  
>  #define XREF_TMPHASH_SIZE	(128)
> -void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
> +int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>  {
>  	struct jffs2_xattr_ref *ref, *_ref;
> -	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
> +	struct jffs2_xattr_ref **xref_tmphash;
>  	struct jffs2_xattr_datum *xd, *_xd;
>  	struct jffs2_inode_cache *ic;
>  	struct jffs2_raw_node_ref *raw;
> @@ -784,9 +784,13 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>  
>  	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
>  
> +
> +	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
> +			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
> +	if (!xref_tmphash)
> +		return -ENOMEM;
> +
>  	/* Phase.1 : Merge same xref */
> -	for (i=0; i < XREF_TMPHASH_SIZE; i++)
> -		xref_tmphash[i] = NULL;
>  	for (ref=c->xref_temp; ref; ref=_ref) {
>  		struct jffs2_xattr_ref *tmp;
>  
> @@ -884,6 +888,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>  		     "%u of xref (%u dead, %u orphan) found.\n",
>  		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
>  		     xref_count, xref_dead_count, xref_orphan_count);
> +	kfree(xref_tmphash);
> +	return 0;
>  }
>  
>  struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
> diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
> index 720007b..1b5030a 100644
> --- a/fs/jffs2/xattr.h
> +++ b/fs/jffs2/xattr.h
> @@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
>  #ifdef CONFIG_JFFS2_FS_XATTR
>  
>  extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
> -extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
> +extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
>  extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
>  
>  extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
> @@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
>  #else
>  
>  #define jffs2_init_xattr_subsystem(c)
> -#define jffs2_build_xattr_subsystem(c)
> +#define jffs2_build_xattr_subsystem(c)		(0)
>  #define jffs2_clear_xattr_subsystem(c)
>  
>  #define jffs2_xattr_do_crccheck_inode(c, ic)
> -- 
> 2.9.3
> 
