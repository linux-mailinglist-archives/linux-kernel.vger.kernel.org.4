Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD996F9231
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjEFNL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFNL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:11:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64161A1DF;
        Sat,  6 May 2023 06:11:21 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QD7B73fNNz18KKh;
        Sat,  6 May 2023 21:07:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 21:11:16 +0800
Subject: Re: [PATCH] jffs2: reduce stack usage in
 jffs2_build_xattr_subsystem()
To:     Christian Marangi <ansuelsmth@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Fabian Frederick <fabf@skynet.be>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Brauner <brauner@kernel.org>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Tim Gardner <tim.gardner@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ron Economos <re@w6rz.net>,
        Nathan Chancellor <nathan@kernel.org>, <stable@vger.kernel.org>
References: <20230506045612.16616-1-ansuelsmth@gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e6f4327a-83f0-22dc-e186-9012912b25d9@huawei.com>
Date:   Sat, 6 May 2023 21:11:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230506045612.16616-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/5/6 12:56, Christian Marangi Ð´µÀ:
> From: Fabian Frederick <fabf@skynet.be>
> 
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
> Many current target on OpenWRT also suffer from a compilation warning
> (that become an error with CONFIG_WERROR) with the following output:
> 
> fs/jffs2/xattr.c: In function 'jffs2_build_xattr_subsystem':
> fs/jffs2/xattr.c:887:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>    887 | }
>        | ^
> 
> Using dynamic allocation fix this compilation warning.
> 
> Fixes: c9f700f840bd ("[JFFS2][XATTR] using 'delete marker' for xdatum/xref deletion")
> Reported-by: Tim Gardner <tim.gardner@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>   fs/jffs2/build.c |  5 ++++-
>   fs/jffs2/xattr.c | 13 +++++++++----
>   fs/jffs2/xattr.h |  4 ++--
>   3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
> index 837cd55fd4c5..6ae9d6fefb86 100644
> --- a/fs/jffs2/build.c
> +++ b/fs/jffs2/build.c
> @@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
>   		ic->scan_dents = NULL;
>   		cond_resched();
>   	}
> -	jffs2_build_xattr_subsystem(c);
> +	ret = jffs2_build_xattr_subsystem(c);
> +	if (ret)
> +		goto exit;
> +
>   	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
>   
>   	dbg_fsbuild("FS build complete\n");
> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index aa4048a27f31..3b6bdc9a49e1 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
>   }
>   
>   #define XREF_TMPHASH_SIZE	(128)
> -void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
> +int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>   {
>   	struct jffs2_xattr_ref *ref, *_ref;
> -	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
> +	struct jffs2_xattr_ref **xref_tmphash;
>   	struct jffs2_xattr_datum *xd, *_xd;
>   	struct jffs2_inode_cache *ic;
>   	struct jffs2_raw_node_ref *raw;
> @@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>   
>   	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
>   
> +	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
> +			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
> +	if (!xref_tmphash)
> +		return -ENOMEM;
> +

I have made some fault injection tests, jffs2 works fine, this patch 
imports no memleak problems. It seems okay.

>   	/* Phase.1 : Merge same xref */
> -	for (i=0; i < XREF_TMPHASH_SIZE; i++)
> -		xref_tmphash[i] = NULL;
>   	for (ref=c->xref_temp; ref; ref=_ref) {
>   		struct jffs2_xattr_ref *tmp;
>   
> @@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
>   		     "%u of xref (%u dead, %u orphan) found.\n",
>   		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
>   		     xref_count, xref_dead_count, xref_orphan_count);
> +	kfree(xref_tmphash);
> +	return 0;
>   }
>   
>   struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
> diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
> index 720007b2fd65..1b5030a3349d 100644
> --- a/fs/jffs2/xattr.h
> +++ b/fs/jffs2/xattr.h
> @@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
>   #ifdef CONFIG_JFFS2_FS_XATTR
>   
>   extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
> -extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
> +extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
>   extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
>   
>   extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
> @@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
>   #else
>   
>   #define jffs2_init_xattr_subsystem(c)
> -#define jffs2_build_xattr_subsystem(c)
> +#define jffs2_build_xattr_subsystem(c)		(0)
>   #define jffs2_clear_xattr_subsystem(c)
>   
>   #define jffs2_xattr_do_crccheck_inode(c, ic)
> 

