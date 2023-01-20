Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E1B674CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjATF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjATF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DA619D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674194267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjmOoqTkye3UNXuCyk++rWgNtMqygxPkyWDL4dhhiqM=;
        b=iMVqJj+02lXfv5RHo8ITaqNl3vJtZIDsS0HQW5E3j7vlri5kIHJ/c/tdgCy53iYLFW2YP4
        ezwTgicL3YBY/ST0Ddm+enwzG8BJHMpJPx6OPtoNCMIn+Hiw8gKgXzQqbBWr+6Nc4enKat
        7+5CkxP77jX7zSyD6xvP90K2+EAJcPA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-kgi0r40PNt-4Eh0V51Y9Ag-1; Fri, 20 Jan 2023 00:57:41 -0500
X-MC-Unique: kgi0r40PNt-4Eh0V51Y9Ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E4F2A5954E;
        Fri, 20 Jan 2023 05:57:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-98.bne.redhat.com [10.64.54.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE79640C6EC4;
        Fri, 20 Jan 2023 05:57:38 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 2/2] drivers/base/memory: Use array to show memory block state
Date:   Fri, 20 Jan 2023 13:57:27 +0800
Message-Id: <20230120055727.355483-3-gshan@redhat.com>
In-Reply-To: <20230120055727.355483-1-gshan@redhat.com>
References: <20230120055727.355483-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an array to show memory block state from '/sys/devices/system/
memory/memoryX/state', to simplify the code.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/memory.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..9474f25c452c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -141,28 +141,15 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	const char *output;
+	static const char *const mem_state_str[] = {
+		NULL, "online", "going-offline", NULL, "offline",
+	};
 
-	/*
-	 * We can probably put these states in a nice little array
-	 * so that they're not open-coded
-	 */
-	switch (mem->state) {
-	case MEM_ONLINE:
-		output = "online";
-		break;
-	case MEM_OFFLINE:
-		output = "offline";
-		break;
-	case MEM_GOING_OFFLINE:
-		output = "going-offline";
-		break;
-	default:
-		WARN_ON(1);
+	if (WARN_ON(mem->state >= ARRAY_SIZE(mem_state_str) ||
+		    !mem_state_str[mem->state]))
 		return sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n", mem->state);
-	}
 
-	return sysfs_emit(buf, "%s\n", output);
+	return sysfs_emit(buf, "%s\n", mem_state_str[mem->state]);
 }
 
 int memory_notify(unsigned long val, void *v)
-- 
2.23.0

