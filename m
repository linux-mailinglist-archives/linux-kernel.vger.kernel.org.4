Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F5627860
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiKNJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiKNJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:00:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776461CB0E;
        Mon, 14 Nov 2022 01:00:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x2so16289791edd.2;
        Mon, 14 Nov 2022 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zivTwRXmaNmxNrJC3hUgTcp8c5Y6QenJRLPxm2W/9wQ=;
        b=nCh0yDqGbkK6aBLZJlr0PdNha/yc+588+4hyoOT+hnjoZPFu26tvgcEsNgGaYJsMK4
         5LITenI6CWkbLGA8a+aj4dTK1xm/PV1PSlsi80Kuzf4OwNI9c9VhXIA8AryYd6uC9xva
         V9Ntmo1V6NQsUe3YIffd+HTUl0LnEVqmmI8gjD5UjNHMmO5RnRjQ8z6DCLN0ZSFTrdZG
         HWtYcdxesnr477oOlJ0NJewjDDqaLKuKJNH7l5iO2UwXGbU3WipQN51fTU1SahifNXiS
         dHx5rj1+C2VmFX4RC7VW7isyPAchAH0uB0AykpcLsguyqfg4eRWUgsgAccW2SijAghqP
         a4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zivTwRXmaNmxNrJC3hUgTcp8c5Y6QenJRLPxm2W/9wQ=;
        b=OHa5j1TcC1O4n994Or4j3fJU6kok4tWXqSacOq4VkuIOye//wKzokXbnmxq8Ud15jX
         P4+AI1rhiZDNEhuhZd6GeQOIu5IOWZ6ZNccL8vR9vMRLEuL4XltfdExTeLJaE+YfYMT+
         HbiIt5t02IcCiO4AADYZB3r3PVkLcMdS18Xyw6Im/xprCRK8VvojHuRJ+6L43KPkEZrN
         tXAbjILQ4/RCRzJUBh9WIl0ADcnwFa18DazbJ5OMTlhH9UWnh6ZoL+k+mr4fxWjkVCCZ
         Sz7OpWQdBMxL9yQ4ylLGj2iJgNtrtzyrqLQmUSW7ZWhiFznlGJEulLNgv0e0e/3HkDoj
         J/sw==
X-Gm-Message-State: ANoB5pkmaZYH0fiIzkrghJMjne5OGG7W9m6xIVdlxQ96mvzfdBV4jEn7
        VKGGpH1FaVuxoCMAVW549r4=
X-Google-Smtp-Source: AA0mqf6MslnmSY2JbINyZhQaXwDI2V3/KLk0KDcI4bv3bsoaD1dkP7LUEiO2wTHB3DXZIM/rUJQ/dg==
X-Received: by 2002:a05:6402:643:b0:462:5f37:5a22 with SMTP id u3-20020a056402064300b004625f375a22mr10203771edx.226.1668416421902;
        Mon, 14 Nov 2022 01:00:21 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id t2-20020a170906a10200b0078194737761sm3852490ejy.124.2022.11.14.01.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:00:21 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] usb: musb: remove extra check in musb_gadget_vbus_draw
Date:   Mon, 14 Nov 2022 10:59:47 +0200
Message-Id: <1668416387-24984-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for musb->xceiv->set_power duplicates the check done in
usb_phy_set_power(). Moreover, not calling usb_phy_set_power() results in
current USB config max current not being propagated through usb_charger FW

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6704a62..ba20272d 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1628,8 +1628,6 @@ static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	if (!musb->xceiv->set_power)
-		return -EOPNOTSUPP;
 	return usb_phy_set_power(musb->xceiv, mA);
 }
 
-- 
1.9.1

