Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C61656254
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLZL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiLZL6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:58:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA26305;
        Mon, 26 Dec 2022 03:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D21F5B80D18;
        Mon, 26 Dec 2022 11:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53192C433D2;
        Mon, 26 Dec 2022 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672055889;
        bh=wSULAFQ9o5Qp1ccx8+zFcSC7eqa2jblW+biQlW4dd/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQZGATooaviZFEzyHo6BhgpTzbgiQvZ3C+MdkxcjwL86SBfGoTwvj709nXOGCuQOZ
         PrWV/ykpvtM+Pvf9xI4MiyoYs2ChMDqNvO4cW6NNV8yhEkwfSppjiVBj/kEaE81st5
         8XLNa+GSNckqD38g2ALoU0XBYAUSYXIyHOoCkp5ritRa6vG8iBg7ycGvuH53cQBnNl
         0IbVpB2NEeC5+27UuzP8hPRfQQs7QfvKgXNFo4RbekuFnUVeS1/27c0k+qhPp3LmZh
         GhJAlsvmLNuovjJMWK0LAGNmYr3BuK0eUkwHbQfBnhiY1IOvjz7MJt0xcbSwDyUZbt
         zYD/nAkxvbl7g==
Received: by pali.im (Postfix)
        id CE4AA77D; Mon, 26 Dec 2022 12:58:06 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Set lower priority for CPLD syscon-reboot
Date:   Mon, 26 Dec 2022 12:45:13 +0100
Message-Id: <20221226114513.4569-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226114513.4569-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to CPLD firmware bugs, set CPLD syscon-reboot priority level to 64
(between rstcr and watchdog) to ensure that rstcr's global-utilities reset
method which is preferred stay as default one, and to ensure that CPLD
syscon-reboot is more preferred than watchdog reset method.

Fixes: 0531a4abd1c6 ("powerpc: dts: turris1x.dts: Add CPLD reboot node")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index e9cda34a140e..c9b619f6ed5c 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -367,11 +367,34 @@
 			};
 
 			reboot@d {
+				/*
+				 * CPLD firmware which manages system reset and
+				 * watchdog registers has bugs. It does not
+				 * autoclear system reset register after change
+				 * and watchdog ignores reset line on immediate
+				 * succeeding reset cycle triggered by watchdog.
+				 * These bugs have to be workarounded in U-Boot
+				 * bootloader. So use system reset via syscon as
+				 * a last resort because older U-Boot versions
+				 * do not have workaround for watchdog.
+				 *
+				 * Reset method via rstcr's global-utilities
+				 * (the preferred one) has priority level 128,
+				 * watchdog has priority level 0 and default
+				 * syscon-reboot priority level is 192.
+				 *
+				 * So define syscon-reboot with custom priority
+				 * level 64 (between rstcr and watchdog) because
+				 * rstcr should stay as default preferred reset
+				 * method and reset via watchdog is more broken
+				 * than system reset via syscon.
+				 */
 				compatible = "syscon-reboot";
 				reg = <0x0d 0x01>;
 				offset = <0x0d>;
 				mask = <0x01>;
 				value = <0x01>;
+				priority = <64>;
 			};
 
 			led-controller@13 {
-- 
2.20.1

