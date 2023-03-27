Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13286CA29B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjC0Lhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0Lhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:37:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D840E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:37:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so34703103edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679917072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFk1Od/+EdFCUvY552WWMWkI0eZLoEwGftRpKewd8rg=;
        b=ALLPX7NIBRUr5LDxpEb/c2hSc9AFyrkmc6dcaPRWf1vNMSIMER+M9CRx1Rk4e/FzWV
         pWxGHtKC8J7mWxTl1klk0P0ym7SadXtbpZPhJRXM2niu2MuRjQBjaFRdHsIt5Vt3Kb2Q
         GSe+qlE7ympdp3kln4/m4Tu1SS+gPdMD3RFVzAl9cTeK5+TDHf9YFwS+h6stc6iSoEW/
         yWUND7tdhxME0NDlMS2OWWFMuaTjuaJzo9ZZhnO7MDEDZaLuVcJaK4I72jNHwPJtYbAu
         caJeQ+HZS+NwW5fbsOjK27G8DPk0Yh25Hns2RNPwm94erxyWjoZp+1h/CcxjJpoBRc8q
         qzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFk1Od/+EdFCUvY552WWMWkI0eZLoEwGftRpKewd8rg=;
        b=I15zIRJon9Uus8ww8rR0OjYRMgfGBPEq3njd5qtT2QTh+2Qb+95z8KF87TCNPKPx9y
         rpYPFvrRmmTTjTE9Mh/5BUWxlo6iYapn6EpWxUFvIxNatQ72Qw7old0FLuWjKOPezFs8
         CLtLsWpLL81TrXpdJVoFF0fpaz3v0saqGRyAa41bUqBEQdMX4kUDDA6rqHC/kKRqA5/x
         fTG/BGL5reFP7YbYc7aiHNqv0sr0VKEwrs9QCYmP5r8cM+qJSP4VwPBkN+wYs6yr2drY
         r8JTGbesxt8ZaRLqwVdsIi5GjL6G8OZIdxFoAfydCPDMb4YeJbjXvmnq2nwokLYGA/YY
         XSAw==
X-Gm-Message-State: AAQBX9cij3QDF4wtpDIp/f93rYYgBIiW46wjJB5TcUnn3DcxOC+BqRNy
        URpTx5+JFWuR12JfiklWBU9MkA==
X-Google-Smtp-Source: AKy350a+xAzIAbxpLmLmCH/0KNk1tkTjeH1fEruONhgv3OXe/3DHnb9cBTHt4wnrFQpYd0e8eXUy7g==
X-Received: by 2002:a17:906:f143:b0:933:4c93:69ee with SMTP id gw3-20020a170906f14300b009334c9369eemr12617295ejb.45.1679917071855;
        Mon, 27 Mar 2023 04:37:51 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id kg2-20020a17090776e200b009334219656dsm12248051ejc.56.2023.03.27.04.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:37:51 -0700 (PDT)
Date:   Mon, 27 Mar 2023 13:37:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 3/3] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Message-ID: <20230327113750.4dahiicpcg3b27mz@orel>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
 <20230324155421.271544-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324155421.271544-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:54:21PM +0100, Alexandre Ghiti wrote:
> During the early page table creation, we used to set the mapping for
> PAGE_OFFSET to the kernel load address: but the kernel load address is
> always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> PAGE_OFFSET is).
> 
> But actually we don't have to establish this mapping (ie set va_pa_offset)
> that early in the boot process because:
> 
> - first, setup_vm installs a temporary kernel mapping and among other
>   things, discovers the system memory,
> - then, setup_vm_final creates the final kernel mapping and takes
>   advantage of the discovered system memory to create the linear
>   mapping.
> 
> During the first phase, we don't know the start of the system memory and
> then until the second phase is finished, we can't use the linear mapping at
> all and phys_to_virt/virt_to_phys translations must not be used because it
> would result in a different translation from the 'real' one once the final
> mapping is installed.
> 
> So here we simply delay the initialization of va_pa_offset to after the
> system memory discovery. But to make sure noone uses the linear mapping
> before, we add some guard in the DEBUG_VIRTUAL config.
> 
> Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> in a better TLB utilization.
> 
> Note that:
> - this does not apply to rv32 as the kernel mapping lies in the linear
>   mapping.
> - we rely on the firmware to protect itself using PMP.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: Rob Herring <robh@kernel.org> # DT bits
> ---
>  arch/riscv/include/asm/page.h | 16 ++++++++++
>  arch/riscv/mm/init.c          | 58 +++++++++++++++++++++++++++++++----
>  arch/riscv/mm/physaddr.c      | 16 ++++++++++
>  drivers/of/fdt.c              | 11 ++++---
>  4 files changed, 90 insertions(+), 11 deletions(-)
> 

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
