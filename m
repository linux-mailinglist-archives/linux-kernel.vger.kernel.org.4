Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86E6E7C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjDSOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjDSOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:23:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B32FB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b733fd00bso2314664b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681914171; x=1684506171;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqMbvZWHdx/umNn2GDsuDcOtpXqKSdzh2puSjeFvGNg=;
        b=BQQfPjXj9RjzqoAPS+lEslGY5dDcNNPEbJrUbMfagQ00SpueZWLcpYAadUOn4K2r/7
         h4HdkG7hv1lk/JwJJQYCK1kCSiFRuTmkN44fcy7kPteadqn38MkQ3ndJHP2Mc9t7NrZL
         nmp1DYP7b7nPYrKCi/AHIrNyGwWhrPzKd1bjeAAqOo6tX3/AL+K+6SRGBPhAsfYsDgSs
         dPS/aO0HTzlFjGLxzQlmfHBIIf93KsDsbdHG4ySz5E0QxtwHAyLnkpkj20M9cIgvdPfV
         aEw0KFtyNn5lgDQSa9YMyBJglZh/UHtAgTzAA5ieEsZiecFBH/5j299y8tclByk2q0hU
         dWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914171; x=1684506171;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqMbvZWHdx/umNn2GDsuDcOtpXqKSdzh2puSjeFvGNg=;
        b=WiNzPQe77T83sbtIvviVFvv7QFXTcJA7rU0zLZ6zk9rdkp0RAcvZiA6z4wOnqkvmQD
         hwZ0xx2dG2YgeoB3Z1i+QSACn2XcfvRN5Z0q9Zj2351CBU7MVqCHST8Y9bigYjNUtfdF
         ftkhEdp4KHpjUGfyxL6F9HTAzPs9n4uiaKVycV/x0LM4F9qxb04Qoe5fUHVtiHM93vMS
         7BIQv5o8kTcoC/EeoCNZWJH8aTD/z41QHiNI5afufPRIUjbIpXFJpSnb1IpXYzVs1TAX
         3x13bQ8XxXi31pyLitXd+WRrgB/wlA4ViGsb+q0xxyUJTTZsv9GONWgttjei2dPdyDaa
         DxRw==
X-Gm-Message-State: AAQBX9cAPRQjxESlZkLomD7X3Q5HR+VmVbzx/O5QNc7aVpkCs824axaB
        69HzcQAc4a7yaTVXNRvH8ljiyUCmoasG1RHTi3VNug==
X-Google-Smtp-Source: AKy350bZHj+5SLgwTf96Z4FllovZ8h4/H1ZYpgVXzzdS4Hiiw7gNLDstVjX8e8aaqlbpRvsz3GY15A==
X-Received: by 2002:a05:6a00:2355:b0:63b:8778:99f7 with SMTP id j21-20020a056a00235500b0063b877899f7mr4656389pfj.9.1681914170729;
        Wed, 19 Apr 2023 07:22:50 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78dc7000000b0063b806b111csm7467077pfr.169.2023.04.19.07.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:50 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:22:50 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Apr 2023 07:22:40 PDT (-0700)
Subject:     Re: [PATCH 08/21] riscv: dma-mapping: only invalidate after DMA, not flush
In-Reply-To: <20230327121317.4081816-9-arnd@kernel.org>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        vgupta@kernel.org, linux@armlinux.org.uk,
        neil.armstrong@linaro.org, linus.walleij@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        bcain@quicinc.com, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        jcmvbkbc@gmail.com, Christoph Hellwig <hch@lst.de>,
        robin.murphy@arm.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     arnd@kernel.org
Message-ID: <mhng-158f3971-b108-426f-b3e2-4f3c02a2199d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 05:13:04 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> No other architecture intentionally writes back dirty cache lines into
> a buffer that a device has just finished writing into. If the cache is
> clean, this has no effect at all, but if a cacheline in the buffer has
> actually been written by the CPU,  there is a drive bug that is likely
> made worse by overwriting that buffer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index d919efab6eba..640f4c496d26 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  		break;
>  	case DMA_FROM_DEVICE:
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	default:
>  		break;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
