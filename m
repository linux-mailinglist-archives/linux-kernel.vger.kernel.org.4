Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD7638FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKYSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKYSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:22:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432061144B;
        Fri, 25 Nov 2022 10:22:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v8so7420908edi.3;
        Fri, 25 Nov 2022 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GIR0vPnh1tQj7f8dFTKnQiTbAWGUY2lBbRumCozbYgU=;
        b=Vk06GqO1+ZPAbUMVJG7AOsu0LWIbr4GVdaL5DGro6FVX3tezXKv3UhoiOE5PYhgl0e
         kizKuzZEof3hAxt4t5QNG/zd4caCXu+fAfXZBe922+TjfRFG+HyHaF+1W5siIeh5/9FG
         V0by94J+nI9VzNg+yU1zooNBQcTgxWKXsNnpApwmVOJZe5+/NxMl04CDA9PrqtsUoUSX
         Mp3XsuJIKzF1MyCrMYvyDUPjPH3tf6WAmyAXo9mQOcR+cId1NNbTLvle8f7+MIgFDV/T
         Ob4a1YhB1rDFgcvrqHe/k8CaAw9dcp5BPMXsor8UPbqDxYt+OFxtQQrurW57bS9KqCH5
         UcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIR0vPnh1tQj7f8dFTKnQiTbAWGUY2lBbRumCozbYgU=;
        b=KMFoCd7ZvIXeXJHcCFElyf0FtkpG1vNaLrjrYCrEkMdzC+20ihJqFyHIGzwJ4Wu316
         om0DiT1cDlovDsc2PD0Z/NWkDnx1RQu1m7f54FvM+LTaniTXEyWsKAK8H3YaN7XjyPPy
         b6Z/PYlY5CSs2m+YDJVGyCY8C4QEP/9Xqbfl3LVRxFPR5gLrONl2f30AUMTK/0pPAPwk
         tk4lAwCrSnQ/UUkSV/akooGziAVchzOwIle3NSYIRp9tglvqF7R8lwq2zmHfWSFKIoT8
         /R+57m+DcTkusyq0mL9wVBzFOJK3eXCQvyMaZkO3o5Id8pOW8mLm+W1h220UfRDepCOf
         EuhA==
X-Gm-Message-State: ANoB5pn0ttZtq+w4xcARdlwudEcY6OIM+alQtnJ/DUkGYJl+KvXJEmdE
        ikCa1txr2fOhYA5Z8lCOwe2XbykRuEc=
X-Google-Smtp-Source: AA0mqf4wiC724gCey5671bcoS4vYj4Crxoycui2EQI2NhG5YHqJ5poRzip/JbAqmQqKGz4LvDoPTiw==
X-Received: by 2002:a05:6402:3711:b0:461:b6a9:c5cb with SMTP id ek17-20020a056402371100b00461b6a9c5cbmr22028968edb.148.1669400563866;
        Fri, 25 Nov 2022 10:22:43 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906200a00b00781dbdb292asm1811610ejo.155.2022.11.25.10.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 10:22:43 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] usb: musb: remove extra check in musb_gadget_vbus_draw
Date:   Fri, 25 Nov 2022 20:21:15 +0200
Message-Id: <1669400475-4762-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Y33H+Pqf3QoN8/IM@atomide.com>
References: <Y33H+Pqf3QoN8/IM@atomide.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for musb->xceiv and musb->xceiv->set_power duplicate those in
usb_phy_set_power(), so there is no need of them. Moreover, not calling
usb_phy_set_power() results in usb_phy_set_charger_current() not being
called, so current USB config max current is not propagated through USB
charger framework and charger drivers may try to draw more current than
allowed or possible.

Fix that by removing those extra checks and calling usb_phy_set_power()
directly.

Tested on Motorola Droid4 and Nokia N900

Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6cb9514..31c4432 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1630,8 +1630,6 @@ static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	if (!musb->xceiv || !musb->xceiv->set_power)
-		return -EOPNOTSUPP;
 	return usb_phy_set_power(musb->xceiv, mA);
 }
 
-- 
1.9.1

