Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56A749EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjGFO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjGFO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD1173F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688653706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiEyy1Zz1RJBfezlwrqTDqR5fyYdhtm3nESopN9SQeo=;
        b=bitsf8QC53jH+qq80hQINAg+HDLYDAsZV6UBUhLctL16JHsca1He4G/Sua3B9TNXKMU7Un
        q6ZTOiXFe20ixst3ZGL0nHrLWWkN/jWpsK/i7iXHNsUmTctXwEiMl+QUJFdKoJalgI9zQG
        b6RlHCJbPDK2OYK8KH080Am2q2U90DQ=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-ERAfOp2hMLqOXWJXbggOXw-1; Thu, 06 Jul 2023 10:28:24 -0400
X-MC-Unique: ERAfOp2hMLqOXWJXbggOXw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-78cc6fa9ad0so146570241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653704; x=1691245704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiEyy1Zz1RJBfezlwrqTDqR5fyYdhtm3nESopN9SQeo=;
        b=X5wwIf5ozspL4WwZIDnknB/jwtB5jjFXR5y+UX4rX0et6KerlVg9Sof1+G1iLvMYY0
         g0qQ756MsYgjvtsbjhGl554OuR4DpzVjUO20/W0Dt8sKryhIGHEGJYMxe9Sr0vcCDY5A
         CCPgyA5BJk94dtoooubtwzjTVJUep8V1LvSoed3QpvdC6XC95bqah9NmJX0EQURpRIOL
         BZxIA6xiL9OgGCyHtqvk5cXxg6MKDH5cItF51NgYtXsB5NHMu7SiHJIUELvDr92HNVxo
         u+zFkMhA8wFy4ODoojQX+e/YpyZu/q0YUEeBkSLmpxLABn3qrBMP2gD3EOJPaAYJNmPI
         2SrQ==
X-Gm-Message-State: ABy/qLbL8G3mqSQVxshhZrdpR8WgrmeC74diLY8Yr3xewxk08chCQx7w
        iOikDzNUw+YF1xhKjOuY8KekoRZsJDp5d4ka6JYG7HYz8aPMzHmclEHH/EDlX9f/+hVZeuclLl+
        JNEFsQheOJybXjK0jDsoOHIU=
X-Received: by 2002:a67:f78f:0:b0:443:6792:38a with SMTP id j15-20020a67f78f000000b004436792038amr666508vso.34.1688653704257;
        Thu, 06 Jul 2023 07:28:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHsmH9Qe69ZAE1m+BF0AQJAAi8Bt5cjaVucwH0fzIP7WDlWRFShHuVChIX7676PUfZkjjSNSQ==
X-Received: by 2002:a67:f78f:0:b0:443:6792:38a with SMTP id j15-20020a67f78f000000b004436792038amr666502vso.34.1688653703990;
        Thu, 06 Jul 2023 07:28:23 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id r21-20020a0cb295000000b0063631be090csm923526qve.125.2023.07.06.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:28:23 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 2/2] fpga: bridge: fix kernel-doc
Date:   Thu,  6 Jul 2023 16:27:55 +0200
Message-ID: <20230706142755.124879-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706142755.124879-1-marpagan@redhat.com>
References: <20230706142755.124879-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings issued by the kernel-doc script:

drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'

- Extend the return description of of_fpga_bridge_get() to include the
  case when try_module_get() fails.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a6c25dee9cc1..0b76c67c50e5 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -87,12 +87,13 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 /**
  * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
  *
- * @np: node pointer of an FPGA bridge
- * @info: fpga image specific information
+ * @np: node pointer of an FPGA bridge.
+ * @info: fpga image specific information.
  *
- * Return fpga_bridge struct if successful.
- * Return -EBUSY if someone already has a reference to the bridge.
- * Return -ENODEV if @np is not an FPGA Bridge.
+ * Return:
+ * * fpga_bridge struct pointer if successful.
+ * * -EBUSY if someone already has a reference to the bridge.
+ * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
  */
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
@@ -155,9 +156,9 @@ EXPORT_SYMBOL_GPL(fpga_bridge_put);
  * fpga_bridges_enable - enable bridges in a list
  * @bridge_list: list of FPGA bridges
  *
- * Enable each bridge in the list.  If list is empty, do nothing.
+ * Enable each bridge in the list. If list is empty, do nothing.
  *
- * Return 0 for success or empty bridge list; return error code otherwise.
+ * Return: 0 for success or empty bridge list or an error code otherwise.
  */
 int fpga_bridges_enable(struct list_head *bridge_list)
 {
@@ -179,9 +180,9 @@ EXPORT_SYMBOL_GPL(fpga_bridges_enable);
  *
  * @bridge_list: list of FPGA bridges
  *
- * Disable each bridge in the list.  If list is empty, do nothing.
+ * Disable each bridge in the list. If list is empty, do nothing.
  *
- * Return 0 for success or empty bridge list; return error code otherwise.
+ * Return: 0 for success or empty bridge list or an error code otherwise.
  */
 int fpga_bridges_disable(struct list_head *bridge_list)
 {
@@ -230,7 +231,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
  *
  * Get an exclusive reference to the bridge and it to the list.
  *
- * Return 0 for success, error code from of_fpga_bridge_get() otherwise.
+ * Return: 0 for success, error code from of_fpga_bridge_get() otherwise.
  */
 int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
@@ -260,7 +261,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
  *
  * Get an exclusive reference to the bridge and it to the list.
  *
- * Return 0 for success, error code from fpga_bridge_get() otherwise.
+ * Return: 0 for success, error code from fpga_bridge_get() otherwise.
  */
 int fpga_bridge_get_to_list(struct device *dev,
 			    struct fpga_image_info *info,
-- 
2.41.0

