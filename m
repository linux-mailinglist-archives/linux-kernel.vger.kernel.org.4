Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE0749EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGFO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjGFO3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992991725
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688653695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOMqxFOjwhp1sr/qCndFS1unAUJRkXxGEaTi00qWpSg=;
        b=VGbavcYmjoO1rEqbyobi/I90nGkNEIscqr6Fi/8ycC3SPEAvTzoTEj/xp+KOS5/QqaZjt/
        EpmpxWWYGu9GIh5/V5RsO8XNPR90Y/cA9fs7stkxYjFgCXCB7GI0nXQ1x+xbGEU2YeX7xr
        /AYlzM67fDgI4mHtnJLqBZrfXLK7exY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-sZtePH3OMMqonXXz6I_svg-1; Thu, 06 Jul 2023 10:28:14 -0400
X-MC-Unique: sZtePH3OMMqonXXz6I_svg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-634dacfa27bso9444926d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653694; x=1691245694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOMqxFOjwhp1sr/qCndFS1unAUJRkXxGEaTi00qWpSg=;
        b=eYqcgyn6LGBs7GI4VnJ+h+dj3eV2GxV631M2VmoVDJ4GdMBlXV+wI+HJhrpBzwkU5Y
         LEHiZ83mbkR/fqCkO2ezM5AOHbZ7lQT31bz9tqH4EV1zS7mPsuZpB58gxKUBTYqMdYQ7
         /M9rdnjS7eyaq11rWOYAAWEff2PcmM0yoI4jDSeeR3u4tqk79bIXv2RB8PWtQPNNzEzG
         bvVd4YxIyTExn7H0JeAXBphvbjxVX/8s/Q4aMevYkqv5qTASs2rmtcKgWaxJJoDMKZpD
         daPLAHMZCCsvw5hvabWlUzXKUmC1RWvkYRr3aDtgnM9Par2jh+au3w330guWZloQtezC
         amZg==
X-Gm-Message-State: ABy/qLYoKKvOx5n2kOTtr8n8UoNhcyixp/oz1SKU/6vj9rKkfvjfrF31
        Ve31WyIyUG/8pH7VgxWGEtvSDmpFXaT09hFFp4wcHbjt3ws2a9Itdz06Hib94xtXjL1/+r6x9VA
        KxE+PlW/40zTuLJwLJ6GPvW8=
X-Received: by 2002:a0c:cd09:0:b0:62d:fddb:1856 with SMTP id b9-20020a0ccd09000000b0062dfddb1856mr1632414qvm.43.1688653693402;
        Thu, 06 Jul 2023 07:28:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0y438reE5zjXcfDA7xUYnNrfLuDVwrxlHfu4NCHzXOuaLWtwVFf9gTuweECoZsXnlFMPAQg==
X-Received: by 2002:a0c:cd09:0:b0:62d:fddb:1856 with SMTP id b9-20020a0ccd09000000b0062dfddb1856mr1632397qvm.43.1688653693121;
        Thu, 06 Jul 2023 07:28:13 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id r21-20020a0cb295000000b0063631be090csm923526qve.125.2023.07.06.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:28:12 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 1/2] fpga: region: fix kernel-doc
Date:   Thu,  6 Jul 2023 16:27:54 +0200
Message-ID: <20230706142755.124879-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706142755.124879-1-marpagan@redhat.com>
References: <20230706142755.124879-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix the following warnings issued by the kernel-doc script:

drivers/fpga/fpga-region.c:46: warning: No description found for return value of 'fpga_region_get'
drivers/fpga/fpga-region.c:97: warning: No description found for return value of 'fpga_region_program_fpga'
drivers/fpga/fpga-region.c:295: warning: No description found for return value of 'fpga_region_init'

- Remove the "and registers a reconfig notifier" part from the description
  of fpga_region_init() since it does not register an of_overlay notifier
  anymore.

- Remove the outdated "if @np is not an FPGA Region" case from the return
  description of fpga_region_get() and replace it with the case when
  try_module_get() fails.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ccf6fdab1360..c9d065a6961b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -38,9 +38,10 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
  *
  * Caller should call fpga_region_put() when done with region.
  *
- * Return fpga_region struct if successful.
- * Return -EBUSY if someone already has a reference to the region.
- * Return -ENODEV if @np is not an FPGA Region.
+ * Return:
+ * * fpga_region struct if successful.
+ * * -EBUSY if someone already has a reference to the region.
+ * * -ENODEV if can't take parent driver module refcount.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
@@ -91,7 +92,7 @@ static void fpga_region_put(struct fpga_region *region)
  * The caller will need to call fpga_bridges_put() before attempting to
  * reprogram the region.
  *
- * Return 0 for success or negative error code.
+ * Return: 0 for success or negative error code.
  */
 int fpga_region_program_fpga(struct fpga_region *region)
 {
@@ -288,8 +289,9 @@ static void fpga_region_dev_release(struct device *dev)
 }
 
 /**
- * fpga_region_init - init function for fpga_region class
- * Creates the fpga_region class and registers a reconfig notifier.
+ * fpga_region_init - creates the fpga_region class.
+ *
+ * Return: 0 on success or ERR_PTR() on error.
  */
 static int __init fpga_region_init(void)
 {
-- 
2.41.0

