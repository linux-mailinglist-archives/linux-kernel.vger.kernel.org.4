Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F0D63083C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiKSBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKSBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:07:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D8E5B3C;
        Fri, 18 Nov 2022 16:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B0E96280C;
        Sat, 19 Nov 2022 00:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68162C4314A;
        Sat, 19 Nov 2022 00:04:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ER3bEm+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668816277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmwBk/Gz2TqSzFgUZDAtaG0xzco/3QDbfEsP3AkA5Y8=;
        b=ER3bEm+YxSIY1yg4IKdwrGVBIvMx0EUlVXTUxMfaRCCgXiSGPO3attbX+RwqWHBJrgV2cn
        ZJmdFuHQ1uBoWlbelNruvYJZnmHu3eQOW/QrN3q5as703nDtvrbRGN8cnioaYY4cjYuFsM
        oi8VLJg/bH3Xf/sK2zJfv/b7h6cibek=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca956244 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 19 Nov 2022 00:04:37 +0000 (UTC)
Date:   Sat, 19 Nov 2022 01:04:35 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3gdkxq4FjXcmAwA@zx2c4.com>
References: <20221118172839.2653829-1-Jason@zx2c4.com>
 <20221118172839.2653829-3-Jason@zx2c4.com>
 <ecfd265b-49e7-79b2-1818-e08a2c652db0@csgroup.eu>
 <Y3gbVorxZyb4SBJa@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3gbVorxZyb4SBJa@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 12:55:02AM +0100, Jason A. Donenfeld wrote:
> Sorry if I'm a bit slow here to grok what's up.

Okay, I think I see it now. That's a complicated patch for a simple idea
because gettime is more complicated than getrandom. I suspect what you
want is something like the below, correct? Seems easy enough.

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index b253e9247706..b3282d7cfb53 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -41,10 +41,10 @@ static void memcpy_and_zero(void *dst, void *src, size_t len)
 }

 static __always_inline ssize_t
-__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
+		       unsigned int flags, void *opaque_state)
 {
 	struct vgetrandom_state *state = opaque_state;
-	const struct vdso_rng_data *rng_info = __arch_get_vdso_rng_data();
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
 	unsigned long current_generation;
@@ -107,3 +107,9 @@ __cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_sta
 	memzero_explicit(chacha_state, sizeof(chacha_state));
 	goto more_batch;
 }
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+{
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state);
+}

