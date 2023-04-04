Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1D6D5585
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDDAYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AB1BCB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680567803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hzpxcJajz08AV0XDrocS4qLOzlh9DO1qut/0bGgwnKs=;
        b=QYRREwlrQlpLvCbW0sX823zqNGo1G8Ul9XNL9fOK+99Grzab8tg3NuHRMbPjSzdQTLZUdj
        YP3CfFwkKGytTou+3wm8xWRLSiAePp4T2KXjwrLSQp8jZExmw0gMYPRQzJmCP5JGpyWI/2
        KF+DS60VmyF3FE+igHCU7op7LwckiW0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-OunVatB0PtmucvWBuqXbvg-1; Mon, 03 Apr 2023 20:23:22 -0400
X-MC-Unique: OunVatB0PtmucvWBuqXbvg-1
Received: by mail-qk1-f197.google.com with SMTP id r197-20020a37a8ce000000b0074a59c12b10so8783qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzpxcJajz08AV0XDrocS4qLOzlh9DO1qut/0bGgwnKs=;
        b=HWfVrTMgsbZ8gkHEsDqoUiXEbNcF2hFdRwoecBayQtIjYOBxvX7+ky5/bXEPALYtmy
         YmYKeEX86w9LRE1H+aoAW9etvkDGCw/O+wjwMdBz8vp9yqbq7EDYYqyqckJYjxLleWGr
         IhePa7BPtTd7cWP2AQA1uwjMg1fjWe9hWrhY3NapV+B/nyaa3oqv4Rg8bGfVY7klqNJk
         TQmQHNADSsQ2yDn0YQ1Athl+igac17q/xWtWBaFByxlOSSBMfMn4b/jywOJ1Cj6NtOxP
         VJHZEyjX/4wmdl60BtX3Amzj9SJX8lEbj1hpGmIe8LtZNBX+AKPxGKZyFMvSMHfSxWH4
         E4HA==
X-Gm-Message-State: AAQBX9dwvWDt8fgRGV4hL0ZrOVR0CaEgIfbr5TfWCn8/gTRRTcdRfqbL
        Apuldl632tx0XBqpPX5QmDxFleuplk21Eo+69P3Sq3WhsudsO3fvUDdfWsdEBD+Bb8U6tzo26sU
        hsrXqTjbgerSCfX7tImhSSS9H
X-Received: by 2002:a05:6214:27c4:b0:5d1:d9f3:dd8c with SMTP id ge4-20020a05621427c400b005d1d9f3dd8cmr824016qvb.46.1680567801630;
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdPb8V+zEe8tO8QV/HpoZCorP5igbv0p/6JHM8en2t+h4oeCDRExu1nGN6FXBGC/7qUud/UQ==
X-Received: by 2002:a05:6214:27c4:b0:5d1:d9f3:dd8c with SMTP id ge4-20020a05621427c400b005d1d9f3dd8cmr824001qvb.46.1680567801386;
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cc681000000b005dd8b934579sm3016236qvj.17.2023.04.03.17.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iommufd/selftest: set varaiable mock_iommu_device storage-class-specifier to static
Date:   Mon,  3 Apr 2023 20:23:17 -0400
Message-Id: <20230404002317.1912530-1-trix@redhat.com>
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
drivers/iommu/iommufd/selftest.c:295:21: warning: symbol
  'mock_iommu_device' was not declared. Should it be static?

This variable is only used in one file so it should be static.
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iommu/iommufd/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2deda489a934..9d43334e4faf 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -292,7 +292,7 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
-struct iommu_device mock_iommu_device = {
+static struct iommu_device mock_iommu_device = {
 	.ops = &mock_ops,
 };
 
-- 
2.27.0

