Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD56F7F15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjEEI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEEI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB01A122;
        Fri,  5 May 2023 01:27:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115eef620so17933997b3a.1;
        Fri, 05 May 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el/Rn7qzup/497ytaREh2DImIqrYtRSHCU5jaoJYhms=;
        b=Iyf4GbJlx14NUP+57ckxFwh5TzvX8eMEKwjajIAGWX4UjGhM/SAV61BJ6vUaIL/YjV
         lKg8sk/u6zp4qHfTiyA2zwSnBu6sCg0FFsGuwFBregRmVW/ba8p0MUEHtVmZnyiE0F/G
         q74XuzMO2Ek7aw571eR3OZpb9fiRP2Hc5EeEUoGmwgU2125XrVHc4NKanACv5myZhNOg
         ygThbAaBC08/sYEXJ1aafJhqEkdBsFSSHuen7bVmtgfjWxSC4GRg4BonT2tKYjMAtS2W
         yz4fk4KbX5r0R//jEFRUcnVYJSC9e3NZhsgLiV9F2CZMGBbw5Mm7V2EvN+R6WnoEDtmG
         UojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=el/Rn7qzup/497ytaREh2DImIqrYtRSHCU5jaoJYhms=;
        b=dV8uY3xk24lfH7XU7YnQ5/ZFGpXzNxEVCwiuFq4i4rUydC2nUYlKZx774kQ2wPnF1t
         gCf+wenfsDZDLySUygxcFPCqnfGwyaEBLbYIK6DQrL6DXhug39yuVoMul25qqdUQPinV
         R2Kb2xEcDcPyN9IO3VPCzhSMJ/zmlw5I+NesJCzByrfplFt4haGThPDAD3Kv6yvOQJJZ
         bD+BTzC82EMgYpx4S6GY4ycWV8mrrh6d2shYikYm7zxehNOoaqHd3eglaA/SXMy0ud0P
         IkF4VSl9HvXxYTxugvEpoad5Mq8bCJx5BbXwBupx20SxV++ggTYqZaS6BUkLd8SfR1t0
         +VkA==
X-Gm-Message-State: AC+VfDyZNXC6gKLdfBvcCtP4yJCFKJ2cRLmV/lMx/JYmxAwzwch3WSqM
        j0BevlcDx2ezg86SrLyNxdk=
X-Google-Smtp-Source: ACHHUZ6U1yKFWRfgcLq5hhCullhfXhzyXSkcylWLS/d1geITMe7fLICBHN3EiylDtt7kpx3RmhVryw==
X-Received: by 2002:a05:6a00:2d0b:b0:5a8:9858:750a with SMTP id fa11-20020a056a002d0b00b005a89858750amr1140902pfb.13.1683275237537;
        Fri, 05 May 2023 01:27:17 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id r15-20020a63440f000000b0051b8172fa68sm1068333pga.38.2023.05.05.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5473F106280; Fri,  5 May 2023 15:27:12 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to 2.4 driver
Date:   Fri,  5 May 2023 15:27:04 +0700
Message-Id: <20230505082704.16228-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505082704.16228-1-bagasdotme@gmail.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=bagasdotme@gmail.com; h=from:subject; bh=+UknXRJJBadqLnLOgfRQbspacSVeqok6a0BQmw70Uac=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkhe29sL9oa+4xJVH2qyvINTQcWzubVu1eao9wwa1/Ak vqCefszO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARTxlGhhlafzJCz4XcKGK4 N/XD5rj1f9wDcvVjWCo2ij7myw5+kczwT/HH1/uKnbzpdp/Zj0ofnPD5erGW/UFG7zULLWU9v3l P4AQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 driver link returns 404. As no one runs 2.4 kernel anymore,
remove the stale reference.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scsi/dc395x.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/scsi/dc395x.rst b/Documentation/scsi/dc395x.rst
index c413b629809bcd..a6320561543650 100644
--- a/Documentation/scsi/dc395x.rst
+++ b/Documentation/scsi/dc395x.rst
@@ -11,10 +11,6 @@ be safe to use. Testing with hard disks has not been done to any
 great degree and caution should be exercised if you want to attempt
 to use this driver with hard disks.
 
-This is a 2.5 only driver. For a 2.4 driver please see the original
-driver (which this driver started from) at
-http://www.garloff.de/kurt/linux/dc395/
-
 Problems, questions and patches should be submitted to the `Linux SCSI
 mailing list <linux-scsi@vger.kernel.org>`_.
 
-- 
An old man doll... just what I always wanted! - Clara

