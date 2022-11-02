Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83529616A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKBRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKBRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7E248D2;
        Wed,  2 Nov 2022 10:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C61CDB8240C;
        Wed,  2 Nov 2022 17:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B70C433C1;
        Wed,  2 Nov 2022 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409755;
        bh=JlfqGwLsDwKmCS1oBu/kDA5a6tTjFIObU3wa7YVmC/s=;
        h=From:To:Cc:Subject:Date:From;
        b=fwYlxiZd1S6Xehhl+9gWwUABNVhSHD8WbO/1WqVXCxG5SFaBD9iKXCgIip2P+Fec2
         WPqIW2QHMTt/2LRGqnD46V2AzVqK0dEhtDe/8CxcKsM7EvEKl+yM3AsRo8QnOHf8W/
         N79bzAfXx0BQ1FiHuKoC8dNJrF9C4ziBLvvZa5bt9LJuslxaV81eM8XdepDvjH185m
         eiljRfsxrYmoj+Gb3lXzWHS8Mwc+qnB+TxLE5Z5RKXafG1/wmxp5hX48kb9R8fss3x
         h6OB+IObWN3X2Fwk7AcVLFlDcPlgoiKmb1A/cGIyfSj3t0jEYwRP71aTZYEof6xUpK
         zZZmgk372RtIQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/4] counter: Adjust final parameter type in function and signal callbacks
Date:   Wed,  2 Nov 2022 10:22:14 -0700
Message-Id: <20221102172217.2860740-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
proposed warning in clang aims to catch these at compile time, which
reveals:

  drivers/counter/counter-chrdev.c:323:34: error: incompatible function pointer types assigning to 'int (*)(struct counter_device *, struct counter_signal *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned int *)') from 'int (*const)(struct counter_device *, struct counter_signal *, enum counter_signal_level *)' [-Werror,-Wincompatible-function-pointer-types-strict]
                  comp_node.comp.signal_u32_read = counter->ops->signal_read;
                                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/counter/counter-chrdev.c:337:33: error: incompatible function pointer types assigning to 'int (*)(struct counter_device *, struct counter_count *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int *)') from 'int (*const)(struct counter_device *, struct counter_count *, enum counter_function *)' [-Werror,-Wincompatible-function-pointer-types-strict]
                  comp_node.comp.count_u32_read = counter->ops->function_read;
                                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  2 errors generated.

  drivers/counter/counter-sysfs.c:845:23: error: incompatible function pointer types assigning to 'int (*)(struct counter_device *, struct counter_signal *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned int *)') from 'int (*const)(struct counter_device *, struct counter_signal *, enum counter_signal_level *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          comp.signal_u32_read = counter->ops->signal_read;
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/counter/counter-sysfs.c:958:22: error: incompatible function pointer types assigning to 'int (*)(struct counter_device *, struct counter_count *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int *)') from 'int (*const)(struct counter_device *, struct counter_count *, enum counter_function *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          comp.count_u32_read = counter->ops->function_read;
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/counter/counter-sysfs.c:959:23: error: incompatible function pointer types assigning to 'int (*)(struct counter_device *, struct counter_count *, u32)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int)') from 'int (*const)(struct counter_device *, struct counter_count *, enum counter_function)' [-Werror,-Wincompatible-function-pointer-types-strict]
          comp.count_u32_write = counter->ops->function_write;
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  3 errors generated.

The ->signal_u32_read(), ->count_u32_read(), and ->count_u32_write()
callbacks in 'struct counter_comp' expect the final parameter to have a
type of 'u32' or 'u32 *' but the ops functions that are being assigned
to those callbacks have an enumerated type as the final parameter. While
these are compatible from an ABI perspective, they will fail the
aforementioned CFI checks.

