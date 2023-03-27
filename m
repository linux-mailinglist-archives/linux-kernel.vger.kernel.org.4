Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3C6CA9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC0QEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjC0QDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2002A59DA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC8D861301
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C0C433D2;
        Mon, 27 Mar 2023 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679933004;
        bh=UAI8hnBtr10njBVyrESNMEAk3Ft426kLgCRWSbtqvlc=;
        h=From:To:Cc:Subject:Date:From;
        b=jj7puwp/Gy7GftHIMldtDuI6kKaiC1OzkAykF0ysu3GCwsqQTagr3Fiipcw8MmRx2
         +YrzKfDEYBRNlT/MeLRGJqO4mosFcOYMAS/L+WO5ygruWTqzCc+ZpzOwmVhW04Fq6w
         NOmcr2IusJ8O85oEHqYEA6UzdkuJ3FL8v9LwIDSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: move sysfs_dev_char_kobj out of class.h
Date:   Mon, 27 Mar 2023 18:03:19 +0200
Message-Id: <20230327160319.513974-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=gregkh@linuxfoundation.org; h=from:subject; bh=UAI8hnBtr10njBVyrESNMEAk3Ft426kLgCRWSbtqvlc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmK+9x2umtsvzpxX9EcvbhzGdNfaFbO7ru+MFwq8i3rn YvsjPzTO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAivzgYFhz+pTIjwbxkk/vB 9k26Ta//5DvZnmJYsMv6lj/zsaADB6INop8u5zNINq64AQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure sysfs_dev_char_kobj is local only to the driver core code,
so move it out of the global class.h file and into the internal base.h
file as no one else should be touching this symbol.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h          | 3 +++
 include/linux/device/class.h | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 6659cf1d3a44..6296164bb7f3 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -191,6 +191,9 @@ const char *device_get_devnode(const struct device *dev, umode_t *mode,
 extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
+/* /sys/dev/char directory */
+extern struct kobject *sysfs_dev_char_kobj;
+
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 void module_add_driver(struct module *mod, struct device_driver *drv);
 void module_remove_driver(struct device_driver *drv);
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index af7fefc39364..f7aad64e256a 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -79,7 +79,6 @@ struct class_dev_iter {
 };
 
 extern struct kobject *sysfs_dev_block_kobj;
-extern struct kobject *sysfs_dev_char_kobj;
 
 int __must_check class_register(struct class *class);
 void class_unregister(const struct class *class);
-- 
2.40.0

