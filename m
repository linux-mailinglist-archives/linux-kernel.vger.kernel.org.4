Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF86BE95F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCQMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCQMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:35:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48E6EBB2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:35:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so19664663edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056519;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlbqNJrYO/n+aN0q9wkJ44zCBKlY2BEF+Xu3HHvs+lk=;
        b=GvRWPpicmYmXHlmXJzdNDbj3S2e1NM1t2O+d+G4mcyTjY+RNbfyihjEQYVJCfuEE3A
         zlk5lls0IKRXAYSk+W1k4r7WAAHoNJX84ayxCGpob5VB9WjjIRAu4iokWHbfwkohcJ0p
         dn7hj23Lm2z6UssOPx44p2pRPWOb8dbf4aS4BxoFNeF5i/2klS/kLb9dLxWY0B9Mb9g6
         DqYWZ/C8CxvtQqSstmM2VXxkwKe6tg/1ZLHXeRz2GTVRHZyxRySRLyF02xn0dBT22pki
         p6JwPKDTHjKHDOEm7/jfym7V+hsH8VThTT9YTKbgj3qxoc4Jth5eU6zK1QXhz+7LL8oO
         29+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056519;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlbqNJrYO/n+aN0q9wkJ44zCBKlY2BEF+Xu3HHvs+lk=;
        b=irLodSFhUz2O+OqLNksmDxGzh7qkFyyFgKv74Qz3Br+TMkP0hrCEiP/zviuXcEBT2U
         AMyUBzp5FyT0eErUpRMLuMGvuZRHrsvsl7jnsJZqwTHdfwSetYbVxNEY1GEsoNYCJlcA
         6lgY+3lCr2+LKXWhvwojYRhz4YjkULCqUdzI0r+KOqXVcSdNK498J7jzMZTuX9VZlVHB
         11URyh9bTDatlsLVljn/PORTVqokSBFuPy5jhLYrzUQ/fuUeyEuF2W7vYj/SDrjsHbDy
         fLxqJkt+pMq7AbHtqVwUChg5408Plh1mcKVBsA1zADRHKVnzrENrP1z18yNagmKDCcNR
         s3/w==
X-Gm-Message-State: AO0yUKVzZUdMR6I59Qp69QnWfuEssLgYZykvrm4YEwC/NPw2pjljLwk0
        KI5X2ezPM2hpHD62OHNPLLg=
X-Google-Smtp-Source: AK7set+E6F3bPV5Jt0m8BKiK0eZ6JpTKSy+WaRiCMLFnBv3jH/IifuFoXGNDYNDyEjhRp3YiSBSA9A==
X-Received: by 2002:a17:906:2357:b0:931:829c:9d58 with SMTP id m23-20020a170906235700b00931829c9d58mr2769653eja.23.1679056518751;
        Fri, 17 Mar 2023 05:35:18 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825? (dynamic-2a01-0c23-c5b8-6200-dd0b-20c2-4c96-a825.c23.pool.telefonica.de. [2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825])
        by smtp.googlemail.com with ESMTPSA id r3-20020a50aac3000000b004fccef39ec9sm1020810edc.70.2023.03.17.05.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:35:18 -0700 (PDT)
Message-ID: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com>
Date:   Fri, 17 Mar 2023 13:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] base: soc: populate machine name in soc_device_register
 if empty
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoC drivers use the same of-based mechanism to populate the machine
name. Therefore move this to the core and try to populate the machine name
in soc_device_register if it's not set yet.
Make meson-gx-socinfo the first user of this new functionality.

Heiner Kallweit (2):
  base: soc: populate machine name in soc_device_register if empty
  soc: amlogic: meson-gx-socinfo: use new soc_device_register
    functionality to populate machine name

 drivers/base/soc.c                     | 15 +++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c |  5 -----
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.39.2

