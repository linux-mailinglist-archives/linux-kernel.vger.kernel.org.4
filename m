Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26A69C65A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBTIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:15:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A896A49
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:15:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47607B80A4A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B546AC433D2;
        Mon, 20 Feb 2023 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676880914;
        bh=H13OuIPnoOpwY/dJtekf2XFjYKtpU4yA1/Mz9u7v62k=;
        h=From:To:Cc:Subject:Date:From;
        b=S8SJipjisbs6cd+OioZ63HlBqPnG+Lcg+xfHlKNX6Qnh4dGmugE8fBKYpSn67Jw/t
         SPmpolO/zRDy17Y30aw/0qc4QOXcSRgjiK5ogmaQVSb75uEr5V1WfXOKiJmbkA+Nmv
         yKpWOYY6JBBNxxoxbKW2gJpE4jafz61vqMZ1s2O+d0mh4JqbDfn0YFoBxon268Rf+2
         TXS8ogZTY4I2tCdqo9Hn5QS0q0VnQ9rYWiwu46oSwD22tPo5FjLvyAape9e2BCVGX6
         IN4YZcpVj7Otz3MqbQdNcdyxM0THJQagYAnsPpSvWsBYlPCKmbZ9kpNjf2ZQEktlQs
         4dXSkYic0LVRg==
Received: by pali.im (Postfix)
        id 4369B9D5; Mon, 20 Feb 2023 09:15:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] powerpc: dts: turris1x.dts: Set lower priority for CPLD syscon-reboot
Date:   Mon, 20 Feb 2023 09:04:35 +0100
Message-Id: <20230220080435.4237-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Original patch: https://lore.kernel.org/lkml/878rgtyx2y.fsf@mpe.ellerman.id.au/

Commit https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=e6333293f27cd395e77c6521afd52ff0bdc58107
("power: reset: syscon-reboot: Add support for specifying priority")
implements priority level and this patch just wiring it for turris1x.dts
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

