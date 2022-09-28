Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC15EDF21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiI1OtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiI1OtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37118E462;
        Wed, 28 Sep 2022 07:49:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v28so7349333wrd.3;
        Wed, 28 Sep 2022 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qvSA+77iX80SyZlPyYReSsjgVzPaFS2EEuNKiTrqrNs=;
        b=J7y6uyGKQBxR3+AjLYG8HWeW8XHhDWbgmZz/RTgcMpPVjQbjUMvTsuk7iB0T1gWTNV
         l5auU0AgOm6lw3A7Mzq0iLAShPMd3soesjsXTzUVJHFsVc0gE6W7yr2TNlQPkf6ktI6P
         hugzjMtnlUDmVoV9vv8IR3wQYO/IZj8PXZM9XkVSXnfJjKBj/LmgN9nhQcdr1IPP6zrY
         m8Q+VNrILWpfYCUSWLLPhxeEwcSvT+CTMadJb8P/APtgavHuC9E08ce4DEblqGfD8s+K
         Sdqyb+Daxz+HGAW7P3OeTU9KFvNLcLS3HDFFVvFhjsUK0kPqDvDyqmJq8Qvd6PGmJkDn
         VP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qvSA+77iX80SyZlPyYReSsjgVzPaFS2EEuNKiTrqrNs=;
        b=gK9ebmwsnxUD+sBeQUyYcjCpI4vywk3KQyvjSpIEDQnX7ljUqRk0Zbc2NLop2coZsW
         KkXsNvmdFgZYQfX9OothdCLBE2gf8JV1PtNcRyJ9L2OmLOqFYpDAsSaqhghr+UDq0uQb
         SyDNqTLd1taY83u+Sz8jt13B5qvvLWxHJemucqoWnlBKSlGYdOpHqQ8JvE8azAPV/RqE
         0M3sy0kM2rzgmAEjYW0NchkjZ5ysJM24pcdXBcrEc5bz0QQXhzm7xRENlEbCVEaz7/5o
         yOLVBT99EsrD/SGCRpDgSptsFPXl8tzEHO+RvBL+XmSqargsCxi3b14vK9jcie1WQpab
         CeEg==
X-Gm-Message-State: ACrzQf0FSFEqPTnUjvpdKRlFwKn1dwD17fheq3ZSnGN6msztFRukB2Cz
        TFTufKMDW5kuOhsuoCGze/UrnfdHQrU=
X-Google-Smtp-Source: AMsMyM6bufvjwdfrTtD1mfsp4uuINqjCjsFayHXUfMz28BjN9Pgyr01rKIGW/+RG79KdU6QATuDZHg==
X-Received: by 2002:a5d:4ac8:0:b0:22c:c8ee:dfd9 with SMTP id y8-20020a5d4ac8000000b0022cc8eedfd9mr2231033wrs.364.1664376546230;
        Wed, 28 Sep 2022 07:49:06 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:05 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 0/7] HID: ft260: fixes and performance improvements
Date:   Wed, 28 Sep 2022 17:48:47 +0300
Message-Id: <20220928144854.5580-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series is an updated version of this one:
https://lore.kernel.org/all/20220525074757.7519-1-michael.zaidman@gmail.com/.

Changes since v1:

- Addressed two security-related issues reported by Enrik Berkhan:
  1. Do not populate hidraw device.
  2. Avoid stale read buffer pointer.

- The patch set v1 was tested by Guillaume Champagne. Added appropriate
  Tested-by notice in the related commits.

Michael Zaidman (7):
  HID: ft260: ft260_xfer_status routine cleanup
  HID: ft260: improve i2c write performance
  HID: ft260: support i2c writes larger than HID report size
  HID: ft260: support i2c reads greater than HID report size
  HID: ft260: improve i2c large reads performance
  HID: ft260: do not populate /dev/hidraw device
  HID: ft260: skip unexpected HID input reports

 drivers/hid/hid-ft260.c | 257 ++++++++++++++++++++++------------------
 1 file changed, 141 insertions(+), 116 deletions(-)

-- 
2.34.1

