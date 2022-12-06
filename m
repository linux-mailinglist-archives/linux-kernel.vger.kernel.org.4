Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BD643B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFDAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiLFC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:59:57 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749DD2252B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:59:56 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 6so12191656pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMvd+bGX7cNzKevq9l2WAnMvQf9LCVqf4zTfyymymRA=;
        b=osFE3Jk5FGwfWjWOIbOBA9zzI8OEon/JIEP6+sIPphN0I909xCeDNZ+irhRNT2EIDL
         Tp6p5I7+N5tDDYpzPHdQCdDQ2JKbPMIfGUqxZiaR+zBodYjWNpJhW5Jrj/Oj99IRAfXZ
         VciAK51zt6sIOUPJA+Sc3liGoeHp4ZMIv9U/7WinuhEPpXpS5zv/brbb8MN/IvjL1o4u
         KeHNrQNspSOjKzBRCLfQtDxD9aM7kv57cxyK1PyQViFs9x+jL2iVgj6flOaf81pIimBS
         4dSBHbdJWzX6InxfkDPgfNonIX1EcjVo4QH08QzyzeuLLng757J3NnI27MMbr3+7F/aN
         /V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMvd+bGX7cNzKevq9l2WAnMvQf9LCVqf4zTfyymymRA=;
        b=02n04Skb6mxb1MB63xISr4o74jagzDVxytD9DNBIH2kTnvKAywiTf8IG/FGLsggW5B
         bUVT46sNDga5bcOoPeCDLEFQvU1y8MJMtb/emu9Gm+j8yszLSuT8EVVuvkEPwHWhaqMU
         s7534cNHcVqyo0m6w3QreQxgQW9PVO/VLitGBhtuG6otBojSBiVIxH7NUGnpiKdbH2Pl
         kFg3RdIjhKalawxnZbaofF7aa9dRS4CDso77hO+DPA6KUdfUmod81+B+LTtMAIe49Szt
         M55rdM2glJYE7tVp1LAkzVeIFMbsqSaG60yhVEFG0hrX8cIygRGOvaCRf8JEzLWlQycV
         j2pA==
X-Gm-Message-State: ANoB5pll/WCf7vwr2y7thWRPfdBiEVxsS57+ji1wKjVQuLiVRHs2OyeM
        lnoH4PzDTyl0LiDVGKcE+TMCFw==
X-Google-Smtp-Source: AA0mqf5KYeHEJXRZ+kr6JgkeAh/50YD15QuTLMsHUkcRykfBkM54G39C9ocTK6xT3SMs2U6hWVnIKw==
X-Received: by 2002:aa7:9629:0:b0:576:8cdd:3f26 with SMTP id r9-20020aa79629000000b005768cdd3f26mr15108687pfg.59.1670295595903;
        Mon, 05 Dec 2022 18:59:55 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0018912c37c8fsm11229940pln.129.2022.12.05.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:59:55 -0800 (PST)
In-Reply-To: <20221109064937.3643993-1-guoren@kernel.org>
References: <20221109064937.3643993-1-guoren@kernel.org>
Subject: Re: [PATCH 0/2] riscv: stacktrace: A fixup and an optimization
Message-Id: <167029558296.27426.13218152789820527456.b4-ty@rivosinc.com>
Date:   Mon, 05 Dec 2022 18:59:42 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, anup@brainfault.org,
        keescook@chromium.org, frederic@kernel.org, nsaenzju@redhat.com,
        peterz@infradead.org, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>,
        vincent.chen@sifive.com, changbin.du@intel.com,
        Palmer Dabbelt <palmer@dabbelt.com>, guoren@kernel.org,
        linux-arch@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 01:49:35 -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> First is a fixup for the return address pointer. The second makes
> walk_stackframe could cross the pt_regs frame.
> 
> Guo Ren (2):
>   riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
>   riscv: stacktrace: Make walk_stackframe cross pt_regs frame
> 
> [...]

Applied, thanks!

[1/2] riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
      https://git.kernel.org/palmer/c/5c3022e4a616
[2/2] riscv: stacktrace: Make walk_stackframe cross pt_regs frame
      https://git.kernel.org/palmer/c/7ecdadf7f8c6

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
