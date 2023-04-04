Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076B6D6906
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjDDQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjDDQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752AF3C3D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2KPh+RVaFN9Pal7vJ7riMct+RuvU+jJfCqJ/90zseQE=;
        b=Ach4laY9gwLWfr4efkBtTcYlgkJCCT/ZaTI0Za+2e4LJCk454COae4YaEyqoIjhSHPvvuU
        1HKDOpquc9hZvQX22J8Qsou+yuJCleEbFrzmxYw8ZDfnHBkh/pCr1hWUOuZ3bGeQRsSN7M
        j6j6Yd8fRAvQM6VtCCoGH5ierTSD1RY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-OhzlfjaIOBeBvHts5DLvdQ-1; Tue, 04 Apr 2023 12:37:49 -0400
X-MC-Unique: OhzlfjaIOBeBvHts5DLvdQ-1
Received: by mail-ot1-f72.google.com with SMTP id w10-20020a9d674a000000b006a249fdc3bfso4821773otm.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KPh+RVaFN9Pal7vJ7riMct+RuvU+jJfCqJ/90zseQE=;
        b=IK4Jp9xZi4tUu3W2iqTqoMIq0LHrJzIz2ExLBhPZvnozZBUEXDIskGf5z0nCmnRlKT
         44UIn4iMQiZXHzuiJ0G+f6800zWxvnlaf+H32OHyLjkXFmbJa2aeB6jcH3+vlmtAyAP2
         L1b/s5XNixa4gnuIKLZTqFDhdpFDDy1NCNgpQUJfdsqmiSn3AUnD4B6yWQCRHG+nZhXP
         KR6iqPafb7c8oYo8AHeoKd/7mZ0eXczQ6QwwGtVYDIqFO+5pQQyDVA4VD7eNKEhlHM5M
         2VldPiELgJ+nJWzZwZy0iAHhrFHG0xYffYUD+dXPcB1eWFvvifvGlxPHtWl9q3T3JcjC
         EGTA==
X-Gm-Message-State: AAQBX9ejVo3fwBLnLZd3dnl2rzLd75LyDIXRKXpa+EOBOfxOJut/Mj5s
        8o+fBxeYNE1bSmqmiqkqBNHi4V3Sp+zIG5M8mPQ09A1DY3gnp+oKR1ORwxuC3vquTVOQzLjWpWD
        WvYKSWIroGKxHxEqYk/NBo2kk
X-Received: by 2002:a05:6808:16a1:b0:384:de2c:663c with SMTP id bb33-20020a05680816a100b00384de2c663cmr1594920oib.24.1680626268796;
        Tue, 04 Apr 2023 09:37:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZxrDkNGc4YICHDa15B9UbAObvQGb7R71nZVrkIvteUaedtQmAUizLPUyUi0/+37tZ0POLYuQ==
X-Received: by 2002:a05:6808:16a1:b0:384:de2c:663c with SMTP id bb33-20020a05680816a100b00384de2c663cmr1594892oib.24.1680626267577;
        Tue, 04 Apr 2023 09:37:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:37:47 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/6] Deduplicating RISCV cmpxchg.h macros
Date:   Tue,  4 Apr 2023 13:37:35 -0300
Message-Id: <20230404163741.2762165-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While studying riscv's cmpxchg.h file, I got really interested in 
understanding how RISCV asm implemented the different versions of 
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the 
duplications and create macros to make it easier to understand what exactly 
changes between the versions: Instruction sufixes & barriers.

I split those changes in 3 levels for each cmpxchg and xchg, resulting a 
total of 6 patches. I did this so it becomes easier to review and remove 
the last levels if desired, but I have no issue squashing them if it's 
better.

Please provide comments.

Thanks!
Leo

Changes since v2:
- Fixed  macros that depend on having a local variable with a magic name
- Previous cast to (long) is now only applied on 4-bytes cmpxchg

Changes since v1:
- Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error


Leonardo Bras (6):
  riscv/cmpxchg: Deduplicate cmpxchg() asm functions
  riscv/cmpxchg: Deduplicate cmpxchg() macros
  riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
  riscv/cmpxchg: Deduplicate xchg() asm functions
  riscv/cmpxchg: Deduplicate xchg() macros
  riscv/cmpxchg: Deduplicate arch_xchg() macros

 arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
 1 file changed, 67 insertions(+), 252 deletions(-)

-- 
2.40.0

