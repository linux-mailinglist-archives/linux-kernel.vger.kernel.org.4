Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E26FD621
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjEJFZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEJFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:25:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF17189
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42E391F45A;
        Wed, 10 May 2023 05:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683696335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFaTo9mF27x5BUvqWPR9SyN02g3L4T0y2NWvn5a/3QU=;
        b=BWPdx5n+YPlimwOR490snSRl4BJwRspEMDoN1muNoS7CoTeDZCqmFFw5RGGlkK3gx1YJ6I
        HrgE/jIzRRLzyzkYCoO1/HfCnw/tDpMXmtZQbl8Vav8qQnOmq/YS64tE/o+RKUYRS67xiL
        y3lM7uU/BtxGng94BHi4YSVVKggnKpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683696335;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFaTo9mF27x5BUvqWPR9SyN02g3L4T0y2NWvn5a/3QU=;
        b=U2ntKBCRCEQePhgS4rkGDBevKOAEhoYopZktd2rt2+4airev9iYj7b4lVp3wSfjkmMakv5
        Ghxpwv3Po6RR62Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CA23138E5;
        Wed, 10 May 2023 05:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qGmFDs4qW2TdFgAAMHmgww
        (envelope-from <colyli@suse.de>); Wed, 10 May 2023 05:25:34 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 2/2] bcache: Convert to lock_cmp_fn
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20230509195847.1745548-2-kent.overstreet@linux.dev>
Date:   Wed, 10 May 2023 13:25:21 +0800
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E1A3A80-AEDD-496D-8492-D177E2E4A29F@suse.de>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
 <20230509195847.1745548-2-kent.overstreet@linux.dev>
To:     Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8810=E6=97=A5 03:58=EF=BC=8CKent Overstreet =
<kent.overstreet@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Coly Li <colyli@suse.de>

Acked-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>

Thanks for this change :-)

Coly Li


> ---
> drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
> drivers/md/bcache/btree.h |  4 ++--
> 2 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 147c493a98..569f48958b 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -559,6 +559,27 @@ static void mca_data_alloc(struct btree *b, =
struct bkey *k, gfp_t gfp)
> }
> }
>=20
> +#define cmp_int(l, r) ((l > r) - (l < r))
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +static int btree_lock_cmp_fn(const struct lockdep_map *_a,
> +     const struct lockdep_map *_b)
> +{
> + const struct btree *a =3D container_of(_a, struct btree, =
lock.dep_map);
> + const struct btree *b =3D container_of(_b, struct btree, =
lock.dep_map);
> +
> + return -cmp_int(a->level, b->level) ?: bkey_cmp(&a->key, &b->key);
> +}
> +
> +static void btree_lock_print_fn(const struct lockdep_map *map)
> +{
> + const struct btree *b =3D container_of(map, struct btree, =
lock.dep_map);
> +
> + printk(KERN_CONT " l=3D%u %llu:%llu", b->level,
> +       KEY_INODE(&b->key), KEY_OFFSET(&b->key));
> +}
> +#endif
> +
> static struct btree *mca_bucket_alloc(struct cache_set *c,
>      struct bkey *k, gfp_t gfp)
> {
> @@ -572,7 +593,7 @@ static struct btree *mca_bucket_alloc(struct =
cache_set *c,
> return NULL;
>=20
> init_rwsem(&b->lock);
> - lockdep_set_novalidate_class(&b->lock);
> + lock_set_cmp_fn(&b->lock, btree_lock_cmp_fn, btree_lock_print_fn);
> mutex_init(&b->write_lock);
> lockdep_set_novalidate_class(&b->write_lock);
> INIT_LIST_HEAD(&b->list);
> diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
> index 1b5fdbc0d8..17b1d201ce 100644
> --- a/drivers/md/bcache/btree.h
> +++ b/drivers/md/bcache/btree.h
> @@ -247,8 +247,8 @@ static inline void bch_btree_op_init(struct =
btree_op *op, int write_lock_level)
>=20
> static inline void rw_lock(bool w, struct btree *b, int level)
> {
> - w ? down_write_nested(&b->lock, level + 1)
> -  : down_read_nested(&b->lock, level + 1);
> + w ? down_write(&b->lock)
> +  : down_read(&b->lock);
> if (w)
> b->seq++;
> }
> --=20
> 2.40.1
>=20

