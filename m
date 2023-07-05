Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FA7491F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGEXkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEXkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:40:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC81989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:40:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso137091b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688600437; x=1691192437;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgsF/Yozlpx3nfM2SL9w4rDMvY31abGjUNz6r4TG+KE=;
        b=Vu7pF9XZzc3t1Mny/o3ibzdUICpJIdLiz/1zifUzyS1IbXBy114fxvGLlttLILcMXn
         HYHRSSwlhZkKYB6szm0+/jcf1mMkZRez5mBWKw6fbGpDo2jcs6ewq/vWjvLbsOk4+qSq
         W4OGwrD8wsO3Evup8IT5yzukcj1W0A21XAXbtZB7K/Q9XK3g4lSz796vmUkuxOg8BlWS
         SHHE12DBZdhJk/UONAi0tGHrGTW+YQzwPrZGJVq5gJLa7jGS/Rlz/NyTgY5CxMOVYme6
         6vNDxB78/Bj4CEK8clvHalQqvlJTTMi8nKr0zQXLBHLxtc4AkP4rZ3/q3S4UpJgJfAnX
         zHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600437; x=1691192437;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgsF/Yozlpx3nfM2SL9w4rDMvY31abGjUNz6r4TG+KE=;
        b=KL1aKsAy02r9KL7oa1Ft4Nlw0shdn7fP1aNoVLVVykPvB/kfmWa6Zha2pL8qXsSr6/
         pUXqEUcXVh73MOlKaIYeSEufzMl/Sa3rrmiNkkb/YI/mnDCxbyf4DLr8sgFsoJry3LU5
         trrvPTy7b5AgECCr9/st5SaBZtFaaXh6b4j7sBYUlvWypoj2hktpb2esCkeXasEt40kG
         EKL6DE6Iz7gAkqKQn/Fu8KwCPi1YfKWri+2D41QRsbO8dGt7gOtTvGiBmr03oZYJkqdv
         qdA5QT1dTqW7V4pV/0wguGZKNXRFIIJEm85x7ZJBoAwLm25HXf05jGKNOnFfdJjRMfrR
         OPpg==
X-Gm-Message-State: ABy/qLa9EBrSuZ9UeHBy0aH6jzToLKCWN/GInOKmimX7FbqFNs7rVu2T
        QVBzf+4j2pZ3JmKjQ1Mg04DLnQ==
X-Google-Smtp-Source: APBJJlGmCyh895H+NKlRrEXoEw+nVendMQS7mGtQ6eFTMLjj37m8JK7kRdXwP+uI0gQH1xZBJFSQTw==
X-Received: by 2002:a05:6a00:1a8f:b0:647:4dee:62b7 with SMTP id e15-20020a056a001a8f00b006474dee62b7mr252551pfv.29.1688600437156;
        Wed, 05 Jul 2023 16:40:37 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b00662610cf7a8sm69515pfv.172.2023.07.05.16.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:40:36 -0700 (PDT)
In-Reply-To: <20230529101524.322076-1-songshuaishuai@tinylab.org>
References: <20230529101524.322076-1-songshuaishuai@tinylab.org>
Subject: Re: [PATCH] riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
Message-Id: <168860030754.22647.1544926627696310969.b4-ty@rivosinc.com>
Date:   Wed, 05 Jul 2023 16:38:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Conor Dooley <conor@kernel.org>, suagrfillet@gmail.com,
        Song Shuai <songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 May 2023 18:15:24 +0800, Song Shuai wrote:
> With this configuration opened, the basic platform-independent s2idle is
> provided by the sole "s2idle" string in `/sys/power/mem_sleep`.
> 
> At the end of s2idle, harts will hit the `wfi` instruction or enter the
> SUSPENDED state through the sbi_cpuidle driver. The interrupt of possible
> wakeup devices will be kept to wake the system up.
> 
> [...]

Applied, thanks!

[1/1] riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
      https://git.kernel.org/palmer/c/c1f048a6bd7d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

