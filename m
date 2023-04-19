Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD276E7C61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjDSOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjDSOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:22:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2034A59D7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63d4595d60fso7308860b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681914162; x=1684506162;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QMI2Yn+3Tt8Q1/CbQZqi01Ckjh+S0S8nE0G1uS1/Is=;
        b=T1EEo/1lNhWtIaj43BCGws+YmfqMTA6iMuWVagfEnT1xJA8qVwOPm1UGiTLe2NOFuM
         xMk7buI+T1c0Hf3+C2uqsQgEJHHaSuEgENbG5BOdgXzQw6qmKvjFm/lHzItwlc4j30pI
         v5SNg4zDHJJ59SreaJer2v7hZf5LQBP2OmSziT6uC7+pvGZBrGJz+CCb8kKTTjdQju9a
         kku5NeVrvk8S8WAibKcjPeWqbCmN/DAxVz0JiSKkYT179rZ/V1dOmkVPAKGqsIK5NZaW
         QXp9BfFBDt3hvjxhkTunOLMevN/GsODpZQqgxG1z5sdsJdhqmd9J2xXVcjSyZmaKNRaM
         NxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914162; x=1684506162;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QMI2Yn+3Tt8Q1/CbQZqi01Ckjh+S0S8nE0G1uS1/Is=;
        b=P4csjtGZjyx3fxrnx/fUqvQ3ghQqD+VXnIkbFgg+XPBXERvxR5P7s0pjAWJOxUql63
         0XSq+yMkO6huYKfd3WUlt4RoaXMSM+T+8GkRQ/21iNzoLC0ByEa/HhpQWzFr8+o6rO4s
         4vL23djhQNcoUzOMTrfYRUdlPLiA3Jcii8fPHyWdv+imH/mWNhe5/WgrEbA7t3Wycu+V
         ZPj2sEzDpE2hSoO5aVKiZtuxpFVOz2K7kmvb9j4V4Um7+1vr2zM46PKVVMvR5b2Bxbc1
         1xKhZZLIo3pQEVziK2i9IV2I7g/+XDe/XoNxgljkJcYrFlr/KK+xPfHV923D9Wuzx1OJ
         AQGg==
X-Gm-Message-State: AAQBX9elmiV5UU1SL4sKhnPGzSiKYSvXucSVWks/ADC/HCZPfLIGSiAB
        EUZy1Dap6eyjc5Z+wDEBse2ERw==
X-Google-Smtp-Source: AKy350bsDoupaU7w23Gv+/Ur91Sz+5sUWiyttfG5xjuFIADCUHqGvSKNWHn052OZEniozc8lOEgaOQ==
X-Received: by 2002:a17:90a:9285:b0:246:5787:6f5d with SMTP id n5-20020a17090a928500b0024657876f5dmr3052189pjo.10.1681914162496;
        Wed, 19 Apr 2023 07:22:42 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm7616348pgm.38.2023.04.19.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:42 -0700 (PDT)
In-Reply-To: <20230324155421.271544-1-alexghiti@rivosinc.com>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v9 0/3] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Message-Id: <168191414582.1929.5343150179757042159.b4-ty@rivosinc.com>
Date:   Wed, 19 Apr 2023 07:22:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 16:54:18 +0100, Alexandre Ghiti wrote:
> This patchset intends to improve tlb utilization by using hugepages for
> the linear mapping.
> 
> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> take care of isolating the kernel text and rodata so that they are not
> mapped with a PUD mapping which would then assign wrong permissions to
> the whole region: it is achieved the same way as arm64 by using the
> memblock nomap API which isolates those regions and re-merge them afterwards
> thus avoiding any issue with the system resources tree creation.
> 
> [...]

Applied, thanks!

[1/3] riscv: Get rid of riscv_pfn_base variable
      https://git.kernel.org/palmer/c/a7407a1318a9
[2/3] riscv: Move the linear mapping creation in its own function
      https://git.kernel.org/palmer/c/8589e346bbb6
[3/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
      https://git.kernel.org/palmer/c/3335068f8721

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