Adjust the type of the final parameter in the ->signal_read(),
->function_read(), and ->function_write() callbacks in 'struct
counter_ops' and their implementations to match the prototypes in
'struct counter_comp' to clear up these warnings and CFI failures.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: David Lechner <david@lechnology.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-omap@vger.kernel.org
---
 drivers/counter/104-quad-8.c            | 6 +++---
 drivers/counter/ftm-quaddec.c           | 2 +-
 drivers/counter/intel-qep.c             | 2 +-
 drivers/counter/interrupt-cnt.c         | 4 ++--
 drivers/counter/microchip-tcb-capture.c | 6 +++---
 drivers/counter/stm32-lptimer-cnt.c     | 4 ++--
 drivers/counter/stm32-timer-cnt.c       | 4 ++--
 drivers/counter/ti-ecap-capture.c       | 2 +-
 drivers/counter/ti-eqep.c               | 4 ++--
 include/linux/counter.h                 | 6 +++---
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index deed4afadb29..30b40f805f88 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -135,7 +135,7 @@ struct quad8 {
 
 static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
-			     enum counter_signal_level *level)
+			     u32 *level)
 {
 	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int state;
@@ -258,7 +258,7 @@ static int quad8_function_get(const struct quad8 *const priv, const size_t id,
 
 static int quad8_function_read(struct counter_device *counter,
 			       struct counter_count *count,
-			       enum counter_function *function)
+			       u32 *function)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
@@ -275,7 +275,7 @@ static int quad8_function_read(struct counter_device *counter,
 
 static int quad8_function_write(struct counter_device *counter,
 				struct counter_count *count,
-				enum counter_function function)
+				u32 function)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index aea6622a9b13..03f03614fc22 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -189,7 +189,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 
 static int ftm_quaddec_count_function_read(struct counter_device *counter,
 					   struct counter_count *count,
-					   enum counter_function *function)
+					   u32 *function)
 {
 	*function = COUNTER_FUNCTION_QUADRATURE_X4;
 
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index af5942e66f7d..0eedd9e1a94e 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -123,7 +123,7 @@ static const enum counter_function intel_qep_count_functions[] = {
 
 static int intel_qep_function_read(struct counter_device *counter,
 				   struct counter_count *count,
-				   enum counter_function *function)
+				   u32 *function)
 {
 	*function = COUNTER_FUNCTION_QUADRATURE_X4;
 
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 229473855c5b..f068248967d6 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -113,7 +113,7 @@ static const enum counter_function interrupt_cnt_functions[] = {
 
 static int interrupt_cnt_function_read(struct counter_device *counter,
 				       struct counter_count *count,
-				       enum counter_function *function)
+				       u32 *function)
 {
 	*function = COUNTER_FUNCTION_INCREASE;
 
@@ -122,7 +122,7 @@ static int interrupt_cnt_function_read(struct counter_device *counter,
 
 static int interrupt_cnt_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
-				     enum counter_signal_level *level)
+				     u32 *level)
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 	int ret;
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index e2d1dc6ca668..76bec91fde6c 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -68,7 +68,7 @@ static struct counter_synapse mchp_tc_count_synapses[] = {
 
 static int mchp_tc_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
-				       enum counter_function *function)
+				       u32 *function)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
 
@@ -82,7 +82,7 @@ static int mchp_tc_count_function_read(struct counter_device *counter,
 
 static int mchp_tc_count_function_write(struct counter_device *counter,
 					struct counter_count *count,
-					enum counter_function function)
+					u32 function)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 bmr, cmr;
@@ -144,7 +144,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 
 static int mchp_tc_count_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
-				     enum counter_signal_level *lvl)
+				     u32 *lvl)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
 	bool sigstatus;
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index d6b80b6dfc28..2dec0c6421d1 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -155,7 +155,7 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
 
 static int stm32_lptim_cnt_function_read(struct counter_device *counter,
 					 struct counter_count *count,
-					 enum counter_function *function)
+					 u32 *function)
 {
 	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
@@ -174,7 +174,7 @@ static int stm32_lptim_cnt_function_read(struct counter_device *counter,
 
 static int stm32_lptim_cnt_function_write(struct counter_device *counter,
 					  struct counter_count *count,
-					  enum counter_function function)
+					  u32 function)
 {
 	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 9bf20a5d6bda..ece55113ba85 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -70,7 +70,7 @@ static int stm32_count_write(struct counter_device *counter,
 
 static int stm32_count_function_read(struct counter_device *counter,
 				     struct counter_count *count,
-				     enum counter_function *function)
+				     u32 *function)
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 smcr;
@@ -97,7 +97,7 @@ static int stm32_count_function_read(struct counter_device *counter,
 
 static int stm32_count_function_write(struct counter_device *counter,
 				      struct counter_count *count,
-				      enum counter_function function)
+				      u32 function)
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1, sms;
diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index fb1cb1774674..96e5d1f271b8 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -188,7 +188,7 @@ static int ecap_cnt_count_write(struct counter_device *counter,
 
 static int ecap_cnt_function_read(struct counter_device *counter,
 				  struct counter_count *count,
-				  enum counter_function *function)
+				  u32 *function)
 {
 	*function = COUNTER_FUNCTION_INCREASE;
 
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index b0f24cf3e891..d73a8baa49e8 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -119,7 +119,7 @@ static int ti_eqep_count_write(struct counter_device *counter,
 
 static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
-				 enum counter_function *function)
+				 u32 *function)
 {
 	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qdecctl;
@@ -146,7 +146,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 
 static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
-				  enum counter_function function)
+				  u32 function)
 {
 	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	enum ti_eqep_count_func qsrc;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b63746637de2..976dcbfd6266 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -324,17 +324,17 @@ struct counter_event_node {
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
 			   struct counter_signal *signal,
-			   enum counter_signal_level *level);
+			   u32 *level);
 	int (*count_read)(struct counter_device *counter,
 			  struct counter_count *count, u64 *value);
 	int (*count_write)(struct counter_device *counter,
 			   struct counter_count *count, u64 value);
 	int (*function_read)(struct counter_device *counter,
 			     struct counter_count *count,
-			     enum counter_function *function);
+			     u32 *function);
 	int (*function_write)(struct counter_device *counter,
 			      struct counter_count *count,
-			      enum counter_function function);
+			      u32 function);
 	int (*action_read)(struct counter_device *counter,
 			   struct counter_count *count,
 			   struct counter_synapse *synapse,

base-commit: d501d37841d3b7f18402d71a9ef057eb9dde127e
-- 
2.38.1

