Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7776A78B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCBBLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4F16ACD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677719440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cnHHltz+FYOGt7sz4GByaHxQ6kD/wFuAdG0z56vTAmQ=;
        b=czlSOupAVjZ73QqT28BIhPJC8+liPmJOitUALrlnOeiloUUB1bhLf0kowe9LXvCdnIDfvV
        wjuJX2ZUFQZZBylF/TG9jFTLYlm//EW8WRjlSN9hY6IACJXZoerHIoTzIrT7buMA9bO1U2
        y+xGBKAX20pVbZ63ql8seNS8ITYu2UU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Oes6U4NmOv2GP5DIKo1Xxg-1; Wed, 01 Mar 2023 20:10:39 -0500
X-MC-Unique: Oes6U4NmOv2GP5DIKo1Xxg-1
Received: by mail-ed1-f72.google.com with SMTP id h13-20020a0564020e8d00b004a26ef05c34so21767470eda.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnHHltz+FYOGt7sz4GByaHxQ6kD/wFuAdG0z56vTAmQ=;
        b=J79QfNbR7OM8xSCjCM90fkI8/GM2Co81Zbv4IFbuSXDWfsQHsm9dHSbjRzU9Iv/aqI
         2RjrBFqWKpra63O5G/nlI4FdgrZYWLYWvQ8+Z/O92WdHIEeuZBlbmjW3LFnlENnxv5S1
         GTmKxYTzL9tZDChRG/tFcDwGwYPS6pXBHSScx20UzkVKOqGYWMQprgAUpE+72Jj3XR+a
         OES7LN3zbKMW3koN/W2rYHQlkavMZgbRx1yuLltxVDUUN+BQpU5ajJCnAzI0AxVI7oeP
         c+N4A8JtLYO9/v3VMoi7oM9XjOcDUPngimRzRJTHJyQ98ww/WP1dgn/6rSuFkmm2FaM3
         2ZRA==
X-Gm-Message-State: AO0yUKX5WTGEiYbyWG17UHMRJ2Qeq1nhURlkFU87f7+gE5LNUyJ5YSoq
        5SjrW3X8ZHdM+1uS3KKS/ZtVvXSg/uSTT5pz/XJav84nW3r/Hf+EcVy61R0GjqvhgQB+NC6VCbO
        a882teQU8+0iwjQv+e8mqJS0h
X-Received: by 2002:a17:907:982:b0:7d3:c516:6ef4 with SMTP id bf2-20020a170907098200b007d3c5166ef4mr11973456ejc.20.1677719438419;
        Wed, 01 Mar 2023 17:10:38 -0800 (PST)
X-Google-Smtp-Source: AK7set8O/Vwba8NJ+8BhT/FVmIv+eAZGFSdO2VOXLhHhcZjSQYIv5Z3LRYkDPqYqXurp+BH9QMvY/g==
X-Received: by 2002:a17:907:982:b0:7d3:c516:6ef4 with SMTP id bf2-20020a170907098200b007d3c5166ef4mr11973432ejc.20.1677719438139;
        Wed, 01 Mar 2023 17:10:38 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id gr16-20020a170906e2d000b008eb5b085075sm6355004ejb.122.2023.03.01.17.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 17:10:37 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] maple_tree: export symbol mas_preallocate()
Date:   Thu,  2 Mar 2023 02:10:35 +0100
Message-Id: <20230302011035.4928-1-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing EXPORT_SYMBOL_GPL() statement for mas_preallocate().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 lib/maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 26e2045d3cda..3bfb8a6f3f6d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5733,6 +5733,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	mas_reset(mas);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mas_preallocate);
 
 /*
  * mas_destroy() - destroy a maple state.
-- 
2.39.2

