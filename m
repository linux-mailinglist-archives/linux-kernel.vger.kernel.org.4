Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77D62B001
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPAZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:25:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB662B611;
        Tue, 15 Nov 2022 16:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF8CCB81B92;
        Wed, 16 Nov 2022 00:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D39BC433C1;
        Wed, 16 Nov 2022 00:25:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ncWjBakD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668558323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zgRevsLRuzjmesuecm8RjAcgfuI6A3hBKmmgMskopY=;
        b=ncWjBakDRAv9Djfd5BnuHmD2W+lTaIzyuoomxxT0SpxgL7XNypmcPGIicw9v62LpGFkWXP
        6zQwJj5tZng0yZoM4GrYIY0ilA74KvCuqQv/6v1lwvMvvS//+7eaehUW6aWvZzCq7djbvO
        Em4pFXRj9AblGYkQgkaWnoIeGHq5+0U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 418f9052 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 00:25:23 +0000 (UTC)
Date:   Wed, 16 Nov 2022 01:25:20 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] random: add helpers for random numbers with given
 floor or range
Message-ID: <Y3Qt8HiXj8giOnZy@zx2c4.com>
References: <20221022014403.3881893-1-Jason@zx2c4.com>
 <20221022014403.3881893-4-Jason@zx2c4.com>
 <60574e8f-20ff-0996-5558-e9bd35e42681@opteya.com>
 <Y3KLH4FqFbJ7bfY0@zx2c4.com>
 <9ffb34a9-3cbc-bd0e-7a92-76851a77b9ef@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ffb34a9-3cbc-bd0e-7a92-76851a77b9ef@opteya.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann,

On Tue, Nov 15, 2022 at 09:42:25AM +0100, Yann Droneaud wrote:
> Le 14/11/2022 à 19:38, Jason A. Donenfeld a écrit :
> > On Mon, Nov 14, 2022 at 07:04:13PM +0100, Yann Droneaud wrote:
> >> I have a bad feeling about this one, and can't help but thinking it's going
> >> to bite someone: when asked to pick a number *between* 0 and 10,
> >> I usually think I'm allowed to pick 10 (even if I'm going to answer 7 as it should).
> > This is one of those bikeshed things you see all over the place, like
> > whether slices in a language should be [start index, end index] or
> > [start index, length], or whether arrays should be 0-based or 1-based.
> > We'll never settle this variety of dispute here.
> >
> > But in this case, there are some particular reasons why it must be this
> > way. Firstly, usage of it this way matches most of the ways the function
> > is actually used in the kernel, and fits existing semantics. This alone
> > I find compelling. But also, having all of these functions use half-open
> > intervals means that each function can take care of its entire range,
> > without having to resort to using 64-bit arithmetic, and no function is
> > a complete subset of any other function. So doing it this way makes
> > these maximally useful too.
> 
> For get_random_below(), which replaces a modulo, <bikeshedding> and could
> have been called get_random_mod()</bikeshedding>, having an open upper
> range seems fine. It's already what can be achieved by the % operator.

No, it is a different operation from modulo, since modulo introduces a
bias. So your first salvo into name bikeshedding not only bikesheds
about the wrong function (we're supposed to be discussing the "between"
one, not the "below" one), but also just isn't very sensible.

> But I believe it's unfortunate get_random_between() cannot be called to
> get a number up to UINT32_MAX, as get_random_between(0, UINT32_MAX) would
> be capped to UINT32_MAX - 1.
> 
> When not a constant, one could hope the function can cope with a maximum
> that would grow up to and including UINT32_MAX.

I don't think 64-bit arithmetic is in the cards here now, sorry. For the
constant case, we could of course just check to see if the operand is
U32_MAX and constant fold in a straight call to get_random_u32_above()
instead, I guess. But then we're introducing different semantics in the
constant case and non-constant case, and I don't want to do that.

Anyway, getting back to the actual topic at hand, if we are to do this
as a fully closed interval rather than a half-open one, ceil==U32_MAX
will be an invalid (overflowing) input to the function. I guess that
wouldn't be the end of the world, but it is certainly different. I agree
it fits the name of the function better. I don't know if it's the most
sensible semantics.

Curious about it, though, I coded it up, and I'll attach the diff below.
The question is whether this actually helps much or if it's more
confusing. Different cases yield different perspectives, I guess.

Jason

---------8<-------------------------

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 9f74b7d71a50..c0eb8a8954a8 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -53,7 +53,7 @@ static unsigned long int get_module_load_offset(void)
 		 */
 		if (module_load_offset == 0)
 			module_load_offset =
