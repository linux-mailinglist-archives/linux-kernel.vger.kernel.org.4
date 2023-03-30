Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2DB6D0D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjC3RqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjC3RqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DCEC46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680198314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zFHJsI5sKs0NfMxgYnvDFDcHAOkfJF585rJ6FieeSVw=;
        b=IuFAxwKgPzwPRAhd/AAMzUoKRmdzWaC8x7uFYlFiYOK2AKZFMhmTE6iK/SHj9BNoScefgu
        dF1ebt0O5my5jpPWap/gdhfz7TfHVoXWciTC9p+BqErpjSlnDbJjhXJJqFLPIQHg3jos2V
        KAVaxlFzKDrNrlRntYUAV0W4TD+r8tw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-N_Kl8hagPbq22SZ6rYGGLg-1; Thu, 30 Mar 2023 13:45:12 -0400
X-MC-Unique: N_Kl8hagPbq22SZ6rYGGLg-1
Received: by mail-qk1-f199.google.com with SMTP id s12-20020a37a90c000000b007468eaf866aso9278139qke.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680198312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFHJsI5sKs0NfMxgYnvDFDcHAOkfJF585rJ6FieeSVw=;
        b=KCjmOkjPrTntK6OwCEv1yVnFHlmDbAdQNAUDvSbWp1UClWmvvuHtqWQDgazMjA+hY/
         vcdwisIcWY3umkAjF9vZk4R79cKyZgVVQGvm6cqsqdfBF9/Ddy1/uds8hi+FD76AHJTZ
         gkfuk8yX4iORmmwXf3gzXwctYY6ZgZpDaCcP3ZBvWlFv1wjdBuq+NBwH4PRJSrOmuOMd
         NDPLqUGD2QgQsdhZ5N5XsubUqtsKj0qQA0x15w2YJ4JDhajTMvbMfg0vKxdwT9oV81w9
         H3pFKlvgi6+UTi5YPyVrYeOW/yXLVG4Jgj5vLaqt9OvmI6XfzZ+SpymVnZekpxoFE2A1
         3smQ==
X-Gm-Message-State: AAQBX9ftVllmx0OlHB07PbA86VqxSxDhVSthNZzXmrnf4auQ4QncoEp7
        pq2mui2OK9XdKMtpYWWujMUzHl6W5Rpp0MHyUF9Y8P7R4L2hZfHqBUufkIbUUh+IHX0EPmbcuhB
        la/QXe3QQCFl+yGhgURyZJt4=
X-Received: by 2002:a05:6214:1250:b0:5b3:4b99:7af8 with SMTP id r16-20020a056214125000b005b34b997af8mr44775138qvv.21.1680198312111;
        Thu, 30 Mar 2023 10:45:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350ariQ87RdJ0VcpoAgQ3Sx2ZHteZahOR7nJo9jl0xg1qA780ZHw2Lm9yDJyy0l+2r3m8dznbNQ==
X-Received: by 2002:a05:6214:1250:b0:5b3:4b99:7af8 with SMTP id r16-20020a056214125000b005b34b997af8mr44775066qvv.21.1680198311657;
        Thu, 30 Mar 2023 10:45:11 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a0e9600b0074230493ccfsm19478qkm.73.2023.03.30.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:45:11 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: fix kernel-doc
Date:   Thu, 30 Mar 2023 19:45:05 +0200
Message-Id: <20230330174505.158920-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
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

Fix the following warnings issued by the kernel-doc script:

drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'

The patch is based on top of 38dbcd697770 ("fpga: bridge: fix kernel-doc parameter description").

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index ff4470067ed5..adb4a79a1b11 100644
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
+ * * -ENODEV if @np is not an FPGA Bridge.
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
+ * Return: 0 for success or empty bridge list; error code otherwise.
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
+ * Return: 0 for success or empty bridge list; error code otherwise.
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
2.39.2

