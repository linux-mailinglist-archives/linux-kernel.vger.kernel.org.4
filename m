Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77796011F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiJQO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJQO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC9186E8;
        Mon, 17 Oct 2022 07:54:33 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klULAhpZTjV6rl9xps3jbm2VcyYIZhUhprV5PhkL+oY=;
        b=KPK+fFneUXp2/wQyWL2E91iF3Y31oFJR6j507SkS2b6vYU2TeciSX1hvg+VAxcwcCdknfP
        qkLsCUmGoe3nndcRiLkbhSff/cnO1LlIpnDVOXUVRtFKvtavw3uWmsaDBjyYt/YdgZyCuy
        htzkSXH78OkRKSsQU6gzz9chvO2vkbirrwrz2UScq2hYHPB4iGZ/BIICWa30cxMSddzBVL
        FHy8ZT3iQ12Ya70rT7X9AkYYQsWi8LuUvCwOdkO5tVfkT33e3KwkdS/EzztIxtEHkdpF5K
        EegomVWFBfPEgllPiuGetuEMl/A6+f0vzkrX4Al245VsH8roMIZFzS2hkyXGig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klULAhpZTjV6rl9xps3jbm2VcyYIZhUhprV5PhkL+oY=;
        b=mSnVvkCJAReQdMJDFU3KQglzb4PHSp03ET78hkUnEejbK3An0fa3vKfR+FVsp994suL0Fv
        YH7dSouAiG3C4PDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/crct10dif-pcl: Remove redundant alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.456602381@infradead.org>
References: <20220915111144.456602381@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845712.401.18228918058416925332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ba1b270c20dfb7f7b7a076b1a97ef4b7dcb539b5
Gitweb:        https://git.kernel.org/tip/ba1b270c20dfb7f7b7a076b1a97ef4b7dcb539b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:01 +02:00

crypto: x86/crct10dif-pcl: Remove redundant alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.456602381@infradead.org
---
 arch/x86/crypto/crct10dif-pcl-asm_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/crypto/crct10dif-pcl-asm_64.S
index 721474a..5286db5 100644
--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -94,7 +94,6 @@
 #
 # Assumes len >= 16.
 #
-.align 16
 SYM_FUNC_START(crc_t10dif_pcl)
 
 	movdqa	.Lbswap_mask(%rip), BSWAP_MASK
