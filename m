Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7226B4800
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjCJO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjCJOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:11 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3D12DDD3;
        Fri, 10 Mar 2023 06:50:38 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1755e639b65so6083081fac.3;
        Fri, 10 Mar 2023 06:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3KHc2qfQy8/Fx/GchcHCRrPSc3mgzu0I8uWgkcqEU0=;
        b=YomaDBgKcI4/WOUBsKf74VZ64VP/0kiT0fkqBA4O1u2g3zDdn+3EAhyNVaqPgT2dRM
         asg7w43ASpptlSAW+581lRJ7skCKtB21FQhsjAnoHABHs0iHQnFU+weKPQ9d79BBSt38
         UoyC4TW4KeQvCwXkpvKzgm5h5YV6/31b0wNHd2JUU8CTYn0Ikl9atR2SF/KV+3MBXLxh
         hf0MCMH5rxvuR7VangIXRblSXo+DnRM/jNAFd/VZ0Es75ZFzfuYonVW5AEPzr+pDYQ+c
         8+LinPUQcIXevPKWRhlXDDWmQHAxuJE65ugP210eqyT+C2aeDgr2i7dziLg/1wiHWWuh
         yTzg==
X-Gm-Message-State: AO0yUKVPaA2j8QimbJ5FQiPOBQo1MNCij7nQEORwdX6OsfHsEcF5KohT
        d5BQBN9QPkpoiIdzdQdNnmaTMKlk4Q==
X-Google-Smtp-Source: AK7set8QmvbQP/Bjfjc3O5nnCMjZn+KxAeSmG9Ea+h1QaqVMxanfmgnEk4F99ymmNw1xiMUHNTguXw==
X-Received: by 2002:a05:6870:8a0e:b0:176:6b9f:7ff4 with SMTP id p14-20020a0568708a0e00b001766b9f7ff4mr13541205oaq.21.1678459706222;
        Fri, 10 Mar 2023 06:48:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id an10-20020a056871b18a00b001730afaeb63sm112238oac.19.2023.03.10.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:25 -0800 (PST)
Received: (nullmailer pid 1546683 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:34 -0600
Message-Id: <20230310144734.1546656-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 6afae9897843..34d755797db4 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -964,7 +964,7 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 
 	sysc_check_children(ddata);
 
-	if (!of_get_property(np, "reg", NULL))
+	if (!of_property_present(np, "reg"))
 		return 0;
 
 	error = sysc_parse_registers(ddata);
-- 
2.39.2

