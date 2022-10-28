Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E0611CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJ1Vxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1Vx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:53:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182224BAA0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:53:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u6so5938442plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwCxQi/lzbG99sopXdaVgVE2DsVCsrVGzk6dQZZnkc8=;
        b=I2wDE32iuPDJS6Ln4R3C7D+1bXa0yvl0RCT+wy/Vt0bL7g0cgQTolmDJ1THfnJ8khZ
         jDEdnMGi8XvZMvYAHMAkQxMDjybr0ID5erEsw7n6tALBv/ktbg7bhZ4rLNKN82hdrShW
         J9ifmwTQrN86Sp5PxD+oOtzKrNwbXuElrxYMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwCxQi/lzbG99sopXdaVgVE2DsVCsrVGzk6dQZZnkc8=;
        b=MN8u9WiFoZCdgPgG1r+LlyO7/FxY4ufuW5Zk/BopGOl77n1bhf7e04sgs6GwbOUEzt
         47VL8Atn2hXXGmQO4/Jbw4INDlfHsmGvnPaQCDApAg5Mb1QABNm4yjsQPTb5xKIxdqKS
         UHT6ADMBalghwJ168nZkg8dxljKeVUpLFCLXjhTBySKaFkHHr+DL0cu34cxCQTl+I+tZ
         YNYWjzMT1+lxWf54DZ4i8+TpTxAEPzMVlUJGmRdllBT4xs5S6j+9wCCOeDF7gOHWlsKW
         VHUsAcjNAxhC2AoLfcYPD2NlOj09Ln5HdZ5ZLJ3hDAEp90/YOoSzcc8BbSMSq3Ss3OXH
         cJmg==
X-Gm-Message-State: ACrzQf0jCmH6kcLxqFCsuTgx4PQfr70LjCPRsGyloe7o/7BKk3pyTHFx
        7iVWpuUwwbdIoxl1Dph/7mDqsg==
X-Google-Smtp-Source: AMsMyM7Z7henHLAjyucT+QXQnehtd5Zyu7DPcyrdvjnKBnTvpxyYd8nxtXTnemCxJqDLmGYfSMu6QA==
X-Received: by 2002:a17:90b:3e81:b0:20d:bbe5:f332 with SMTP id rj1-20020a17090b3e8100b0020dbbe5f332mr19029604pjb.112.1666994006140;
        Fri, 28 Oct 2022 14:53:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id a4-20020a621a04000000b00545f5046372sm3251964pfa.208.2022.10.28.14.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:53:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH] drm/i915: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:53:22 -0700
Message-Id: <20221028145319.1.I87b119c576d486ad139faf1b7278d97e158aabe4@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver often takes a good 100ms to start, but in some particularly
bad cases takes more than 1 second.

In surveying risk for this driver, I poked around for cross-device
shared state, which can be a source of race conditions. GVT support
(intel_gvt_devices) seems potentially suspect, but it has an appropriate
mutex, and doesn't seem to care about ordering -- if devices are present
when the kvmgt module loads, they'll get picked up; and if they probe
later than kvmgt, they'll attach then.

Additionally, I see past discussions about this patch [1], which
concluded that there were problems at the time due to the way
hdac_i915.c called request_module("i915") and expected it to complete
probing [2]. Work has since been merged [3] to fix that problem.

This driver was pinpointed as part of a survey of drivers that take more
than 100ms in their initcall (i.e., are built in, and probing
synchronously) on a lab of ChromeOS systems.

[1] [RFC] i915: make the probe asynchronous
    https://lore.kernel.org/all/20180604053219.2040-1-feng.tang@intel.com/

[2] https://lore.kernel.org/all/s5hin4d1e3f.wl-tiwai@suse.de/

[3] Commit f9b54e1961c7 ("ALSA: hda/i915: Allow delayed i915 audio
    component binding")

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/i915/i915_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 38460a0bd7cb..1cb1f87aea86 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1371,7 +1371,10 @@ static struct pci_driver i915_pci_driver = {
 	.probe = i915_pci_probe,
 	.remove = i915_pci_remove,
 	.shutdown = i915_pci_shutdown,
-	.driver.pm = &i915_pm_ops,
+	.driver = {
+		.pm = &i915_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 int i915_pci_register_driver(void)
-- 
2.38.1.273.g43a17bfeac-goog

