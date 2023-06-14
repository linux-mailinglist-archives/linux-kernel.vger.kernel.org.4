Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D5730450
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbjFNP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbjFNP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:56:44 -0400
X-Greylist: delayed 798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 08:56:37 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84634E57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Pn345bV35kHjk6YsQq8dmYqZoHyOvoQvv+9XtR7M7h0=; b=2
        sya0aFb/QdDdY7WFrQAIFe42FVXCIFZaY7h7lWLT56EHnJtnK8nuAphvz0zhskmd
        TnmI+JGPDqhG4rZf0lVodqiiL1JQdsVZAPl74GhdpaYYXiL7xiwRy9gp7O3np0y0
        BeAxRq7ENrrOHzpK0KVv+NdtIBb0Zs1dutjTTPiyqQ=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgD3__cs44lk3qXsAA--.4023S2;
        Wed, 14 Jun 2023 23:56:29 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, lucas.demarchi@intel.com,
        piotr.piorkowski@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] drm/i915: Fix missing check for return value of dev_get_platdata()
Date:   Wed, 14 Jun 2023 08:56:26 -0700
Message-Id: <20230614155626.119999-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgD3__cs44lk3qXsAA--.4023S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF47uFWrJrW7GrWkJw17trb_yoWDWFXEg3
        WrArnayry2krZ8tF12yrWfuryfK3Wjvr1ktryftr93CwnFyryUtrn7Jw17Wr1xJay7JFW8
        Aw15uFsxtwnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOxhLUUUUU
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_get_platdata() function may return NULL, which may
cause null pointer deference, and most other callsites of
dev_get_platdata() do Null check. Add Null check for return
value of dev_get_platdata().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index 5863763de530..a1655ddbe910 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -336,6 +336,9 @@ void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
 		return;
 
 	pdata = dev_get_platdata(&dev_priv->display.audio.lpe.platdev->dev);
+	if (!pdata)
+		return;
+
 	ppdata = &pdata->port[port - PORT_B];
 
 	spin_lock_irqsave(&pdata->lpe_audio_slock, irqflags);
-- 
2.17.1

