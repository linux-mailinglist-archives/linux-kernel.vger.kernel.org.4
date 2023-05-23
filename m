Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7870DC84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjEWMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEWMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6E1A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684844610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZcdS5ZYCFqiP7jrSNIfHlTxhn1+gXnyqS/hyK8+OMEQ=;
        b=TszuQseAkQ0rgSkxBeHkJw6l9NZh8Ej5AegkNxCwk6+3ClfYw0Vweofml7bp2ISB6VU8Gg
        0FecIaB0pUFd7ethi6tEyTD3e9lQlFW8Ehh1yF8td9kV7uboX0ZioW/BH5aUBLlZ0JxUtA
        9FXz5g33b/k7BnHIG7TdgakkYtauQYU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-1OEZhNzWOV6RD7ZlSSVdyA-1; Tue, 23 May 2023 08:23:29 -0400
X-MC-Unique: 1OEZhNzWOV6RD7ZlSSVdyA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75935a16b8eso578014385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684844608; x=1687436608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcdS5ZYCFqiP7jrSNIfHlTxhn1+gXnyqS/hyK8+OMEQ=;
        b=IB7LdDdPnSzWRp2TosX9zdDWLWbpEzWoMo0Pgvj8SjI5j6sygLJtlRMqTkRGKqkmDt
         prciCgE4aTDDtPD/fYYsl8m4cChGitSVCjKytUSPMqlO+0trCBv2qbY8D7eFXzKVtFKy
         15qyrSzXtZ+fqba+jKiYxJSXveA2Ixck65EUDIv3ZH8xuo3YttUOoewohsm+lwaamwws
         tJnYLtLw6We6WOHdAbZ/+jbuZV1a7vwiBokmHx66NtitNUYEoVZLPnBeTFu0S/amKecA
         yklxbLNeG5nafZHLQ2740c6fC1eHqhC/+Vtui6Ledy5ld92YnDlZxpG16qqvFLx/H4gH
         QY1A==
X-Gm-Message-State: AC+VfDwDO1LZc9aqCJU8xE3ehch60akKCSqm0glsVKoQD9kVEXd0vMWJ
        ubWD1+B54JRnLD7zfJ+iPqwlia3J7oZklDoItRdC/5aP4OTIuoZdCZbhtRs/3Ip/Iut13CLtcH6
        J4Knjsz0DkXQVh3twij5xBIU8
X-Received: by 2002:a05:620a:85b:b0:75b:23a0:e7b9 with SMTP id u27-20020a05620a085b00b0075b23a0e7b9mr3925117qku.26.1684844608654;
        Tue, 23 May 2023 05:23:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OkJ4+ngoCOz2Nvt1fCAFY86/rFVTzN+eippzTrgANV1PkY48JHhCiID6DyJAXgEc1KmZrVA==
X-Received: by 2002:a05:620a:85b:b0:75b:23a0:e7b9 with SMTP id u27-20020a05620a085b00b0075b23a0e7b9mr3925099qku.26.1684844608408;
        Tue, 23 May 2023 05:23:28 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v21-20020ae9e315000000b007594229600csm2465379qkf.81.2023.05.23.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 05:23:28 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     akpm@linux-foundation.org, dianders@chromium.org, pmladek@suse.com,
        kernelfans@gmail.com, lecopzer.chen@mediatek.com,
        ldufour@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] watchdog: set variables watchdog_soft,hardlockup_user_enabled storage-class-specifier to static
Date:   Tue, 23 May 2023 08:23:24 -0400
Message-Id: <20230523122324.1668396-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
kernel/watchdog.c:40:19: warning: symbol
  'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
kernel/watchdog.c:41:19: warning: symbol
  'watchdog_softlockup_user_enabled' was not declared. Should it be static?

These variabled are only used in their defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 877d8670f26e..237990e8d345 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -37,8 +37,8 @@ static DEFINE_MUTEX(watchdog_mutex);
 
 unsigned long __read_mostly watchdog_enabled;
 int __read_mostly watchdog_user_enabled = 1;
-int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
-int __read_mostly watchdog_softlockup_user_enabled = 1;
+static int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
+static int __read_mostly watchdog_softlockup_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly watchdog_hardlockup_available;
 
-- 
2.27.0

