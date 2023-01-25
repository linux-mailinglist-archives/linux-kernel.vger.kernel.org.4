Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911A967AA13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 06:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjAYFtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 00:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjAYFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 00:49:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2787B7EDD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:49:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9so16906734pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2clZK09JqH0mZYrKAloUknV6sK19Xq1RB4pFi5pvbzg=;
        b=lJagTaVpLa/x/1F9OUFLXUG3brlAAz7I7HAD4j6qmxM0TfDu9z7IsujQpX0Xygwe/7
         mdk+2mH0SXm1XzB9CfA6gtulFA27UowLX0D9wMsfujnxhvERNr7sqkQvUocz5ye4o8lG
         5q2TE6BTglP8/3bDhP4v5Wh+8OAwhmm56Fg4lCUH5MlvWZdocpVwPkMH0BZkcmALIExx
         A2Vu+D+4HgsscZBqBay1/2rWqylQ9N+RmfEIQ1vqn8y89sR59/PlQdt+VaadG0PU/xHc
         nioKwfiOx2CVBdq8sFkakFM4eey9DspAejLnXPoUPqQe7YXp9nM4bXgUnj/+kHidPC27
         n/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2clZK09JqH0mZYrKAloUknV6sK19Xq1RB4pFi5pvbzg=;
        b=IeFPdUXTdwZRV5iOt4UZ7+XekmEcGPrQNxmwfiXXlVle1zp6MoHY2viDgqUPknu6uf
         tyGOnbC49Nrnyxvg+zzvm3vyITtA7jsP/minppJj80ZUUjnDxsTYbN5YrAoL40dQuAud
         /9ovqU6VZCoELrFUMM3crluPEEZpoIn2iXBGXNTp1PRw3/SXYTpTGqDcw01NDUSndLJl
         czJqvY/fl+cHMpzJSaL2oSOkS4cJo0Mq0Tfb0R2Oj6doGvpL/TYVKOsmVPtKw7g1y5gV
         2s9Dp3p5JYJ0hc13kJy/jeJ1x9OqSp/NIH8w6Ouj0MoHgRbwjQJ/tjBbSwlYj8SBDMAr
         FARA==
X-Gm-Message-State: AFqh2kq0beQJIlLZWOR5TN3PMV/YfhYQEtIL21f3iMAnH0c+9PWgyzzT
        mHNXCi5a6YEJj6mJeMyDYRyuwA==
X-Google-Smtp-Source: AMrXdXuCxWM5IJmuHLPIH8llgP98HDUza7zHbZk/CV/fN5JGBRlzjAAE9jvy0Nv6Uz/k+Pqdjvbhbw==
X-Received: by 2002:a17:902:bb89:b0:194:9b5e:a0a5 with SMTP id m9-20020a170902bb8900b001949b5ea0a5mr32269763pls.43.1674625740608;
        Tue, 24 Jan 2023 21:49:00 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00196048cc113sm2639954plw.126.2023.01.24.21.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:49:00 -0800 (PST)
In-Reply-To: <20230116064342.2092136-1-liaochang1@huawei.com>
References: <20230116064342.2092136-1-liaochang1@huawei.com>
Subject: Re: [PATCH] riscv/kprobe: Fix instruction simulation of JALR
Message-Id: <167462569110.21287.11897342152923707674.b4-ty@rivosinc.com>
Date:   Tue, 24 Jan 2023 21:48:11 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenlifu@huawei.com, bjorn@kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        penberg@kernel.org, mhiramat@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>, me@packi.ch,
        guoren@kernel.org, Liao Chang <liaochang1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 14:43:42 +0800, Liao Chang wrote:
> Set kprobe at 'jalr 1140(ra)' of vfs_write results in the following
> crash:
> 
> [   32.092235] Unable to handle kernel access to user memory without uaccess routines at virtual address 00aaaaaad77b1170
> [   32.093115] Oops [#1]
> [   32.093251] Modules linked in:
> [   32.093626] CPU: 0 PID: 135 Comm: ftracetest Not tainted 6.2.0-rc2-00013-gb0aa5e5df0cb-dirty #16
> [   32.093985] Hardware name: riscv-virtio,qemu (DT)
> [   32.094280] epc : ksys_read+0x88/0xd6
> [   32.094855]  ra : ksys_read+0xc0/0xd6
> [   32.095016] epc : ffffffff801cda80 ra : ffffffff801cdab8 sp : ff20000000d7bdc0
> [   32.095227]  gp : ffffffff80f14000 tp : ff60000080f9cb40 t0 : ffffffff80f13e80
> [   32.095500]  t1 : ffffffff8000c29c t2 : ffffffff800dbc54 s0 : ff20000000d7be60
> [   32.095716]  s1 : 0000000000000000 a0 : ffffffff805a64ae a1 : ffffffff80a83708
> [   32.095921]  a2 : ffffffff80f160a0 a3 : 0000000000000000 a4 : f229b0afdb165300
> [   32.096171]  a5 : f229b0afdb165300 a6 : ffffffff80eeebd0 a7 : 00000000000003ff
> [   32.096411]  s2 : ff6000007ff76800 s3 : fffffffffffffff7 s4 : 00aaaaaad77b1170
> [   32.096638]  s5 : ffffffff80f160a0 s6 : ff6000007ff76800 s7 : 0000000000000030
> [   32.096865]  s8 : 00ffffffc3d97be0 s9 : 0000000000000007 s10: 00aaaaaad77c9410
> [   32.097092]  s11: 0000000000000000 t3 : ffffffff80f13e48 t4 : ffffffff8000c29c
> [   32.097317]  t5 : ffffffff8000c29c t6 : ffffffff800dbc54
> [   32.097505] status: 0000000200000120 badaddr: 00aaaaaad77b1170 cause: 000000000000000d
> [   32.098011] [<ffffffff801cdb72>] ksys_write+0x6c/0xd6
> [   32.098222] [<ffffffff801cdc06>] sys_write+0x2a/0x38
> [   32.098405] [<ffffffff80003c76>] ret_from_syscall+0x0/0x2
> 
> [...]

Applied, thanks!

(with Guo's suggested cleanup)

[1/1] riscv/kprobe: Fix instruction simulation of JALR
      https://git.kernel.org/palmer/c/ca0254998be4

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
