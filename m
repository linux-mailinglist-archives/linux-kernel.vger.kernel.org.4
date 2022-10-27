Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8760F386
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiJ0JUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiJ0JUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:20:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2951707E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666862403; x=1698398403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=X4HZsC2UHwmsaiEO54dlFpkcDdriC3RIpdAYueIPt+w=;
  b=lFkp7Q5i+uKX3PkeCHCAU+SZftjBd9L+9/XjFBwXzj06EcmBa5KvjVp5
   EPlNXGX1gvcEa0nIvZJ3K5TR7NZnNH4I+NAwhsBdH3RfFcgk/H4eZJdRg
   Ew6FrZ/Hce9WlCBbxU8zPUZ0t/P0OUDXtLFivtKENgQkCO5w4yrBXQ0mt
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Oct 2022 02:20:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:20:01 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 02:19:58 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <mhiramat@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 2/2] f2fs: fix the msg data type
Date:   Thu, 27 Oct 2022 14:42:41 +0530
Message-ID: <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
References: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data type of msg in f2fs_write_checkpoint trace should
be const char * instead of char *.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 include/trace/events/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ff57e7f..7fbfce4 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1404,7 +1404,7 @@ TRACE_EVENT(f2fs_readpages,
 
 TRACE_EVENT(f2fs_write_checkpoint,
 
-	TP_PROTO(struct super_block *sb, int reason, char *msg),
+	TP_PROTO(struct super_block *sb, int reason, const char *msg),
 
 	TP_ARGS(sb, reason, msg),
 
-- 
2.7.4

