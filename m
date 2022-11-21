Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76847632E44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKUU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiKUU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:57:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE2D92EF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:57:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b21so11680163plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=a+8s62R9vB+JzHkkOoet6Cx6GWbxqA3eYfIMwlFnB9o=;
        b=fniv4c5WvNO/fe0wN9wrXEKEfDwyhJUrFdsvKJuO4y8MLgjdPfrmtbqzVu9910adRx
         JhWCrZzOw5Y4TMTcRNRUMinuR1pTJc07Ab2uIsBTenDVRwIWcSufF0FviArIpiMuWU+P
         IPtgSPdMeOKp463RZepfWc5GcgnQ1IXwCnXW25wm8eXMbmVuzAGpXvLVDLRyyao1O19g
         TSpEVqACWSznUcJxTOOQQB2Hl65J4fAhUqLmy4Dld6xq7YGsBTKCXVwuBv4u7AMIz7/t
         DTzDtC7BTLu1NCSJNGzUlPFc5UqYceYH3rDOtzavepUkuWizF7c6H8sq7yXjv7CjjjEH
         Xoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+8s62R9vB+JzHkkOoet6Cx6GWbxqA3eYfIMwlFnB9o=;
        b=1qP5BmzmNpkvXDRZgrOVVE59tb81icoE8hc6E+BM/JxDjAmaTznzeeah2Y58lPAwQ6
         LISQB+nln0rATEMPycZiSlX9avUhRcokROkgHiBYZWMiAfc0s7H9Ei+DClVDV2EL3BkN
         BgQ4ctLTPBzvUNxwpBCXY44ecxGUS0xQI4QBV601YnNdealShspE2Z0qXPsPCxIM8Lyh
         G4Mcju0PX15nu/DFkbraXSi2BVtnVXjfQpy6t2nH8LKhlq8AJ9lzxaU4+jicLztvgFFG
         1tjSFlgaIE4s/Slzn54AW/+wz/2bIUgMOb4Y7VkGMZXQvEziaQV9TN8h8WJb36CLof4U
         VrfQ==
X-Gm-Message-State: ANoB5pnYBVCxJrFUP7atlQhek1eRPd7SolGIJKGyOWK7IsC9h+y5vU0N
        4YdkVM5IrALFeaJ9gIu0tphA5Q==
X-Google-Smtp-Source: AA0mqf5sAA/E/U6YfTqD7f0WABcznW3d/e4KdkkWOwum97uDCHlLJhlE8SujKPDevUBcC4tY/ckbTA==
X-Received: by 2002:a17:90b:3c0d:b0:20d:478a:9d75 with SMTP id pb13-20020a17090b3c0d00b0020d478a9d75mr28239558pjb.149.1669064236510;
        Mon, 21 Nov 2022 12:57:16 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0016d773aae60sm4937091plk.19.2022.11.21.12.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:57:16 -0800 (PST)
Subject: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Date:   Mon, 21 Nov 2022 12:56:47 -0800
Message-Id: <20221121205647.23343-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As per [1], whether or not the core can wake up from non-retentive
suspend is a platform-specific detail.  We don't have any way to encode
that, so just stop using them until we've sorted that out.

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
Events are stopped during CPU suspend"), which fixes suspend on the D1
but breaks timers everywhere.
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 05fe2902df9a..9d1063a54495 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
 	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
 	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
 		return false;
+
+	/*
+	 * Whether or not RISC-V systems deliver interrupts to harts in a
+	 * non-retentive suspend state is a platform-specific detail.  This can
+	 * leave the hart unable to wake up, so just mark these states as
+	 * unsupported until we have a mechanism to expose these
+	 * platform-specific details to Linux.
+	 */
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return false;
+
 	return true;
 }
 
-- 
2.38.1

