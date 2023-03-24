Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43C6C842D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCXSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCXSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E4518AAC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679680789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2SlfuA3seKVuPBc9pms+nyAsg+dbGKkRRSZsZ5fGf6M=;
        b=EaLS/86WNMdA/mWMHZSFHMQDD2qI6kUnNThwFDgh14wsCrRMZkS8qup8/amAftqJ+tIydB
        zG508zbmorL47/A+62+4AhVo9tNLIXTRBRZXt3KkVgnjO6jQVRvnmA3dXmC3U8l0VC0Uhc
        DCRRN8FlHPooZ0eX/zCNRtULAICsdwM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-_YfeOLEZPL-phxbco1FOlg-1; Fri, 24 Mar 2023 13:59:46 -0400
X-MC-Unique: _YfeOLEZPL-phxbco1FOlg-1
Received: by mail-qv1-f72.google.com with SMTP id f8-20020a0cbec8000000b005b14a30945cso1386006qvj.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SlfuA3seKVuPBc9pms+nyAsg+dbGKkRRSZsZ5fGf6M=;
        b=RQPdqLQTL3trW7ZvdjUS3FdhjTpCksAip8ty9EAP2d2BluzCkyEB1cnd1pMrMN8N1E
         brseDKEBWruaGJbToM+AfyN/ktcY8io+ko2VEa7kf5YAoSacxm+cYq0hvlGCpdonOLkB
         5NIjyFvHsiAt3LjTe7/olIv4ooUzZDpWuO1oNADiX3TAkKLERd46pXGIWcQbcfRFINfB
         501NzFPHdHypCLOkYQU78w7rI7r2BMdjT4Zq0lFDeBrAjeaaLFiOelGKaH5aWTY6sITM
         69yGMIqFp5oQVMRDf/hR5E+Hi2HE8vi8hqEkXGNl7NV3RhZww2LMqtpVnrS/J/2edUr1
         LOgg==
X-Gm-Message-State: AO0yUKVQFElAMPvU9wmjBw1rUQXOlwpVtNBApOGKtz6M1oWZusELiofi
        A+2IKWnRHuQGZZBKtgGkWyyY7k/GZchpYdZrDBu6xwOoVgNnUpYOoVIWOQtl4wrlFn/uWm213+6
        t30IpP3cNonT5pWOA8nRjceNg
X-Received: by 2002:ac8:7f0c:0:b0:3d9:cb72:3655 with SMTP id f12-20020ac87f0c000000b003d9cb723655mr6583290qtk.42.1679680785050;
        Fri, 24 Mar 2023 10:59:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set+EpvbTKS6UkAI9qC1M5oisPsBZrKldqHHaYLhOFZliJhezGwoJ4U58KvcHYh8O3HR+0W6PUQ==
X-Received: by 2002:ac8:7f0c:0:b0:3d9:cb72:3655 with SMTP id f12-20020ac87f0c000000b003d9cb723655mr6583271qtk.42.1679680784847;
        Fri, 24 Mar 2023 10:59:44 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id dm40-20020a05620a1d6800b0074411b03972sm1658551qkb.51.2023.03.24.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:59:44 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ccaulfie@redhat.com, teigland@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] fs: dlm: remove unused is_granted function
Date:   Fri, 24 Mar 2023 13:59:42 -0400
Message-Id: <20230324175942.2653272-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
fs/dlm/lock.c:239:19: error: unused function
  'is_granted' [-Werror,-Wunused-function]
static inline int is_granted(struct dlm_lkb *lkb)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/dlm/lock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1582c8b1404c..b9c124b88f15 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -236,11 +236,6 @@ static inline int is_altmode(struct dlm_lkb *lkb)
 	return test_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
 }
 
-static inline int is_granted(struct dlm_lkb *lkb)
-{
-	return (lkb->lkb_status == DLM_LKSTS_GRANTED);
-}
-
 static inline int is_remote(struct dlm_rsb *r)
 {
 	DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
-- 
2.27.0

