Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155CC6B3985
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCJJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCJJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:01:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74210A10C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:57:20 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d6so2652651pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678438640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1VtgZWk+HjXenFKjPpHfn0DN33LLaYk0FmNJWNjz/8=;
        b=B/I2yfr49AEDmOO3dUKOiflWB5RtJAuXC/DJk7jtMBh+UtRe4lfJY66f9dDsSRNkjG
         s64zfOQYmLzGWm7t7mkYoTr9fx93OaTM1/L3DQS4PUXrR/KEqumGMQ/enUgmMU2SUl7F
         nP/tAlESCAMxOSZE1DEwDDaoROEOXTtGVJOdfPx5d9Pwcqiqb7fXV/IMfiNx3bUMWS2V
         wik1CRUzqe/crq/ywwqx1oroJjCNkrTZ6E/5DtpmP7Xtk19Ojd3qh9uZrs5XkQmy0B0C
         tiOqgANXMHxtgd/nRKPLPLMjIraN7GzSaVvzVJB2c0lLw5J5sN/lzBWSSDfl1jYefJHh
         XXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1VtgZWk+HjXenFKjPpHfn0DN33LLaYk0FmNJWNjz/8=;
        b=7hHG7kj+HKl50H25Fi+YYwUpPTQJ8VaQAFz676rOKd41kNyqOpWGHqN3FA61O6hl6P
         7om9mEoFzPlftlSQIe8klCX8EazZF06sKXfFj4AjwGv0iB4SIa4b4TWCFE9VBr6ib9LY
         O/a8n6HG+uoELJarNdZvd7ODleuHuVn15gw94k9MKeuuSn95PmSSoqeUnv8n4LhoiEPs
         zQzpI2HaADUTGNWizflHAexe3D5eBW0MbJ+p/N2UVa5jzL4xBHLAdN7vW/Xx6Y8+MEiw
         w6/r49B8TbIZIvaAubAKA+7WWYWiWdEgJG8rke0KNG0oBmvMydCgIym5EBmi0n4Ry1Tx
         1Omw==
X-Gm-Message-State: AO0yUKUw6CeM5iylbNH9tE1sbiPsGlqYWOMd/1Vgwt0UGC3OSzXkezEB
        eHZPl/tq+Pm5AtC7+R/4p6xtMA==
X-Google-Smtp-Source: AK7set+yZha6GiSITCQI2jS/+04CLPiNL6J0wLrKIb2itQreHUPzN+GqaGS24sVC5b2tgEF76HNtcQ==
X-Received: by 2002:a62:6143:0:b0:5a8:bbac:1cf2 with SMTP id v64-20020a626143000000b005a8bbac1cf2mr20558744pfb.1.1678438639683;
        Fri, 10 Mar 2023 00:57:19 -0800 (PST)
Received: from localhost.localdomain ([49.206.47.87])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b005a9bf65b591sm899151pfo.135.2023.03.10.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:57:19 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     kernelfans@gmail.com
Cc:     akpm@linux-foundation.org, ardb@kernel.org,
        catalin.marinas@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Date:   Fri, 10 Mar 2023 14:27:12 +0530
Message-Id: <20230310085712.31515-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro’s test farm.

> After introducing zboot image, kexec_file can not load and jump to the
> new style image. Hence it demands a method to load the new kernel.

...

This patch set build and boot tested on arm, arm64 and FVP.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: kexec@lists.infradead.org
> To: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

links to test results,
 - https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-arm-kernel_20230306030305_15595-1-kernelfans_gmail_com/?failures_only=false#!#test-results


--
Linaro LKFT
https://lkft.linaro.org
