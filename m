Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02575029B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjGLJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjGLJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:12:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6AF9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:12:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso69016035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689153167; x=1691745167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Keu0rY+gipqgw/+O2XoBbwO35AHep9g015KVBZdfX8=;
        b=MJy37K5wDhGWmO6tjYwl9vzsSW5TSHMgShH8aXlIfweopgEqSnLn3zLT1hZp00jfjv
         Z2r64qVP2V+bc7gIVWoIOyk0w/e8RKkFqk32JkI/5iWc+9kkHjHm9ln2DEMM1enmtba8
         xBUQKEjqXJlZSJtzhA8n+4VBz43UrWa6zsMdWETlgP+Y/CQgzYLaCrv9C/1wZkbtd+Ol
         b0gSzGNi259Bi29csxFk2gxcU+OhPl6oY/ag/rwDyRP2GFddK1ma+Fz0lzYT4vdxa3qW
         7ffWwssze8CPQzpkNpQTJL6QBq9mG9tRPp4StV1KHsaG90lJnbhG33IUvU10hpfzQFfl
         IV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153167; x=1691745167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Keu0rY+gipqgw/+O2XoBbwO35AHep9g015KVBZdfX8=;
        b=apxtoTuYKFD568ALJVPjpeyJa1318gv9foo09bzdjGNEehQBgj0bKA0aaEt7qMFE2C
         Nhg+qmib2fcOanMiuZcsrc58pgYzamc4l37JVNOfxM1PnGcL6qtymJdKxBq+nkeSgNHl
         nUE68gNexOXBS3sRAJ90WpJu5NXNFwXSZGcAB/h+7mDVMsrI8Pez0GvNjII14StiK/4u
         5dEIsr80CDV9Kf01XC/AWHR+U6CXtgQpNHTPAu2RCaB45OOA8604QNp2VIfBElrLFPJB
         x5/DPJTR/hTzRYdwdXs72wdfQRCSZoCuOPVNOysfOM/Jnasw+ZmgnhyiMB7xi8hRmxPY
         Od3g==
X-Gm-Message-State: ABy/qLbOnglFz9FwNeuEilF287d6GJtJP3OjCq/7+xKCVVrzoJtvqhjn
        RPRZHC5p52rbz0AsJ7Js4AJElQoHx+8BVx4Yrynapw==
X-Google-Smtp-Source: APBJJlECUZpjCW7O6OJjt0u6XvJkX1VCPr/IOpCGswvLci1VXws3fwowtCSHBG395+nqVy7KjDv4AA==
X-Received: by 2002:a7b:c457:0:b0:3fb:739d:27b2 with SMTP id l23-20020a7bc457000000b003fb739d27b2mr16764374wmi.8.1689153167573;
        Wed, 12 Jul 2023 02:12:47 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c364b00b003f90b9b2c31sm15013711wmq.28.2023.07.12.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:12:47 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v2 1/3] peci: cpu: Add Intel Sapphire Rapids support
Date:   Wed, 12 Jul 2023 11:12:38 +0200
Message-ID: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for detection of Intel Sapphire Rapids processor based on
CPU family & model.

Sapphire Rapids Xeon processors with the family set to 6 and the
model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
is "spr".

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Refactored from previous patchset as seperate patch based on subsystem.
---
 drivers/peci/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index de4a7b3e5966..3668a908d259 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.model	= INTEL_FAM6_ICELAKE_X,
 		.data	= "icx",
 	},
+	{ /* Sapphire Rapids Xeon */
+		.family	= 6,
+		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.data	= "spr",
+	},
 	{ /* Icelake Xeon D */
 		.family	= 6,
 		.model	= INTEL_FAM6_ICELAKE_D,

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

