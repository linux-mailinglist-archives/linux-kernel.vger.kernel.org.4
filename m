Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C836DBB87
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDHORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDHORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CDB74D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680963373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=16PACF2Cqi8DglmssJPQj5cwBgWbt6Gz12Izi9hnlTs=;
        b=HW9e8BwUtTPIEIADNY8M5wJVmPNQz5LjFgcn5hA/jO5J6xDooDvsehDppNgDnG26CJylvb
        UZwhpZUq16LZXUAXbu/G5J9PueV2OtndMHvN98ko6m1VXkDhPyuKv/5TyCDpNuWjWmHwn9
        GaOJ8rWH0yTqCI1oKjD7cGOJUk8cv+w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-MVs1OcKtOlyiWQ5RXdSk4A-1; Sat, 08 Apr 2023 10:16:12 -0400
X-MC-Unique: MVs1OcKtOlyiWQ5RXdSk4A-1
Received: by mail-qt1-f197.google.com with SMTP id 13-20020ac8570d000000b003e37d3e6de2so947633qtw.16
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 07:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680963372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16PACF2Cqi8DglmssJPQj5cwBgWbt6Gz12Izi9hnlTs=;
        b=iFSOM3KItcLMrQe7dmUE0shHT0ILpdoJxm96cF12RgfUJFk4tR/pAyezvWoM1qXYWA
         /cFkx0HkyFiS4VJfyKm3VZ5dNm4IZcwOddDme94aGxAgJwxZUbTzki//S5cndyvLOcvQ
         ftUMQ7LaxdG+yC6Qk1P/QhNFJy/fkXvPMmnViKwioqWv6fjrs0EGXm8GP/Q+uuj//XTh
         vMg3TCb/Wc3wO6Zboy19lBxXEOtxKew4MAUWoX1I8pxRJQdGTrDUfpwjrXUy4AUlQoSk
         yb/o9yJuSQG1tmSzehQ0z1vwV6XpK7HJY+9sH44zlflQTLuL60i35fKTXjz2qpEsSuNW
         fT8w==
X-Gm-Message-State: AAQBX9cdWfJe1eoYMd9WgLY2lXudJnZ5eIgw+RouOWpPzcwhpPpZ7ze/
        3m0kDdnHHs5L1K1hQPdY8a5p+5FZIb/9MuIr2EC4vASbnWAeT7hrX7VmoZEdWYQWzOycAIhWBC7
        I+nY8uS3WetOke6AU+w8zdvNc
X-Received: by 2002:a05:6214:2347:b0:5a9:609d:e23c with SMTP id hu7-20020a056214234700b005a9609de23cmr3808809qvb.34.1680963371944;
        Sat, 08 Apr 2023 07:16:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+MFuek8zXfsgwggZbwN/3OOFkmjQaWKdr8ANSLVnRP0Wk1S6eMy9QYpJUKQJaNeGz5hHHSQ==
X-Received: by 2002:a05:6214:2347:b0:5a9:609d:e23c with SMTP id hu7-20020a056214234700b005a9609de23cmr3808792qvb.34.1680963371715;
        Sat, 08 Apr 2023 07:16:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a0e9000b0074230493ccfsm2032569qkm.73.2023.04.08.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 07:16:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mm: backing-dev: set variables dev_attr_min,max_bytes storage-class-specifier to static
Date:   Sat,  8 Apr 2023 10:16:09 -0400
Message-Id: <20230408141609.2703647-1-trix@redhat.com>
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
mm/backing-dev.c:266:1: warning: symbol
  'dev_attr_min_bytes' was not declared. Should it be static?
mm/backing-dev.c:294:1: warning: symbol
  'dev_attr_max_bytes' was not declared. Should it be static?

These variables are only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/backing-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index ad011308cebe..7ed2559b8809 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -263,7 +263,7 @@ static ssize_t min_bytes_store(struct device *dev,
 
 	return ret;
 }
-DEVICE_ATTR_RW(min_bytes);
+static DEVICE_ATTR_RW(min_bytes);
 
 static ssize_t max_bytes_show(struct device *dev,
 			      struct device_attribute *attr,
@@ -291,7 +291,7 @@ static ssize_t max_bytes_store(struct device *dev,
 
 	return ret;
 }
-DEVICE_ATTR_RW(max_bytes);
+static DEVICE_ATTR_RW(max_bytes);
 
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
-- 
2.27.0

