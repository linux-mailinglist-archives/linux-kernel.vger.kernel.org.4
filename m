Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401D64F388
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLPVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLPVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:54:17 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04145F402;
        Fri, 16 Dec 2022 13:54:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a16so3800909qtw.10;
        Fri, 16 Dec 2022 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjgSuNcfu6wLmaRa6ePAjpxabqq9MAxI6CRRehBhmdg=;
        b=EP848bjXNUdzDwYNsZ2cFpfscp9AwPICsoLizzjc7yDIPgpvrCJ8uDiHED7U/0A4Mi
         zbQFUxfxQsi5eX0NuHPd0ZluYekE+hrLqau7+UA4Rq1Zig1EqtzP8/GrDKn8QL7v6VBt
         mlXiMm/fsNhzcvQ6KVYP7mq8eMK9jBvC/r1k/BZX37Z4d3iiOTwpkqsCx68r03VLpOla
         w193ylycS957v5ln2ZDS3IQh9D9svTmdHdEkPTPJFfSeGoTcFf89ZB+jaq7KFdo0oD/O
         rnqNnpRo61o8eNUeGAbTpt0Vf57rEQHPLmb9isNaXi8KeW3TtCCxO8XMw8GTRt4bEOVc
         ouvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjgSuNcfu6wLmaRa6ePAjpxabqq9MAxI6CRRehBhmdg=;
        b=B0GPYI53xhmu7Wv6xrspNCPCnhtW/P4WlwrWO9Qhwslw9qeu5CpxxH2wJaLgDPwa6w
         HYH5Jjl5PI31izUDHYUTLzPugeM3IAFVZb0m2SuGsnbABfL66XCEg7shT2qqys7zjdVa
         p54xFGbvc7CEmH9iKfRCQ1v2pk7i/a6xWincig88Ab21bZJIlM3TxB3qhZBoze/je8Ug
         kWyagtTvCqvAyX7afPWlmPAeVUDAuCA2//tSfmS247miDwmP1ZdevuQHXQ1DeO+eIdg8
         Bfx9ke80g4NBUYU1PGN/nBD9G3LllZq3kbFeDImWkaVcuCujW0kF6nqMQuLI7sR4Gv+f
         j6eA==
X-Gm-Message-State: AFqh2kpHmYsT21Us/z+A4/jhNkxLFPGy+/ikV618UNLyXkENCUbE5uae
        ChBa4Ex4D+VRH85HicYSi7U=
X-Google-Smtp-Source: AMrXdXuXZoKMCiShk32gFA75ToBvj3sNmcsVmDqp9MzqNn07uAorbuiajYDvWp51D/dUKZTLKhssPw==
X-Received: by 2002:ac8:4792:0:b0:3a7:f424:d1bb with SMTP id k18-20020ac84792000000b003a7f424d1bbmr1588337qtq.21.1671227653754;
        Fri, 16 Dec 2022 13:54:13 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8554c000000b003972790deb9sm1947605qtr.84.2022.12.16.13.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:54:13 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        gmpy.liaowx@gmail.com, linux-mmc@vger.kernel.org
Cc:     f.fainelli@gmail.com, tony.luck@intel.com, anton@enomsg.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [RFC 0/1] mmc: Add mmc pstore backend support
Date:   Fri, 16 Dec 2022 16:54:09 -0500
Message-Id: <20221216215410.26960-1-kdasu.kdev@gmail.com>
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
 drivers/mmc/core/block.c     |  61 ++--
 drivers/mmc/core/block.h     |   9 +
 drivers/mmc/core/core.c      |  28 +-
 drivers/mmc/core/mmcpstore.c | 594 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     | 166 +++++-----
 include/linux/mmc/host.h     |   3 +
 8 files changed, 746 insertions(+), 129 deletions(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

