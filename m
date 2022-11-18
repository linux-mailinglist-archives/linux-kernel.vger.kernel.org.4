Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAC62EDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiKRGjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRGjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:39:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93954B1A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so7712687wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5oiNfOvT41t6HXKynIXOeq5TbszuzB9U1lEY6iugAI=;
        b=PBM8o/sZo2cZJdq4tjMFqGZ8h6B7Z2rtpjHe2f96qGeAhYiAmwC2LrjYyS8tVTDUu0
         3xa2u/uQCoHNvQSgogRz/0rbUemfdbpM5RMb5Ccff5UDiMFjUOkoYnHC3aTwWaNZTm5D
         jdjRj3yrAiuS22gTVGKWPkCMvgbnYu4MbBZsQnzTPXDW6zg8Q0PCthlBUxx54SZJXMJ/
         BCmnfwCCxUMSdjN/vlrg39UQZEBXd/7QzopjEOseUGQ/8dxG96LqZxlBOcjjorsXKfmU
         +ra6NJ3JyCxGzQq4P6XrC1uhXuDtBO/lyz5aJg/Si3qfhVkIo6am0U72pukg9F4MNyX8
         6gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5oiNfOvT41t6HXKynIXOeq5TbszuzB9U1lEY6iugAI=;
        b=rShQBh0Iz4/sQc69GAnmXscVoCswVFGtX8xL21sBKaFi70BFkqZOBoIUELqfyS7LNJ
         b1ewzadB7HXcTN4CXFo4ZQz+/fBk91MxQYPG1tmC1qJuOHSE3aEXBPvoYAQpyAD3X3/s
         ianxCKJLcsrGKcoZWhWMM02f0pEnpdk2BO7h5wRied88ccMfXXmJHvaqmk4Hj/pL3xV9
         yjP3LRpHizlBC4okZTwaCt4EkalX0Tyc9T3A4zX2iA8YoeFd41zkH2gZ9LeEalgJW3Pk
         QEXoMchckNJrdYKINGaR0puxU7Owmea/NNzrjxxsyHOlrZjBIkhPPI5l/uBc+Yw7sOhI
         itxA==
X-Gm-Message-State: ANoB5pn21e7GwM/UXG9SikNgGvu28aXXI6AEAs8qVqJKxoge1s9U+R+m
        dFStfxWSvZW+1xf2GXr60CYa4A==
X-Google-Smtp-Source: AA0mqf4sxXL2uHYL7tVOtnmynropwSLEvJ73fiO1FHrThbsnDDTCWmh5QoRyKmt2uCq8z9+daNsZ5A==
X-Received: by 2002:adf:ed86:0:b0:236:4930:2468 with SMTP id c6-20020adfed86000000b0023649302468mr3260380wro.221.1668753558092;
        Thu, 17 Nov 2022 22:39:18 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003b4fdbb6319sm7853861wmi.21.2022.11.17.22.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: fixes for 6.1
Date:   Fri, 18 Nov 2022 06:38:36 +0000
Message-Id: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi Greg,

Here is a few minor fixes in u-boot-env, rmem and lan9662-otp nvmem providers.
-two lan9662 fixes are to fix the compatible string and fix a smatch
warning.
- rmem fixes an error handling path.
- u-boot env has fix for data offset.

If its not too late, can you take them for 6.1.

Many thanks,
Srini


*** BLURB HERE ***

Christian Lamparter (1):
  nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env

Claudiu Beznea (1):
  nvmem: lan9662-otp: fix compatible name

Horatiu Vultur (1):
  nvmem: lan9662-otp: Change return type of
    lan9662_otp_wait_flag_clear()

Wei Yongjun (1):
  nvmem: rmem: Fix return value check in rmem_read()

 drivers/nvmem/lan9662-otpc.c | 4 ++--
 drivers/nvmem/rmem.c         | 4 ++--
 drivers/nvmem/u-boot-env.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

