Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0846E73D53D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjFYXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFYXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:18:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3002AE43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66c729f5618so1390415b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687735129; x=1690327129;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggy/7h1OPvstNA0LMyWIdKuG/UdvrrY9huBZRZ1dffc=;
        b=FPJt8W4ID6XMXNwf1/VDKjHKddiZA2HyalGr4b7xUSwxScRpb8jmJ10eanIKIZv6dP
         Yt4Aia8ROJ2su6ZpuuAupfSD8XRUvCxQBYSb/hIjFjEnwshNVvsn3RPlweXpUTKKqccl
         kNq84gbcwQSW6bWF5cBkMdTLfcE7R4Y6PU8q7pk5046SnwEfhl+wqnzEDBsaiqAaIC+5
         rRNOUEwQDWq1GUQMEiRLSQJwFJHNLwi4A1Bk48kf7khPsYQmDjfmzU8FyRRdEUkEKey+
         mtF6v1L0ApdP+yH7YcND616lDMDQ9oFg5m3/2SWCMulebzoATcU4uXNcwEg/y3Jk5Cbs
         vDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687735129; x=1690327129;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggy/7h1OPvstNA0LMyWIdKuG/UdvrrY9huBZRZ1dffc=;
        b=AIwkrVSxe+C41voW4zYTBrPomcPFgQlkfXcEMl2qFms4hPvnB8Qezy6OZ85SFadRdg
         h84wkwmmJmgO19T7W1trUGxJiuG2RB5rNAC0Y50UxxVWwIY3JLw1e/goQgqtTXJ9l14I
         H6eEBrNahahRYMUAIvVREjrdxfQhcrj0yZBtbLa3ftF/w90XjuHTvTEF8k7Iw022sjx5
         24pw3M/tP0uGd9J7mZ1KaMVnWmcyTZraRYPHO6vo0E20nyGqDSdIRwD39lODrou0WnyM
         YL1I+rBWh32affjXpSZGK1hmpBpfdzCa82LTQUMNR6Y1ZIEX8Fom/vOAWq08XWbUxbxl
         GxdQ==
X-Gm-Message-State: AC+VfDx92ejCFOmaRVZnOb+d9sE6CzwBIp9LqVVLafDaQ10UrZYESZ6l
        DHNQqiGpKUxKR6dU6P7NjpqNWjRusrEGZLV8u+o=
X-Google-Smtp-Source: ACHHUZ6STT7aK+LnRIHxE3GjBnB8LVhIpf1/SkLYkFWTvrD+zpVBcDnGSskJdr3AwnPeVhacnd1DPA==
X-Received: by 2002:a05:6a00:1804:b0:667:e17e:85bc with SMTP id y4-20020a056a00180400b00667e17e85bcmr33742884pfa.0.1687735129579;
        Sun, 25 Jun 2023 16:18:49 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m18-20020aa79012000000b0064fc715b380sm2693121pfo.176.2023.06.25.16.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:18:49 -0700 (PDT)
In-Reply-To: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
Subject: Re: (subset) [PATCH V2 0/4] Remove WARN_ON in save_processor_state
Message-Id: <168773507361.1389.9680109116196931036.b4-ty@rivosinc.com>
Date:   Sun, 25 Jun 2023 16:17:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        chris@zankel.net, jcmvbkbc@gmail.com, steven.price@arm.com,
        vincenzo.frascino@arm.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, jeeheng.sia@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, Song Shuai <songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 15:50:45 +0800, Song Shuai wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
> 
> In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
> is not defined, but the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
> We also don't have to check it in save_processor_state.
> 
> [...]

Applied, thanks!

[3/4] riscv: hibernate: remove WARN_ON in save_processor_state
      https://git.kernel.org/palmer/c/91afbaafd6b1

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

