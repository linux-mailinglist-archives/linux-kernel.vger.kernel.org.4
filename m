Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0325BC2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISGCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiISGCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:02:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238F13E9A;
        Sun, 18 Sep 2022 23:02:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b35so39779694edf.0;
        Sun, 18 Sep 2022 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vvDnxWxa/4IpF0mTrVEUOhaygWRJT9ag8AWxwB/A5f0=;
        b=iPcjgjqo7NH6joxD4DrSCYNYa8T3j8M1sRcC1AzfvxMnqmpchieDty9C0eTeaL5Ugn
         m5iWgzi63D/bK8HsL6rMH5OoCPAJH2EXbrynIisfRuIo3ExqU5mOdSHvFQtRQp09jEEJ
         5uBEeW9opYs3WMiAx3xkGGxgtrXoGJwJNlqIwEsYheKpfs3KBKXccJw8rhu1/oeDzNLi
         yniVS2hiKYnQ5qYEeSxDiaRrz99FyEzmx3mE1PcndnCeHUxVPGDFYGVql0H2VUQEh3Ms
         fXSgpwdaJ19T5f/oMdoo9Lty3ZnF00KEsq9cz+UTr+foXMcSBl9HCn3ep6o02e38gvqY
         1gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vvDnxWxa/4IpF0mTrVEUOhaygWRJT9ag8AWxwB/A5f0=;
        b=K0nriZ2375Sdmdnm4T/bVYNLsvbvtLK3yWtWlKqMSyuECsz5JyN2gLdP2csv2mhVNO
         nkXoV2MoUS2ZQiz8SMcgZxNYuEQFo2H67ihCe0hVc3B6iBmmFYTrShJM8nkcYeiih/Up
         fP0fog2Lryy2rBvb43fc7zgtbao6Rg+JU8LumeblOWTDoPERzKC+0BXyAxBQlac6NmUM
         7/daDvBeDa1vgpwG3iM26WD+/B5CTXekxokWHvah1PeXVo3gIuzlhTLv2Wju/L4r/aXI
         luesy8fLkdeFXB1dFRH9iyO0Z0ZIVFi+x9lGnfU5FjWkhIMvuH7r+oDd8U9pDstveAxk
         FIDw==
X-Gm-Message-State: ACrzQf1WNfS+TtAL1Z4E7aeF/1RopyTWXkS0tGWSohimLnhOtG484fES
        vu579qCXRFOOdlhtNB52+GQ=
X-Google-Smtp-Source: AMsMyM7Iy5nRkInrGFeHKFOj3c9mXsDPpHAXk4qm3cZS7A/toiyJ8OY4FEhbA0b9LGGS/LhKf8aGzg==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr14079159edb.102.1663567350851;
        Sun, 18 Sep 2022 23:02:30 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id kv13-20020a17090778cd00b0072b33e91f96sm15045329ejc.190.2022.09.18.23.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 23:02:30 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: make SCSI_MOD depend on BLOCK for cleaner .config files
Date:   Mon, 19 Sep 2022 08:01:12 +0200
Message-Id: <20220919060112.24802-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI_MOD is a helper config symbol for configuring RAID_ATTRS properly,
i.e., RAID_ATTRS needs to be m when SCSI=m.

This helper config symbol SCSI_MOD still shows up even in kernel
configurations that do not select the block subsystem and where SCSI is
not even a configuration option mentioned and selectable.

Make this SCSI_MOD depend on BLOCK, so that it only shows up when it is
slightly relevant in the kernel configuration.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/scsi/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 955cb69a5418..03e71e3d5e5b 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -2,9 +2,10 @@
 menu "SCSI device support"
 
 config SCSI_MOD
-       tristate
-       default y if SCSI=n || SCSI=y
-       default m if SCSI=m
+	tristate
+	default y if SCSI=n || SCSI=y
+	default m if SCSI=m
+	depends on BLOCK
 
 config RAID_ATTRS
 	tristate "RAID Transport Class"
-- 
2.17.1

