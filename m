Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0436AE29E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCGOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:33:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA37659E;
        Tue,  7 Mar 2023 06:28:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9773D4261B;
        Tue,  7 Mar 2023 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678199320;
        bh=IHBFh1p5NyHgt8gvoelp3FjaqhLt2Kb0Z3qVKYeXOdA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=h2srMFberg2ar42BciBp2T7cZs0r5shq2P0JO3QjUsxOSin6WJjNGQt8O9BFC3Mm9
         RmOByQ5GjAayiskLq3j6O537VbLpqEpJECfmqh7HVRN3loyCsyMrUheWI9qWm9s1Eo
         jT61rZQD7uUbslS2NbKDSA8O2Q7jgY0T7o0VSfs7OEqbf/cEUP9KBk2b2aB0UwOX5r
         TUgy/AjztHbk1UKMJq34coDNE/EPadHFGI118XgAMrbdBK5FIdzyiVtudxfbhPtgUv
         L7b8YoB/MD/NkNCpHht09obReHlsuwunHAv/PZUBC1XXY/6YkLymjrCX8tmvTyqpE6
         wvZlhqdR8YD9g==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 07 Mar 2023 23:25:41 +0900
Subject: [PATCH RFC 16/18] rust: bindings: Bind the Asahi DRM UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-rust-drm-v1-16-917ff5bc80a8@asahilina.net>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
In-Reply-To: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678199192; l=634;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=IHBFh1p5NyHgt8gvoelp3FjaqhLt2Kb0Z3qVKYeXOdA=;
 b=wkeUw1/4v9Ab0PfwNo+jl9En/WC72prGsQJCMySNRiL0kR7MponwPpCU1MUn2TIUBmAy343h5
 5r7eQI3fZzOChdQd3fPBlNVcvU1ltpg4wdV0XFkDAdRHwRgurJDACCZ
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Asahi UAPI to bindings_helper.h so Rust code can use it.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index dc01be08676e..e21c87e6d317 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -35,6 +35,7 @@
 #include <linux/sysctl.h>
 #include <linux/timekeeping.h>
 #include <linux/xarray.h>
+#include <uapi/drm/asahi_drm.h>
 #include <uapi/drm/drm.h>
 
 /* `bindgen` gets confused at certain things. */

-- 
2.35.1

