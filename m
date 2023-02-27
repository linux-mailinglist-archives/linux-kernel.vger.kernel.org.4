Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0766A361D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjB0BML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0BMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:12:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5A26AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:12:07 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PQ2Wf2LHrzrS3k;
        Mon, 27 Feb 2023 09:11:26 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 09:12:02 +0800
Subject: Re: [PATCH v2] ubifs: dirty_cow_znode: Fix memleak in error handling
 path
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230215022507.2363193-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9121ae91-5b4f-4b10-46fc-6cc0683c949d@huawei.com>
Date:   Mon, 27 Feb 2023 09:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230215022507.2363193-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/2/15 10:25, Zhihao Cheng Ð´µÀ:
Hi, Richarch,
> Following process will cause a memleak for copied up znode:
> 
> dirty_cow_znode
>    zn = copy_znode(c, znode);
>    err = insert_old_idx(c, zbr->lnum, zbr->offs);
>    if (unlikely(err))
>       return ERR_PTR(err);   // No one refers to zn.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216705
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   v1: https://patchwork.ozlabs.org/project/linux-mtd/patch/20221118090236.664244-3-chengzhihao1@huawei.com/
>   v1->v2: In v1, if insert_old_idx() failed, old index neither exists in
> 	 TNC nor in old-index tree. Which means that old index node could
> 	 be overwritten in layout_leb_in_gaps(), then ubifs image will be
> 	 corrupted in power-cut.
> 	 In v2, copy_znode() is splitted into 2 parts: resouce allocation
> 	 and znode replacement, insert_old_idx() is splitted in similar
> 	 way, so resouce cleanup could be done in error handling path
> 	 without corrupting metadata(mem & disk).
> 	 It's okay that old index inserting is put behind of add_idx_dirt(),
> 	 old index is used in layout_leb_in_gaps(), so the two processes
> 	 do not depend on each other.
>   fs/ubifs/tnc.c | 137 +++++++++++++++++++++++++++++++------------------
>   1 file changed, 87 insertions(+), 50 deletions(-)
> 

Just a reminder to notify that this is a v2 fix to replace original 
solution (which is in next branch) 
https://patchwork.ozlabs.org/project/linux-mtd/patch/20221118090236.664244-3-chengzhihao1@huawei.com/.

> diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
> index 2df56bbc6865..6b7d95b65f4b 100644
> --- a/fs/ubifs/tnc.c
> +++ b/fs/ubifs/tnc.c
> @@ -44,6 +44,33 @@ enum {
>   	NOT_ON_MEDIA = 3,
>   };
>   
> +static void do_insert_old_idx(struct ubifs_info *c,
> +			      struct ubifs_old_idx *old_idx)
> +{
> +	struct ubifs_old_idx *o;
> +	struct rb_node **p, *parent = NULL;
> +
> +	p = &c->old_idx.rb_node;
> +	while (*p) {
> +		parent = *p;
> +		o = rb_entry(parent, struct ubifs_old_idx, rb);
> +		if (old_idx->lnum < o->lnum)
> +			p = &(*p)->rb_left;
> +		else if (old_idx->lnum > o->lnum)
> +			p = &(*p)->rb_right;
> +		else if (old_idx->offs < o->offs)
> +			p = &(*p)->rb_left;
> +		else if (old_idx->offs > o->offs)
> +			p = &(*p)->rb_right;
> +		else {
> +			ubifs_err(c, "old idx added twice!");
> +			kfree(old_idx);
> +		}
> +	}
> +	rb_link_node(&old_idx->rb, parent, p);
> +	rb_insert_color(&old_idx->rb, &c->old_idx);
> +}
> +
>   /**
>    * insert_old_idx - record an index node obsoleted since the last commit start.
>    * @c: UBIFS file-system description object
> @@ -69,35 +96,15 @@ enum {
>    */
>   static int insert_old_idx(struct ubifs_info *c, int lnum, int offs)
>   {
> -	struct ubifs_old_idx *old_idx, *o;
> -	struct rb_node **p, *parent = NULL;
> +	struct ubifs_old_idx *old_idx;
>   
>   	old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
>   	if (unlikely(!old_idx))
>   		return -ENOMEM;
>   	old_idx->lnum = lnum;
>   	old_idx->offs = offs;
> +	do_insert_old_idx(c, old_idx);
>   
> -	p = &c->old_idx.rb_node;
> -	while (*p) {
> -		parent = *p;
> -		o = rb_entry(parent, struct ubifs_old_idx, rb);
> -		if (lnum < o->lnum)
> -			p = &(*p)->rb_left;
> -		else if (lnum > o->lnum)
> -			p = &(*p)->rb_right;
> -		else if (offs < o->offs)
> -			p = &(*p)->rb_left;
> -		else if (offs > o->offs)
> -			p = &(*p)->rb_right;
> -		else {
> -			ubifs_err(c, "old idx added twice!");
> -			kfree(old_idx);
> -			return 0;
> -		}
> -	}
> -	rb_link_node(&old_idx->rb, parent, p);
> -	rb_insert_color(&old_idx->rb, &c->old_idx);
>   	return 0;
>   }
>   
> @@ -199,23 +206,6 @@ static struct ubifs_znode *copy_znode(struct ubifs_info *c,
>   	__set_bit(DIRTY_ZNODE, &zn->flags);
>   	__clear_bit(COW_ZNODE, &zn->flags);
>   
> -	ubifs_assert(c, !ubifs_zn_obsolete(znode));
> -	__set_bit(OBSOLETE_ZNODE, &znode->flags);
> -
> -	if (znode->level != 0) {
> -		int i;
> -		const int n = zn->child_cnt;
> -
> -		/* The children now have new parent */
> -		for (i = 0; i < n; i++) {
> -			struct ubifs_zbranch *zbr = &zn->zbranch[i];
> -
> -			if (zbr->znode)
> -				zbr->znode->parent = zn;
> -		}
> -	}
> -
> -	atomic_long_inc(&c->dirty_zn_cnt);
>   	return zn;
>   }
>   
> @@ -233,6 +223,42 @@ static int add_idx_dirt(struct ubifs_info *c, int lnum, int dirt)
>   	return ubifs_add_dirt(c, lnum, dirt);
>   }
>   
> +/**
> + * replace_znode - replace old znode with new znode.
> + * @c: UBIFS file-system description object
> + * @new_zn: new znode
> + * @old_zn: old znode
> + * @zbr: the branch of parent znode
> + *
> + * Replace old znode with new znode in TNC.
> + */
> +static void replace_znode(struct ubifs_info *c, struct ubifs_znode *new_zn,
> +			  struct ubifs_znode *old_zn, struct ubifs_zbranch *zbr)
> +{
> +	ubifs_assert(c, !ubifs_zn_obsolete(old_zn));
> +	__set_bit(OBSOLETE_ZNODE, &old_zn->flags);
> +
> +	if (old_zn->level != 0) {
> +		int i;
> +		const int n = new_zn->child_cnt;
> +
> +		/* The children now have new parent */
> +		for (i = 0; i < n; i++) {
> +			struct ubifs_zbranch *child = &new_zn->zbranch[i];
> +
> +			if (child->znode)
> +				child->znode->parent = new_zn;
> +		}
> +	}
> +
> +	zbr->znode = new_zn;
> +	zbr->lnum = 0;
> +	zbr->offs = 0;
> +	zbr->len = 0;
> +
> +	atomic_long_inc(&c->dirty_zn_cnt);
> +}
> +
>   /**
>    * dirty_cow_znode - ensure a znode is not being committed.
>    * @c: UBIFS file-system description object
> @@ -265,21 +291,32 @@ static struct ubifs_znode *dirty_cow_znode(struct ubifs_info *c,
>   		return zn;
>   
>   	if (zbr->len) {
> -		err = insert_old_idx(c, zbr->lnum, zbr->offs);
> -		if (unlikely(err))
> -			return ERR_PTR(err);
> +		struct ubifs_old_idx *old_idx;
> +
> +		old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
> +		if (unlikely(!old_idx)) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		old_idx->lnum = zbr->lnum;
> +		old_idx->offs = zbr->offs;
> +
>   		err = add_idx_dirt(c, zbr->lnum, zbr->len);
> -	} else
> -		err = 0;
> +		if (err) {
> +			kfree(old_idx);
> +			goto out;
> +		}
>   
> -	zbr->znode = zn;
> -	zbr->lnum = 0;
> -	zbr->offs = 0;
> -	zbr->len = 0;
> +		do_insert_old_idx(c, old_idx);
> +	}
> +
> +	replace_znode(c, zn, znode, zbr);
>   
> -	if (unlikely(err))
> -		return ERR_PTR(err);
>   	return zn;
> +
> +out:
> +	kfree(zn);
> +	return ERR_PTR(err);
>   }
>   
>   /**
> 

