Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779696930C1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBKL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBKL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:58:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6358A2B2BD;
        Sat, 11 Feb 2023 03:58:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so5865381wms.1;
        Sat, 11 Feb 2023 03:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRXF46+mjeBDdYeATScPjTk613xPVVf9nci3gZ3rPFM=;
        b=gP3nwW5NmOGyIYbeuxc2DLrPiZoBThXf731AGcyvQUeZOOVbGQaqBHGPIXcqHQGuhr
         GYHB966YKm0BByoAU+4cRdXI50d3YqNQ95wILcGlMpM9ZGpIhJgUm1W/rvTEuqgrMJLn
         43lqoFO/YCWXRpgGb41R8xXEFqTeAP+QFx/3PJDpP0OSxEmMzS2CWr56dwUEaZ16uwUo
         ksqsn6NFbIQ2UOUA9hbqmjm0lXdijUW4PggkAKfcqYEQ5+2Bzsb2moCSZKQ/YPSg59V7
         3cO2NphwtJFWgOSqTVLxX6wHWnZnSlv2Pd3l4DD3s062Lu3Pqk8a3WocK+vwtnTs1Jhs
         LJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRXF46+mjeBDdYeATScPjTk613xPVVf9nci3gZ3rPFM=;
        b=kPKgC5vDQAjL4vFQFDYQwcTnV+ysnG3F56dfgV5zpvjlQIlu9L7gPTVvDVoSNu6cjQ
         0mP1EP9LwNnD1Rfmq75MVTblCeTQ3okEsxy8pKGOrCEcp8k7QQnt9ke71sCA+82DiCsX
         SvQk0zLPexbPSkaG8zBCxLs8ElZd1R9bk+MnZCPLtW4hVQI5DxXLFvK1im/nkkpWlpFO
         aeHsLbBLTUcRidJa8UD9XpuQdiydPsRYRuYB8YWgUsSqwnqkGicrZjWENayT7EOOyLhu
         3WL8KovbcG9GiIEQglhjJbQx2zr7bKMP7szVpyJR5nSYw+SJo5alPfz97qfFHli7HUFk
         D3Ag==
X-Gm-Message-State: AO0yUKUvIILDUZGFxtQ/Do+wbi17qakOyPXXuy+yKfBkb1JBq5KBKDcw
        OkTnHW/01iIkj7D5ihIeb/lx5GL2nWV89A==
X-Google-Smtp-Source: AK7set/O6l5BC3r2vT+5rSrInP1G4K0G19SNWDI+i/eg9xgkfeECpZk/ZYoSpP/49P1M0Y9gPGTmYw==
X-Received: by 2002:a05:600c:998:b0:3dc:59ee:7978 with SMTP id w24-20020a05600c099800b003dc59ee7978mr14827167wmp.38.1676116685784;
        Sat, 11 Feb 2023 03:58:05 -0800 (PST)
Received: from michael-VirtualBox.. (109-186-125-17.bb.netvision.net.il. [109.186.125.17])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b003e01493b136sm11646027wms.43.2023.02.11.03.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:58:05 -0800 (PST)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v1 0/1] HID: ft260: add GPIO support
Date:   Sat, 11 Feb 2023 13:57:51 +0200
Message-Id: <20230211115752.26276-1-michael.zaidman@gmail.com>
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

The FTDI FT260 chip implements USB to I2C/UART bridges through two USB
HID class interfaces. The first is for I2C, and the second is for UART.
Each interface is independent, and the kernel detects it as a separate
USB hidraw device. In addition, the chip implements 14 GPIOs via
multifunctional pins.

This patch set adds GPIO support.

Michael Zaidman (1):
  HID: ft260: add GPIO support

 drivers/hid/hid-ft260.c | 476 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 447 insertions(+), 29 deletions(-)

-- 
2.34.1

