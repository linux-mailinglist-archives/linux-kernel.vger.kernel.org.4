Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673136CCF94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjC2BpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2BpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:45:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0019B2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:45:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b8-20020aa78708000000b005eaa50faa35so6698124pfo.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680054300;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYeI/i9wqMGf819/Dh2oVh1hS6IvbfAuYepCeOqr2KI=;
        b=AU/8uFw0OoaqlosQJo0ph1OohbjHec2zHfPmuigUDtW9bS5EhbQqL15VDWZcXD3vMJ
         +DIWbKCegnTi1CSZVSjrIITHUuv7zW3SntW7GR0OfgkXk9H6tHHzg4YtMEbr2v4aiGnz
         juHOOgveV/pDck84w06QOZ4ilULakvYvZmiXup00yGh52BK0aMwsEGaC67bTMDp51JTA
         wC/GujyC9+4sewzNEeAUiCMiMMB9eJ0eLPaqdH5ob3QgprgTq15s9A7eWcOKU5WoE15/
         RTpfWTre4iCJOe9Z2Vqetvj9Rd+w8x7i3dyHJZoL7hFZ4xc/5G6IYffWrDQyApUY7S27
         uuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680054300;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYeI/i9wqMGf819/Dh2oVh1hS6IvbfAuYepCeOqr2KI=;
        b=vagXvXQGz1P7ukaprBZQLF130MDkbdstEV7sw1sdJC00OjiJtyuN95a7ze0VtOrS+a
         uHFFyYm7viDmBl11/PKGs/dBJWb/ZDPMqKIeYJmp6H3Wtv2WGxFPllp3TLEd4CChWoTq
         jzxKk1rcvmvSr5xa1EKamwreopefS8lT3qHmkmJP2i66u9fKB9CqYMP7mEW6SSiL8UHH
         2SXU2v3Uh5AbyeRJLCAo9wqJA8isoP7JyEnV5OFcyjdb/3/ZX5Zk74ARvjuJO3Vzl81q
         Rg37f/5fRkqYnBZm5vIgZgDJbOmeHjTTryhiC1uncXpnh/Q4xJdYRIcC9/RGdd5mXRBL
         kDGw==
X-Gm-Message-State: AAQBX9cjWt4c68ibZF+NE7+ai+Dz/wyg35swOkZLA8VTiCdkiTERzZtK
        7naTl1bFVBoT059hPNz607KFgAlItVr+jw==
X-Google-Smtp-Source: AKy350brnWnarSFPKwae/zYAPgBn9U5fdu00oqt47DsoGkrKG6Tsh8itzph/TT7TGkcjjykDpqENZTRzmN50bA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:ea0c:b0:1a0:527b:9189 with SMTP
 id s12-20020a170902ea0c00b001a0527b9189mr6492632plg.11.1680054300003; Tue, 28
 Mar 2023 18:45:00 -0700 (PDT)
Date:   Wed, 29 Mar 2023 01:44:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329014455.1990104-1-wonchung@google.com>
Subject: [PATCH] drm/sysfs: Expose DRM connector id in each connector sysfs
From:   Won Chung <wonchung@google.com>
To:     wonchung@google.com, bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, gildekel@chromium.org,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose DRM connector id in device sysfs so that we can map the connector
id to the connector syspath. Currently, even if we can derive the
connector id from modeset, we do not have a way to find the
corresponding connector's syspath.

This is helpful when determining the root connector of MST tree. When a
tree of multiple MST hub is connected to the system, modeset describes
the tree in the PATH blob. For example, consider the following scenario.

+-------------+
| Source      |    +-------------+
| (Device)    |    | BranchX     |
|             |    | (MST)       |
|       [conn6]--->|       [port1]--->DisplayA
+-------------+    |             |
                   |             |    +-------------+
                   |             |    | BranchY     |
                   |             |    | (MST)       |
                   |       [port2]--->|       [port1]----->DisplayB
                   +-------------+    |             |
                                      |       [port2]----->DisplayC
                                      +-------------+

DPMST connector of DisplayA would have "mst:6-1" PATH.
DPMST connector of DisplayB would have "mst:6-2-1" PATH.
DPMST connector of DisplayC would have "mst:6-2-2" PATH.

Given that connector id of 6 is the root of the MST connector tree, we
can utilize this patch to parse through DRM connectors sysfs and find
which connector syspath corresponds to the root connector (id == 6).

ChromeOS intend to use this information for metrics collection. For
example, we want to tell which port is deriving which displays even with
a MST hub. Chromium patch for parsing DRM connector id from the kernel
is at http://crrev.com/c/4317207.

Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/gpu/drm/drm_sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 183130355997..11f98c5d6103 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -282,16 +282,27 @@ static ssize_t modes_show(struct device *device,
 	return written;
 }
 
+static ssize_t connector_id_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+
+	return sysfs_emit(buf, "%d\n", connector->base.id);
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(enabled);
 static DEVICE_ATTR_RO(dpms);
 static DEVICE_ATTR_RO(modes);
+static DEVICE_ATTR_RO(connector_id);
 
 static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_dpms.attr,
 	&dev_attr_modes.attr,
+	&dev_attr_connector_id.attr,
 	NULL
 };
 
-- 
2.40.0.348.gf938b09366-goog