-				get_random_u32_between(1, 1024 + 1) * PAGE_SIZE;
+				get_random_u32_between(1, 1024) * PAGE_SIZE;
 		mutex_unlock(&module_kaslr_mutex);
 	}
 	return module_load_offset;
diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index f31c94855a09..0b01e699864d 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -253,7 +253,7 @@ static int pkcs1pad_encrypt(struct akcipher_request *req)
 	ps_end = ctx->key_size - req->src_len - 2;
 	req_ctx->in_buf[0] = 0x02;
 	for (i = 1; i < ps_end; i++)
-		req_ctx->in_buf[i] = get_random_u32_between(1, 256);
+		req_ctx->in_buf[i] = get_random_u32_between(1, 255);
 	req_ctx->in_buf[ps_end] = 0x00;

 	pkcs1pad_sg_set_buf(req_ctx->in_sg, req_ctx->in_buf,
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index b09b9408ec44..2c7ef4084c3f 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -962,11 +962,11 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 		if (div == &divs[max_divs - 1] || get_random_u32_below(2) == 0)
 			this_len = remaining;
 		else
-			this_len = get_random_u32_between(1, remaining + 1);
+			this_len = get_random_u32_between(1, remaining);
 		div->proportion_of_total = this_len;

 		if (get_random_u32_below(4) == 0)
-			div->offset = get_random_u32_between(PAGE_SIZE - 128, PAGE_SIZE);
+			div->offset = get_random_u32_between(PAGE_SIZE - 128, PAGE_SIZE - 1);
 		else if (get_random_u32_below(2) == 0)
 			div->offset = get_random_u32_below(32);
 		else
@@ -1094,12 +1094,12 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 	}

 	if (get_random_u32_below(2) == 0) {
-		cfg->iv_offset = get_random_u32_between(1, MAX_ALGAPI_ALIGNMASK + 1);
+		cfg->iv_offset = get_random_u32_between(1, MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " iv_offset=%u", cfg->iv_offset);
 	}

 	if (get_random_u32_below(2) == 0) {
-		cfg->key_offset = get_random_u32_between(1, MAX_ALGAPI_ALIGNMASK + 1);
+		cfg->key_offset = get_random_u32_between(1, MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " key_offset=%u", cfg->key_offset);
 	}

