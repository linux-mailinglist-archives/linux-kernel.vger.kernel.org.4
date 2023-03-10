Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E756B47B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjCJOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjCJOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:53:02 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9310F45D;
        Fri, 10 Mar 2023 06:49:12 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso3048542otk.3;
        Fri, 10 Mar 2023 06:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMPAIKuNlYfwl+YKIIWa1ctChtks/5gg2kAnqibcaTE=;
        b=dC+RoomwETgHhJMFNRa0bfe4pgnMMPIcl3CoKYV70kV/taidJH/PLQPirF2YJaV5as
         EwZh0w+RCsnGSPVP20p94QfVx52C1FLZkyEflEf3RJ+XVL3TZfvp++pdDW7NDN/skMGX
         OXdO797MQpACVKgvlW+rIuoHRflM3hXEuiNoo6l6z26uEF12hRQtJ8/CSuzU9y6CMeKP
         GYw5CUil/raohu2xjcpCZBWl59M5HbNJtC6YV1eutkrmNuOrA2Mj2NW06sAYcUXK2C7R
         xLfvI00Snw9yEiHv40pG8JPC4xliUNfXWI6KUKS+ooAWnalnxQZRmEwBBVD4k8veqTW7
         FaAA==
X-Gm-Message-State: AO0yUKUoEVUwIUnY+B2U18MR7AMY3DxzHyBTJygBdYBt1Cpc5enYffxa
        DOb2pjuE7WkGCqGpWlBOlw==
X-Google-Smtp-Source: AK7set8OnAxQN6y3ccR26yajoFEGuzwZcaUQ5w2owL8ZDy3o89b64aD5KMomn/MPxmUbe/vy4DRJXA==
X-Received: by 2002:a05:6830:574:b0:684:b6d7:c804 with SMTP id f20-20020a056830057400b00684b6d7c804mr12890493otc.18.1678459701729;
        Fri, 10 Mar 2023 06:48:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p16-20020a056830131000b0068bc8968753sm128553otq.17.2023.03.10.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:21 -0800 (PST)
Received: (nullmailer pid 1546544 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ppc/tumbler: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:33 -0600
Message-Id: <20230310144733.1546500-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/ppc/tumbler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index f3f8ad7c3df8..6c882873b344 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1363,7 +1363,7 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 		if (of_node_name_eq(np, "sound")) {
 			if (of_get_property(np, "has-anded-reset", NULL))
 				mix->anded_reset = 1;
-			if (of_get_property(np, "layout-id", NULL))
+			if (of_property_present(np, "layout-id"))
 				mix->reset_on_sleep = 0;
 			of_node_put(np);
 			break;
-- 
2.39.2

