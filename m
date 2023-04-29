Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0B6F21E7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbjD2BOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjD2BOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270F213C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682730835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxUu3MmKtEAkPDdgovuy1mdTL8nMzHcvM/Q3crl2dXQ=;
        b=XZVi1FVjLsx8gCpyRDcuZ4CurB2+S+b+5UMlYQL+pT967ETIoQGFTXRi4c6dvP4M6R+eVh
        kz7KRoJ8zvjmWv37IsKwQQFa6JgfPGD9bYdEW/csON0OtmpI53OvGmj6RxxgIlaq/glLSO
        22GBXY7+eYUa/omDp2P5lacVAdnV7Io=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-i6bcFt89N4qH1SMx6PC-4w-1; Fri, 28 Apr 2023 21:13:54 -0400
X-MC-Unique: i6bcFt89N4qH1SMx6PC-4w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75131c05344so1104304485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682730833; x=1685322833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxUu3MmKtEAkPDdgovuy1mdTL8nMzHcvM/Q3crl2dXQ=;
        b=WExpkyTCXKjY2ma4yP5xjW+9wX8gFyct91g+Soez/jf8E4SDLOHlK85oFeSmcOntud
         /U4dIiQg5orAzB54DB1TxTZZkRCcDMdcM7D+SOvUznFb48+2D9B8WL4JaB67Dh1xFRog
         f/8GS7QjkSO54wS+XpuNa6N/cmsPZesbicz7VAJE6kQ8qR8PFBJZcfev/oWizHGNEeK7
         vr4yKSoquzir/vpF7jYmSgaRaUOm2SO2QCNzEdPLWG7NPvlwrD8iSDUKtdXZWsLKbjvf
         FEMVZE7NRfuKBTjFcZixVaNErl1QXCb0/Spa3R+7rwgcMpCBBOJeoWgz8frBQVrQ4Auv
         2jwA==
X-Gm-Message-State: AC+VfDycPqSjSp1XIJMgd0WsPhMcYi8Uyy8KL1nzgm7MsGxq8x0hW2wY
        TZfUZWVHrtJ0rVTf0Z+OHnaoA2BytdwHQy5T54dqUoP8u5thlM2YUfa+5nMxuqzgGEPIAu7tC9z
        BedXZKcIKjtbaJ50Gc5jRSRaH
X-Received: by 2002:ac8:5b95:0:b0:3e3:9275:17ad with SMTP id a21-20020ac85b95000000b003e3927517admr20651661qta.12.1682730833604;
        Fri, 28 Apr 2023 18:13:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47wQHWzqdZCPnmnzs3TJMwdXQLN9+xR2Qt1w/tzb5WpAKmf0qJd3aRrbCOA0GJUO7+es3Qug==
X-Received: by 2002:ac8:5b95:0:b0:3e3:9275:17ad with SMTP id a21-20020ac85b95000000b003e3927517admr20651654qta.12.1682730833343;
        Fri, 28 Apr 2023 18:13:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ea28-20020a05620a489c00b0074ad0812747sm7143953qkb.77.2023.04.28.18.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 18:13:53 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     airlied@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] agp/uninorth: remove unused variable size
Date:   Fri, 28 Apr 2023 21:13:44 -0400
Message-Id: <20230429011344.2681089-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ppc64, gcc with W=1 reports
drivers/char/agp/uninorth-agp.c: In function 'uninorth_create_gatt_table':
drivers/char/agp/uninorth-agp.c:372:13: error: variable
  'size' set but not used [-Werror=unused-but-set-variable]
  372 |         int size;
      |             ^~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/agp/uninorth-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4ba864..ee67d587cad1 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -369,7 +369,6 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 {
 	char *table;
 	char *table_end;
-	int size;
 	int page_order;
 	int num_entries;
 	int i;
@@ -383,10 +382,8 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	size = page_order = num_entries = 0;
 
 	do {
-		size = A_SIZE_32(temp)->size;
 		page_order = A_SIZE_32(temp)->page_order;
 		num_entries = A_SIZE_32(temp)->num_entries;
 
-- 
2.27.0

