Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7A612244
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2LOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2LOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:14:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561B5B9D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:14:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF3DF1FB;
        Sat, 29 Oct 2022 04:14:18 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90153F534;
        Sat, 29 Oct 2022 04:14:10 -0700 (PDT)
Date:   Sat, 29 Oct 2022 12:14:04 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Message-ID: <Y10K/N8tKrSYfyPN@e120937-lin>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <fc09a68c-bd6d-0328-4052-88d40b50077d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc09a68c-bd6d-0328-4052-88d40b50077d@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:38:25PM -0700, Florian Fainelli wrote:
> Hi Christian,

Hi Florian,

> 
> On 10/19/2022 1:46 PM, Cristian Marussi wrote:
> [snip]
> 
> > In V2 the runtime enable/disable switching capability has been removed
> > (for now) since still not deemed to be stable/reliable enough: as a
> > consequence when SCMI Raw support is compiled in, the regular SCMI stack
> > drivers are now inhibited permanently for that Kernel.
> 
> For our platforms (ARCH_BRCMSTB) we would need to have the ability to start
> with the regular SCMI stack to satisfy if nothing else, all clock consumers
> otherwise it makes it fairly challenging for us to boot to a prompt as we
> purposely turn off all unnecessary peripherals to conserve power. We could
> introduce a "full on" mode to remove the clock provider dependency, but I
> suspect others on "real" silicon may suffer from the same short comings.
> 

Indeed in V1 of this series the Raw mode was dynamically switched on/off at
runtime, so that you could have booted your system with a full working
SCMI stack and then Raw mode could have been enabled/disabled via
scmi_raw/enable entry, so causing the SCMI drivers to be unbound after
boot when entering Raw mode.

The idea, indeed, was initially to be able to boot a regular system, perform
any kind of non-SCMI testing and then switch at will into Raw mode, perform
your SCMI testing, and then back from the grave into normal mode when needed.
(this way you could have deployed into CI one single image for all
testing scenarios...)

The valid objections/worries were around the stability/relliability of such
a solution both when entering Raw mode and then coming back to normal
use: i.e. not being sure to be able to safely unbind all and to safely
bind back all the stack at the end.

The full discussion about this is in this thread if you'd want to
chime in with your point of view:

https://lore.kernel.org/all/Yvvb6Y+lzuABT1fy@sirena.org.uk/

So we removed it, but the idea was not fullly abandoned, we could revive
it with some variations, most probably binding this feature to a Kconfig
option (default=N).

Any feedback/idea from You in these regards is highly welcome.

> Once user-space is reached, I suppose we could find a way to unbind from all
> SCMI consumers, and/or ensure that runtime PM is disabled, cpufreq is in a
> governor that won't do any active frequency switching etc.
> 
> What do you think?

Anyway, thinking about your scenario, maybe this dynamic-switch is NOT
a good solution in your case, because that was an all-or-nothing switch
that caused the full SCMI stack to be unbound, you could not selectively
keep alive what you possibly need to stay on even after boot.

I think that an alternative, maybe better, option in your case, since
you are willing to manually fine-tune at runtime which parts of the SCMI
has to be inhibited to avoid interferences while Raw-testing (via unbind/
unload or policy governors changes), a better option could be a
'full-coexistence' Raw mode solution.

In such a COEX configuration you'll boot a normal system with all the
SCMI drivers operational as configured in the DT, BUT with also the
Raw mode initialized and ready to be used.

In this scenario, basically, you'll have the normal message transactions,
coming from the regular SCMI drivers, and the Raw transactions, injected
from your test suite, that happily coexist side-by-side at the pure
trasaction level: this does NOT mean that you won't suffer any interference
at the protocol level so, as said, you'll have anyway to inhibit properly the
SCMI drivers by hand to avoid false-positives in your results.
(imagine testcase generating a series of Raw get/set/get transaction on
a resource while the regular stack issue a set on the same
res...notifications interferences are even worst...)

Now, the GOOD_NEWS : is ... that this can be done already with an additional
slim patch that has to be applied on top of this series, patch that I
have not posted still since not sure of its utility, but that I am using
heavily in my setup and which works fine for me (with really rare
interferences on testing even without fine-tuning/disabling anything by hand..)

I attached such patch at the end of this mail so that you can
immediately be unblocked and experiment further with Raw mode as you
planned.

I'll cleaned it up and post it also to the next V5 at this point.

Once that COEX is enabled, you should see something like this at boot:

