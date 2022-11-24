Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF92163787B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKXMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKXMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5E267F7F;
        Thu, 24 Nov 2022 04:03:08 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/reZgs1mHvIik14mC34fwej5ggEtfEoagFzjrvn3iEc=;
        b=BLl7NuwSDvPaBY/66Ul1fZSblOFyy55I6TO9pZIqWAT8KMZTVc/OrrLvTsM5qQMknrY9tU
        PywaGkJLt6xG7uSQTQTWLNVQhvHZe7FoiHItSie1k7/bRPce5TIrlYqqbh1Rz4Ev3KOfTN
        eM6wRKoE8P0MzjT8dqENWVhMDzy1SKg/Qky6t//Q67me7O6vQmS+ILiRCnBCCs59VM9KOz
        KG0/g19Jh6CJP6oCdaYUAttWAAI8Lb1e8bV4lA/FcLIQL9wDG2gao/gMSQbcJH7WaVcta9
        onVX/zzW7zUZwbQECHbRWXQlhQCM5oQuwdm/HA/X/VMwNqbXc1LGNtThoXFFsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/reZgs1mHvIik14mC34fwej5ggEtfEoagFzjrvn3iEc=;
        b=ByZ3wtqn0cyb+WMt2LJjyL9aTR5KdkL0liHd1zZnMjU1PiQmGqau93NM5CilloG2U5Anyk
        4S4tfYwHWQYKNGDw==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Remove the repeated declaration
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221108104117.46642-1-zhangshaokun@hisilicon.com>
References: <20221108104117.46642-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <166929138559.4906.12348858053492188552.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     634a9d5ec78ae2899725950dfb97b98ce7a2f0e4
Gitweb:        https://git.kernel.org/tip/634a9d5ec78ae2899725950dfb97b98ce7a2f0e4
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Tue, 08 Nov 2022 18:41:17 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:18 +01:00

perf/x86/amd: Remove the repeated declaration

The function 'amd_brs_disable_all' is declared twice in

    commit ada543459cab ("perf/x86/amd: Add AMD Fam19h Branch Sampling support").

Remove one of them.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221108104117.46642-1-zhangshaokun@hisilicon.com
---
 arch/x86/events/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6a44aed..0e849f2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1320,7 +1320,6 @@ void amd_brs_enable_all(void);
 void amd_brs_disable_all(void);
 void amd_brs_drain(void);
 void amd_brs_lopwr_init(void);
-void amd_brs_disable_all(void);
 int amd_brs_hw_config(struct perf_event *event);
 void amd_brs_reset(void);
 
