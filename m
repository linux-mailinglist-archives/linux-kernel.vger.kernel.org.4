Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9970AE3E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjEUNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEUN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:28:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7809C;
        Sun, 21 May 2023 06:21:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB2D91FD88;
        Sun, 21 May 2023 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684675310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsM4Cv/srHTmWHPMTiUXiGFITZ54mA/K/irQdpcwplY=;
        b=CmBxgcNU52MI6T8v9Pj3wmT4mKUZvr2RKI5E5CN12vFBs0C5rfn5Amgb023ZDwUWeFgL8C
        6sZFlNRf1EzoCe59JRHVfUvJ3q42M+MzBiJ3vnlqQI6lExgI4JpTeHzFfaSA4KB1I59bMk
        gKrt2hIIOriWcMVnDvD0mG19C898cP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684675310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsM4Cv/srHTmWHPMTiUXiGFITZ54mA/K/irQdpcwplY=;
        b=RbUmPt+EScEQk92Szr6ZCazI91vAaIkbSoaEXDytoBYRYm5IBi17btfMsbOKMdDugGYMOB
        6tu8LcQv0QCSpBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3845313425;
        Sun, 21 May 2023 13:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKo8O+waamSEJAAAMHmgww
        (envelope-from <colyli@suse.de>); Sun, 21 May 2023 13:21:48 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [tip: locking/core] bcache: Convert to lock_cmp_fn
From:   Coly Li <colyli@suse.de>
In-Reply-To: <168457974565.404.16611061652498882569.tip-bot2@tip-bot2>
Date:   Sun, 21 May 2023 21:21:36 +0800
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Coly Li <colyli@suse.de>" <"mailto:colyli"@suse.de>,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FBFDA28-6886-4315-A942-88F3542CE244@suse.de>
References: <20230509195847.1745548-2-kent.overstreet@linux.dev>
 <168457974565.404.16611061652498882569.tip-bot2@tip-bot2>
To:     linux-tip-commits@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8820=E6=97=A5 18:49=EF=BC=8Ctip-bot2 for Kent =
Overstreet <tip-bot2@linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The following commit has been merged into the locking/core branch of =
tip:
>=20
> Commit-ID:     0ad397b556936a14052aa65d8fa958a9f3175add
> Gitweb:        =
https://git.kernel.org/tip/0ad397b556936a14052aa65d8fa958a9f3175add
> Author:        Kent Overstreet <kent.overstreet@linux.dev>
> AuthorDate:    Tue, 09 May 2023 15:58:47 -04:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 19 May 2023 12:35:10 +02:00
>=20
> bcache: Convert to lock_cmp_fn
>=20
> Replace one of bcache's lockdep_set_novalidate_class() usage with the
> newly introduced custom lock nesting annotation.
>=20
> [peterz: changelog]
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>


Can the above =E2=80=9C<mailto:colyli@suse.de>=E2=80=9D be removed from =
my acked-by. This was automatically and invisibly added by MacOS email =
client, which just introduced chaos in such use case.

Thanks.

Coly Li


> Link: =
https://lkml.kernel.org/r/20230509195847.1745548-2-kent.overstreet@linux.d=
ev
> ---
> drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
> drivers/md/bcache/btree.h |  4 ++--
> 2 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 147c493..569f489 100644
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
> index 1b5fdbc..17b1d20 100644
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

