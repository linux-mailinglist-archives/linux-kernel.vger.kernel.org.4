Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E66E0238
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDLW6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:58:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5541FD0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:58:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id la3so12899698plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681340325; x=1683932325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOEVsGPEHY97AUL8m2SEMppSOPhbxPinO2kLSevOP+4=;
        b=I8Y0cZoug/ztnrR16OVWxghDXXGVvYS0DhJuN5foZz2YL0O6PI7upnHhcCm8pj9w/a
         4tzAWEQdh9b1evPw2t82S2rr9B271r2pmyThue1tcOH7UBzmNU/+pYGgFVdjukUC+uII
         fBh2fl6k6FTim+SJUmosy0L5U0GVjKMGqlz7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681340325; x=1683932325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOEVsGPEHY97AUL8m2SEMppSOPhbxPinO2kLSevOP+4=;
        b=U19TU0bjGYNkKiHRMhliYBRAstVRjyjUEcfPGHLlf6gKUu0PBokhdGRXFFjuXjc0xz
         lhkMWMFhj7DMoE1aAQxRYfcR4EDptmUIfzkUcal6CNeMdwlCeusSNYvY4pMR6/FBxRIa
         r1vE/lluQVByrjHC92GaVHp6aVJDfDwNMP6AaIVH3+x3mbSuZBkzvgeoR71gDebTZnQm
         HhJEMooYBoHPz0j9xY804ylpS1oxowpUeNEjEeMZZGKnPiWZJU6NQaraRjZ7/FKIUZKO
         ofl/ksbXZ7HdSidl0kgMy2+NM/k/+QoHCq9HSCvWn0kHHz7vJlBNA2hkZfL+q3fvgULM
         rg0Q==
X-Gm-Message-State: AAQBX9ePg/9ea0IZIBokK5QLC7SgO3mRF4tqQWIFLLDVo3ctm+UTY/si
        XWPFzmbuzEytUREaDzIjeXGyuf0D64HvfKKelEM=
X-Google-Smtp-Source: AKy350Z6PmHSjVoWVa3Z0ae0fS064iOMOK5se8aQGdQNW+UJftxl9pxfZeIswsw0zSJvCF2hb+I/IQ==
X-Received: by 2002:a17:90a:648e:b0:23f:7ff6:eba with SMTP id h14-20020a17090a648e00b0023f7ff60ebamr1048624pjj.0.1681340324766;
        Wed, 12 Apr 2023 15:58:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:b369:7768:6a4a:9e77])
        by smtp.gmail.com with ESMTPSA id r22-20020a6560d6000000b00513468106d8sm122944pgv.1.2023.04.12.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:58:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] driver core: Don't require dynamic_debug for initcall_debug probe timing
Date:   Wed, 12 Apr 2023 15:58:42 -0700
Message-Id: <20230412225842.3196599-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't require the use of dynamic debug (or modification of the kernel to
add a #define DEBUG to the top of this file) to get the printk message
about driver probe timing. This printk is only emitted when
initcall_debug is enabled on the kernel commandline, and it isn't
immediately obvious that you have to do something else to debug boot
timing issues related to driver probe. Add a comment too so it doesn't
get converted back to pr_debug().

Fixes: eb7fbc9fb118 ("driver core: Add missing '\n' in log messages")
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/dd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8def2ba08a82..1b16e0fb7658 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -708,7 +708,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
https://chromeos.dev

