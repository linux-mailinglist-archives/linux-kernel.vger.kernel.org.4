Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAB6B4805
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjCJO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjCJOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCD12DDDC;
        Fri, 10 Mar 2023 06:50:41 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bh20so4395918oib.9;
        Fri, 10 Mar 2023 06:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg0iiSi5D59knB4afnWtDWtKwbjfNwldsnK0gCKicW0=;
        b=u6NKrZcomeSeCWVU9t8mzRYZzZBNpDqHaD6Kfpo49o//eA+d5rqOugBkF4C+Ofe5Sa
         Au5QJl3epk6vbvnB9nG0e5qonv3vOJjrgWsamhiw/TSRJarsD29qGUQEMTx9rAWPLkaw
         zzuoPw5/4a19XBvsxsd2z0UiFnpqZl7LLUre9kIQjC0cJhoVRJ8wuFA2eKM6hNpht2Gc
         Pu3dcNlx8XRStB6+Nu8rU7GG10Rfi3hriCu25ncp6VcR1KEhhgNX0VASKLcOJLDySvn4
         OWMe0ohUUh8Zp4IBLMRAheVjsP4Typr3zqfqgcZbH8d4CJR0727/CvZJDyApIn8+PfvN
         Un9Q==
X-Gm-Message-State: AO0yUKX/4oSdsAAa7twtOnb0DuAk+vstjCjTTChjAExK2BlDC18IiqJp
        LVYbFfvwqzGZhaVRJANKTSF6+vZgZQ==
X-Google-Smtp-Source: AK7set92BIXB3jjxOYgKQPRW8pbJ81CxrVf+/wWybdPCOhgKgGGi0VZyqb33P79YwF+5XDXBzMvJFQ==
X-Received: by 2002:a05:6808:15a4:b0:37a:2bf0:5027 with SMTP id t36-20020a05680815a400b0037a2bf05027mr1100385oiw.21.1678459712608;
        Fri, 10 Mar 2023 06:48:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n204-20020acaefd5000000b0037d7c3cfac7sm982882oih.15.2023.03.10.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:32 -0800 (PST)
Received: (nullmailer pid 1546613 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:33 -0600
Message-Id: <20230310144734.1546587-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/ppc/tumbler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 6c882873b344..12f1e10db1c4 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1361,7 +1361,7 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 
 	for_each_child_of_node(chip->node, np) {
 		if (of_node_name_eq(np, "sound")) {
-			if (of_get_property(np, "has-anded-reset", NULL))
+			if (of_property_read_bool(np, "has-anded-reset"))
 				mix->anded_reset = 1;
 			if (of_property_present(np, "layout-id"))
 				mix->reset_on_sleep = 0;
-- 
2.39.2

