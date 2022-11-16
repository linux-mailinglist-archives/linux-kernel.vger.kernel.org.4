Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15E062BD36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiKPMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKPMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E013D3C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668600128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBCDaltTnEkyasPr95FrZvMKGG7154FaBt72snWNmEY=;
        b=atfodMCYdecfbDQJ60P8Lqw4eVD3Amu/pklU3y2Xzo6mUL1x5BAthVnWaiHVCJ+hD9WUcz
        rCfKPbyOqQVw1+GM+5HkHyrcLG1R/clgrK2EJdbmI4JTDupTolclD4ozM6SALDgvxnxaDa
        PeYDUxY/O7GJV6ZUySr0uXE0Ofkjits=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-kvOeMQtxNNOVcn-WRH_5qw-1; Wed, 16 Nov 2022 07:02:07 -0500
X-MC-Unique: kvOeMQtxNNOVcn-WRH_5qw-1
Received: by mail-wr1-f71.google.com with SMTP id r4-20020adfbb04000000b00236639438e9so3663704wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBCDaltTnEkyasPr95FrZvMKGG7154FaBt72snWNmEY=;
        b=PRTxuDIZVxo0vuRN2k53pI2Il+k4c3zeL0Lcm1N/fNBMmL0qqwpAw02Bm2qDNa/gdJ
         b3CqUPrTVR8/m+uH4KVGPqQDNQHR1+uhyJWUI764MBNlBTpcKKLBIzw4nz3fT+x7OeEz
         xFwhdSwLTAWBdcO8lzdpG72bGX0wnr5D1sl12aWEOohbfwrM1LP3c17vDmbwdQ7WKOhh
         NExdV8LP/1vCxmlxR+c13BP1J+uHO6lEnEKaIyWoanji7fnF/JgGLzcCJJIWaNzn7IqD
         yhCgiW3SUM00NtJ9AB0oq1LgUcvslUWJESljQQf9Q4hh+FhuJMuhzggtaQkiB75tz41Z
         5aBw==
X-Gm-Message-State: ANoB5plGJPym+HD0oRJE3MiS0FJqaFa95DqhrMsFyWqNVnUJrqja1l3G
        llxhGVFgsV6N86cCcTZyeouXTGMeKn5elu22br084wcEo2Y3pXBvV3y61Zv6BHcjKJ7cWi1F7FC
        TSDi7l9820XsNzJPMX9+I5JkQM0UruT02yfV3OegJ9b50auuG7A+rD3iutZ9eAr7lH4HQjLmrD1
        4=
X-Received: by 2002:a05:600c:4b17:b0:3cf:8b22:b567 with SMTP id i23-20020a05600c4b1700b003cf8b22b567mr1858796wmp.144.1668600126409;
        Wed, 16 Nov 2022 04:02:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6KcgmCL/QNhicRTBPFu1lqivBGGB3rknS3b5jX3oiZWxdz2L0DdR/VFWVJ9fiTIvp+K3GmAg==
X-Received: by 2002:a05:600c:4b17:b0:3cf:8b22:b567 with SMTP id i23-20020a05600c4b1700b003cf8b22b567mr1858754wmp.144.1668600126011;
        Wed, 16 Nov 2022 04:02:06 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i17-20020adfefd1000000b00236b2804d79sm15327240wrp.2.2022.11.16.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 3/4] driver core: Add fw_devlink.timeout param to stop waiting for devlinks
Date:   Wed, 16 Nov 2022 13:01:59 +0100
Message-Id: <20221116120159.519908-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116115348.517599-1-javierm@redhat.com>
References: <20221116115348.517599-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the probe deferral timeout does two things:

1) Call to fw_devlink_drivers_done() to relax the device dependencies and
   allow drivers to be probed if these dependencies are optional.

2) Disable the probe deferral mechanism so that drivers will fail to probe
   if the required dependencies are not present, instead of adding them to
   the deferred probe pending list.

But there is no need to couple these two, for example the probe deferral
can be used even when the device links are disable (i.e: fw_devlink=off).

So let's add a separate fw_devlink.timeout command line parameter to allow
relaxing the device links and prevent drivers to wait for these to probe.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 .../admin-guide/kernel-parameters.txt         |  7 ++++
 drivers/base/dd.c                             | 38 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..38138a44d5ed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1581,6 +1581,13 @@
 			dependencies. This only applies for fw_devlink=on|rpm.
 			Format: <bool>
 
+	fw_devlink.timeout=
+			[KNL] Debugging option to set a timeout in seconds for
+			drivers to give up waiting on dependencies and to probe
+			these are optional. A timeout of 0 will timeout at the
+			end of initcalls. If the time out hasn't expired, it'll
+			be restarted by each successful driver registration.
+
 	gamecon.map[2|3]=
 			[HW,JOY] Multisystem joystick and NES/SNES/PSX pad
 			support via parallel port (up to 5 devices per port)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1e8f1afeac98..ea448df94d24 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -261,6 +261,7 @@ static int driver_deferred_probe_timeout = 10;
 #else
 static int driver_deferred_probe_timeout;
 #endif
+static int fw_devlink_timeout = -1;
 
 static int __init deferred_probe_timeout_setup(char *str)
 {
@@ -272,6 +273,16 @@ static int __init deferred_probe_timeout_setup(char *str)
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
+static int __init fw_devlink_timeout_setup(char *str)
+{
+	int timeout;
+
+	if (!kstrtoint(str, 10, &timeout))
+		fw_devlink_timeout = timeout;
+	return 1;
+}
+__setup("fw_devlink.timeout=", fw_devlink_timeout_setup);
+
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
@@ -318,6 +329,15 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+static void fw_devlink_timeout_work_func(struct work_struct *work)
+{
+	fw_devlink_drivers_done();
+
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+}
+static DECLARE_DELAYED_WORK(fw_devlink_timeout_work, fw_devlink_timeout_work_func);
+
 void deferred_probe_extend_timeout(void)
 {
 	/*
@@ -330,6 +350,13 @@ void deferred_probe_extend_timeout(void)
 		pr_debug("Extended deferred probe timeout by %d secs\n",
 					driver_deferred_probe_timeout);
 	}
+
+	if (cancel_delayed_work(&fw_devlink_timeout_work)) {
+		schedule_delayed_work(&fw_devlink_timeout_work,
+				      fw_devlink_timeout * HZ);
+		pr_debug("Extended fw_devlink timeout by %d secs\n",
+			 fw_devlink_timeout);
+	}
 }
 
 /**
@@ -352,9 +379,12 @@ static int deferred_probe_initcall(void)
 
 	if (!IS_ENABLED(CONFIG_MODULES)) {
 		driver_deferred_probe_timeout = 0;
-		fw_devlink_drivers_done();
+		fw_devlink_timeout = 0;
 	}
 
+	if (!fw_devlink_timeout)
+		fw_devlink_drivers_done();
+
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
 	 * that is optional
@@ -366,6 +396,12 @@ static int deferred_probe_initcall(void)
 		schedule_delayed_work(&deferred_probe_timeout_work,
 			driver_deferred_probe_timeout * HZ);
 	}
+
+	if (fw_devlink_timeout > 0) {
+		schedule_delayed_work(&fw_devlink_timeout_work,
+				      fw_devlink_timeout * HZ);
+	}
+
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
-- 
2.38.1

