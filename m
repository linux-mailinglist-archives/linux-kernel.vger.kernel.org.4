Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01CA6F597A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjECOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjECOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BC5FD3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683122483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Il2Tq+zS33ksY9INyL3IhsljNXln+sovSvsBut32DE=;
        b=IF8b28f0yZJpzh+9B/TYlkY5ViL39w9jvkXOeiOMcFQx7bPiKoaNjDyCNczo8Kyb1reiNs
        6xwMuA49bAEjY6bEyoSQUET/aSYVAmthUSp07TfIeyMPbDYiQ1YcD6BtdNQwT2PVfU2e3A
        YPmmChMC3YRirjqdanXl6dUX89MChec=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-zqXPoXx_O52LthbFquJypQ-1; Wed, 03 May 2023 10:01:21 -0400
X-MC-Unique: zqXPoXx_O52LthbFquJypQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34a0b75eso467689166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683122476; x=1685714476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Il2Tq+zS33ksY9INyL3IhsljNXln+sovSvsBut32DE=;
        b=KTFaiCShRGlzwySMqX0mBr2w9psTx/W2GZequBY0y+nego8eufassYCN1CCRLhAr72
         0dBUOAEvbbkNP8pwWo7getJ8M3uRrUYgAH84CQeSpZGHTGkult+ORCt081Yp9dt6zhwd
         xsrmb4Vo1aXu3kNpV7RTErJaiCIHm0f/HzPNX32RTVksznW1pSs2Ji+9BsHFUMm2dfJn
         CZHzBka7z6zW9t9BtgzYaL6tArItNUPdzOwcE2l/ZeRH22Md8ecv9Cwxfai8TmSpJd4/
         9q7gEeEQthoc9WJKfEPXbaCkHUNu5GCk2NRCKMAkeWOcxG7buo5mJnC/npePFekTx+QM
         I1Rg==
X-Gm-Message-State: AC+VfDyjuzkkxtIfcssvDai9bpOQniUg3BBG4v/nJv2WFQLmEEfyuI87
        8Evd0QIGgUAoIaW1tA2rgwPW2x5ony2Vt/ulBZTSmGGwDm/N7hMbTna+sjv3rEEELUKekbSA5JE
        CrTJYm4sCh3XEU/j2lF5S2Ctn
X-Received: by 2002:a17:907:daa:b0:94f:3eec:f6b5 with SMTP id go42-20020a1709070daa00b0094f3eecf6b5mr3366048ejc.57.1683122476183;
        Wed, 03 May 2023 07:01:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VGaXLvHuYIGWrNA1RjvkxhdE9GKsPgniiA5ySFOrm4GhYLdn+pfujLnUmJ0M1BEq8eVZZ4Q==
X-Received: by 2002:a17:907:daa:b0:94f:3eec:f6b5 with SMTP id go42-20020a1709070daa00b0094f3eecf6b5mr3366020ejc.57.1683122475887;
        Wed, 03 May 2023 07:01:15 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id re4-20020a170906d8c400b0094a82a236cbsm17196221ejb.129.2023.05.03.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:01:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix permissions for the buffer_percent file
Date:   Wed,  3 May 2023 16:01:14 +0200
Message-Id: <20230503140114.3280002-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file defines both read and write operations, yet it is being
created as read-only. This means that it can't be written to without the
CAP_DAC_OVERRIDE capability. Fix the permissions to allow root to write
to it without the need to override DAC perms.

Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c365..e278f4202a7ed 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9655,7 +9655,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
+	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);
-- 
2.40.1

