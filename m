Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E098B6A64B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCABWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCABWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:22:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4CD32E5C;
        Tue, 28 Feb 2023 17:22:07 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso6694720ots.9;
        Tue, 28 Feb 2023 17:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677633726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0dDKM/kz9j+kr4YipucQRbjkJuSAUreWGjHChZMyfU=;
        b=j70Z6d74PxeOmjKCkXe3wzFvCUDGNQMIVJgZJLIB80H5UBzLcqON1dFrv8KYK5wdwc
         7VOamfdrjECIxrS90d+V/UUnWd/frIxXi+KLwMx0xQFJkeNcUGf3Wovvf5LLuV3l3Upo
         0wX2PN9bIfMISC0V1VONVxUwNeswAIJs01DK9HnNJ7bK2gOMr5tiBzAR7MwIt/RLDYrR
         InGI9xk39UvaSvdabX0kBG0bOahWv/tZrUnqz/toFzwQGTSzyRhhuR1DopzEIRiTlEoA
         tZ24iuuKF5wdi+kq7wFbFCZAsMVqex5i8zERzB9kWDn1CPR2nGPIlhlFsrnmvuRyi99l
         /iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677633726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0dDKM/kz9j+kr4YipucQRbjkJuSAUreWGjHChZMyfU=;
        b=Hw2aF4pqAVOgfW/coYEfldySypmH573kJ1z/d1KG0Hn9UNEgR5pAGWBWgYW2jJbuLT
         GWJYRnGQ48HDFE0pjSLo6RN321sfeM6B3iXD4ueCa5b9L+lkJ+pnk/1GMElfvkhwxLLG
         F2p0RnsJYKEnEAotpEnNv4qcQ0HWxgPyiBT9avGI08mA2Oqjd9MnDMRlheQOUXtmnR92
         W9Wi3n1qVgwBDtMRbstI9WeD41wj2lyaYgUxIt2xwNTqL6Ch0E1NwEPP3LPe3jyOqmhq
         St6MZGy4occFmxtZ1doziQ+ZeBsVSHZJDJK4KWpd20mmVsB15fK1eMIenz7YmmYAcr7s
         Xbsg==
X-Gm-Message-State: AO0yUKXN1f5v5EJHazO2YIwgV+OSu615EGIJvuEysvsFgbifh3gx5U/F
        F8ePlWUnx2Wqpgd9KHz4ju4q9kiXt2o=
X-Google-Smtp-Source: AK7set/qbane1eg06bWyjfTJCCSYY62178P6KH3XhvxVAYkSbuCmbKzoa2lpaYkWW6xkbjfFB3LKxA==
X-Received: by 2002:a05:6830:829:b0:68b:d344:97cb with SMTP id t9-20020a056830082900b0068bd34497cbmr2510876ots.13.1677633725847;
        Tue, 28 Feb 2023 17:22:05 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:20c1:2bed:d8f3:84d8])
        by smtp.gmail.com with ESMTPSA id v2-20020a056830140200b006864b5f4650sm4436362otp.46.2023.02.28.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:22:05 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/2] of: unittest: option to allow tests that trigger kernel stack dump
Date:   Tue, 28 Feb 2023 19:21:14 -0600
Message-Id: <20230301012116.1488132-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
some tests that trigger a kernel stack dump.  Filtering the boot
messages with scripts/dtc/of_unittest_expect detects that the stack
dump is expected instead of being a test error.

Test beds might interpret the stack dumps as errors, resulting in
needless debugging and error reports.  These test beds are likely
to remove unittests due to these stack dumps. To avoid these problems,
have the unittest default to skip the tests that trigger a stack dump.

Add a kernel cmdline option to not skip those tests.  This option can
be used by testers who are able to interpret the stack dumps as not
an error.

Frank Rowand (2):
  of: unittest: option to allow tests that trigger kernel stack dump
  of: unittest: add of_unittest_stackdump to kernel documentation

 .../admin-guide/kernel-parameters.txt         |  4 ++
 drivers/of/unittest.c                         | 54 +++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

-- 
Frank Rowand <frowand.list@gmail.com>

