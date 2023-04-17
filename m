Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053126E42F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjDQIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:52:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D14C3E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:52:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CE4B21A3B;
        Mon, 17 Apr 2023 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681721569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MP9ylYftkTexkhTlTuQaX9NZiDPLZVCz9rTEkhHTi68=;
        b=uJnLB5TxgVGkipwZQaBYBCJTuUbKJDlbuQE12ZtjOUghrf3Y63Vb64X96rXzRXVXYLF2h9
        WrH9WUIHwoDuYaLk0/MqN/Zf7mXss04cpu7Xn8/K2xjzeUBpkztODMZN+u+IR0mUn8JVGB
        L6Cs44Q0TviOcGQ4w2uw7lcOXAlhGAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681721569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MP9ylYftkTexkhTlTuQaX9NZiDPLZVCz9rTEkhHTi68=;
        b=pW1j96tf2uE9z7XXgYpEQ+gRRE5IgqYnVYj6RF8GjAn+jZJGWuIXiXqSY8DlAX2/I2Wfuy
        NMzDt2aCvwiPG6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F4DC13319;
        Mon, 17 Apr 2023 08:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JEJeD+EIPWSBUAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 08:52:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BFC68A0744; Mon, 17 Apr 2023 10:52:48 +0200 (CEST)
Date:   Mon, 17 Apr 2023 10:52:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: move qbtos and stoqb to header file
Message-ID: <20230417085248.ojybd7uk4vhynguh@quack3>
References: <20230414160435.64119-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414160435.64119-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15-04-23 00:04:35, Yangtao Li wrote:
> qbtos() and stoqb() are defined repeatedly in many files,
> let's move it to the header file.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for the patch! Although the functions (qbtos(), v1_qbtos(),
v2_qbtos()) are in the end the same, logically they speak about different
things. v1_qbtos() talks about units used for storing in v1 quota file,
v2_qbtos() talks about units used for storing in v2 quota file, and qbtos()
talks about units used when communicating through quotactl(2) system call.
So I think the code is just cleaner the way it currently is.

								Honza

