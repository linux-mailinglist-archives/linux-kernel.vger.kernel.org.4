Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D56D1074
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC3VDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC3VC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:02:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6ABDD6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:02:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso21149125pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680210177;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/xsTJDZlQeJOjmK2KOoGoYyGsO3o/mIzwXJZJba2dQ=;
        b=JnrYslCBdaBmWFrna8dF7+I4WqGxOyf1SdneNgW+b/qZFufmf5ZQCa0Y6BG+iYP76c
         HRTmL4LAemn5IosIpP833RVUcqQc2cOrvgS1s6WhlUCk7U73yRTQcaSHm7SDLmtQvQed
         zG2xpg+eD0/A887w+kdvbPsNJs1JCtKdd9dfGETiQRkpHLCieKgoQccyXKvo9wxRBfBM
         /W1J2VzYUccdg4s/JgajcqJ4/qrWUFrYgI7jahcjsvrbdB3lD0c7krw+PVpxk8qtSfB+
         WWHv/fU6I17C4IzxKnCEKZmB0Obj6AWc8dYOLrKJRd4P9+JTlo1ZM0F9il7uDJm2jBI3
         JE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210177;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/xsTJDZlQeJOjmK2KOoGoYyGsO3o/mIzwXJZJba2dQ=;
        b=5pMwZfzaqT/BctoYi3W8n/0Un5coymnYBt3Fy0y/zLkRhs3pfsoE6pqYQcnNHfZlyc
         PjWDPUDfdLUfUFj7KzU38u1t1uikgq3iaIXzGlmBXNU3+PHoZrL+tibjGfKDcsb7S7FO
         5ULA61cmbXuoyVhEtidCMlL7Sn+DN/Whompm8BU5IqKZ18HDvKdAfqgf4YAhyyQOQWy4
         9+E/vugioq9ip3xnMDW3eeLv+NB/2DyJtSQzX8Nl3wkIzdB66T2nNB4tysqqCZ80Qnvy
         TU88HwN7Rb95WmD+SgWTnQJpIoaFoVRU0uNbaDn+p9OtszsETOl2UQvp1vLQTfzO4tJw
         xPkw==
X-Gm-Message-State: AO0yUKUl9ZC35s85Mr/F2fPnhMOYXJEeaiEkZRVNyCVdW+bRCPS4XdVk
        gBjMLNeQX2sYyZmr5F2Zu/dLvA==
X-Google-Smtp-Source: AK7set8Tu5xQiv2POaFwMPQARW9IYLHTrFmIgYV0fJYXtvJptVdt71Q4oVmfS4TbYWoY9B6XBctZow==
X-Received: by 2002:a05:6a20:3a9c:b0:d9:77f7:d62e with SMTP id d28-20020a056a203a9c00b000d977f7d62emr19771027pzh.36.1680210176765;
        Thu, 30 Mar 2023 14:02:56 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78493000000b00627df85cd72sm272683pfn.199.2023.03.30.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:02:55 -0700 (PDT)
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for
 riscv_has_extension[un]likely()'s alternative dependency
Message-Id: <168021016598.24378.3655010932034321812.b4-ty@rivosinc.com>
Date:   Thu, 30 Mar 2023 14:02:45 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 10:05:37 +0000, Conor Dooley wrote:
> Here's my attempt at fixing both the use of an FPU on XIP kernels and
> the issue that Jason ran into where CONFIG_FPU, which needs the
> alternatives frame work for has_fpu() checks, could be enabled without
> the alternatives actually being present.
> 
> For the former, a "slow" fallback that does not use alternatives is
> added to riscv_has_extension_[un]likely() that can be used with XIP.
> Obviously, we want to make use of Jisheng's alternatives based approach
> where possible, so any users of riscv_has_extension_[un]likely() will
> want to make sure that they select RISCV_ALTERNATIVE.
> If they don't however, they'll hit the fallback path which (should,
> sparing a silly mistake from me!) behave in the same way, thus
> succeeding silently. Sounds like a
> 
> [...]

Applied, thanks!

[1/2] RISC-V: add non-alternative fallback for riscv_has_extension_[un]likely()
      https://git.kernel.org/palmer/c/1aa866931b80
[2/2] RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
      https://git.kernel.org/palmer/c/1ee7fc3f4d0a

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

