Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61C6D68EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjDDQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjDDQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:31:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B04229
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:31:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so33434666wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680625911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWfv0RYKjPE6ILniOXyfBwX408cO5MlZVjVqu1n4tX0=;
        b=gm6N3McuZafztBRpXbRs/EtWofSB3kteTecmmRGTGY+mg3PO3rycfsnfCepxBdvE1X
         CA5oTDMx7cB9LPbH46uuSVfemJ9TixIn9B9UWz9Bs9tZnhZfBCZAe4wCRIs3KoL86jBU
         7WYugu8GFmQPMm0TPTK1qUCOXVprJyxPc4MkJyRJ42s+0YKCVrpFsh9TgAlpBG4NvO+t
         ALir0xzrye7Fv5xG4El0PCQDewrAqZ/zuZ1LU47SJFC3C/FGW1bjsuEBqFNeWjvYISm6
         hD8UXZk5iori2YiLYozpCToFjFPHX0wCAttrxtOYZ8i03vElaMGoeYb021+GOtGkkALx
         dBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWfv0RYKjPE6ILniOXyfBwX408cO5MlZVjVqu1n4tX0=;
        b=cmkRrc7z24P4LuiEF+2ikwsCMlgZYYkzewbni/1t3hfX8ZZk18X11cWb8V37KYqc5t
         hV6IRVdvVn568pxRu5Lo+6ne506BMici+786Nk67dlrE+Y4T9N/kxhSXfCggHNLNUCsE
         cfHGc7Ag5W6CD3WF7dC0xnWvfx5l6kvK/TAvwEVagl3KUxgAjBm0+gb++vW15wb5Vtje
         ChHNtdRGPzWdB039IQx0BVF4Qac1EBIUbNzZigyob5ryyuNiiw4X5emxLYWp+4juj0vW
         77KFViotFx7Wll/+89FVnIRaN5koQJZzu7t/GXj8hBBla6Rj8ZeewQETo/wH9bcu4L9b
         CUqA==
X-Gm-Message-State: AAQBX9dDdMFgJkDpKNN0rvyvwmAKNdiL+l8EC0ww3SBon9e5pKnWa3Pa
        U22gJ+X0mKQPTZBm9ggcspFTBrJcf9f5tg/HeXY=
X-Google-Smtp-Source: AKy350aiLZ902xG3dAVk/EXrQHSxt8nzwRy0ZUODd4WkgfRlIS16RUPDwFhtYw3lILRXUt83CfLWMg==
X-Received: by 2002:a5d:4a4a:0:b0:2ce:aed5:7dc with SMTP id v10-20020a5d4a4a000000b002ceaed507dcmr2109083wrs.68.1680625911057;
        Tue, 04 Apr 2023 09:31:51 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d68c1000000b002c59f18674asm12741037wrw.22.2023.04.04.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:31:50 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:31:49 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] RISC-V: KVM: Implement guest external interrupt
 line management
Message-ID: <buomdae5cjxjctzleywsjqejf2k3d3zuwqi7zyrjq4fc2xzng5@mdxdojrdkm4j>
References: <20230404153452.2405681-1-apatel@ventanamicro.com>
 <20230404153452.2405681-10-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404153452.2405681-10-apatel@ventanamicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:04:52PM +0530, Anup Patel wrote:
> The RISC-V host will have one guest external interrupt line for each
> VS-level IMSICs associated with a HART. The guest external interrupt
> lines are per-HART resources and hypervisor can use HGEIE, HGEIP, and
> HIE CSRs to manage these guest external interrupt lines.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_aia.h |  10 ++
>  arch/riscv/kvm/aia.c             | 239 +++++++++++++++++++++++++++++++
>  arch/riscv/kvm/main.c            |   3 +-
>  arch/riscv/kvm/vcpu.c            |   2 +
>  4 files changed, 253 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
