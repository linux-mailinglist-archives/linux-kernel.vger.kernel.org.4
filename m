Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD26B9030
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCNKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCNKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF449884D;
        Tue, 14 Mar 2023 03:35:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6901BA8;
        Tue, 14 Mar 2023 03:35:41 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 012C33F71A;
        Tue, 14 Mar 2023 03:34:54 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 14/17] Documentation: EM: Add a new section about the design
Date:   Tue, 14 Mar 2023 10:33:54 +0000
Message-Id: <20230314103357.26010-15-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314103357.26010-1-lukasz.luba@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new section 'Design' which covers the information about Energy
Model. It contains the design decisions, describes models and how they
reflect the reality. Add description of the basic const. EM. Change the
other section IDs.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 36 +++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ef341be2882b..e97c7f18d8bd 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -72,16 +72,34 @@ required to have the same micro-architecture. CPUs in different performance
 domains can have different micro-architectures.
 
 
-2. Core APIs
+2. Design
+-----------------
+
+2.1 Basic EM
+^^^^^^^^^^^^
+
+The basic EM is built around const. power information for each performance
+state. This model can be derived based on power measurements of the device
+e.g. CPU while running some benchmark. The benchmark might be integer heavy
+or floating point computation with a data set fitting into the CPU cache or
+registers. Bare in mind that this model might not be covering all possible
+workloads running on CPUs. Thus, please run a few different benchmarks and
+verify with some real workloads your power model values. The power variation
+due to the workload instruction mix and data set is not modeled.
+Also static power which can change during runtime due to variation of SOC
+temperature is not modeled in EM.
+
+
+3. Core APIs
 ------------
 
-2.1 Config options
+3.1 Config options
 ^^^^^^^^^^^^^^^^^^
 
 CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
 
 
-2.2 Registration of performance domains
+3.2 Registration of performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Registration of 'advanced' EM
@@ -110,8 +128,8 @@ The last argument 'microwatts' is important to set with correct value. Kernel
 subsystems which use EM might rely on this flag to check if all EM devices use
 the same scale. If there are different scales, these subsystems might decide
 to return warning/error, stop working or panic.
-See Section 3. for an example of driver implementing this
-callback, or Section 2.4 for further documentation on this API
+See Section 4. for an example of driver implementing this
+callback, or Section 3.4 for further documentation on this API
 
 Registration of EM using DT
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -156,7 +174,7 @@ The EM which is registered using this method might not reflect correctly the
 physics of a real device, e.g. when static power (leakage) is important.
 
 
-2.3 Accessing performance domains
+3.3 Accessing performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 There are two API functions which provide the access to the energy model:
@@ -175,10 +193,10 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
 More details about the above APIs can be found in ``<linux/energy_model.h>``
-or in Section 2.4
+or in Section 3.4
 
 
-2.4 Description details of this API
+3.4 Description details of this API
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .. kernel-doc:: include/linux/energy_model.h
    :internal:
@@ -187,7 +205,7 @@ or in Section 2.4
    :export:
 
 
-3. Example driver
+4. Example driver
 -----------------
 
 The CPUFreq framework supports dedicated callback for registering
-- 
2.17.1

