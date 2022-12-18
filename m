Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4C64FEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiLRLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiLRLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B435FCD;
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so4085375wma.3;
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pB3pR0xSFkHS5ng5jDm59LQOgE/5iH7o38sPru0IP/w=;
        b=RRIWX3L1au1PZjBj+aHAbqCx1VgQZnU0VQa4OvI0mR0VtbOH+MBKMCHguIvuhuBzHc
         btF9GHl9MT7GxSOLL62PomsMMIFMtUA3EjGWLCuZOkVSLl+N0dNUFAuwOht4CHMad+vh
         dxdE1f5InzN9Nfv1qj5BnWlmfE88NVZukYxcMTzBkcNKvQKG573fFcv9EgcOttKsVMjX
         pMo0Jp8N72mEQl0pO6j9/TVpb/ORECKsF67JcCasGDqUIw5UaGJFkp5GeRP3Jl5eDrmo
         bZ1eWaAKd/O4nhABWv3XvKaFUe9X8sTJH+DYQXJsb5V4wTsgBJl7dBINdtrj7yVZLYNX
         4FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB3pR0xSFkHS5ng5jDm59LQOgE/5iH7o38sPru0IP/w=;
        b=40jTvaMKXgG93TbJNt6YrBJOIsT3XwLkJDnFTm6Nf/7oGT9fUKvM6HEBaQYXgZwESi
         FMx+KT5NulsXfNXhGNMMKWo1zDCT3OkvFm3lEXtLwWvQAWPEHAJBrn5II9asX4I2T0sV
         hCb/xEsLs7/rlwGSbn+j9qRkIWQkDOdOEoFJjZoJpwcGMc9VQ1V2JQS0GTC5mSqbnUWF
         sKoGN8UyI+vcw1W29IJCgvqiugixMC5ToBJSX2R2PscCVeEYkZufYXJZzgpLVz0BujNO
         WJxyYZOlUPfQcFLZSYfAtnSqw3tdWIr1HDb+XfR/3nKt7S7yFJs6Z4c0LamKsoHZVhQ2
         fB5g==
X-Gm-Message-State: ANoB5pkJ5nH30epsnIKUEJ/R/o63+IC513pskG0hjrtVBMVuf5zWrL9V
        vrYvDtgyX6FaHa9QG9mQagB46tkZ0SQaSg==
X-Google-Smtp-Source: AA0mqf6ZNz/555rRqS/lBkaB3r3XYKInXHbcS5TuYdkVbk8o1QsCwIcYzQbpQ+/TzSOv8A4ut2IsUQ==
X-Received: by 2002:a05:600c:5546:b0:3d1:f6b3:2ce3 with SMTP id iz6-20020a05600c554600b003d1f6b32ce3mr40164490wmb.35.1671363120747;
        Sun, 18 Dec 2022 03:32:00 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:00 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 0/6] hwmon: (aquacomputer_d5next) Add Aquacomputer Aquaero sensors
Date:   Sun, 18 Dec 2022 12:31:25 +0100
Message-Id: <20221218113131.3752-1-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Add support for the Aquacomputer Aquaero 5/6 fan controllers. These fan
controllers support 4 fans, 8 physical temperature sensors, 8 virtual
temperature sensors and 2 flow sensors.

The first 5 patches prepare support for Aquacomputer Aquaero without
changing the functionality. Patch 6 adds support for Aquaero sensors.
Fan control is planned for a future patch.

Leonard Anderweit (6):
  hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_SIZE to
    AQC_SENSOR_SIZE
  hwmon: (aquacomputer_d5next) Restructure flow sensor reading
  hwmon: (aquacomputer_d5next) Add structure for fan layout
  hwmon: (aquacomputer_d5next) Device dependent serial number and
    firmware offsets
  hwmon: (aquacomputer_d5next) Make fan sensor offsets u16
  hwmon: (aquacomputer_d5next) Support sensors for Aquacomputer Aquaero

 Documentation/hwmon/aquacomputer_d5next.rst |   5 +
 drivers/hwmon/aquacomputer_d5next.c         | 193 ++++++++++++++++----
 2 files changed, 165 insertions(+), 33 deletions(-)

-- 
2.38.1

