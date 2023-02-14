Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4E697055
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjBNWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F49EB57;
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so1510430wmp.1;
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMXnw1VQbx8Sv6EwiMKN2CItMHbinEY7o7yRWkmdY/w=;
        b=FXSyug5ZkRqNz85G/mIciOh6KEJc19RzIJFXXm1I21jfpEbb3bTXbqeKCsp+6Swrt6
         pRVwPLI3K5z9PLANI39ojOhskzW2C6WqnTym9AHPyappb3ZALXfE0IFZ9Reue4Ljb1nA
         s7v/VquL9ZYV8Gu+t1EuZonlNg17UgJuVf5wwC0GXzAy8/D2LRs4r62y304qfjvheqlR
         s5vL2wKCrZX+2ZWIjwqJseCGsVhWMkV43gTOY3vIRHN3uOuKMVHwTr7h4nI4g1sh9a1k
         p5YHSKdTVIXyu+etWOmOsOTa/TmuyxV4plw5RdBMZaIpbilplZ/W1kOlyi4h5S4gvKRW
         D1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMXnw1VQbx8Sv6EwiMKN2CItMHbinEY7o7yRWkmdY/w=;
        b=5WNjmEf1sI1DHDTyD6jiQ7Q7pMwtL8LAZnicPERUY7Bpr+hZajbO1dKhOoMEO77Gwx
         QLO/OCwmm8eNk3Hh2y1n1a0hLKGrDh0K2jQQMtoMDkKln8UoRDcSIOj9hWV/CFLBzPQn
         axAcWAPZ6m4nNcAi8XJ8CBfbi47JploE7ugWf+lZoCuU0ZkRGb5Y7+R0mr5CYJdIITzP
         Zr/OZarABTbk7WQQAIjLQjLTjh3Ws2pyDlHAOFiCGWzNsRBNX5FsbcHyg3q65N4ePPg5
         oFM5ANjBMAfxMZtxaZ0gr1NNJf4JvMKiRnTCGtnHifeWcxIBNt0yw+mTdwj0BQMkdG38
         JXPA==
X-Gm-Message-State: AO0yUKXWu5K+eXsHGdNQtb81hTBNidGbi99+83WDBSmV+V/yFZmfIf3g
        J4FEWedy2TZjVqbm5pI7upxkMiC70us=
X-Google-Smtp-Source: AK7set/tM8s2RiEJEMN6uWf3UY9LrrDzG6rIpTwhNfcePgvPj/sWGT5FXFUz75ht5huBgV4hLdecwQ==
X-Received: by 2002:a05:600c:539b:b0:3db:1ab:b91b with SMTP id hg27-20020a05600c539b00b003db01abb91bmr295735wmb.15.1676412110535;
        Tue, 14 Feb 2023 14:01:50 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:49 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 0/6] hwmon: (aquacomputer_d5next) Add Aquacomputer Aquaero control
Date:   Tue, 14 Feb 2023 23:02:15 +0100
Message-Id: <20230214220221.15003-1-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Add support for controlling the Aquacomputer Aquaero 5/6 fan controllers. The
controllable settings include temperature offsets and fan PWM.

The first four patches expand the capabilities of the control system without
changing functionality. Patches 4-6 add support for Aquaero control.

changelog:
v2:
 - split original patch 3 into three patches to have one logical change each
 - explain why Aquaero does not need the checksum
 - improve wording of documentation
 - drop last patch with pwmX_mode

Leonard Anderweit (6):
  hwmon: (aquacomputer_d5next) Support one byte control values
  hwmon: (aquacomputer_d5next) Support writing multiple control values
    at once
  hwmon: (aquacomputer_d5next) Device dependent control report settings
  hwmon: (aquacomputer_d5next) Add infrastructure for Aquaero control
    reports
  hwmon: (aquacomputer_d5next) Add temperature offset control for
    Aquaero
  hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero

 Documentation/hwmon/aquacomputer_d5next.rst |   5 +-
 drivers/hwmon/aquacomputer_d5next.c         | 182 ++++++++++++++++----
 2 files changed, 155 insertions(+), 32 deletions(-)

-- 
2.39.1

