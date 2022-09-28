Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A715EE477
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiI1Skz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiI1Skv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:40:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA24F38A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e6acbac9so127963997b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=5TCg37Bpaaxg1bIKDQj7APiXHEcmNduv8uVe3aPc6f4=;
        b=ra6s9asTgE635pFaEWqxlAD1YIF/1+WeX8UAYb2AvvbVvjEpQr3l7XOUQ9dmW25ZUO
         6CcIs8dDEvWnAhMMLCxNsgTjB4DhaKDcyJo7oSJ/9MqYL73Cv9GG9gJgikfZ3ZHPzigC
         Ln6WAkQomvYkecjsZlggkyghs1RBZ5YykeKOmDUxagdcOAoUBIzxRho0B1/RGlOABRV/
         +mo4BJ8Aab2ANr3Pl83jC4bJT2ucvl2bzfmb2RrlumtSx2/CGX5xk6U3IL5nWTu3vqG2
         B4T0G2Wru6Ox2lAIeHFGlv6POxruwWuG9O0mkoiBCFfbDtqesW5Kq4K9pftbLM9QlD2R
         rYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5TCg37Bpaaxg1bIKDQj7APiXHEcmNduv8uVe3aPc6f4=;
        b=Noh0q/oLW/lOBbVNKnX6XrFXuCxKjD31RpwICF/myWvoBzFmMErVW8DvaZuzRwDGtx
         B2ZT1fZXy0jyi7iSNhhbIN1jUW7N9sYM4q71B6Zi5xBFXphY2Y9vSO8x6GYwGaSqYmLu
         r+VrQH2LgGjKaNCUb1nhTo8qpIGj6q0LyXpFoEa/Wwh1QJaGXYwRnLq6AgDmQwkiTsex
         YiZeI15qB7VjygmwuHFDoPlZxdoxOu+zKTpFcYu90+dJmT9Oe1iOD+WvoV4vgQcGtYj4
         Z8iM2tLdNZXuekyt1rmusi5p+6BSrZu3KCse0C9aosZZDuP4uEjy3LQD9hc37BMnritm
         1TXw==
X-Gm-Message-State: ACrzQf1iwdRUfoA1lcBtpCapqBChKtECTun95p7urnHExrEzD3Im87dD
        YvPMqmol98Mu1nkB9mM2d1Tc35RimJlRiToJH9xr8niSmyEQBIJffIoIPApRFoMTZJ34vL5lNvv
        Q8b96VSBS7Acn/XOFHoTCVBMT1EFrrO/bhiHZUjtiN87NU9dIu+tXh+U1+MH2Tloe33LDzlbN
X-Google-Smtp-Source: AMsMyM4j02Klappo+jGwcy2Zwf3ML21UKeaeC9SFVxn49hBDIfGPTXTbgTLhGcm0dx+TwmBNCmxku5zpScme
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:d508:baac:7b11:f912])
 (user=eranian job=sendgmr) by 2002:a5b:f01:0:b0:6b7:b30f:54b4 with SMTP id
 x1-20020a5b0f01000000b006b7b30f54b4mr25897983ybr.149.1664390450030; Wed, 28
 Sep 2022 11:40:50 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:40:41 -0700
Message-Id: <20220928184043.408364-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH 0/2] perf/x86/amd/lbr: fix LBR filtering support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, sandipan.das@amd.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short patch series to address some kernel issues with the AMD LBrv2
enablement which were introduced in Linux 6.0.

Stephane Eranian (2):
  perf/x86/utils: fix uninitialized var in get_branch_type()
  perf/x86/amd/lbr: adjust LBR regardless of filtering

 arch/x86/events/amd/lbr.c | 8 ++++++--
 arch/x86/events/utils.c   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

