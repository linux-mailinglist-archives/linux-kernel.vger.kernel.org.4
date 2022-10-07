Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1855F791B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJGNiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJGNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128EA4B8A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665149898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KLExc21YikxYfkGzogVL5HvRLyAIOk3MYbkInTDglKs=;
        b=F8U0yXCt9f9LRmj1P0O3CZ6fGU2uCrng4ayZaNpETXARyN8sm6HFjbk4MP458r6bAL4835
        +ihW7V16qC4xbxA4R1qffbrTx2XJ0GvehFQFl+x3+eH3BXg4MZu0GJNYYoUb6NP/J0h4JF
        iwVG+6l3itLboI1Ts6JxXZpSnu++CWo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-523-Qp0MeFEsO6iVWz7u07bfzw-1; Fri, 07 Oct 2022 09:38:17 -0400
X-MC-Unique: Qp0MeFEsO6iVWz7u07bfzw-1
Received: by mail-wr1-f71.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so1455045wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLExc21YikxYfkGzogVL5HvRLyAIOk3MYbkInTDglKs=;
        b=orAVL950tavy2necg+0pLeo5C5hqdSq63kWLJxPpBmcU4Ur+K72S4bHL+f3t+cZNu6
         /AvR9H6o4cGB9QMSPvM+V5nGHBBXQHBTc/JM8jXxc8mZKcjeQQdmTynK+QpiTCiuJvZe
         N0k48HRjLivsyLG9lkRAfa/RkYWWGB8QXq+H9L8nlJUt8fcb01ujvKw6mC0k7Ju9eU2e
         jvPcwMAGf37ANQXOpwGOe7ocuZ77b/ePPjm/knvED/iZL9fcwuj03cml7dVdYcZ+tcRv
         LKvHzmHAI2JGpjXiiPsmm3gOo4gUTSAvDlTZ4aOqvv528/kjxZA/HlAwodTqPmXjxAzM
         RqEg==
X-Gm-Message-State: ACrzQf18Ycq3l4vhrWn17J3REFJv+nDhaLnI5OOcUglNbRBusTV7zARE
        uFXePkr/gJBOexp6L8VTitkba/O4WihhVKgIohrXkda1Deaj6B3mIVFjrkqHjAOCptEsB3DCPie
        dtvdYicT+OjeAN+0BM99lV+k=
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr3087504wrw.243.1665149895153;
        Fri, 07 Oct 2022 06:38:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70RDA0DD69O0XjxoiDBxjeGXQHA+jCC60Vq1qMN7flnCd8L1EiVTzKLW6Zic2kg6PV2dI03A==
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr3087487wrw.243.1665149894757;
        Fri, 07 Oct 2022 06:38:14 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b0022e3cba367fsm2092740wrs.100.2022.10.07.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:38:13 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: [PATCH modules-next] module: tracking: Keep a record of tainted unloaded modules only
Date:   Fri,  7 Oct 2022 14:38:12 +0100
Message-Id: <20221007133812.804837-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that no module record/or entry is added to the
unloaded_tainted_modules list if it does not carry a taint.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/tracking.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&
-- 
2.37.3

