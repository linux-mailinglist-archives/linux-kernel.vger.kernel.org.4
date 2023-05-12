Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997E9700490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjELJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjELJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:59:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB49712E89;
        Fri, 12 May 2023 02:58:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA55165C;
        Fri, 12 May 2023 02:59:27 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4FBC3F5A1;
        Fri, 12 May 2023 02:58:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 15/17] Documentation: EM: Add a runtime modifiable EM design description
Date:   Fri, 12 May 2023 10:57:41 +0100
Message-Id: <20230512095743.3393563-16-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new runtime modifiable EM design and how it can be used.
Change the last section layout and allow to provide another example
how to use this new API in a driver code.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index e97c7f18d8bd..64c2462dc9a6 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -89,6 +89,26 @@ due to the workload instruction mix and data set is not modeled.
 Also static power which can change during runtime due to variation of SOC
 temperature is not modeled in EM.
 
+2.2 Runtime modifiable EM
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To better reflect power variation due to static power (leakage) the EM
+supports runtime modifications of the power values. The mechanism relies on
+RCU to free the modifiable EM perf_state table memory. Its user, the task
+scheduler, also uses RCU to access this memory. The EM framework is
+responsible for allocating the new memory for the modifiable EM perf_state
+table. The old memory is freed automatically using RCU callback mechanism.
+This design decision is made based on task scheduler using that data and
+to prevent wrong usage of kernel modules if they would be responsible for the
+memory management.
+The drivers which want to modify the EM values are protected from concurrent
+access using a mutex. Therefore, the drivers must use sleeping context when
+they want to modify the EM. The runtime modifiable EM might also be used for
+better reflecting real workload scenarios, e.g. when they pop-up on the screen
+and will run for longer period, such as: games, video recoding or playing,
+video calls, etc. It is up to the platform engineers to experiment and choose
+the right approach for their device.
+
 
 3. Core APIs
 ------------
-- 
2.25.1

