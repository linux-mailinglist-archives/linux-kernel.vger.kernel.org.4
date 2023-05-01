Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDE6F3BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjEBBFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBBFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:05:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085B30EE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:05:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52079a12451so2091240a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682989517; x=1685581517;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xim+YwtJ3hVeEuFvAqTRFSvTuubExAeyqWhYkDSWX+8=;
        b=a/VwioxRWKBGGfo8+D948pg43L9SyAzP+Kn3Xe0BSFRdFAGDZEpGXaFIEuIguKXJFB
         j8r9GUUyREniRVoJhMVQrhPMsP7yKFgV8azbI+FdCWCkwM5jksQi4gM8JLMhylYe12aO
         Rt5xLnmxlUp6KuG0Bfnw33CLWqlL0190BXjbdbFzOciElgd637oM4rBU0RTGz0w8g8R1
         ty00ErVAGlBB5Myk/5lau+8uyG5x2I94kzUGbfEwhgZh2uTzlvP9NIVMsa4Z1Ye4endP
         mmHVFUhgjc39scrwsFJsbnhO8sYsVhK7x6HzLDkGeKxRECcamJ2p6xFADlFmtpzXNd1W
         OrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989517; x=1685581517;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xim+YwtJ3hVeEuFvAqTRFSvTuubExAeyqWhYkDSWX+8=;
        b=a06Mhw7H+NBjihHfLIskUDVIvkOQflvMCaobXba1n6uNagZnHGOLQX8C49XS4q3nQh
         rT0ZfuH82IY9m80HlAtq1QhVj5UcdCoGypqG3AT4Yq39OuxZbpJEpTtFlXciB4xohhZm
         s3ouNK8O5BT1beF6/NH87QXTXOmQ6EwIrqxObN+76R/XxGfa6f3ANsmAddvRuMN1pJvQ
         d8Dng2xdWn1gO4UR33snSbdK9O/s+ScV7XDz2BUo1byfjOG7Ed+j/Xx4WaqPVHSK5BjS
         rnpAj1vUNyU7SgensWMhTLviW8E1LGv+aCa4etPVZIK4W4qOLvyWT2JeuEd/8Dzx4FBl
         RD3Q==
X-Gm-Message-State: AC+VfDzB62fimd74tfHbXoKraj9SFgUs8xja5ewaRs3ZOxnp0fDskW3N
        GSN1y3pipILNP4Q5a57vTfUGfQ==
X-Google-Smtp-Source: ACHHUZ7QRiUqR/YyO0uBuaJQ2kl6f0vyFPeyTZXoz9H5OVSxK2osli3MlSK7xqDSR5NswkoP2NWxrA==
X-Received: by 2002:a05:6a20:1581:b0:e7:56ad:5a40 with SMTP id h1-20020a056a20158100b000e756ad5a40mr17323425pzj.36.1682989516918;
        Mon, 01 May 2023 18:05:16 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79616000000b0063f1a1e3003sm18684466pfg.166.2023.05.01.18.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:05:16 -0700 (PDT)
In-Reply-To: <20230501223353.2833899-1-dfustini@baylibre.com>
References: <20230501223353.2833899-1-dfustini@baylibre.com>
Subject: Re: [PATCH] riscv: compat_syscall_table: Fixup compile warning
Message-Id: <168298107624.32296.3849079211902567638.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 01 May 2023 15:33:54 -0700, Drew Fustini wrote:
> ../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
> field overwritten [-Woverride-init]
>    12 | #define __SYSCALL(nr, call)      [nr] = (call),
>       |                                         ^
> ../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
> '__SYSCALL'
>   567 | __SYSCALL(__NR_semget, sys_semget)
> 
> [...]

Applied, thanks!

[1/1] riscv: compat_syscall_table: Fixup compile warning
      https://git.kernel.org/palmer/c/f9c4bbddece7

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

