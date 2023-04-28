Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F86F203B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbjD1VpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjD1VpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E926BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682718276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3xq9b3mzkDMehGF7QYb9iknV9CByKnvhN1KkK6W9vLs=;
        b=LDs7oFJcLUPe5m4BkhhIu1NkczZ09lXsnKHf3KclpXEcHeM4SOjBXQpXE+MIpsKrCVlMsS
        MyMQSIozQ2dXi3/90IFesTCWN9eup/wfnnC7n9TP2kaYm4pphct8wziTIgdn2/0SSN+2h0
        BZsZxLAkcTmLkjTMXjVlJU829JVdmnA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-8FuGuVmrPnKMVceDWB6mpA-1; Fri, 28 Apr 2023 17:44:35 -0400
X-MC-Unique: 8FuGuVmrPnKMVceDWB6mpA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef5e75e89cso2179711cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718275; x=1685310275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xq9b3mzkDMehGF7QYb9iknV9CByKnvhN1KkK6W9vLs=;
        b=cMIWfJysOvylRw6MAzwmRzqp5N8RrYv/SFlUqFVpaDwwVqgvbFKy44kBAO2qQmq1fM
         KJZhhWPXlM2pOMxUi5xJXlmGQF6eKp0UoV0EFYHcBZuQrPMce4Cs1gozjA199DY+HRpB
         3aakvYg96sZzToJ4yXcvKmjDt7iHdYEcQ50luO7pwyUB4Rovnx3/R6TErlcGLwi/AlQq
         gzMoi+mc5Wh32ugU/gS/5CVzvImHT1JGC95uste6jvva6lxAh6jGqseL6pP6OZwC/0sF
         AxFxlZgxxIKgQw2SA8hs4fX7uah4tfQJLxnu9c7YsnWjcQPy1cUrcItPVG2+Q1IAmR/z
         hZsA==
X-Gm-Message-State: AC+VfDxuHhPLoncmYO90YATZWunYZMYSYBQ/LEIL12KcxLezGsNVHb4p
        avlvnB+NZNBQD/7BI+Bi6AjkiW6BKy4cdOHKaQ4fgXmRmw/girks5VNLFvR5o5eR8PdduG+XPQb
        1J+3O4H8IhscH+9qWPrTGqFv1dGJhPlT53bEDZpP0GrYgr7uG5jITPMAaCmRScrk/D5kP3KvU9f
        TTyx0=
X-Received: by 2002:ac8:5f87:0:b0:3e6:98a5:a965 with SMTP id j7-20020ac85f87000000b003e698a5a965mr10550905qta.22.1682718275032;
        Fri, 28 Apr 2023 14:44:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5d6t7CifLW5ybIQrs3PC5MW8uqpNhfWO0PpNvUAUmQmdOvZrV6rRoYpwFmJ0TfXu0ZBIiTxA==
X-Received: by 2002:ac8:5f87:0:b0:3e6:98a5:a965 with SMTP id j7-20020ac85f87000000b003e698a5a965mr10550879qta.22.1682718274658;
        Fri, 28 Apr 2023 14:44:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id or16-20020a05620a619000b0074abe1e1457sm7045508qkn.76.2023.04.28.14.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:44:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] init: Define rotate conditionally on ! CONFIG_390
Date:   Fri, 28 Apr 2023 17:44:24 -0400
Message-Id: <20230428214424.2678669-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For s390, gcc with W=1 reports
init/do_mounts_rd.c:192:24: error: variable
  'rotate' set but not used [-Werror=unused-but-set-variable]
  192 |         unsigned short rotate = 0;
      |                        ^~~~~~

rotate is not used for s390 so should be conditionally defined.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 init/do_mounts_rd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..cbc4c496cb5f 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -189,9 +189,9 @@ int __init rd_load_image(char *from)
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
-	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
 #if !defined(CONFIG_S390)
+	unsigned short rotate = 0;
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
@@ -249,7 +249,9 @@ int __init rd_load_image(char *from)
 	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
+#if !defined(CONFIG_S390)
 			rotate = 0;
+#endif
 			fput(in_file);
 			break;
 		}
-- 
2.27.0

