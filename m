Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463C362E16E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiKQQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbiKQQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7678D7B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88DB662182
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23551C43470;
        Thu, 17 Nov 2022 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702007;
        bh=i1lZPKuAFPDspEiLg7DUBaeK7ssl4ie66mV57kFz+x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7nnKZwxxwouXwf6GsGK/ZGiKV8/DUcMCQDodY5FnOYA22S93q4kOtWvwq7JPGFNS
         AbJPQuhKqpsiRRV8mJpgvzMn3kRUPdrfdKzR74577EpIBAboxg3jDOStZbhBDuOHpo
         3XAtQulhyyz4jvT9RB1qN/3WDG5i1NnceWD/Qdqa/7GoSK/oYXCx5cUZoRhiIOh6z4
         DloKg2xKL8kbFUjykPovknEOGTC0sZ20kOZoX8z2T8YrX9LM+r1UXHM8fuAB9CtKD2
         Kgytvg5A53ps0+pojrxr5q7/wXJV+UZEOO2+OSQjVCHq4U8UKk/IEtiCMp1JRItwd2
         IMR4IV+FJ2Zog==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/20] habanalabs/gaudi2: classify power/thermal events as info
Date:   Thu, 17 Nov 2022 18:19:40 +0200
Message-Id: <20221117161951.845454-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As power and thermal envelope events are pure informative and not
indicating an error, we reduce the print level to info only.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 59940c8df2d2..61960fa059e0 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6828,6 +6828,7 @@ static inline bool is_info_event(u32 event)
 {
 	switch (event) {
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
+	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_S ... GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
 		return true;
 	default:
 		return false;
-- 
2.25.1