[    1.824269] arm-scmi firmware:scmi: SCMI RAW Mode initialized.
[    1.830155] arm-scmi firmware:scmi: SCMI RAW Mode COEX enabled !
[    1.836473] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.847481] arm-scmi firmware:scmi: SCMI Protocol v2.0 'arm:arm' Firmware version 0x20a0000
...

... and then you can just use the scmi_raw entries as you wish.

Any transaction, normal or raw, will be visible as usual in the SCMI
traces (even though, currently, NOT distinguishable by type raw/normal)

So...after this other too much long mail (:P)...let me know what you
think about al of this (including the possibility of revive the runtime
dynamic switch too...)

Thanks,
Cristian


---->8-----

From 8613438d4171866088339e030959cb1de8e88c6a Mon Sep 17 00:00:00 2001
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Sun, 21 Aug 2022 19:09:39 +0100
Subject: [PATCH] [DEBUG] firmware: arm_scmi: Add SCMI Raw mode COEXISTENCE
 support

When Raw mode support is configured in coexistence mode, normal SCMI
drivers are allowed to register and work as usual with the SCMI core.
Normal and raw SCMI message transactions will remain anyway segregated from
each other, it is just that any SCMI test suite using the Raw mode
access could report unreliable results due to possible interferences
from the regular drivers access to shared SCMI resources.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig     | 10 ++++++++++
 drivers/firmware/arm_scmi/driver.c    | 21 +++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 drivers/firmware/arm_scmi/raw_mode.c  |  2 +-
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ab726a92ac2f..743f53fbe2f8 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -36,6 +36,16 @@ config ARM_SCMI_RAW_MODE_SUPPORT
 	  order to avoid unexpected interactions with the SCMI Raw message
 	  flow. If unsure say N.
 
+config ARM_SCMI_RAW_MODE_SUPPORT_COEX
+	bool "Allow SCMI Raw mode coexistence with normal SCMI stack"
+	depends on ARM_SCMI_RAW_MODE_SUPPORT
+	help
+	  Allow SCMI Raw transmission mode to coexist with normal SCMI stack.
+
+	  This will allow regular SCMI drivers to register with the core and
+	  operate normally, thing which could make an SCMI test suite using the
+	  SCMI Raw mode support unreliable. If unsure, say N.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 32374fdba997..f0b06b6e8dc2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -449,9 +449,14 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
  */
 struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle)
 {
+	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	return scmi_xfer_get(handle, &info->tx_minfo);
+	xfer = scmi_xfer_get(handle, &info->tx_minfo);
+	if (!IS_ERR(xfer))
+		xfer->is_raw = true;
+
+	return xfer;
 }
 
 /**
@@ -531,6 +536,7 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
+	xfer->is_raw = false;
 	return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
@@ -2401,7 +2407,8 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
+	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
 		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
 			id_table->name, id_table->protocol_id);
 		return -EINVAL;
@@ -2634,11 +2641,13 @@ static int scmi_probe(struct platform_device *pdev)
 					       info->tx_minfo.max_msg);
 		if (!IS_ERR(info->raw)) {
 			dev_info(dev, "SCMI RAW Mode initialized.\n");
-			return 0;
+			if (!IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX))
+				return 0;
+			dev_info(dev, "SCMI RAW Mode COEX enabled !\n");
+		} else {
+			dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
+			info->raw = NULL;
 		}
-
-		dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
-		info->raw = NULL;
 	}
 
 	if (scmi_notification_init(handle))
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 2f3bf691db7c..70a48adcc320 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -88,6 +88,7 @@ struct scmi_msg_hdr {
 /**
  * struct scmi_xfer - Structure representing a message flow
  *
+ * @is_raw: Flag to state if this xfer has been generated by RAW mode
  * @transfer_id: Unique ID for debug & profiling purpose
  * @hdr: Transmit message header
  * @tx: Transmit message
@@ -119,6 +120,7 @@ struct scmi_msg_hdr {
  * @priv: A pointer for transport private usage.
  */
 struct scmi_xfer {
+	bool is_raw;
 	int transfer_id;
 	struct scmi_msg_hdr hdr;
 	struct scmi_msg tx;
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 3fdfc0564286..0edaeb405267 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -1154,7 +1154,7 @@ void scmi_raw_message_report(void *r, struct scmi_xfer *xfer, unsigned int idx)
 	struct device *dev;
 	struct scmi_raw_mode_info *raw = r;
 
-	if (!raw)
+	if (!raw || (idx == SCMI_RAW_REPLY_QUEUE && !xfer->is_raw))
 		return;
 
 	dev = raw->handle->dev;
-- 
2.34.1


----8<-----
