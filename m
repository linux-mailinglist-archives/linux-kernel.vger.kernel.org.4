Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A66F6701
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEDINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEDIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:33 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C586110CE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:10:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187804; x=1683195004; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=31Q4Ro1pFyBL9G3wOnVJ2u79v4uFUgKaZchoxW9ol9Q=;
 b=R4Z6tafp2IIDrMX+McEptOOvxLn1vSYSEQd2c0kMpNxhyEKKXqIEB/fG9otKNqtt2sLyeLFZhxusRZg1CxTfmU4F+w2CbGYVQjFRoRYz7WQzhp7UYq3FbzrItXF4Sq/ZaozUkjKR+dwqrSgaoO+yjXuji5GCXo/CKfwM+HGqpRisUnzKDsMWDZX8dxzd4ZI1oFje/LocJ74eU3pA5KV9e2AqNhBogBoIKVKYwGPtuUimhiOzQBNoCm2z92YmwaHecsUq2jWT7kRxz9vsOW5NT7RK3e/N6poaOetaf179w4Im8Pb16V/VR1yVGXtQl1Ot4O+5Ok84NRHW+577Wqj0qw==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 57d6487547fc with SMTP id
 645365e6f77227a83038fba9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:59:34 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 08/11] Documentation/hwmon: Revise userspace tools documentation
Date:   Thu,  4 May 2023 00:57:49 -0700
Message-Id: <20230504075752.1320967-9-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite lm-sensors installation and usage guidelines
and mark the list of third-party utilities as outdated.
Fix minor issues (typos, grammar, etc.) and add markup.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/hwmon/userspace-tools.rst | 129 +++++++++++++++++++-----
 1 file changed, 103 insertions(+), 26 deletions(-)

diff --git a/Documentation/hwmon/userspace-tools.rst b/Documentation/hwmon/userspace-tools.rst
index bf3797c8e734..79c932954e4a 100644
--- a/Documentation/hwmon/userspace-tools.rst
+++ b/Documentation/hwmon/userspace-tools.rst
@@ -1,43 +1,120 @@
+===============
 Userspace tools
 ===============
 
+.. contents::
+
 Introduction
+============
+
+Hardware monitoring information is pertinent to almost every Linux system.
+For instance, most computer mainboards manufactured since the late 1990s have
+reported system health data such as temperatures, voltages, and fan speeds.
+All modern CPUs, GPUs, and SoCs have built-in internal temperature sensors and
+often have other types of sensors as well. In addition, an increasing number
+of components, such as power supplies and liquid CPU coolers, are now embedded
+systems ("smart devices") capable of measuring and providing relevant sensor
+data themselves.
+
+The Linux Hardware Monitoring subsystem (``hwmon``) supports most common types
+of hardware monitoring sensors, regardless of how they are connected to the
+system. Sensor measurements are made available in the ``/sys`` virtual
+filesystem at ``/sys/class/hwmon``. Userspace tools are then used to display
+the measured values or configure the sensors and data sources in a more
+friendly manner.
+
+``lm-sensors``
+==============
+
+``lm-sensors`` is a collection of command-line utilities that allows you to
+view hardware monitoring information and set monitoring limits. On some
+systems, it is used to process raw sensor data into a usable form. It may also
+be used to probe the system at a low level to help detect available sensors.
+
+While active development has largely ceased as of 2023, its status is closer
+to "finished" than "abandoned". It has strong historical ties to ``hwmon``,
+and a properly configured installation of ``lm-sensors`` (or its
+``libsensors`` library component) is often required by other hardware
+monitoring utilities.
+
+Installation
 ------------
 
-Most mainboards have sensor chips to monitor system health (like temperatures,
-voltages, fans speed). They are often connected through an I2C bus, but some
-are also connected directly through the ISA bus.
+Most Linux distributions provide the ``lm-sensors`` suite as a package.
+It is recommended that you use this package for ease of installation.
+Please consult your Linux distribution's documentation for more information.
+
+If needed, sources may be found at https://hwmon.wiki.kernel.org/lm_sensors.
+Basic compilation, installation, and uninstallation may be accomplished with
+``make all``, ``make install``, and ``make uninstall``, respectively.
+
+Usage
+-----
+
+General hints to get things working after installation:
 
