Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783F67F947
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjA1P6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1P6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 10:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5B301B9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674921447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o1hFi29m2tLFoMSgX1Xxr0wRbhC6bZNV9GQljnutL+Y=;
        b=HFtmEpDR60J8tLGQ1zw3Zr3opRqgs45msReg6mfeSVshekga2dSoJaqS5W3ZroroqS2cf6
        BmTuV6SdueNBfuGS5xS8oxjihjZNE5X0ZVnlRHLyDDGRu/qiEjF1rSmDyD9tzf3TTog7ep
        bb/m4zi4RBEvuM1U55OyWtChtH77rig=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-Iof8SuZOPlmNp0G0cfDb7A-1; Sat, 28 Jan 2023 10:57:18 -0500
X-MC-Unique: Iof8SuZOPlmNp0G0cfDb7A-1
Received: by mail-qv1-f72.google.com with SMTP id jh2-20020a0562141fc200b004c74bbb0affso4200266qvb.21
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 07:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1hFi29m2tLFoMSgX1Xxr0wRbhC6bZNV9GQljnutL+Y=;
        b=W4v4FF0lkFYtbBmjwrhBNsRu+Pqk3Z7Xe5ouLGxy6UL1wJoddhQY6D6sTgoqnbd46k
         uacIYoVKwJlUz0g3g6NgL9ixErHZk2IZ+u1t19dThvijH87MRkHKo1sbnWkBRhUVYrN2
         xHw23BTxgsl3MF8AJ06hNuKOtMsQPBhDlEB7iOuBIA5EaOmoyzqrSb5UigPj9/WPaS+l
         c+HQyQFw503ei5J3+5o5wpiXJkwvruV0udkK38zPZEDFmWgYYmjGYDVlQPrFzqnf7qLK
         C3TLTIBwo1Zhm1P0gnbNTYc/2U1e+oRrk08QoFEWMEIei3yCXos34i3hdoSfiZ/4i4Lj
         Q7Zw==
X-Gm-Message-State: AO0yUKV2e5gB+AugU4Bh+yLdE9KLgc41tSfF9Sj3P3h+GN7r/1zhhXWh
        +wNbxT8pRxi0dlfox63FVp6biuwk4wC0eBwtDcgfLf7/a4ehApp9+uW9SGUsWBot0c+7qQ/IS3U
        jb9h/BUXBFXtZmifkwuXIHdQ3
X-Received: by 2002:a05:6214:1801:b0:537:6843:5187 with SMTP id o1-20020a056214180100b0053768435187mr3021482qvw.23.1674921437682;
        Sat, 28 Jan 2023 07:57:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8IX2UCay4Ef/iP2lKAqWg8juFsr68fQLZ3jV0VloJKIMraw6EqN9kuD0Sk+QICX6ox7Ns76A==
X-Received: by 2002:a05:6214:1801:b0:537:6843:5187 with SMTP id o1-20020a056214180100b0053768435187mr3021473qvw.23.1674921437422;
        Sat, 28 Jan 2023 07:57:17 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n206-20020a3740d7000000b007090cad77c1sm4964200qka.3.2023.01.28.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 07:57:17 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] greybus: remove unused header variable in gb_operation_message_alloc()
Date:   Sat, 28 Jan 2023 07:57:06 -0800
Message-Id: <20230128155706.1243283-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
drivers/greybus/operation.c:365:31: style: Variable 'header' is not assigned a value. [unassignedVariable]
 struct gb_operation_msg_hdr *header;
                              ^
header is only used to calculate the size of the messge.  This can be done without a variable
but rather with calling sizeof() with the struct type.

Fixes: dc779229b538 ("greybus: introduce gb_operation_message_init()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/greybus/operation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 8459e9bc0749..9d322fc6531b 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -362,8 +362,7 @@ gb_operation_message_alloc(struct gb_host_device *hd, u8 type,
 			   size_t payload_size, gfp_t gfp_flags)
 {
 	struct gb_message *message;
-	struct gb_operation_msg_hdr *header;
-	size_t message_size = payload_size + sizeof(*header);
+	size_t message_size = payload_size + sizeof(struct gb_operation_msg_hdr);
 
 	if (message_size > hd->buffer_size_max) {
 		dev_warn(&hd->dev, "requested message size too big (%zu > %zu)\n",
-- 
2.26.3

