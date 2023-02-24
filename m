Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DB6A179C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBXIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:00:07 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AC22797;
        Fri, 24 Feb 2023 00:00:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AC7E9424B9;
        Fri, 24 Feb 2023 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677225602;
        bh=0OwJlzst8QnGBgBcQk6fTLszxJcN7zyR3Uch+1IED3Y=;
        h=From:Subject:Date:To:Cc;
        b=azST5eqx5b7QMLR8ATMAy34kmbqzXch0+Izv5mG1EgncDMCGkErboRH25vcweteIG
         AZJyBCb7qlgUZDiUZ7BlogzLevTk8RqaXRUt56Ix2atp22x7bQOGHA8zl/PErmMbz1
         lGFmV8w/D5ii9hcnVm5fnUIGL+lCUUK6lIQaPMQLavp5H+VT3JAr0jSr59w3I4B16V
         hHOhPuVS4P4vy6AjigLEEiiuAwK4qsr64pLR/xR8ANts0/2MCtr+7KknxNbEHJeHD+
         KUdzagkuyPXsB53DMxFni6bnubHrBETiUHASNBKkQwkKFiZ9w4EOndrUAGreQoOEgF
         PmxWnEe7YK1VA==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/2] rust: sync: Arc: Any downcasting and assume_init()
Date:   Fri, 24 Feb 2023 16:59:32 +0900
Message-Id: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVu+GMC/x2NMQ6DQAwEv4Jcx4IYRMFXIgrfYcDNgeyAIiH+n
 jvK2Z3VXuBiKg5DdYHJqa5byvB+VRBXTougTpmBGmobog7t8C+yRQzcRupl6qRnyHpgFwzGKa5
 lsOxH/bglL/1uMuvvufqM9/0H5guVzXoAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677225599; l=718;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=0OwJlzst8QnGBgBcQk6fTLszxJcN7zyR3Uch+1IED3Y=;
 b=MsH7fCaHou7xPAAUUnI0ciXy7xK6obm6TD3QPM7GG2vtUQLay6AChAR9KGhsHWG9rlpAgb/C3
 8nkD+GkApjUAVK46Lr2bMjadiDcAr0BbXD7zGYEgc9FzOi7nINvuGkg
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This short series is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

The two patches simply add two missing features to the kernel Arc
implementation which are present in the Rust std version: `Any`
downcasting and `assume_init()`.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (2):
      rust: sync: arc: implement Arc<dyn Any + Send + Sync>::downcast()
      rust: sync: arc: Add UniqueArc<MaybeUninit<T>::assume_init()
 rust/kernel/sync/arc.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-rust-arc-ba3c26ed4e6a

Thank you,
~~ Lina

