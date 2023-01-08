Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112766174E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjAHRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjAHRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFEBC3D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20538B80AC0
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F312BC433F0;
        Sun,  8 Jan 2023 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198449;
        bh=QXyLYBGTQIYpn1EZArlCDm9z3ZIpm2y0wkuHfDoqJ78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crWcSojsLcEZDkBRyGyiO8WuaKPIsP2VFRj+6eFq8g5lS41nTuL980qx/C8AvCDQ3
         I5yvxwmchYPPtcbrKMMmePd60tKN1kslbcJGaqf38TowK/wYI8eTlLmxsILxl8MhaM
         GNuSkfhDRmxx8mAvC0nHFayGSXz6xohNUwWSEKpKZ/Ja7UjEbs1PK43CvAAxRjC9NE
         eK+pLa9FHrO6CI9c4yWcYKpDqwpC5bH+2iMgPxXbpU/0kbgNCzpR9VPgg8m1Ff1mGv
         75STges8CtSw16uJnQn8jXPnQ6GR91/6OAIRrdW9z2MdwOl2xKjNIpFtxQDpyEy76S
         tt6HxsXddPrtw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/7] habanalabs: define events to trace PCI LBW access
Date:   Sun,  8 Jan 2023 19:20:37 +0200
Message-Id: <20230108172040.3991204-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108172040.3991204-1-ogabbay@kernel.org>
References: <20230108172040.3991204-1-ogabbay@kernel.org>
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

There are cases where it may be useful to dump the whole LBW configs.
Yet, doing so while spamming the kernel log will probably shade other
important messages since the LBW access is done in sheer volume.
To answer this we add trace events for those too.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/trace/events/habanalabs.h | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/trace/events/habanalabs.h b/include/trace/events/habanalabs.h
index 10233e13cee4..951643e6a7a9 100644
--- a/include/trace/events/habanalabs.h
+++ b/include/trace/events/habanalabs.h
@@ -123,6 +123,45 @@ DEFINE_EVENT(habanalabs_comms_template, habanalabs_comms_wait_status_done,
 	TP_PROTO(struct device *dev, char *op_str),
 	TP_ARGS(dev, op_str));
 
+DECLARE_EVENT_CLASS(habanalabs_reg_access_template,
+	TP_PROTO(struct device *dev, u32 addr, u32 val),
+
+	TP_ARGS(dev, addr, val),
+
+	TP_STRUCT__entry(
+		__string(dname, dev_name(dev))
+		__field(u32, addr)
+		__field(u32, val)
+	),
+
+	TP_fast_assign(
+		__assign_str(dname, dev_name(dev));
+		__entry->addr = addr;
+		__entry->val = val;
+	),
+
+	TP_printk("%s: addr: %#x, val: %#x",
+		__get_str(dname),
+		__entry->addr,
+		__entry->val)
+);
+
+DEFINE_EVENT(habanalabs_reg_access_template, habanalabs_rreg32,
+	TP_PROTO(struct device *dev, u32 addr, u32 val),
+	TP_ARGS(dev, addr, val));
+
+DEFINE_EVENT(habanalabs_reg_access_template, habanalabs_wreg32,
+	TP_PROTO(struct device *dev, u32 addr, u32 val),
+	TP_ARGS(dev, addr, val));
+
+DEFINE_EVENT(habanalabs_reg_access_template, habanalabs_elbi_read,
+	TP_PROTO(struct device *dev, u32 addr, u32 val),
+	TP_ARGS(dev, addr, val));
+
+DEFINE_EVENT(habanalabs_reg_access_template, habanalabs_elbi_write,
+	TP_PROTO(struct device *dev, u32 addr, u32 val),
+	TP_ARGS(dev, addr, val));
+
 #endif /* if !defined(_TRACE_HABANALABS_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
2.25.1

