Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC5E72AEF0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFJVKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFJVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C9D30F9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686431378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=whk8LCDI/O2jXvvaBN0dOJYkF+7e5dfH9oNJPu7ipD8=;
        b=isnlwTrc2poQmUliVrMy3ttu2yXSEUNgCt5qAJNM/Gz7aYGl6K4vy5xM4ugGBxwmIYg4cn
        F6F0MN9+CrpJlL4Nov2cgtGCONSKX+cRjduYk6xYfC6NxlElwDIlBxZ01XUAGHPD+j2J0c
        iUGwSihQ2g4SpGWJiMyU35l1aa+9/6w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-TnEQyrmPNG-WzzKEU-U_Tg-1; Sat, 10 Jun 2023 17:09:37 -0400
X-MC-Unique: TnEQyrmPNG-WzzKEU-U_Tg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f9ec5ab50dso6533571cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686431376; x=1689023376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whk8LCDI/O2jXvvaBN0dOJYkF+7e5dfH9oNJPu7ipD8=;
        b=KvPUEc31oQz3vq8A7UWPQ6X23nXMeNy328hAfbd6iyWwUi/Kl3RgLznfaoI4j/w0xx
         Hib9fyFsjsFFJo1MQjyalgMOP3GRk7t6T03k8HNLc0tmHk4Bri2d3WrMCY6ttkP5z+kb
         YA2VGrLnTewCmTB3UIjLnIrSTV9ES3RxeJweXVoS8D196bYnLefrOKtT+JBm4BcmDWZM
         w6uTfzol7yJlIPLCWRZfVniQ0etq4cmSTebrB8xum8TOb/oV5eBqMIRTby/g+Z0oGwAd
         mAbKwgPtpg+7E0HF8PQVH5v1hZ9L0cWWxMprAf8TsAu34O4IJKCQBhnTmpLmsl68br83
         YV/Q==
X-Gm-Message-State: AC+VfDyovPKzj3bZHDkKnJAnwJyqhx+pgf8mHKctavGIzE1qFgcDmNSC
        vwQtj8Ivo07OzQHWmF3pm5Py5mNtX34QxZbT63H9b9d75S3ZJUuo38VfvSOH3C/xYxq8Rc3OSbo
        wFcYuPyVhwo3uDrcHQiD0uGH/
X-Received: by 2002:ac8:57cc:0:b0:3f9:7251:30f4 with SMTP id w12-20020ac857cc000000b003f9725130f4mr6276324qta.4.1686431376743;
        Sat, 10 Jun 2023 14:09:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6/m5cQYtKIkm5rXShhXYKAKgeTgWN14pGp1pXpg4ts/5g4vJjRVW2y96C7y3gT18cObtLJGA==
X-Received: by 2002:ac8:57cc:0:b0:3f9:7251:30f4 with SMTP id w12-20020ac857cc000000b003f9725130f4mr6276306qta.4.1686431376496;
        Sat, 10 Jun 2023 14:09:36 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d20-20020ac84e34000000b003f6ac526568sm2187472qtw.39.2023.06.10.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 14:09:36 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC/amd64: set variable gpu_node_map storage-class-specifier to static
Date:   Sat, 10 Jun 2023 17:09:30 -0400
Message-Id: <20230610210930.174074-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/edac/amd64_edac.c:990:3: warning: symbol
  'gpu_node_map' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5d7c080d96a2..597dae7692b1 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -984,7 +984,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
  * system and what the lowest AMD Node ID value is for the GPU nodes. Use this
  * info to fixup the Linux logical "Node ID" value set in the AMD NB code and EDAC.
  */
-struct local_node_map {
+static struct local_node_map {
 	u16 node_count;
 	u16 base_node_id;
 } gpu_node_map;
-- 
2.27.0

