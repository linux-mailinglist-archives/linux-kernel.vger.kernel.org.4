Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0961E099
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKFHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKFHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:14:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12436BC19
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:14:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s4so5465951qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DonEqSTJiwnh5BPpFBajI/K8nd1IJI444+Ft76rBKbY=;
        b=BwTCwscxr3J8iHXdr/sJ6iyd05vpTUtyYq8PxjSk8DRZAF/9cnofyj2B8Hc82Oqi/C
         cw6HletfEyCnEQNj6xDMQHEZNQlqrF4FM+RaTz6NqWTe3CYpgPelSMw5+Vt8wq6B34x7
         s3FFXYPnK4Uid2ePnXzA2TdYgMUC4KVVlv5ITyprhQ0knqB/EmX0u11ayM7SxX9pzs80
         3gZZ0top7GnxatAbAjQJursv2FCr+dK1tSuazhRhwTBkbIINe9BnEV77LK8uY0C8zUIc
         UFNmeTP9eautaNKnay1NdBQ/p767iB7dqTrkSJJJPt46LPDTHxr0dir9liGEGKH4sfga
         JIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DonEqSTJiwnh5BPpFBajI/K8nd1IJI444+Ft76rBKbY=;
        b=hchQu0eu3hddFSF51rXgGWT1Zbx3hfozw3dlLbzEx/afHSABoVKCTIVz+nOZzt8Qap
         HpofwvatQN8Iajso66XjVM8rik6J54AymB09LAKPeM8QhGOgMvYYtMTn9FjRZmsCC0pH
         o9R1mUK64Ta8yX5jYlHH2yURUypD0yxcoNAGG66DaqjCRhp9JnJuWd8vnBIEDCCArPBT
         nK8chQF/4foDAIUa/h3UMsZ3O0LNHorn8+gsdyMxU60ou0PWacIgZGqms9ekT05y2frl
         EMLz/75PXrxMmeaUBxz7gqDSdnc/b5IOQEXB0oekTbeCggRmTx1kYRVqHDQTBq60T9Fp
         tACw==
X-Gm-Message-State: ACrzQf1rzK5CLV06TUnkG5hZbB85ZTaseqakZ1SbQS7Jj/zEQGVwuh94
        JYsPCdQkIqM64/1ukdlD0asduw==
X-Google-Smtp-Source: AMsMyM4FmqkCCkXopNcpZQ8cRQq0Ci9aFTIZoXidQE8xCp5VjNMrmafuc/0Yt5R0XiKoR7wKPlicrw==
X-Received: by 2002:a05:622a:986:b0:3a5:1eca:a7e1 with SMTP id bw6-20020a05622a098600b003a51ecaa7e1mr30721034qtb.350.1667718863157;
        Sun, 06 Nov 2022 00:14:23 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006af0ce13499sm3719038qkj.115.2022.11.06.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 00:14:22 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/3] Migrate i8255 GPIO drivers to regmap API
Date:   Thu,  3 Nov 2022 07:20:46 -0400
Message-Id: <cover.1667472555.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Precursor patches are provided for 104-dio-48e and 104-idi-48 to migrate
their respective device-specific registers first in order to simplify
the subsequent patch migrating the i8255 library and its dependents.

The struct i8255 control_state member serves as a cache of the i8255
device's control register. Does the regmap API support caching such that
we won't need to manually update a control_state member?

William Breathitt Gray (3):
  gpio: 104-dio-48e: Migrate to regmap API
  gpio: 104-idi-48: Migrate to regmap API
  gpio: i8255: Migrate to regmap API

 drivers/gpio/gpio-104-dio-48e.c | 200 +++++++++++++++++++----------
 drivers/gpio/gpio-104-idi-48.c  | 110 +++++++++++-----
 drivers/gpio/gpio-gpio-mm.c     |  97 ++++++++++----
 drivers/gpio/gpio-i8255.c       | 218 +++++++++++++++++++++-----------
 drivers/gpio/gpio-i8255.h       |  54 ++++----
 5 files changed, 451 insertions(+), 228 deletions(-)


base-commit: b8b80348c57b360019071e17380298619c5d8066
-- 
2.37.3

