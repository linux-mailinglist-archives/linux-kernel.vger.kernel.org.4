Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADA69020A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBIIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBIIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:23:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37085BB2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:23:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r3so1392186edq.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DERA6rZJqjWeH7DEhVRmhhsPITPHyc6ZUiK7R87w4Ak=;
        b=bkeUeyi9xhUKUg70LQRIUCRAa1C0nf3xTOOpkxOAF8kea2cBXsC80xYMPQcar5o3m3
         VcO2hSCWdniCKDwuP7vIVF0tYFDz5h829LcB0rU3OyPayiVGqUvQbEf/f2u6nkyc7mUc
         q5DohMh9xaCiNRSE9MSkUPyAuwVgTuml0ywWQAMKwA8OgpCqiOxUVuIrrdvR2HRNnlgx
         LCvYF4qZbDDPH2JreZLMaVuLvqGKp1wtNGxmIfLLPcE+792Ht764ihnU39UM8Ag4+Tf/
         DyLhOxouk5+P5F2gNhAsH+8ntf5UzGlC8Igd0zTYyTaguI9K7Pm7nfJPgWBcQ1WEmoMe
         KH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DERA6rZJqjWeH7DEhVRmhhsPITPHyc6ZUiK7R87w4Ak=;
        b=e1kPPybndHSNeArR1xT/FSvX2ObN0LplkzqKzj4vuWwHMss6YhZFATiQtoyI+YlWOR
         Q/PVTa0/IahRtno3TgCmSMJPqTuaDoufzMcv3uG7EUfMXMVEOjmn46mhzS1rfOguEHL4
         jgAaWAPMbtNzGZ+pmggTtU1fHf1coN4st/ll4LzAKi5eLc3yzgJHlAT73CHsocQsh/AJ
         prZqFgmXI+iBMQfFid21bORCdy3HzZJs7ZVfwauupdeChAdH/oVV3pbJwQWykhAklXF9
         nffwLbweCQVKEpSuBQq+vu2Gy9hJRe1BN0xu9KQYW5e5gLVXsMWnQ6kZTN2aq5J2mkpm
         sf+A==
X-Gm-Message-State: AO0yUKXhvdOg0CU4Vs2CEruO6N+qfeapLqTYhmje0+i+PAK19Tx4JnHT
        1IYO5WSC59f9RcD7WH3YP91Kyw==
X-Google-Smtp-Source: AK7set8jXgg1VDK2HzYMhcGyAX1CdYIy1E+euV0DjBqRFwDwWuFHD9A6MrwVc/mf/TDmCy8k5Z88Ng==
X-Received: by 2002:a50:8d5b:0:b0:46b:19ab:68d8 with SMTP id t27-20020a508d5b000000b0046b19ab68d8mr10810492edt.40.1675930992606;
        Thu, 09 Feb 2023 00:23:12 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004ab0e9e396bsm407314edj.87.2023.02.09.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:23:11 -0800 (PST)
Date:   Thu, 9 Feb 2023 09:23:10 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@rivosinc.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
Message-ID: <20230209082310.q7lkpnic5t5arq5a@orel>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208225328.1636017-2-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:53:27PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> As Andrew reported,
>     Zb* comes after Zi* according 27.11 "Subset Naming Convention"
> so fix the ordering accordingly.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 420228e219f7..8400f0cc9704 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -185,9 +185,9 @@ arch_initcall(riscv_cpuinfo_init);
>   * New entries to this struct should follow the ordering rules described above.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> -	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> -- 
> 2.39.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
