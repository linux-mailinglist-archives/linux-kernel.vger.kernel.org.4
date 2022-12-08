Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AC6472A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiLHPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiLHPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F044AD300
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED35B82438
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1D8C433D7;
        Thu,  8 Dec 2022 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512456;
        bh=cAKcQcV7iFao3mOnMlI+eG//rxDwyNKzE9TaluP3uTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEPzu9Nf19B4upbsDev+PrO9XTZElweiNQgTmQci4ZUiOZCsBUv2NEVUXk62bDvxv
         Fxe9Dxo4ISyT9HrbcqXddJfFTPSDTipvM/OkCZlW29l+pzQ7WbV2cKZEXIg6aH9e5M
         R6atgI6G33paYLZUERyXmpTHgRgOBtX5p8u8ry7lBZf5pQ0EWdHMUo4+ag3KX+0YQF
         +ZuBKjqtP9a0k7x77CdD2Wt5FyJmd18Z6E15gVTYspDy4X6Ks8i9BRTjmxneAJJa6L
         wSZ8K3kAt8zd+kkCg7fJWW0DO2Ht3SC+K1eKNfyjOW08eF+X34xzvyxO3wFLgDatM1
         w+cSCnVwO0Vvg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 16/26] habanalabs: define traces for COMMS protocol
Date:   Thu,  8 Dec 2022 17:13:40 +0200
Message-Id: <20221208151350.1833823-16-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

As the COMMS protocol is being used more widely in our driver,
an available debug tool for the handshake will be handy.

This commit defines tracepoints to various key points of the COMMS
protocol.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/trace/events/habanalabs.h | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/trace/events/habanalabs.h b/include/trace/events/habanalabs.h
index f05c5fa668a2..10233e13cee4 100644
--- a/include/trace/events/habanalabs.h
+++ b/include/trace/events/habanalabs.h
@@ -87,6 +87,42 @@ DEFINE_EVENT(habanalabs_dma_alloc_template, habanalabs_dma_free,
 	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size, const char *caller),
 	TP_ARGS(dev, cpu_addr, dma_addr, size, caller));
 
+DECLARE_EVENT_CLASS(habanalabs_comms_template,
+	TP_PROTO(struct device *dev, char *op_str),
+
+	TP_ARGS(dev, op_str),
+
+	TP_STRUCT__entry(
+		__string(dname, dev_name(dev))
+		__field(char *, op_str)
+	),
+
+	TP_fast_assign(
+		__assign_str(dname, dev_name(dev));
+		__entry->op_str = op_str;
+	),
+
+	TP_printk("%s: cms: %s",
+		__get_str(dname),
+		__entry->op_str)
+);
+
+DEFINE_EVENT(habanalabs_comms_template, habanalabs_comms_protocol_cmd,
+	TP_PROTO(struct device *dev, char *op_str),
+	TP_ARGS(dev, op_str));
+
+DEFINE_EVENT(habanalabs_comms_template, habanalabs_comms_send_cmd,
+	TP_PROTO(struct device *dev, char *op_str),
+	TP_ARGS(dev, op_str));
+
+DEFINE_EVENT(habanalabs_comms_template, habanalabs_comms_wait_status,
+	TP_PROTO(struct device *dev, char *op_str),
+	TP_ARGS(dev, op_str));
+
+DEFINE_EVENT(habanalabs_comms_template, habanalabs_comms_wait_status_done,
+	TP_PROTO(struct device *dev, char *op_str),
+	TP_ARGS(dev, op_str));
+
 #endif /* if !defined(_TRACE_HABANALABS_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
2.25.1

