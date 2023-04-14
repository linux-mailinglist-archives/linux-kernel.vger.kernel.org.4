Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C596E2A22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDNSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDNSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:34:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42384EDD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:34:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94a342f202cso47882066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681497295; x=1684089295;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/J+vjdb6cOyet1NlcJdx7Gney2QIkG13+uv7x6+rlKE=;
        b=G05SBNFy+5LmoPB7N11GwA1JML3OifQBNYPoauP/kLqe28fX59OGvQikVdsU4O2tDh
         zOVj501kf2xTO+zvTMDq+Kp3aZf+eYqSK5ua93Kja/71tEvabIKH1sKsPC43lAsaDyxa
         2tEn0/DMof+CP2PLedntGb1xlx8uKxCHbsofChiYZtDQXfp+80LxC7owTaumdLcudxSk
         9DNIyE9PdqzsdES5sUSsGT2tGVek6S186vBvQTOs4T63Y2DZpHmZQzFOVppbxnt0IKZw
         5pjqR1HRtfrwumCZwBC+wyXKi2zgAqi04XXYr4NdQDbBD0wZkL5pSDSiK72I/3J/RVIY
         SqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497295; x=1684089295;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/J+vjdb6cOyet1NlcJdx7Gney2QIkG13+uv7x6+rlKE=;
        b=gA6ICQogITuzjsp+kO5MjZqXNU0ZPrGgJYMaOlfASceZIR2NYmAhavmLUms73uiSAX
         0wbxSCxznQo/DQiOVD88SnuxJahN39j2dMjXbN9X9GsRL4O6lOCbJ8TUP16KQXskOlmL
         5UE+T7OKc2ly885n7dEBoNmUhQ/gYGQXpubsRW1CE9AkkSTvIWmI7KM9PPpZ/qcTcsgt
         9ksma7oXJRudhyRWCZyjE3CywEx5OEXX9DYmgUDJdm+mjlT/8sUXP6Joj7yvIVI8DTlO
         oya1/Ve6AGnX4q7vFvdrlcp7oVpRF88P2YhJgtBdQpz/kEHgka0zz2asbrq43vvXuJNu
         pKzw==
X-Gm-Message-State: AAQBX9dwJZ/M8rxWVtSMBWaqqKsAGlXbX5Rk7/GxQ9WqWb23kzwL0cA9
        WblDAaaCZF199sMOv78ubM0rYkFaEPI=
X-Google-Smtp-Source: AKy350Yfsz8pokbm+WLlXGCqYoauSB33GAtn2ZEuFtPM657L3N+8DOR1vE+fbxwQQ7ZaL7nCXRMN1w==
X-Received: by 2002:a17:906:d4:b0:947:bff2:1c2b with SMTP id 20-20020a17090600d400b00947bff21c2bmr2971926eji.1.1681497294723;
        Fri, 14 Apr 2023 11:34:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id m9-20020a1709062b8900b0094a9b9c4979sm2781449ejg.88.2023.04.14.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:34:54 -0700 (PDT)
Date:   Fri, 14 Apr 2023 20:34:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
Message-ID: <20230414183452.GA12295@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading the driver for rtl8192e, the W_DISABLE# switch is working as
intended. But when the WLAN is turned off in software and then turned on
again the W_DISABLE# does not work anymore. Reason for this is that in
the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
checked and returned when true. bfirst_after_down is set true when
switching the WLAN off in software. But it is not set to false again
when WLAN is turned on again.

Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
above described bug.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 45989a77a27c..a644543015ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -648,6 +648,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
-- 
2.40.0

