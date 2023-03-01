Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B706A7664
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCAVuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCAVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:50:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B7498A1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:50:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso293464277b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677707406;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpj5qaodj5ScmnNVI3rS9lV8D5wtu+qpU9VuY7cTTKw=;
        b=NhNtT+6dGVHh00iSdAACqfRBFAA8gf6z22UVtLG48MBccW6lc47mdX6u4S3FN+9QmZ
         mWWKZ5GQQ1LHaoHzaYhg7xIPc9gr9tlfVsFAFUMIlKhSaJEUxwWfZ/Ebk3+Wsu8Nf3hS
         zafom0jKpVZTLmC/AdVJT01uxzJbu6KIYR0YLBrtu8ZHJ3NA9QefB4xo4T6PunQ5irJr
         OQjaIKArceRovZJc10UY0aVk5gijhFDZoUVpQh2GwEbo8Bmrkte13+eq5rEb/Vv2hzn+
         sYInPfBEeQLT2HBq/aAPIGTo82S94stYrqWyb+PqmSh930CFo13uC0ItSG3CpfNv87bV
         Vttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707406;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpj5qaodj5ScmnNVI3rS9lV8D5wtu+qpU9VuY7cTTKw=;
        b=DhcXlu39nUN+eouRZSNg/NFhrEvkxDQmN/n3ufkhZZtNUYllQwKxiYGsOxo+nVxd6U
         4HsIHojySpLqV7AalR8FCWh0TEX7FThtQnJ8tlmiGzTytvW0rhM2lkk9hzNt6WiLMIMo
         L0aiqa30Zl6xCNqvhe4TTXY+8Z1kBcPbL/LEPFw3pg/a2m8Zn4F6gyBXQ87SGQ6/b53P
         MjMGUxDHwQ2l8hBlwhkJzuWRGL13qP+qoEzq4SnT3yEVEM2dW5UeAgywwXG9vpBVKRP0
         hoKAgZDmRd+S/IeKACzTFbvYq+AJV4bfig2jsDE8JRuZ/LVUL+dYKspnHkznFEMyVFMF
         Suqg==
X-Gm-Message-State: AO0yUKVESspKB8CbkrOn2n1JUDOIQP8lC+LQTmWyPF7zgkvwZvfnF3Si
        T1NXmFgAfFslKxbPP0N3TP6TBNGmnywx6q4=
X-Google-Smtp-Source: AK7set81Xd2tYA4JOiqSKDhL+z8UEtfehns/zS6Rq/x95FFMqWM3N6FEq8Q+gfDREO1ct62FNHlpEoore1o1Hvs=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:debf:1aed:5c45:c92])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1003:b0:9f5:af6b:6f69 with SMTP
 id w3-20020a056902100300b009f5af6b6f69mr14719319ybt.5.1677707406553; Wed, 01
 Mar 2023 13:50:06 -0800 (PST)
Date:   Wed,  1 Mar 2023 13:49:51 -0800
In-Reply-To: <20230301214952.2190757-1-saravanak@google.com>
Message-Id: <20230301214952.2190757-5-saravanak@google.com>
Mime-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 4/4] driver core: Delete fw_devlink_purge_absent_suppliers()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
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

After recent changes to fw_devlink that ended with commit 4a032827daa8
("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
cares about the "compatible" property and figures out the correct struct
device at runtime.

So, there's no need for any driver or framework to call
fw_devlink_purge_absent_suppliers() anymore and we can delete it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 16 ----------------
 include/linux/fwnode.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6878dfcbf0d6..46364c4d1983 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -186,22 +186,6 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
 	fwnode_links_purge_consumers(fwnode);
 }
 
-void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
-{
-	struct fwnode_handle *child;
-
-	/* Don't purge consumer links of an added child */
-	if (fwnode->dev)
-		return;
-
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
-	fwnode_links_purge_consumers(fwnode);
-
-	fwnode_for_each_available_child_node(fwnode, child)
-		fw_devlink_purge_absent_suppliers(child);
-}
-EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
-
 /**
  * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode_handle
  * @from: move consumers away from this fwnode
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 5700451b300f..63972c863fcd 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -210,6 +210,5 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
-void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 
 #endif
-- 
2.39.2.722.g9855ee24e9-goog

