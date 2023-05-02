Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15A6F3BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjEBBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBBFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:05:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B230EE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:05:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b8b19901fso3722950b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682989519; x=1685581519;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGOWcjl/uqCwccdmYHPReY1aipEcvrgGi4N1Hy5FkdQ=;
        b=0X21iJVwX4o++xGqJyzeqmOE4egyylqqMrFdl8GFUw4URCmhzwiqEXGtv3PgTWbx6X
         Ggs5EcMasuJrUTxl090Q6mEcvzcwjPaKvHOEGU1UPmAYklHiKe9b6BOMdCfGKvc0QVkX
         UaW+R113kPTSKUOO9bJKw9Ywiwh1TJGlAlYQqoRdlnjpxUkuh6IEhR/yDxAba5rN2Giz
         mTFzL1deNZ9X+nox5Tt/cK1uZBgxyRzf30nyQGZy2pWeat0xNQyg08sgn4V81B6+9gSE
         zNxpG3oeYcTq8ncCZZ/jCGskwKijag13s/Jp+Z9/AT35YTvBFbQHapIxjGnTXe/bwwds
         LzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989519; x=1685581519;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGOWcjl/uqCwccdmYHPReY1aipEcvrgGi4N1Hy5FkdQ=;
        b=Hp1HRidK6+mmcgeX1dxdTz9nT4O9aDnKtcKj5kI+r5LDCUDtvIw/BKXOa8ViRPjvbM
         kV83fKPOspAaaHTltxwoBMHD/GLUHc0mCs6i9lPDtQHFoKEl6pRC02s4YD2rsXQ+b5bO
         x0NBEu1gkQ9x6n3Eh/72wY/xdVdbai9KcuTnPla1XFpkqqeBhAapJoT2rsOzTcbbLSqD
         L+CY8YJm+8INkHNQx7CrsxaHuzhuADhkw8PjBNlO1/UkFlngjpW0oIpMUGOVA/WNBrzd
         BW/THjMYx5hZabFaAu+s8CBOmI7qyMD0PdanzVbxbCWkvLWR1Egdy/JHZjVaDezrvzv0
         b0rg==
X-Gm-Message-State: AC+VfDzWomqLiNMD2/+SRK4s46bHvwQRXmhUmqVADl8kP16Z49XBoEev
        y0sd5Tc+wGYacTyRgmZOAevMqA==
X-Google-Smtp-Source: ACHHUZ6P0dRfMgvCYBi+Gg5gd+4m7NemyXrvpJ08uoBwNqVnpHM8RxdFXHkc2HUkrKkPO1aqrb3O3Q==
X-Received: by 2002:a05:6a20:a121:b0:f6:15f3:ca36 with SMTP id q33-20020a056a20a12100b000f615f3ca36mr21264422pzk.50.1682989519214;
        Mon, 01 May 2023 18:05:19 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00170400b00640f01e130fsm12118736pfc.124.2023.05.01.18.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:05:18 -0700 (PDT)
In-Reply-To: <20230428120932.22735-1-alexghiti@rivosinc.com>
References: <20230428120932.22735-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Move .rela.dyn to the init sections
Message-Id: <168298679769.11596.14558462295548985911.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 17:19:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Apr 2023 14:09:32 +0200, Alexandre Ghiti wrote:
> The recent introduction of relocatable kernels prepared the move of
> .rela.dyn to the init section, but actually forgot to do so, so do it
> here.
> 
> Before this patch: "Freeing unused kernel image (initmem) memory: 2592K"
> After this patch:  "Freeing unused kernel image (initmem) memory: 6288K"
> 
> [...]

Applied, thanks!

[1/1] riscv: Move .rela.dyn to the init sections
      https://git.kernel.org/palmer/c/4db9e253e701

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