@@ -1653,7 +1653,7 @@ static void generate_random_hash_testvec(struct shash_desc *desc,
 	if (maxkeysize) {
 		vec->ksize = maxkeysize;
 		if (get_random_u32_below(4) == 0)
-			vec->ksize = get_random_u32_between(1, maxkeysize + 1);
+			vec->ksize = get_random_u32_between(1, maxkeysize);
 		generate_random_bytes((u8 *)vec->key, vec->ksize);

 		vec->setkey_error = crypto_shash_setkey(desc->tfm, vec->key,
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index cfb85d00ab6e..cf54be6b056a 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -129,7 +129,7 @@ enum mhi_pm_state {
 #define PRIMARY_CMD_RING				0
 #define MHI_DEV_WAKE_DB					127
 #define MHI_MAX_MTU					0xffff
-#define MHI_RANDOM_U32_NONZERO(bmsk)			(get_random_u32_between(1, bmsk + 1))
+#define MHI_RANDOM_U32_NONZERO(bmsk)			(get_random_u32_between(1, bmsk))

 enum mhi_er_type {
 	MHI_ER_TYPE_INVALID = 0x0,
diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index bb46b57cc230..e971b2ae2cb1 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -400,7 +400,7 @@ static int __find_race(void *arg)
 		struct dma_fence *fence = dma_fence_get(data->fc.tail);
 		int seqno;

-		seqno = get_random_u32_between(1, data->fc.chain_length + 1);
+		seqno = get_random_u32_between(1, data->fc.chain_length);

 		err = dma_fence_chain_find_seqno(&fence, seqno);
 		if (err) {
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index b5983b19513d..b721d1fe2464 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3807,7 +3807,7 @@ static int cma_alloc_any_port(enum rdma_ucm_port_space ps,

 	inet_get_local_port_range(net, &low, &high);
 	remaining = (high - low) + 1;
-	rover = get_random_u32_between(low, remaining + low);
+	rover = get_random_u32_between(low, remaining + low - 1);
 retry:
 	if (last_used_port != rover) {
 		struct rdma_bind_list *bind_list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 02481487b203..0e91e36b5c21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -42,7 +42,7 @@ static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)

 	if (!fl)
 		sport = get_random_u32_between(IB_ROCE_UDP_ENCAP_VALID_PORT_MIN,
-					       IB_ROCE_UDP_ENCAP_VALID_PORT_MAX + 1);
+					       IB_ROCE_UDP_ENCAP_VALID_PORT_MAX);
 	else
 		sport = rdma_flow_label_to_udp_sport(fl);

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index d4d7c6dac001..5a6c346e5c40 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1405,7 +1405,7 @@ static void ns_do_bit_flips(struct nandsim *ns, int num)
 	if (bitflips && get_random_u16() < (1 << 6)) {
 		int flips = 1;
 		if (bitflips > 1)
-			flips = get_random_u32_between(1, bitflips + 1);
+			flips = get_random_u32_between(1, bitflips);
 		while (flips--) {
 			int pos = get_random_u32_below(num * 8);
 			ns->buf.byte[pos / 8] ^= (1 << (pos % 8));
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 34d5981f4513..1ee75e5b652b 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -285,7 +285,7 @@ static __init bool randomized_test(void)

 	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
 		get_random_bytes(ip, 4);
-		cidr = get_random_u32_between(1, 32 + 1);
+		cidr = get_random_u32_between(1, 32);
 		peer = peers[get_random_u32_below(NUM_PEERS)];
 		if (wg_allowedips_insert_v4(&t, (struct in_addr *)ip, cidr,
 					    peer, &mutex) < 0) {
@@ -311,7 +311,7 @@ static __init bool randomized_test(void)
 				mutated[k] = (mutated[k] & mutate_mask[k]) |
 					     (~mutate_mask[k] &
 					      get_random_u8());
-			cidr = get_random_u32_between(1, 32 + 1);
+			cidr = get_random_u32_between(1, 32);
 			peer = peers[get_random_u32_below(NUM_PEERS)];
 			if (wg_allowedips_insert_v4(&t,
 						    (struct in_addr *)mutated,
@@ -329,7 +329,7 @@ static __init bool randomized_test(void)

 	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
 		get_random_bytes(ip, 16);
-		cidr = get_random_u32_between(1, 128 + 1);
+		cidr = get_random_u32_between(1, 128);
 		peer = peers[get_random_u32_below(NUM_PEERS)];
 		if (wg_allowedips_insert_v6(&t, (struct in6_addr *)ip, cidr,
 					    peer, &mutex) < 0) {
@@ -355,7 +355,7 @@ static __init bool randomized_test(void)
 				mutated[k] = (mutated[k] & mutate_mask[k]) |
 					     (~mutate_mask[k] &
 					      get_random_u8());
-			cidr = get_random_u32_between(1, 128 + 1);
+			cidr = get_random_u32_between(1, 128);
 			peer = peers[get_random_u32_below(NUM_PEERS)];
 			if (wg_allowedips_insert_v6(&t,
 						    (struct in6_addr *)mutated,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 0e6bf5e5c8a9..5eaa9e8cabf7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1128,7 +1128,7 @@ static void brcmf_p2p_afx_handler(struct work_struct *work)
 	if (afx_hdl->is_listen && afx_hdl->my_listen_chan)
 		/* 100ms ~ 300ms */
 		err = brcmf_p2p_discover_listen(p2p, afx_hdl->my_listen_chan,
-						100 * get_random_u32_between(1, 4));
+						100 * get_random_u32_between(1, 3));
 	else
 		err = brcmf_p2p_act_frm_search(p2p, afx_hdl->peer_listen_chan);

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index f0b94633834e..068b7f66e7c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1099,7 +1099,7 @@ static void iwl_mvm_mac_ctxt_cmd_fill_ap(struct iwl_mvm *mvm,
 			iwl_mvm_mac_ap_iterator, &data);

 		if (data.beacon_device_ts) {
-			u32 rand = get_random_u32_between(36, 64);
+			u32 rand = get_random_u32_between(36, 63);
 			mvmvif->ap_beacon_time = data.beacon_device_ts +
 				ieee80211_tu_to_usec(data.beacon_int * rand /
 						     100);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8319fdc59fb4..aab48feb55db 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2588,7 +2588,7 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	curseg->alloc_type = LFS;
 	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
 		curseg->fragment_remained_chunk =
-				get_random_u32_between(1, sbi->max_fragment_chunk + 1);
+				get_random_u32_between(1, sbi->max_fragment_chunk);
 }

 static int __next_free_blkoff(struct f2fs_sb_info *sbi,
@@ -2625,9 +2625,9 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
 			/* To allocate block chunks in different sizes, use random number */
 			if (--seg->fragment_remained_chunk <= 0) {
 				seg->fragment_remained_chunk =
-				   get_random_u32_between(1, sbi->max_fragment_chunk + 1);
+				   get_random_u32_between(1, sbi->max_fragment_chunk);
 				seg->next_blkoff +=
-				   get_random_u32_between(1, sbi->max_fragment_hole + 1);
+				   get_random_u32_between(1, sbi->max_fragment_hole);
 			}
 		}
 	}
diff --git a/include/linux/random.h b/include/linux/random.h
index acaa328fb34d..6d7598d16212 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -104,15 +104,16 @@ static inline u32 get_random_u32_above(u32 floor)
 }

 /*
- * Returns a random integer in the interval [floor, ceil), with uniform
+ * Returns a random integer in the interval [floor, ceil], with uniform
  * distribution, suitable for all uses. Fastest when floor and ceil are
- * constant, but still fast for variable floor and ceil as well.
+ * constant, but still fast for variable floor and ceil as well. Ceil must be
+ * less than U32_MAX.
  */
 static inline u32 get_random_u32_between(u32 floor, u32 ceil)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && __builtin_constant_p(ceil) &&
-			 floor >= ceil, "get_random_u32_between() must take floor < ceil");
-	return floor + get_random_u32_below(ceil - floor);
+			 floor > ceil || ceil == U32_MAX, "get_random_u32_between() must take floor <= ceil < U32_MAX");
+	return floor + get_random_u32_below(ceil - floor + 1);
 }

 void __init random_init_early(const char *command_line);
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index eed30ad29796..5fca11c52324 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -31,7 +31,7 @@ static bool __init test_encode_decode(void)
 	int i;

 	for (i = 0; i < ITERS_PER_TEST; ++i) {
-		size_t size = get_random_u32_between(1, MAX_ENCODABLE_SIZE + 1);
+		size_t size = get_random_u32_between(1, MAX_ENCODABLE_SIZE);
 		bool is_write = !!get_random_u32_below(2);
 		unsigned long verif_masked_addr;
 		long encoded_watchpoint;
diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index f4ff3041ec10..209211968719 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -149,7 +149,7 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 static void __init test_hexdump_set(int rowsize, bool ascii)
 {
 	size_t d = min_t(size_t, sizeof(data_b), rowsize);
-	size_t len = get_random_u32_between(1, d + 1);
+	size_t len = get_random_u32_between(1, d - 1);

 	test_hexdump(len, rowsize, 4, ascii);
 	test_hexdump(len, rowsize, 2, ascii);
@@ -208,11 +208,11 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
-	int rs = get_random_u32_between(1, 3) * 16;
+	int rs = get_random_u32_between(1, 2) * 16;

 	do {
 		int gs = 1 << i;
-		size_t len = get_random_u32_between(gs, rs + gs);
+		size_t len = get_random_u32_between(gs, rs + gs - 1);

 		test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
 	} while (i++ < 3);
@@ -223,11 +223,11 @@ static int __init test_hexdump_init(void)
 	unsigned int i;
 	int rowsize;

-	rowsize = get_random_u32_between(1, 3) * 16;
+	rowsize = get_random_u32_between(1, 2) * 16;
 	for (i = 0; i < 16; i++)
 		test_hexdump_set(rowsize, false);

-	rowsize = get_random_u32_between(1, 3) * 16;
+	rowsize = get_random_u32_between(1, 2) * 16;
 	for (i = 0; i < 16; i++)
 		test_hexdump_set(rowsize, true);

diff --git a/lib/test_printf.c b/lib/test_printf.c
index da5efc8b8543..ba49318623f2 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -126,7 +126,7 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * be able to print it as expected.
 	 */
 	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
-	rand = get_random_u32_between(1, elen + 2);
+	rand = get_random_u32_between(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
 	failed_tests += do_test(rand, expect, elen, fmt, ap);
 	failed_tests += do_test(0, expect, elen, fmt, ap);
diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 7a2caf4596c5..f389be97db8b 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -151,7 +151,7 @@ static int random_size_alloc_test(void)
 	int i;

 	for (i = 0; i < test_loop_count; i++) {
-		n = get_random_u32_between(1, 101);
+		n = get_random_u32_between(1, 100);
 		p = vmalloc(n * PAGE_SIZE);

 		if (!p)
@@ -291,12 +291,12 @@ pcpu_alloc_test(void)
 		return -1;

 	for (i = 0; i < 35000; i++) {
-		size = get_random_u32_between(1, PAGE_SIZE / 4 + 1);
+		size = get_random_u32_between(1, PAGE_SIZE / 4);

 		/*
 		 * Maximum PAGE_SIZE
 		 */
-		align = 1 << get_random_u32_between(1, 12);
+		align = 1 << get_random_u32_between(1, 11);

 		pcpu[i] = __alloc_percpu(size, align);
 		if (!pcpu[i])
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 6167e19056f0..ffc4ef8f9bfa 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1299,7 +1299,7 @@ static void match_all_not_assigned(struct kunit *test)
 	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);

 	for (i = 0; i < 256; i++) {
-		size = get_random_u32_between(1, 1024 + 1);
+		size = get_random_u32_between(1, 1024);
 		ptr = kmalloc(size, GFP_KERNEL);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
@@ -1308,7 +1308,7 @@ static void match_all_not_assigned(struct kunit *test)
 	}

 	for (i = 0; i < 256; i++) {
-		order = get_random_u32_between(1, 5);
+		order = get_random_u32_between(1, 4);
 		pages = alloc_pages(GFP_KERNEL, order);
 		ptr = page_address(pages);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -1321,7 +1321,7 @@ static void match_all_not_assigned(struct kunit *test)
 		return;

 	for (i = 0; i < 256; i++) {
-		size = get_random_u32_between(1, 1024 + 1);
+		size = get_random_u32_between(1, 1024);
 		ptr = vmalloc(size);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 99abe86fc9b1..b60407b1f69b 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -532,7 +532,7 @@ static void test_free_bulk(struct kunit *test)
 	int iter;

 	for (iter = 0; iter < 5; iter++) {
-		const size_t size = setup_test_cache(test, get_random_u32_between(8, 308),
+		const size_t size = setup_test_cache(test, get_random_u32_between(8, 307),
 						     0, (iter & 1) ? ctor_set_x : NULL);
 		void *objects[] = {
 			test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT),
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 08f0152c32da..3f986b64733c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -772,7 +772,7 @@ static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
 		/* No free swap slots available */
 		if (si->highest_bit <= si->lowest_bit)
 			return;
-		next = get_random_u32_between(si->lowest_bit, si->highest_bit + 1);
+		next = get_random_u32_between(si->lowest_bit, si->highest_bit);
 		next = ALIGN_DOWN(next, SWAP_ADDRESS_SPACE_PAGES);
 		next = max_t(unsigned int, next, si->lowest_bit);
 	}
@@ -3088,7 +3088,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 */
 		for_each_possible_cpu(cpu) {
 			per_cpu(*p->cluster_next_cpu, cpu) =
-				get_random_u32_between(1, p->highest_bit + 1);
+				get_random_u32_between(1, p->highest_bit);
 		}
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bab37a529db5..70ebee41c94f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7374,7 +7374,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * calculate conn info age as random value between min/max set in hdev.
 	 */
 	conn_info_age = get_random_u32_between(hdev->conn_info_min_age,
-					       hdev->conn_info_max_age);
+					       hdev->conn_info_max_age - 1);

 	/* Query controller to refresh cached values if they are too old or were
 	 * never read.
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5eb401003368..3afacbbaef45 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2381,7 +2381,7 @@ static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
 		__u16 t;
 		if (pkt_dev->flags & F_QUEUE_MAP_RND) {
 			t = get_random_u32_between(pkt_dev->queue_map_min,
-						   pkt_dev->queue_map_max + 1);
+						   pkt_dev->queue_map_max);
 		} else {
 			t = pkt_dev->cur_queue_map + 1;
 			if (t > pkt_dev->queue_map_max)
@@ -2478,7 +2478,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 	if (pkt_dev->udp_src_min < pkt_dev->udp_src_max) {
 		if (pkt_dev->flags & F_UDPSRC_RND)
 			pkt_dev->cur_udp_src = get_random_u32_between(pkt_dev->udp_src_min,
-								      pkt_dev->udp_src_max);
+								      pkt_dev->udp_src_max - 1);

 		else {
 			pkt_dev->cur_udp_src++;
@@ -2490,7 +2490,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 	if (pkt_dev->udp_dst_min < pkt_dev->udp_dst_max) {
 		if (pkt_dev->flags & F_UDPDST_RND) {
 			pkt_dev->cur_udp_dst = get_random_u32_between(pkt_dev->udp_dst_min,
-								      pkt_dev->udp_dst_max);
+								      pkt_dev->udp_dst_max - 1);
 		} else {
 			pkt_dev->cur_udp_dst++;
 			if (pkt_dev->cur_udp_dst >= pkt_dev->udp_dst_max)
@@ -2505,7 +2505,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		if (imn < imx) {
 			__u32 t;
 			if (pkt_dev->flags & F_IPSRC_RND)
-				t = get_random_u32_between(imn, imx);
+				t = get_random_u32_between(imn, imx - 1);
 			else {
 				t = ntohl(pkt_dev->cur_saddr);
 				t++;
@@ -2527,7 +2527,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 				if (pkt_dev->flags & F_IPDST_RND) {

 					do {
-						t = get_random_u32_between(imn, imx);
+						t = get_random_u32_between(imn, imx - 1);
 						s = htonl(t);
 					} while (ipv4_is_loopback(s) ||
 						ipv4_is_multicast(s) ||
@@ -2575,7 +2575,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		__u32 t;
 		if (pkt_dev->flags & F_TXSIZE_RND) {
 			t = get_random_u32_between(pkt_dev->min_pkt_size,
-						   pkt_dev->max_pkt_size);
+						   pkt_dev->max_pkt_size - 1);
 		} else {
 			t = pkt_dev->cur_pkt_size + 1;
 			if (t > pkt_dev->max_pkt_size)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1a348298a99e..f6d37b855f50 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3647,7 +3647,7 @@ static void tcp_send_challenge_ack(struct sock *sk)

 		WRITE_ONCE(net->ipv4.tcp_challenge_timestamp, now);
 		WRITE_ONCE(net->ipv4.tcp_challenge_count,
-			   get_random_u32_between(half, ack_limit + half));
+			   get_random_u32_between(half, ack_limit + half - 1));
 	}
 	count = READ_ONCE(net->ipv4.tcp_challenge_count);
 	if (count > 0) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3f750e6d0ac3..20ee7216bfe8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -104,7 +104,7 @@ static inline u32 cstamp_delta(unsigned long cstamp)
 static inline s32 rfc3315_s14_backoff_init(s32 irt)
 {
 	/* multiply 'initial retransmission time' by 0.9 .. 1.1 */
-	u64 tmp = get_random_u32_between(900000, 1100001) * (u64)irt;
+	u64 tmp = get_random_u32_between(900000, 1100000) * (u64)irt;
 	do_div(tmp, 1000000);
 	return (s32)tmp;
 }
@@ -112,11 +112,11 @@ static inline s32 rfc3315_s14_backoff_init(s32 irt)
 static inline s32 rfc3315_s14_backoff_update(s32 rt, s32 mrt)
 {
 	/* multiply 'retransmission timeout' by 1.9 .. 2.1 */
-	u64 tmp = get_random_u32_between(1900000, 2100001) * (u64)rt;
+	u64 tmp = get_random_u32_between(1900000, 2100000) * (u64)rt;
 	do_div(tmp, 1000000);
 	if ((s32)tmp > mrt) {
 		/* multiply 'maximum retransmission time' by 0.9 .. 1.1 */
-		tmp = get_random_u32_between(900000, 1100001) * (u64)mrt;
+		tmp = get_random_u32_between(900000, 1100000) * (u64)mrt;
 		do_div(tmp, 1000000);
 	}
 	return (s32)tmp;
diff --git a/net/netfilter/nf_nat_helper.c b/net/netfilter/nf_nat_helper.c
index a12c3470f7fd..6352b180d575 100644
--- a/net/netfilter/nf_nat_helper.c
+++ b/net/netfilter/nf_nat_helper.c
@@ -223,7 +223,7 @@ u16 nf_nat_exp_find_port(struct nf_conntrack_expect *exp, u16 port)
 		if (res != -EBUSY || (--attempts_left < 0))
 			break;

-		port = get_random_u32_between(min, range + min);
+		port = get_random_u32_between(min, range + min - 1);
 	}

 	return 0;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c118476f73ae..d0fd379df6a8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2072,7 +2072,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high)
 	} else {
 		u32 spi = 0;
 		for (h = 0; h < high-low+1; h++) {
-			spi = get_random_u32_between(low, high + 1);
+			spi = get_random_u32_between(low, high);
 			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
 			if (x0 == NULL) {
 				newspi = htonl(spi);

