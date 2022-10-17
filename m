Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874AA6013D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJQQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJQQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:47:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40994151C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:47:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s2so16952502edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVq1slC8WyteXvk7RgIypCJejBcKboJNQiDOlth57NM=;
        b=WLhZOoL0+ZlT3dtpqnUUanAxr3S3mdBeaPUVrfBjeO6OTToxShZto4EIoSHhXL+A+o
         3X4OIFRZc6kNM/uFgD9++gNH2IR0kY0OzVjf5t2eSpPUgDgPswtp4G913D9XCgQFaT9j
         m03i19GeBSu59zjOA0uFAw0k/etEpSuDmanmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVq1slC8WyteXvk7RgIypCJejBcKboJNQiDOlth57NM=;
        b=4DwXkmCU3vohkAnlJi+8R+9WrRwGQkpjNmHelXtip4hrMkvoKsUY3zNfjl0YvuGltX
         h6Pc99pHYEX+CJ3JXrsS+LMPGiIKNumZ7hyt0lM9pDj+80h3bNQEMgMN+S7OwqJ/GEQ9
         ygYIGB7lDw5PwxU+nv062e95OAHIXeoHyCx2jaoaavsbb+nkkDDtpCNkGvX/8EeDg/ve
         1XEr/Dlpl5HKvOPFEg2i73yl+GOS7RBWwvP2J/qVmSWB4z6+Qbd1CgpJjGzL8CH+bHQ4
         zk5+OHXBNQ5bdx0FNbzW02hqC03JZRLjONSnvn/PiI8b0iI3nDm2NOPZbl/sIP4bHIcs
         Q8Qw==
X-Gm-Message-State: ACrzQf1qPuqp9AS5lUkQh6yQHTHbXX0yLsyGJhkvovmfsPsqBf5/Mg2V
        +A5uAIHXxHzLXVvXfjTZG02yMsyiTkbqAw==
X-Google-Smtp-Source: AMsMyM7JzS8qgO6HKr9k/3n5USEcYA/w3vjO4D99E/pC1lnADlVjuncf3w8SKHgf2bailRsMya+j4A==
X-Received: by 2002:a05:6402:2706:b0:45d:aaae:e74a with SMTP id y6-20020a056402270600b0045daaaee74amr3392104edd.72.1666025235279;
        Mon, 17 Oct 2022 09:47:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-101-110.retail.telecomitalia.it. [95.244.101.110])
        by smtp.gmail.com with ESMTPSA id va30-20020a17090711de00b0078d61c5db0asm6316887ejb.49.2022.10.17.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:47:14 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] clk: ti: mux: don't free `parent_names' on kzalloc() failure
Date:   Mon, 17 Oct 2022 18:46:46 +0200
Message-Id: <20221017164646.4193618-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although no operation is performed by kfree() on a NULL pointer, it's
however suboptimal and semantically wrong doing it.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/ti/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 46b45b3e8319..1f924db2ad98 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -182,7 +182,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	}
 	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
 	if (!parent_names)
-		goto cleanup;
+		return;
 
 	of_clk_parent_fill(node, parent_names, num_parents);
 
-- 
2.32.0

