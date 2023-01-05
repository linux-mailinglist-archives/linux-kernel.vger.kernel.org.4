Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9491565F12A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjAEQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjAEQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:29:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9849058304;
        Thu,  5 Jan 2023 08:29:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so36692027wrb.4;
        Thu, 05 Jan 2023 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0EVCr8niOrDqjzMLygmK437Bl2kIDtpevcurJg/sh4=;
        b=jDIVtUpClcQ+UxG9qVupCt0iQQGwHM+d6T7wEusmr+qK30mUCcYc9GUyuqoMxRGc6F
         yLsE6pp9oKTyZKpGEPno5HWa/Jp/mb4Kc0geXzmf2qw2NY8NBd1Jgf0FriM5Za1PQKZV
         1Hyyngu7+VstGQViUN36nBx25MrximOkklcdi8G+oTCIwZ5tMwFmvn7FmIPpIrrqe5ND
         a0Hw5QjJ2BBPZUTn0xztv694WU6bZ6DQTF6gBJKr+sAaDlG3r3jof4uouVUvKsnD8OcK
         nDlc91mOj0bGL3XTt6c2pFBHr8WyBJRHyB4jI5T2BeUBBlZDszPy4LltDjv3zPP19r3G
         Qxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0EVCr8niOrDqjzMLygmK437Bl2kIDtpevcurJg/sh4=;
        b=5D3OY810mBCiyYJUihkl4+atzm1sVT+Kh3aRVSDfE7zF9yn2i/UkgjoW/9gMhgefzS
         ObXXNouw8I0lnSk36931FmfF19RyMh6UxABLKhqei0g5XCphtMfTqZn5oH3QdgzI63Fv
         6XRb9nkwGAQyi6vl2o1fo67N/AuPgCIx/tZHMhqAmxjMusVSMW9uEiHRpG3h3tNUlq0Q
         d7T9vsu/sZ5FUKFZoE8wVx/tJrW1Dni7zNqoOpR1Y800cpOFd6uoFLVouU8gsnSwIfKV
         Hy9urDoB+HWrpA8IxssWQpwIi6C/RVKw15J5RBXUllrMKip/nWhPYL21+d5RONbXhS/P
         lxyA==
X-Gm-Message-State: AFqh2koZWAAxNaKOzHhtBBLnPPfaZjMl6Ft0dFxyZduoxVXPvlMAzBeh
        Y3rwu+NCY40SeqR0oan25K8=
X-Google-Smtp-Source: AMrXdXtdx1ljPkWlugJYyqxedcQLP7LIr489mbO58wIq4UPlhosgyNRl41DeetoAC5tBRLPKPwtTzw==
X-Received: by 2002:a5d:6844:0:b0:2a2:5a2:cc10 with SMTP id o4-20020a5d6844000000b002a205a2cc10mr5139614wrw.36.1672936176128;
        Thu, 05 Jan 2023 08:29:36 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id z1-20020adfdf81000000b00268aae5fb5bsm36862776wrl.3.2023.01.05.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:29:35 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] crypto: sun8i-ce - Add TRNG clock to the D1 variant
Date:   Thu, 05 Jan 2023 17:29:34 +0100
Message-ID: <3212177.44csPzL39Z@jernej-laptop>
In-Reply-To: <20221231220146.646-3-samuel@sholland.org>
References: <20221231220146.646-1-samuel@sholland.org>
 <20221231220146.646-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 23:01:44 CET je Samuel Holland napisal(a):
> At least the D1 variant requires a separate clock for the TRNG.
> Without this clock enabled, reading from /dev/hwrng reports:
> 
>    sun8i-ce 3040000.crypto: DMA timeout for TRNG (tm=96) on flow 3
> 
> Experimentation shows that the necessary clock is the SoC's internal
> RC oscillator. This makes sense, as noise from the oscillator can be
> used as a source of entropy.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


