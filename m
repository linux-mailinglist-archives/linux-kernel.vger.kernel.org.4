Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01B6FF7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjEKRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjEKRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:01:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB98693
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aae46e62e9so64092835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683824504; x=1686416504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlgUXjTDtEtrxv/KvgWVy44S+Dve/HMsI4TUr1ZbDUg=;
        b=ItIHLaHadK4pK/honMZMvGWHXzE8k7VzUCDmhg9be7aT65eB2rUSphEXrlBteMVLiL
         SGoOD33s96tkbg18qkXuYUo7Mi/L3LFOAD0PSMRLB0vIYqI5pqlcmlBy9ZGyTO6l+c66
         h4e+jDd1albU9o+5CX7mUOEZ/3lnPZUs7/PiLVATiyu4edUzsGLoLtQ6cN0Qzo5EimJU
         fiomoHZyXXPraz+W/BkOsxIGSH+39cqNKzImA2J6T5B2Bzmm+Sya5xvmDaZZuq24E32M
         lM3w/It+5wRKTqwR2gN7GuVEelWxM2LbZi5Zy6bHEMgYoSdLHQlff5HnT9jS51sRNjLu
         S4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824504; x=1686416504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlgUXjTDtEtrxv/KvgWVy44S+Dve/HMsI4TUr1ZbDUg=;
        b=lFuZGlsDXiJn4zrJFEHAplFwRqjEZc/A8EPUZsZsAZzmC+AJxX+PdVxcYwgBpIrKXo
         d/ar9MA1zr0pJw3VOPQPsShNKSW0LW5HbU5PPUmb5+g6heA4jsuTD1hjuCf1me0iFqMu
         BK1vFFP3UE9E7UYQmqMXCSlXGaJe/Jp64gFZAX7R7E+yGAPL6nM1uH7tkq7vL9FY6nzk
         +BQlspkfdUAqdtNRH2l7uV8+QgOkERYbleuDyvRq0w/yCBBvB6zd/jvFmtmHKn9syC8B
         GfLlflvHr2V74Pnkp9EDwaaxVLWPh31m1VMQS2drnZ8Eu17nrzi0xKaFPYmIwbf2LstO
         enjw==
X-Gm-Message-State: AC+VfDyXA8E31JhgeWXEZ11a+FRJlmClkHY/HCi3Mi0rdFINxZJoFoGS
        2Gqdmt1ylS01ag5BEbny1GU=
X-Google-Smtp-Source: ACHHUZ6Nalhgua5FoNS5CCxKWMsXR/0wAy4U/hKA+jlb2rlpWlqGXQOn0JKIpTztmvRwGIEco1pScQ==
X-Received: by 2002:a17:903:1d0:b0:1ac:7624:51d7 with SMTP id e16-20020a17090301d000b001ac762451d7mr15329997plh.69.1683824503775;
        Thu, 11 May 2023 10:01:43 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-94-72.dynamic-ip.hinet.net. [36.228.94.72])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001ab0083c6c9sm6156240pls.261.2023.05.11.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:01:43 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARC: fix the THREAD_SHIFT definition
Date:   Fri, 12 May 2023 01:01:37 +0800
Message-Id: <20230511170139.343434-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

When I read the arch/arc code, I first found that the
definition of THREAD_SHIFT looks incorrect and the
description of 16KSTACKS looks confusing. I submit
these 2 small patches to address the issue I found.

Min-Hua Chen (2):
  ARC: fix incorrect THREAD_SHIFT definition
  ARC: rename 16KSTACKS to DEBUG_STACKS

 arch/arc/Kconfig.debug             | 7 ++++---
 arch/arc/include/asm/thread_info.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1

