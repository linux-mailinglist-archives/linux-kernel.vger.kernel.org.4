Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFB6D6903
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjDDQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjDDQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429CA3C15
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fTZoJOKUVJY/f2KQDosLCvsRFwkdojmnGGHVyYY0hj0=;
        b=Xjv3iuveEI0cQo8StTIHUm1pmxSK9iQGCITdAh3LyNxOwXvQxr7/JZLtI5pYv8yc3x0joh
        TtQ/zLQrr2zudNmGJOVjxVg0edjO/ZihMEPVjvmYLCoZDWuJuBjFZ+D9pnzU1cz7QSAg9e
        vwYeEXgprUpRilmJ3EbA1S5W8Kli6R8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656--p0ZaElmPy6yeH4Jz71EPg-1; Tue, 04 Apr 2023 12:36:33 -0400
X-MC-Unique: -p0ZaElmPy6yeH4Jz71EPg-1
Received: by mail-qt1-f199.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso22496680qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTZoJOKUVJY/f2KQDosLCvsRFwkdojmnGGHVyYY0hj0=;
        b=br3mY1Bjh1KGaZQxdkMvKto0EnSSL2UWIFI9R3+oscg1Mxer0hCPb56B3NVeBpxF6y
         BQq5sQFlDVOQIAdafrkE34VRVRBAs60OOe9T3Ag/zOTSnWqO6PEyeWIisS+fTk4VKEbN
         cxTErlp14+qICTaq38jLTMjVT6pDYpTIFO9jqqetYeM4PBLLtmNNCy21EFhjeRGJdLmg
         50pve1ikp3TyWwTZnzCTgO1hEI5S+bUFe9gNyVxpZhExOJfiySqmqz/XccY75g0fbraA
         MT942owoSJbN12beQJ0v4lQOQrF/5asYoGIC8qPqYynid0ksSq+OpxvDn2j6zsCw2It0
         YBnw==
X-Gm-Message-State: AAQBX9cLCilNTNORadZvK7pgKKK7hvQ/saTKRjJq+7bWIcXweZguw/7u
        b0kjQpxruZ4vG5yeDUY53KSBiezhI7ToZsM7Kmm452bTDZOpHTUeqsP8LrWmO+O4JqXPJkLhXa7
        8m8yci1JYsHRftwrzt0WAyIkO
X-Received: by 2002:a05:6214:f05:b0:5df:47e2:8df5 with SMTP id gw5-20020a0562140f0500b005df47e28df5mr4656683qvb.31.1680626192430;
        Tue, 04 Apr 2023 09:36:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z0rbHNsX4JqcOdMeDlPBHQD33te85KEufGinrShuSNRFSQ5MqzvBgQ+U2JWE9SKv33AfRqrA==
X-Received: by 2002:a05:6214:f05:b0:5df:47e2:8df5 with SMTP id gw5-20020a0562140f0500b005df47e28df5mr4656660qvb.31.1680626192211;
        Tue, 04 Apr 2023 09:36:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a049000b007468ad71799sm3696027qkr.64.2023.04.04.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:36:31 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     michael@walle.cc, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout storage-class-specifier to static
Date:   Tue,  4 Apr 2023 12:36:29 -0400
Message-Id: <20230404163629.1923871-1-trix@redhat.com>
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
drivers/nvmem/layouts/sl28vpd.c:144:21: warning: symbol
  'sl28vpd_layout' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvmem/layouts/sl28vpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 9cc1715c2fd5..05671371f631 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -141,7 +141,7 @@ static const struct of_device_id sl28vpd_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
-struct nvmem_layout sl28vpd_layout = {
+static struct nvmem_layout sl28vpd_layout = {
 	.name = "sl28-vpd",
 	.of_match_table = sl28vpd_of_match_table,
 	.add_cells = sl28vpd_add_cells,
-- 
2.27.0

