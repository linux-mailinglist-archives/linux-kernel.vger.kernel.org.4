Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993096CFF10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjC3Iuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjC3IuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:50:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72F4EFE;
        Thu, 30 Mar 2023 01:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 955CAB8268A;
        Thu, 30 Mar 2023 08:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026D9C433D2;
        Thu, 30 Mar 2023 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680166209;
        bh=torgI06B/J0R66UMOhGDjGUeyg08LmEJEdr+FuzGCms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z36FJkPvEKhY9/yZVCZlogoD6cMdcQ+fOGHaZohYd9pjXv/MjH3pFtRzdKVI5PQHA
         na+I8m8bw+IEfzNKObO3BBNE4LZ+w3pBvTaKqYpqgQoMmUl40Xzhpn+pgfEzi2m2Hk
         Z2XPV95NyiWRXRe8k0mU+pFva4YURdf5NmGU+NYJyuANtnz3TkTwt+v7xwuE9JV6xF
         X8J8scGiX++7CNXJ6DVFM7hU3DcOoT7ZZ+YN8bMiJ1W4r4K0MRleapyPL1lthZdOfJ
         Zi3Hn8KoGrKVBOStzzCMWEgXfW1fpDKYiOepiy3IztVwdA5pSq0ELQhl0DoOSzc2mg
         Leq6ng5ip5euA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 3/3] arm64: dts: ti: k3-am625: Use interrupt line for Type-C chip
Date:   Thu, 30 Mar 2023 11:49:54 +0300
Message-Id: <20230330084954.49763-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330084954.49763-1-rogerq@kernel.org>
References: <20230330084954.49763-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since revision 1.3 the Type-C chip's interrupt line
is available. This will break Type-C role swap on
older boards, and it will remain in Peripheral mode.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 467e17e28916..5d899b56aed6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -256,3 +256,9 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&typec_pd0 {
+	interrupt-parent = <&exp1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+	interrupt-names = "irq";
+};
-- 
2.34.1

