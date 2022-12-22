Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A0654641
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiLVTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiLVTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:00:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21BD90;
        Thu, 22 Dec 2022 11:00:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso6625172pjp.4;
        Thu, 22 Dec 2022 11:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFlHOhHC7/RmpQRJa9gEiaIHntvkmmoFbzYzTMby5Y=;
        b=PlDDL7ZL3x2WUthmq9xSA5HiVbobKOOt85aMcEJ+jwTZK+rQ0xq/RfpsYssFH5TKHx
         Wcyuyg14ZY8Iosw8PxR7zDjWKQrqTJ/IQb3h/6b3yzVvQB7fuEbgMf1+b3RU+Saf3U/y
         wrDWe3IaUiW91k6F/fRo2Y+reuOk1joi8IJchc6vpSvDqXXh5KDUvvFvyxl2kzMAqccz
         hQkUcZzdXB8q7MokCmCW25rEICuq5cTNRGrPXXbkmL0LCdcAznP/eC6PpPdRx4mtIiQe
         FGTGZDb9Kp9uNM9jWyKNPDIpaOepaw0vBd+puiG5afsUybO/YcYPQBnufFRACNQcsjng
         s5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cFlHOhHC7/RmpQRJa9gEiaIHntvkmmoFbzYzTMby5Y=;
        b=WjNTwKU6i8ketZWDmg7990ingtLrN6gPYMMq8F8BH6ft4YkwwpltqPmiBsRMDZ7mqH
         GTUQ4XjZNfslY7u84pzPg+hR1gNi+Nd45Js2/lurc2JVFeLiJVOnN8IjSTWT31NOYroV
         Ps2LFSYTzXeEHv7OmqKnYZ6kJRATgY3HOZXehXbnoH/gAS9Ddt8C/UaNJ4sESzjJKpB7
         JPHVulOZWdf83GpyCAJIB/A/8JA/R8ZTSDYQEJli3jZ4iLrxwnfRIDtAzLow/C7SmnJa
         c8PJi912QHmDAY8d9ihy6witIn0SUcQsEjtmaibSg/Bxhxjrifb47FhkRSEQ1NDE6ZH6
         N+Gw==
X-Gm-Message-State: AFqh2krAGkdqoBKod/ZsvUM0zKxGpCvog5wy+L20KK1+sjVh7RFBCEIz
        4+v7GrsvdyYBlDE5IF3OSfE=
X-Google-Smtp-Source: AMrXdXu+d0bvQupICQM/vO8qDmVSJ5qhYWGOG6oHEIQSd01+pmglPRDQ4dBxKphtc9Ulgbv02Zp4uA==
X-Received: by 2002:a17:903:22ca:b0:186:5fa1:1eae with SMTP id y10-20020a17090322ca00b001865fa11eaemr8858986plg.48.1671735640822;
        Thu, 22 Dec 2022 11:00:40 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902d54600b001925169e9f4sm61468plf.98.2022.12.22.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:00:40 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        gmpy.liaowx@gmail.com, linux-mmc@vger.kernel.org,
        CLoehle@hyperstone.com
Cc:     f.fainelli@gmail.com, tony.luck@intel.com, anton@enomsg.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [RFC v2 0/1] mmc: Add mmc pstore backend support
Date:   Thu, 22 Dec 2022 13:59:47 -0500
Message-Id: <20221222185948.12717-1-kdasu.kdev@gmail.com>
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

v2 changes:

- Fixed rebase with upstream linux master
- Fixed build warnings

Have been trying to provide mmc backend support for fs/pstore feature
to be able to capture panic and dmesg logs to a emmc partition. The code is
based on mtdpstore and used kernel mmctest also as reference to be able to
send mmc rw requests. This code is work in progress and does not succssfully
write to the mmc partition as expected when a magic sysrq panic is induced.

Needed help from original authors and mmc core and host driver experts to
comment on missing peices. To that end I am sending an RFC patch. I have
confirmed by enabling dynamic debug that mmcpstore read and panic_write
routines do get called by the fs/pstore/zone driver, however I do not see
expected results mounted /sys/fs/pstore after a reboot.

Kamal Dasu (1):
  mmc: Add mmc pstore backend support

 drivers/mmc/core/Kconfig     |  13 +
 drivers/mmc/core/Makefile    |   1 +
 drivers/mmc/core/block.c     |   4 +
 drivers/mmc/core/block.h     |   9 +
 drivers/mmc/core/mmcpstore.c | 592 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |  20 ++
 include/linux/mmc/host.h     |   3 +
 7 files changed, 642 insertions(+)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

