Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3632678C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAXADu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAXADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8B83C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674518574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Viudg6MoejX0l+blH0qOsZmA3H+aCmAXY+dSPMYU12A=;
        b=Xliz6UEplvRqSrCfqt4+pEnG1+X4pO/qPvBYaboSIiT6Y2xmHaNFVjM/t6wbyI6f00rc5A
        kzibmE+IeCOBPlWnCMLoQwzf4U/BZ8/ZkwOfk2S48Fc1iFhmb6lOsIXRxtVlhNLJMGGGfO
        +4WbitzoROUCuDMVSQZoSph3RQG6b1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ts3hbKqWPQ-brZHtcxct8g-1; Mon, 23 Jan 2023 19:02:50 -0500
X-MC-Unique: ts3hbKqWPQ-brZHtcxct8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F4D1802BF3;
        Tue, 24 Jan 2023 00:02:50 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-98.bne.redhat.com [10.64.54.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 157142166B32;
        Tue, 24 Jan 2023 00:02:47 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, shan.gavin@gmail.com
Subject: [PATCH] nodemask: Drop duplicate check in for_each_node_mask()
Date:   Tue, 24 Jan 2023 08:02:43 +0800
Message-Id: <20230124000243.415621-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value type is changed from 'int' to 'unsigned int' since
commit 0dfe54071d7c8 ("nodemask: Fix return values to be unsigned").
Besides, the conversion between 'int' and 'unsigned int' on the
parameter @node is guaranteed to be safe due to the limited range of
MAX_NUMNODES and CONFIG_NODES_SHIFT. By the way, '(node >= 0)' should
have been '(node) >= 0' actually.

It's unnecessary to check if their return values are greater or equal
to 0 in for_each_node_mask(). Remove it.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/nodemask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index bb0ee80526b2..8d07116caaf1 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -385,7 +385,7 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 #if MAX_NUMNODES > 1
 #define for_each_node_mask(node, mask)				    \
 	for ((node) = first_node(mask);				    \
-	     (node >= 0) && (node) < MAX_NUMNODES;		    \
+	     (node) < MAX_NUMNODES;				    \
 	     (node) = next_node((node), (mask)))
 #else /* MAX_NUMNODES == 1 */
 #define for_each_node_mask(node, mask)                                  \
-- 
2.23.0

