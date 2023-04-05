Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ABB6D83C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjDEQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2040C9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uRp7zyhJ6Yi3pRFyCp4cjb1Sb4xwEdR02ajcxUWQYvo=;
        b=CoVaFIanPWMi1Hnu1LCc3UUTB46vcWvMfJCtQss9oi7QYfcgXmRoO666tHRS2UpNuaCMlr
        dD5c/Jt38Ar+nvm/gDJWPqx7uO2T0dx1atrzxQ2zNRdjYUFL749rnNAz0wTMZMQysptNqe
        ZRVQO21TmDkEUoR3aiPHQ12yldgDMtg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Y_zvxVkJPgaN4gHkbg8yQQ-1; Wed, 05 Apr 2023 12:36:06 -0400
X-MC-Unique: Y_zvxVkJPgaN4gHkbg8yQQ-1
Received: by mail-qk1-f198.google.com with SMTP id r197-20020a37a8ce000000b0074a59c12b10so2511570qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRp7zyhJ6Yi3pRFyCp4cjb1Sb4xwEdR02ajcxUWQYvo=;
        b=w0vN8PnWiEXaTqGS14ONRuBMcvj0yG4qDSdWmSnrGfbezrDVtOQTQVT2JjUnpYe19a
         UAeYncyv6Kx+KFj7lyiOuv/Gn2pFCJ0tX9I257hdh+Qyk+tlXfySkKeD1XCga05D5Z8l
         rNR/bw0pxhKTMNI1l1lCtXdNGPX6UzqDtrGWFyaqjuSo+ddZtqbhsKwWUcZLKCxKIfpe
         fwKIOWrhsNrFKap2y+2vqAsWbo6kI9cfNdWx3s+GfllwfqX79KWzrCqPUrvtYBwxtz3Z
         HFSqB+Y4cCUlQe41e8VeBObyJ9jrQ0aALT+RtgJTpNgnGWYe+hPzIHQpEkFnm8ygUDpa
         4fGw==
X-Gm-Message-State: AAQBX9fgH4Q4mNVkJn62LK7151ZY1PnoBM0z+dDF9vE1FKL5ZiCz/yuH
        sbzMMSgq1CIxH//k9f3Gt1D0IuTx/W97CCub0/7/1BDwkzNHNyDlghPfPDHDFHkQYrfNHECRM4B
        ykzqfTinPAsdNA1qlDMH8mVI1
X-Received: by 2002:ad4:5767:0:b0:5b8:d0b5:9a46 with SMTP id r7-20020ad45767000000b005b8d0b59a46mr11567508qvx.37.1680712565582;
        Wed, 05 Apr 2023 09:36:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGlChu6azNYa8qce9Yb5zkdt6RTSQjH2/6bi1ChTWjqT6Kw08jFbFTPgEkFhJ0A2saGejIiw==
X-Received: by 2002:ad4:5767:0:b0:5b8:d0b5:9a46 with SMTP id r7-20020ad45767000000b005b8d0b59a46mr11567474qvx.37.1680712565339;
        Wed, 05 Apr 2023 09:36:05 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id da6-20020a05621408c600b005e1235e6f2esm4349493qvb.12.2023.04.05.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:36:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/psi: set varaiable psi_cgroups_enabled storage-class-specifier to static
Date:   Wed,  5 Apr 2023 12:36:02 -0400
Message-Id: <20230405163602.1939400-1-trix@redhat.com>
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

smatch reports
kernel/sched/psi.c:143:1: warning: symbol
  'psi_cgroups_enabled' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 02e011cabe91..c8a556eb9f8a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -140,7 +140,7 @@
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
-DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
+static DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
 
 #ifdef CONFIG_PSI_DEFAULT_DISABLED
 static bool psi_enable;
-- 
2.27.0

