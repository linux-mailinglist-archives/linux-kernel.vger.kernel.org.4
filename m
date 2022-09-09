Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD05B379C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIIMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiIIMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903111E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:18:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e18so2239574edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GzTst0nKwjS2DHPs7FOf2wavqhpxfB2fVlaUjY3LQyY=;
        b=a+7dyxcUXK7LyUVvaDRNrzzKcZwzbHlBiutzxuQOEPGBBS1QJZ0Yd6OfBEbWuJQWdc
         VIHzsS+m06PfHov7A0ghU7eoyExOSfq7qYyGiKj2I1uxBpuoP1eDWgY77U0jBI8qKk4/
         OkwJuRd0BS0H/MfZHH2m21yIk2tUSPYQYcMN+NZxgVGP0+C1z1Qzpw8LyYEAWJwnxRmP
         fpAbkx+m2cgCnN+4hw26oUpii2IjF0PUtPMR1wOBJpW1ekoCsEyvCNqcZtlLMqYbGAzY
         GBOdJltIy6TUEsfvWj5XiW68XHz3RMz//G2hIGFdL8EKT+6sbOcscWX+2iNadhkekl60
         dh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GzTst0nKwjS2DHPs7FOf2wavqhpxfB2fVlaUjY3LQyY=;
        b=xZ9k2DDxSXlJRzVJ2QzXB/jJetNc9mdBWz/Q5kBMg1kIip7A3IbkQ1cJ6QJsl4dNLN
         46c9rDNBq/ad1b2fN66wEkuU/+R7STERBCeAoHvEdIXhJF12+5G7dHmLtdecuraGjAdG
         /TuJWb5xaGVU1sOgomsEB3DUFQl0zLHlmFY8aGV4aaOtBCRWO/hQn+XcubUaVMBNLhmP
         SsW+3+IVfE0ke16KPFKkfR3cW4+lc2H2MfVovCk+5KbPPWc8nJpdhqbX+4ASXzFO90sx
         uc0HZFAxR5V09yWZ2JGDuskeP3AtmXSBbem5bGytjKaHIkkGsNqjTwWmLEey3NPX6vOr
         2Yjw==
X-Gm-Message-State: ACgBeo2lmB0JOorg8OpthB6WEWWBiyv0ZpphNyplK1gyptbVhIEDAkOF
        7T1J7zb03SZmdsT/1x8/HRBYfm9gbuc=
X-Google-Smtp-Source: AA6agR5uBhRVTSQlVR+njblpjFjiUsBgO9vW3S/tHNvltk8Ma8f4HoLTfNSHDRoi/biM3dgxzkKe0w==
X-Received: by 2002:aa7:d447:0:b0:44e:ebb8:b691 with SMTP id q7-20020aa7d447000000b0044eebb8b691mr11011082edr.428.1662725913118;
        Fri, 09 Sep 2022 05:18:33 -0700 (PDT)
Received: from localhost.localdomain (wlan-244090.nbw.tue.nl. [131.155.244.90])
        by smtp.gmail.com with ESMTPSA id p17-20020a170906785100b0073bdb2f6f28sm167143ejm.217.2022.09.09.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:18:32 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 0/2] use memset to make code clearer
Date:   Fri,  9 Sep 2022 14:17:54 +0200
Message-Id: <cover.1662724786.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-write some code using memset to make it more obvious. Also remove an
unnecessary volatile qualifier, because compiler complains about passing
volatile pointer to memset.

V3: get rid of "volatile" entirely, instead of just casting it away.
V2: re-write commit message because previous message describes a
non-existent problem.

Nam Cao (2):
  staging: vt6655: remove unnecessary volatile qualifier
  staging: vt6655: use memset to make code clearer

 drivers/staging/vt6655/desc.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

