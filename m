Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED99C6319F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKUG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKUG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:58:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8E8175B5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:58:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p21so9765693plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtruWrVYTytoEhIj6SMwW8OKntqRZGuB4D7xreZ5kLA=;
        b=zv/HlQ1+Kd/LPc2G4AXA2rmVOt0ecSPXMRHhl95bCGd7z4kAnCaLNgLxqz3IvFnlWC
         imM1sj4HhcQnltsphPzF4FL62L3DvQmBsFDoA6K2UdCbitJBolWFB0/p+uFPa9JKPCL/
         xT1vmDBjcYjqDEWU2enbYWDm9gS2uj2JhcPMmX1y9aRvtYbZME0drywKFCLdUBhmECOv
         mHvetH16NAOhFIZ8tdG8a/D/D5ZEyLX1bdN9+rAs+rlvOWR9QyN6p77zXnVymIsOkV9o
         BV4jaHv8Z6KbL+dCKTgu6gICEQHpPXoMIHr204NNBpAusMbBHi+rvESl1cT3XkjzHvlO
         YhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtruWrVYTytoEhIj6SMwW8OKntqRZGuB4D7xreZ5kLA=;
        b=z6tEl4lDzoHj77tTCd6v/doKgQHGBn0tMb8xMTv1UmZdo+rohpNK5Cb6jLtcgxu4+E
         wRx1+vhnjnNT0UDNdwl/lv33EnzqXy0DEk8mxxFzAKbEnNtkIkI+qYs4el5be8CBmEX1
         ZxvuNZASdii1eXza3IZitQq/FOI565a9oOGOZYgXTHU2xPXjxTwbIfm0t2hmcMCL3qW0
         tSIq/XAyqgFM53nKOc4f+h0A/22nvz7IUZXtmnaugNWGl9lmXIW8B30T3cNmYjJnvuHc
         qv/O/+ZknEmjAyQ5DS4dzYWaBcyqPoVxJcy5BK7eahp56zfGj6UY4kAmdYW0lPBIGsLe
         udQQ==
X-Gm-Message-State: ANoB5pnYL9UTzxBtEzJV4nWA7nqECaL6s6R7psOJ0bbyQz+8RCBmMoNT
        IaQpX1fIjqS7QEvoimqm5TXlRQ==
X-Google-Smtp-Source: AA0mqf798fKaxTjbntdCx0efdOqdpua9GVAcVfxzz7LWqVYRLZCZtj7NR/w3ElJqXAGAoiJTw73Lrw==
X-Received: by 2002:a17:902:f552:b0:186:b768:454d with SMTP id h18-20020a170902f55200b00186b768454dmr1830511plf.82.1669013882031;
        Sun, 20 Nov 2022 22:58:02 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id c10-20020a630d0a000000b0047702d44861sm6815938pgl.18.2022.11.20.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:58:00 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        johan@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: Disallow "opp-hz" property without a corresponding clk
Date:   Mon, 21 Nov 2022 12:27:48 +0530
Message-Id: <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1669012140.git.viresh.kumar@linaro.org>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the special code added by the commit 2083da24eb56 ("OPP:
Allow multiple clocks for a device"), to make it work for Qcom SoC.

In qcom-cpufreq-hw driver, we want to skip clk configuration that
happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
the "opp-hz" property so we can use the freq based OPP helpers.

The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
no longer need the special handling of the same in the OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c    | 14 --------------
 drivers/opp/debugfs.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e87567dbe99f..b7158d33c13d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1384,20 +1384,6 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	}
 
 	if (ret == -ENOENT) {
-		/*
-		 * There are few platforms which don't want the OPP core to
-		 * manage device's clock settings. In such cases neither the
-		 * platform provides the clks explicitly to us, nor the DT
-		 * contains a valid clk entry. The OPP nodes in DT may still
-		 * contain "opp-hz" property though, which we need to parse and
-		 * allow the platform to find an OPP based on freq later on.
-		 *
-		 * This is a simple solution to take care of such corner cases,
-		 * i.e. make the clk_count 1, which lets us allocate space for
-		 * frequency in opp->rates and also parse the entries in DT.
-		 */
-		opp_table->clk_count = 1;
-
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 		return opp_table;
 	}
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 96a30a032c5f..402c507edac7 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -138,7 +138,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	 * - For some devices rate isn't available or there are multiple, use
 	 *   index instead for them.
 	 */
-	if (likely(opp_table->clk_count == 1 && opp->rates[0]))
+	if (likely(opp_table->clk_count == 1))
 		id = opp->rates[0];
 	else
 		id = _get_opp_count(opp_table);
-- 
2.31.1.272.g89b43f80a514