-The kernel drivers make the data from the sensor chips available in the /sys
-virtual filesystem. Userspace tools are then used to display the measured
-values or configure the chips in a more friendly manner.
+* Run the ``sensors`` command. Note the available sensors on your system.
 
-Lm-sensors
-----------
+* If you don't see the sensors you expect, here are a few possibilities:
 
-Core set of utilities that will allow you to obtain health information,
-setup monitoring limits etc. You can get them on their homepage
-http://www.lm-sensors.org/ or as a package from your Linux distribution.
+  * You must run the ``sensors-detect`` command to detect available sensors.
+    It will try to find the correct kernel modules (i.e. ``hwmon`` drivers)
+    for your hardware and make the necessary changes to load them
+    automatically. You may have to make these changes yourself in some cases.
 
-If from website:
-Get lm-sensors from project web site. Please note, you need only userspace
-part, so compile with "make user" and install with "make user_install".
+    .. attention::
+      Though unlikely, ``sensors-detect`` may damage your system while
+      conducting certain low-level checks. You will have the chance to refuse.
 
-General hints to get things working:
+  * You are missing the kernel module(s) you need, but it is just a matter of
+    installing it.
 
-0) get lm-sensors userspace utils
-1) compile all drivers in I2C and Hardware Monitoring sections as modules
-   in your kernel
-2) run sensors-detect script, it will tell you what modules you need to load.
-3) load them and run "sensors" command, you should see some results.
-4) fix sensors.conf, labels, limits, fan divisors
-5) if any more problems consult FAQ, or documentation
+    Some Linux distributions already include all in-kernel ``hwmon`` drivers
+    as part of a base installation, but others may only provide them in a
+    "kernel modules" or "extra kernel modules" package. Please consult your
+    Linux distribution's documentation for more information.
+
+    If you are using a self-compiled kernel, ensure that the necessary driver
+    is set to be compiled as modules in the kernel config, then recompile and
+    reinstall.
+
+    In some cases, a hardware vendor or an open-source developer provides an
+    unofficial third-party driver for your hardware. Please refer to the
+    documentation for that driver for more information.
+
+  * The module that you need exists and has been updated to work with your
+    hardware, but only for a later kernel version, or it has not been updated
+    yet, or it does not exist.
+
+    Unfortunately, you will need to upgrade your kernel or Linux distribution,
+    or wait and do so later, or implement support for your hardware yourself.
+
+* Once ``sensors`` is working, you may still need to edit its configuration
+  file (most likely ``/etc/sensors3.conf``) before its output becomes usable.
+
+  For example, this is necessary if several mainboards use the same sensor
+  chip for hardware monitoring duties, but due to design differences between
+  boards, the same measured value means different things on each.
+
+  You may also want to edit the config file to change sensor names, change how
+  displayed values are calculated, and/or hide sensors from view.
+
+  For more information, please refer to the ``man`` pages for ``sensors`` and
+  ``sensors.conf``.
+
+* If you run into more problems, consult FAQs and documentation as needed, or
+  try searching for your particular mainboard or computer system to see what
+  has worked for others.
 
 Other utilities
----------------
+===============
+
+.. warning ::
+  This section is outdated and in need of attention.  Please use this
+  information with caution, and please consider sending patches to update it.
 
 If you want some graphical indicators of system health look for applications
-like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
-hardware-monitor
+like: ``gkrellm``, ``ksensors``, ``xsensors``, ``wmtemp``, ``wmsensors``,
+``wmgtemp``, ``ksysguardd``, ``hardware-monitor``
 
-If you are server administrator you can try snmpd or mrtgutils.
+If you are server administrator you can try ``snmpd`` or ``mrtgutils``.
-- 
2.34.1