> ---
>  fs/quota/quota.c      | 10 ----------
>  fs/quota/quota_v1.c   | 27 +++++++--------------------
>  fs/quota/quota_v2.c   | 31 +++++++++----------------------
>  include/linux/quota.h | 10 ++++++++++
>  4 files changed, 26 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 052f143e2e0e..094c2844ede3 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -174,16 +174,6 @@ static int quota_setinfo(struct super_block *sb, int type, void __user *addr)
>  	return sb->s_qcop->set_info(sb, type, &qinfo);
>  }
>  
> -static inline qsize_t qbtos(qsize_t blocks)
> -{
> -	return blocks << QIF_DQBLKSIZE_BITS;
> -}
> -
> -static inline qsize_t stoqb(qsize_t space)
> -{
> -	return (space + QIF_DQBLKSIZE - 1) >> QIF_DQBLKSIZE_BITS;
> -}
> -
>  static void copy_to_if_dqblk(struct if_dqblk *dst, struct qc_dqblk *src)
>  {
>  	memset(dst, 0, sizeof(*dst));
> diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
> index cd92e5fa0062..309df78f1c22 100644
> --- a/fs/quota/quota_v1.c
> +++ b/fs/quota/quota_v1.c
> @@ -16,27 +16,14 @@ MODULE_AUTHOR("Jan Kara");
>  MODULE_DESCRIPTION("Old quota format support");
>  MODULE_LICENSE("GPL");
>  
> -#define QUOTABLOCK_BITS 10
> -#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
> -
> -static inline qsize_t v1_stoqb(qsize_t space)
> -{
> -	return (space + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS;
> -}
> -
> -static inline qsize_t v1_qbtos(qsize_t blocks)
> -{
> -	return blocks << QUOTABLOCK_BITS;
> -}
> -
>  static void v1_disk2mem_dqblk(struct mem_dqblk *m, struct v1_disk_dqblk *d)
>  {
>  	m->dqb_ihardlimit = d->dqb_ihardlimit;
>  	m->dqb_isoftlimit = d->dqb_isoftlimit;
>  	m->dqb_curinodes = d->dqb_curinodes;
> -	m->dqb_bhardlimit = v1_qbtos(d->dqb_bhardlimit);
> -	m->dqb_bsoftlimit = v1_qbtos(d->dqb_bsoftlimit);
> -	m->dqb_curspace = v1_qbtos(d->dqb_curblocks);
> +	m->dqb_bhardlimit = qbtos(d->dqb_bhardlimit);
> +	m->dqb_bsoftlimit = qbtos(d->dqb_bsoftlimit);
> +	m->dqb_curspace = qbtos(d->dqb_curblocks);
>  	m->dqb_itime = d->dqb_itime;
>  	m->dqb_btime = d->dqb_btime;
>  }
> @@ -46,9 +33,9 @@ static void v1_mem2disk_dqblk(struct v1_disk_dqblk *d, struct mem_dqblk *m)
>  	d->dqb_ihardlimit = m->dqb_ihardlimit;
>  	d->dqb_isoftlimit = m->dqb_isoftlimit;
>  	d->dqb_curinodes = m->dqb_curinodes;
> -	d->dqb_bhardlimit = v1_stoqb(m->dqb_bhardlimit);
> -	d->dqb_bsoftlimit = v1_stoqb(m->dqb_bsoftlimit);
> -	d->dqb_curblocks = v1_stoqb(m->dqb_curspace);
> +	d->dqb_bhardlimit = stoqb(m->dqb_bhardlimit);
> +	d->dqb_bsoftlimit = stoqb(m->dqb_bsoftlimit);
> +	d->dqb_curblocks = stoqb(m->dqb_curspace);
>  	d->dqb_itime = m->dqb_itime;
>  	d->dqb_btime = m->dqb_btime;
>  }
> @@ -172,7 +159,7 @@ static int v1_read_file_info(struct super_block *sb, int type)
>  	}
>  	ret = 0;
>  	/* limits are stored as unsigned 32-bit data */
> -	dqopt->info[type].dqi_max_spc_limit = 0xffffffffULL << QUOTABLOCK_BITS;
> +	dqopt->info[type].dqi_max_spc_limit = 0xffffffffULL << QIF_DQBLKSIZE_BITS;
>  	dqopt->info[type].dqi_max_ino_limit = 0xffffffff;
>  	dqopt->info[type].dqi_igrace =
>  			dqblk.dqb_itime ? dqblk.dqb_itime : MAX_IQ_TIME;
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index b1467f3921c2..d4282329753b 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -41,19 +41,6 @@ static const struct qtree_fmt_operations v2r1_qtree_ops = {
>  	.is_id = v2r1_is_id,
>  };
>  
> -#define QUOTABLOCK_BITS 10
> -#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
> -
> -static inline qsize_t v2_stoqb(qsize_t space)
> -{
> -	return (space + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS;
> -}
> -
> -static inline qsize_t v2_qbtos(qsize_t blocks)
> -{
> -	return blocks << QUOTABLOCK_BITS;
> -}
> -
>  static int v2_read_header(struct super_block *sb, int type,
>  			  struct v2_disk_dqheader *dqhead)
>  {
> @@ -127,7 +114,7 @@ static int v2_read_file_info(struct super_block *sb, int type)
>  	qinfo = info->dqi_priv;
>  	if (version == 0) {
>  		/* limits are stored as unsigned 32-bit data */
> -		info->dqi_max_spc_limit = 0xffffffffLL << QUOTABLOCK_BITS;
> +		info->dqi_max_spc_limit = 0xffffffffLL << QIF_DQBLKSIZE_BITS;
>  		info->dqi_max_ino_limit = 0xffffffff;
>  	} else {
>  		/*
> @@ -226,8 +213,8 @@ static void v2r0_disk2memdqb(struct dquot *dquot, void *dp)
>  	m->dqb_isoftlimit = le32_to_cpu(d->dqb_isoftlimit);
>  	m->dqb_curinodes = le32_to_cpu(d->dqb_curinodes);
>  	m->dqb_itime = le64_to_cpu(d->dqb_itime);
> -	m->dqb_bhardlimit = v2_qbtos(le32_to_cpu(d->dqb_bhardlimit));
> -	m->dqb_bsoftlimit = v2_qbtos(le32_to_cpu(d->dqb_bsoftlimit));
> +	m->dqb_bhardlimit = qbtos(le32_to_cpu(d->dqb_bhardlimit));
> +	m->dqb_bsoftlimit = qbtos(le32_to_cpu(d->dqb_bsoftlimit));
>  	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
>  	m->dqb_btime = le64_to_cpu(d->dqb_btime);
>  	/* We need to escape back all-zero structure */
> @@ -248,8 +235,8 @@ static void v2r0_mem2diskdqb(void *dp, struct dquot *dquot)
>  	d->dqb_isoftlimit = cpu_to_le32(m->dqb_isoftlimit);
>  	d->dqb_curinodes = cpu_to_le32(m->dqb_curinodes);
>  	d->dqb_itime = cpu_to_le64(m->dqb_itime);
> -	d->dqb_bhardlimit = cpu_to_le32(v2_stoqb(m->dqb_bhardlimit));
> -	d->dqb_bsoftlimit = cpu_to_le32(v2_stoqb(m->dqb_bsoftlimit));
> +	d->dqb_bhardlimit = cpu_to_le32(stoqb(m->dqb_bhardlimit));
> +	d->dqb_bsoftlimit = cpu_to_le32(stoqb(m->dqb_bsoftlimit));
>  	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
>  	d->dqb_btime = cpu_to_le64(m->dqb_btime);
>  	d->dqb_id = cpu_to_le32(from_kqid(&init_user_ns, dquot->dq_id));
> @@ -279,8 +266,8 @@ static void v2r1_disk2memdqb(struct dquot *dquot, void *dp)
>  	m->dqb_isoftlimit = le64_to_cpu(d->dqb_isoftlimit);
>  	m->dqb_curinodes = le64_to_cpu(d->dqb_curinodes);
>  	m->dqb_itime = le64_to_cpu(d->dqb_itime);
> -	m->dqb_bhardlimit = v2_qbtos(le64_to_cpu(d->dqb_bhardlimit));
> -	m->dqb_bsoftlimit = v2_qbtos(le64_to_cpu(d->dqb_bsoftlimit));
> +	m->dqb_bhardlimit = qbtos(le64_to_cpu(d->dqb_bhardlimit));
> +	m->dqb_bsoftlimit = qbtos(le64_to_cpu(d->dqb_bsoftlimit));
>  	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
>  	m->dqb_btime = le64_to_cpu(d->dqb_btime);
>  	/* We need to escape back all-zero structure */
> @@ -301,8 +288,8 @@ static void v2r1_mem2diskdqb(void *dp, struct dquot *dquot)
>  	d->dqb_isoftlimit = cpu_to_le64(m->dqb_isoftlimit);
>  	d->dqb_curinodes = cpu_to_le64(m->dqb_curinodes);
>  	d->dqb_itime = cpu_to_le64(m->dqb_itime);
> -	d->dqb_bhardlimit = cpu_to_le64(v2_stoqb(m->dqb_bhardlimit));
> -	d->dqb_bsoftlimit = cpu_to_le64(v2_stoqb(m->dqb_bsoftlimit));
> +	d->dqb_bhardlimit = cpu_to_le64(stoqb(m->dqb_bhardlimit));
> +	d->dqb_bsoftlimit = cpu_to_le64(stoqb(m->dqb_bsoftlimit));
>  	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
>  	d->dqb_btime = cpu_to_le64(m->dqb_btime);
>  	d->dqb_id = cpu_to_le32(from_kqid(&init_user_ns, dquot->dq_id));
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index fd692b4a41d5..23a09bc954a4 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -538,4 +538,14 @@ struct quota_module_name {
>  	{QFMT_VFS_V1, "quota_v2"},\
>  	{0, NULL}}
>  
> +static inline qsize_t qbtos(qsize_t blocks)
> +{
> +	return blocks << QIF_DQBLKSIZE_BITS;
> +}
> +
> +static inline qsize_t stoqb(qsize_t space)
> +{
> +	return (space + QIF_DQBLKSIZE - 1) >> QIF_DQBLKSIZE_BITS;
> +}
> +
>  #endif /* _QUOTA_ */
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
