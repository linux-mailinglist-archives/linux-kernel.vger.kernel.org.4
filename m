Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69A6C86ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjCXUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjCXUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:38:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD31E1D5;
        Fri, 24 Mar 2023 13:38:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2781327pjz.1;
        Fri, 24 Mar 2023 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679690320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5G/syVam4SknjFsEw80vzFCuD6BG5cs1b0YrLZ+gNk=;
        b=Qszr7DLVXSvWv7inbHD/oLNYm+jkkEndHv5jZjZ1JN2QZtmnnYUMaN7SIit905jKth
         /BY1QWiJtMJQoKUekclBnpaxN2Xaogq4ZhxUCS4g3M1TsjvkjTxR6CGheH5nCIdpTSI8
         4aBMEACUlkyn3IVVgCADf9JiPEQd2G4JNbs7tRSJrLQ3TgVlG0Nso9zPQAAfaR7XLJTN
         kbqiWuVPaEyBZYFi8ItKvBr+hg9POkkTrChKWNFM20EVn245JbJMhk/zM0utkwROuCEP
         Xu8SUw2TVZZjV2hOEEVaHhTA48dWf+vlBGCSYZjDgI2CORx6M2xjDLlC16HhHzcYwWmD
         4PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5G/syVam4SknjFsEw80vzFCuD6BG5cs1b0YrLZ+gNk=;
        b=Fkca0FAQ4AtqliZw8qJB2+60JK/w17QHF9IcJd/9UVm5d+HBd0WbUjx+/XZNZUxvcO
         VFr39C2ZAHJRnaRzjDrsJP/McaQnzqzbkROGOeVr2jhpOuy5kV8bmfQr8lc3HGuDoC1q
         GxsZtuEpeeZEnz7W3Zh/4wrBcjtiMD3UYiYEK8gVKG+TM0v1NzybT6E54G5aIVN11PN3
         9OFB0nuAJQMfovuGV5JIy0kGW1v9/fUj7WvZlAQV21yonaU/7JEC8E8Hab8V+O4GmN4o
         KATn8+3PCT5SkMeRajUkzIJ0ww9pIaHTLCSasfv1RBSksdUeF6GdmzKGKSpKmkH2pK3q
         74uA==
X-Gm-Message-State: AAQBX9fXXhqeNOc0iJ5ruNOmYQ1ZGhP8JXBhcba5L3cyGN0/Ty3sHHAw
        5ZXYpKzQITk398TxVhv+/pXUNKIM/bg=
X-Google-Smtp-Source: AKy350abHWZOnX82gVzMiOfTyAKmvgrVNRXbgit78I2H0sTGJQu3A7O6RzW1hgRIEMIzxXixOSoN6g==
X-Received: by 2002:a17:902:c949:b0:1a1:adb0:ed72 with SMTP id i9-20020a170902c94900b001a1adb0ed72mr4729285pla.4.1679690320097;
        Fri, 24 Mar 2023 13:38:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b001966d94cb2esm14503431plr.288.2023.03.24.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:38:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Lear <matthew.lear@broadcom.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 2/2] media: rc: gpio-ir-recv: Fix support for wake-up
Date:   Fri, 24 Mar 2023 13:38:33 -0700
Message-Id: <20230324203833.3540187-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324203833.3540187-1-f.fainelli@gmail.com>
References: <20230324203833.3540187-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was intended from the start to be a wake-up source for the
system, however due to the absence of a suitable call to
device_set_wakeup_capable(), the device_may_wakeup() call used to decide
whether to enable the GPIO interrupt as a wake-up source would never
happen. Lookup the DT standard "wakeup-source" property and call
device_init_wakeup() to ensure the device is flagged as being wakeup
capable.

Reported-by: Matthew Lear <matthew.lear@broadcom.com>
Fixes: fd0f6851eb46 ("[media] rc: Add support for GPIO based IR Receiver driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/media/rc/gpio-ir-recv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 8dbe780dae4e..41ef8cdba28c 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -103,6 +103,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
-- 
2.34.1

