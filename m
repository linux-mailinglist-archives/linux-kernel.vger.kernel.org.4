Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A566914C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjBIXky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBIXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:40:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002A1557B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:39:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v23so4729664plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wT/0184QjMo+hmna041cEtaG6eN6ojeXECE1DHEFSQ=;
        b=Xi7uN1iNuU6j8CyhuB+Q8Ro1+tDhMRMhE/eXW2mnOjxw3fbzNdpTaoozEmDFmv3NKP
         TTwFmi/nHzkFHh3j2mH9k+rZz76OvBfY3MLcVZTjRO+NS225lIwC/UYKImZ6IHcza652
         mkqaXi96YHTKRA7sEq5c7juc4yJXOO734qBCIiRyfXF7sqOslnY4umQ0+HPkzyy6mTk/
         pyS9TDPisKRCyMVx9wnbMNNyh5r5mLZyhOrTkGw/+J5dvjrdk1r+Nq1WWSLbo3k7yNuF
         ZD5TL4s6km07a4CExde3fA0zx/BRmdu255qXu4O3e33Vjfsi5tYHywWJnyBPBJFMgXsE
         4ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wT/0184QjMo+hmna041cEtaG6eN6ojeXECE1DHEFSQ=;
        b=YVsl0bxHEo+gqo8HWhrKIgiGbiRW2yOMFZiuRwOpdrzM4u/ivB0IbsJhk707Q1n1Ss
         TvQvv5KLTv6UZwFUQbHvVAbGJ7w8aTvd69lcugGBT926CaAvWYERgP9V8eUzuw26QO+1
         E/DRAxWnzXLBN/Hu99FsCAG9sturVOcD3PBIYPaGOGyNkS1oJGERro6ujgccdcfko80t
         9zI9Kbguf1RtmgcDOpFdni8d/zH22lHs70qpbK1EkiYR+cntoVBQ4uOxn85xHYBnzhVF
         8coA+QbAqeWIBOuedC28qSgxAsnR4WNzsOLXmM6ado9X0mACL5ofr0JttBRWAH3sII76
         xhdg==
X-Gm-Message-State: AO0yUKUB3Aperud/UmwSCmkOfAvwHB4RrIgTJIzulzT2WN0N4Ef+VX5J
        hlsb3SrSuTf5GI9qNCaz3/Z2yPt8eQs6AXjA
X-Google-Smtp-Source: AK7set8c2bbe8BRUkWxwcIOXpfZBXg+wJf1MhsMcEj0bP58SBsJBwEnMePwyfOKDTOgwEhAv8IJ7UA==
X-Received: by 2002:a05:6a20:42a1:b0:be:c5de:7157 with SMTP id o33-20020a056a2042a100b000bec5de7157mr15363619pzj.53.1675985971490;
        Thu, 09 Feb 2023 15:39:31 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78119000000b00581ad007a9fsm1978680pfi.153.2023.02.09.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:39:30 -0800 (PST)
In-Reply-To: <20230127035306.1819561-1-guoren@kernel.org>
References: <20230127035306.1819561-1-guoren@kernel.org>
Subject: Re: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in
 flush_icache_pte
Message-Id: <167598585275.27143.16666537067061607902.b4-ty@rivosinc.com>
Date:   Thu, 09 Feb 2023 15:37:32 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ca426
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        Mark Rutland <mark.rutland@arm.com>, bjorn@kernel.org,
        tongtiangen@huawei.com, ajones@ventanamicro.com,
        Andrew Waterman <andrew@sifive.com>, guoren@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 22:53:06 -0500, guoren@kernel.org wrote:
> In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
> in __sync_icache_dcache()"), we found RISC-V has the same issue as the
> previous arm64. The previous implementation didn't guarantee the correct
> sequence of operations, which means flush_icache_all() hasn't been
> called when the PG_dcache_clean was set. That would cause a risk of page
> synchronization.
> 
> [...]

Applied, thanks!

[1/1] riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
      https://git.kernel.org/palmer/c/950b879b7f02

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

