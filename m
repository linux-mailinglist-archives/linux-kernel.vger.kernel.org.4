Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EF6AE29D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCGOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCGOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:33:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4DC7A90F;
        Tue,  7 Mar 2023 06:28:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7AEE7426E8;
        Tue,  7 Mar 2023 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678199305;
        bh=PLNwTx966zByawYI9/x7zPg7nR2YAfsS2pH/0itkzOI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=NzazbWrvDmMavYRtui5Bhfs+u+J04jGyXpZVZtoYyF3xQqMtKMYT2GZx5PvDRsm/e
         w3R2yDcXKlby6CeAko/nDjv33/b+TqqkjCDjjxqGZoryIAT09hbYc5lBBtC20slhoX
         PM4NsdCzE/6fPFfIZtI5Y8URge/uP2kj2LHqzKFieNg37kJBpwG8nP7nzj51FgWN4C
         /0LfQa+Re1R9H4/EB2yMqoE8dZhcitUfrwcLo44JkslEVJTwgQ14i+xnO3BdHQL0/N
         jIi1IOSkF6gG/2F2gFlcWSoWYUqhIkf2J8wOoWwGFMv5Qm1HHamYDJ81VZKLDWzQLY
         SFVO72HCjH8eA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 07 Mar 2023 23:25:39 +0900
Subject: [PATCH RFC 14/18] rust: drm: gem: Add set_exportable() method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-rust-drm-v1-14-917ff5bc80a8@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678199191; l=1043;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=PLNwTx966zByawYI9/x7zPg7nR2YAfsS2pH/0itkzOI=;
 b=MjFE04ydpFUIDjxSVNQLI84A5BtCxwGQPMyQgPalsSvbYqggHyxs6a9C0P0EIP/PLFM9RVKhD
 fHOskSTk3+WA8ZFMMr/ZHXxfKAlDqdNPAOYtZsZ2Vxzc7VvQoLpGV/a
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

This allows drivers to control whether a given GEM object is allowed to
be exported via PRIME to other drivers.
---
 rust/kernel/drm/gem/mod.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e66bdef35c2e..196252a25b5a 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -135,6 +135,13 @@ pub trait BaseObject: IntoGEMObject {
         self.gem_ref().size
     }
 
+    /// Sets the exportable flag, which controls whether the object can be exported via PRIME.
+    fn set_exportable(&mut self, exportable: bool) {
+        // SAFETY: gem_obj() is valid per the type invariant, and this is safe to write if we
+        // are the only holder (mutable ref).
+        unsafe { (*self.gem_obj()).exportable = exportable };
+    }
+
     /// Creates a new reference to the object.
     fn reference(&self) -> ObjectRef<Self> {
         // SAFETY: Having a reference to an Object implies holding a GEM reference

-- 
2.35.1

