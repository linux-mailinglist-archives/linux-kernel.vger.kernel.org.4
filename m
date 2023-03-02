Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE16A7929
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCBBqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCBBqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:46:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3747418
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:46:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bf649e70so297334917b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677721607;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WKfcerjXQseaKVRz3+zhREKuOTGqLB9SMtnLVwI+DA8=;
        b=K+Xil5yjo0Bweo5bwal8MR5BickozTfQmKQD2KbDwtvK1Z/IXSOn3z4QqM3sY25d5p
         UjHLMXucR5xkM82x2y9GWCrlkESvisXETQB+0MqQFtVUukRv59YCFNz9uYDySwCTZ3js
         urKVgALR8lr9EhYQULpzsZTTOiODqiC6HvtmwnPMdFrvjX67ZwJrn/L9rs5/ciUfXqaS
         AwSV22UgMi/sv/iDVckLlMmzoIRqUiTpaZJ396TGKlV2V+eJ6qf4rppmDLCSL6K6TR1b
         zXRbe7iDbUL89PIchSdL09UpW+IRbCEQd3hA4CX46ttFljOAoCue0GX3Ym+epF/uh60n
         afNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721607;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKfcerjXQseaKVRz3+zhREKuOTGqLB9SMtnLVwI+DA8=;
        b=FlgOzx9zD+L+tuW9EfXh0y8LKpmBgFuxrFnHE9miebUPv3/wnzk7Q99zRRGhC8hcDb
         gDLKU9AaG+EagsP6Zi62WccrFsY4d8Kd/1vBMFcjg8gjYm8XDZFLeQdXj+Yt+k0wYPBl
         W/HxMOX5ZlWobMVaj1II1JTfbJgXAtvXuheuJIYgGLuM4s1LP7El+A6m0XGVbZ4M9geH
         F6AFL4Kipu+XCd3P0+j/XajUOX+1QkCiV9GUcNjtPnaOlp7Z6Wz4SbfYR60gZtLf9QPC
         cNgNmVXvDALcR8tvyqdSqccK39GPSR/G6PpGS3lONau4j6o7DTjtMy3VZEiBXkXcaur3
         WqwA==
X-Gm-Message-State: AO0yUKUVDtR5BlMTFBYePs1p3AaIQJpqtyVB2+528xwdESaCRBRj4C2U
        O0J/6ohMnrYInABXOXu0c1mS2ssbiCYmrOg=
X-Google-Smtp-Source: AK7set/WWa6XTKXdfk8xvAuB6R3fTO7w+15wY91+2KM8GcSpmjLL+S5JgnioYkUXghJ7Qb3Wfl2eneW3LfKQFgU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7e6c:b66b:c51a:b6ed])
 (user=saravanak job=sendgmr) by 2002:a81:ac4e:0:b0:535:5e8c:65ef with SMTP id
 z14-20020a81ac4e000000b005355e8c65efmr5165876ywj.6.1677721606963; Wed, 01 Mar
 2023 17:46:46 -0800 (PST)
Date:   Wed,  1 Mar 2023 17:46:38 -0800
Message-Id: <20230302014639.297514-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
From:   Saravana Kannan <saravanak@google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already mark fwnodes as initialized when they are registered as clock
providers. We do this so that fw_devlink can tell when a clock driver
doesn't use the driver core framework to probe/initialize its device.
This ensures fw_devlink doesn't block the consumers of such a clock
provider indefinitely.

However, some users of CLK_OF_DECLARE() macros don't use the same node
that matches the macro as the node for the clock provider, but they
initialize the entire node. To cover these cases, also mark the nodes
that match the macros as initialized when the init callback function is
called.

An example of this is "stericsson,u8500-clks" that's handled using
CLK_OF_DECLARE() and looks something like this:

clocks {
	compatible = "stericsson,u8500-clks";

	prcmu_clk: prcmu-clock {
		#clock-cells = <1>;
	};

	prcc_pclk: prcc-periph-clock {
		#clock-cells = <2>;
	};

	prcc_kclk: prcc-kernel-clock {
		#clock-cells = <2>;
	};

	prcc_reset: prcc-reset-controller {
		#reset-cells = <2>;
	};
	...
	...
};

This patch makes sure that "clocks" is marked as initialized so that
fw_devlink knows that all nodes under it have been initialized.

If the driver creates struct devices for some of the subnodes,
fw_devlink is smart enough to know to wait for those devices to probe.
So, no special handling is required for those cases.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com/
Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/clk-provider.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 842e72a5348f..c9f5276006a0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1363,7 +1363,13 @@ struct clk_hw_onecell_data {
 	struct clk_hw *hws[];
 };
 
-#define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
+#define CLK_OF_DECLARE(name, compat, fn) \
+	static void __init name##_of_clk_init_declare(struct device_node *np) \
+	{								\
+		fn(np);							\
+		fwnode_dev_initialized(of_fwnode_handle(np), true);	\
+	}								\
+	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
 
 /*
  * Use this macro when you have a driver that requires two initialization
-- 
2.39.2.722.g9855ee24e9-goog

