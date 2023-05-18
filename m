Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585D7083A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEROMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjEROMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E15A6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684419086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iQwVdHv6Lw8dEb3HJ22Fi/mr3hZkypY/pgo/f+VOrUI=;
        b=Lr3q9aOK/SvN56bWisCTQbcY0L5SLUaSy+7/QwhdqAHtnVvuZWL93g8IcRVnm3QNERGF5+
        7GJclvh4coLzigpFzTwkRFtghurnOqwPderNbBvQLNgvAQr39jUQ/boySYHUGzy9/Ldx5O
        L8Zbbk/do0oAv+f8a7TCMUJSwAdn9f0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-E4oEOimmOEWsAD37Yw1kIw-1; Thu, 18 May 2023 10:11:24 -0400
X-MC-Unique: E4oEOimmOEWsAD37Yw1kIw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6213569ba95so30181476d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684419084; x=1687011084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQwVdHv6Lw8dEb3HJ22Fi/mr3hZkypY/pgo/f+VOrUI=;
        b=h3+XdM7V3rriEVMLE8FTCjsDUFgtrknlz7fj/x0zRg550eOgphIZX6n+hHJYo1hswm
         fCItmze6dRf8Wo3binxYNYW/dMI3cEnh5AKXTarXeAY1GxUuxOgW4VXH6hRfqMsxRLlQ
         Qps5XYE9s/Skf9tKoj3hh651f9daEWfLZVZ6zwMleoFCvBgKxOMMXCPj/oCLL86PffN5
         BMKYuN6VmYPHhY84eec1tNW3MdXlXojsHZo/MadXCwADqUSgNK7/e+njbLVUCsjjjvZW
         damQpCS5qSj4uGfRltBy9ks7XftZYt3ZBlCBdOt4hOVVDLtq8nl9vzlDGJylQFarAf1n
         tM9w==
X-Gm-Message-State: AC+VfDwE9R7Shqwmx72A3+pCV5xm8TFofdrh1xIgIOu5JuEwrxED7NJ/
        sVgsarIMStfkgoWXd1VGtdOy6fgXLK3iuirXgLuiniitNAzHWANKb19P26rml9Qph8ALiniEoX9
        SmZBTQY/A88w/bIAifb4gZRGW2KU/+pbS
X-Received: by 2002:a05:6214:2aa1:b0:607:e40:c7c3 with SMTP id js1-20020a0562142aa100b006070e40c7c3mr5780674qvb.6.1684419084102;
        Thu, 18 May 2023 07:11:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sS63L/DaE4MyDckM9sjRqG00t/bCBaKB4ljyhbTxnxCkkUDcnixiQgVZxf3I21eHBiXouFw==
X-Received: by 2002:a05:6214:2aa1:b0:607:e40:c7c3 with SMTP id js1-20020a0562142aa100b006070e40c7c3mr5780650qvb.6.1684419083864;
        Thu, 18 May 2023 07:11:23 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id dc9-20020a056214174900b0061b7c0ff41dsm549620qvb.34.2023.05.18.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:11:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mm: page_alloc: set sysctl_lowmem_reserve_ratio storage-class-specifier to static
Date:   Thu, 18 May 2023 10:11:19 -0400
Message-Id: <20230518141119.927074-1-trix@redhat.com>
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
mm/page_alloc.c:247:5: warning: symbol
  'sysctl_lowmem_reserve_ratio' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1023f41de2fb..8032fffa425a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -244,7 +244,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
+static int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
 #ifdef CONFIG_ZONE_DMA
 	[ZONE_DMA] = 256,
 #endif
-- 
2.27.0

