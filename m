Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5636A27A5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 07:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBYGyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 01:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 01:54:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1F1815A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 22:54:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536af109f9aso30312827b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIImxg9xqGk7iRLE6VcmUficCLyaW9zBtMXyCa679dw=;
        b=EYdYZwBJo7rQhONBIENr5THO6qgaJUdnZoGLVs6CBkXZrP12+fd2jIH0Mt5DjloIwb
         JH+YScG/pmbw9R6lJQIPqKTnJihCvFsZ4Cu9AVKPVTjCEwJKqJnd8gXQrRj1GSYdGfuJ
         6wCiTdk3oYPE/JqM5Z0nSbdWesFb2NIGhAdJLZmmDPmCaBshuURdZElxj2xwUcU5NbsK
         YWvW4ZqjnXQdQgERGfcxkfm9rAzqfsjTEtjhwiyOZ4HCGkjIz5QSSP2UwQEFAUP3KtKR
         PEu65M+ZnL0tjjtWF1ukMFXr+4eDYHDnmDnXXvfa7bGQlGvqAQUbcuol2mYeEAdV5DLd
         W61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIImxg9xqGk7iRLE6VcmUficCLyaW9zBtMXyCa679dw=;
        b=N2uNWkGGYXvUhWGxMGpLthkS1tq1+xuCtqDb926wnSL7tuoqiSff8N7mandC2/Mdm0
         DyPvkwXND/uHhYsPQtqgziSNGFD9Xq3iGdOgPNl/GUxN0tl4OQY4sWFx2k91eCrjSLv4
         nhMyEvA7BwRD7gnwwRVngRsdRsIPoQnQWQquTshjzrAdDvXkmUXiJQih3wPf2BpIC2XF
         4ABZc1vzQ+XwJVtAVMH4XRanALV3sMnTl93y5quFcpnpw3cAtuQDbh4dtiliekApzz24
         9XCQ06cyaNFvbWbGnjrXAt8SQ5VsSVBtrFbS2zMyuL0Cl5rUPmlMZuC9tPXE0lDn2Ntu
         utCw==
X-Gm-Message-State: AO0yUKWQxVG49VD5WnmP1H8Tj7ltk/jc+Y1gZf5oF1FqXdLamlNQ4MRr
        emrItBhLkN7PmOk37Rdy8hXJcLb/++xaaDo=
X-Google-Smtp-Source: AK7set+5e7l97LaUyO/u+xABQzJO6K8dJXbheNNMAogHBhKtFvq1+6CYwOLVgdeqOBD5s1zvPw1r4wdWroH3PLE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:36e2:326c:12f0:fecd])
 (user=saravanak job=sendgmr) by 2002:a05:6902:145:b0:a17:c06d:60d2 with SMTP
 id p5-20020a056902014500b00a17c06d60d2mr4831087ybh.1.1677308086257; Fri, 24
 Feb 2023 22:54:46 -0800 (PST)
Date:   Fri, 24 Feb 2023 22:54:42 -0800
Message-Id: <20230225065443.278284-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1] driver core: fw_devlink: Print full path and name of fwnode
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the log messages were printing just the fwnode name. While it's
short, it's not always uniquely identifiable in system. So print the
full path and name to make debugging easier.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4f02a10f802f..44a2f6596e54 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -98,7 +98,7 @@ static int __fwnode_link_add(struct fwnode_handle *con,
 
 	list_add(&link->s_hook, &sup->consumers);
 	list_add(&link->c_hook, &con->suppliers);
-	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
+	pr_debug("%pfwf Linked as a fwnode consumer to %pfwf\n",
 		 con, sup);
 
 	return 0;
@@ -122,7 +122,7 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
  */
 static void __fwnode_link_del(struct fwnode_link *link)
 {
-	pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
+	pr_debug("%pfwf Dropping the fwnode link to %pfwf\n",
 		 link->consumer, link->supplier);
 	list_del(&link->s_hook);
 	list_del(&link->c_hook);
@@ -1104,7 +1104,7 @@ int device_links_check_suppliers(struct device *dev)
 		if (!dev_is_best_effort(dev)) {
 			fwnode_ret = -EPROBE_DEFER;
 			dev_err_probe(dev, -EPROBE_DEFER,
-				    "wait for supplier %pfwP\n", sup_fw);
+				    "wait for supplier %pfwf\n", sup_fw);
 		} else {
 			fwnode_ret = -EAGAIN;
 		}
-- 
2.39.2.637.g21b0678d19-goog

