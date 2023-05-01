Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34C6F3250
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjEAOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:51:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF471A6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:51:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso27216246b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682952695; x=1685544695;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSCPrqXOc+jiMcJ1awitEwssb+M8Ttbck4A1Ax5no44=;
        b=t2bjDBj4KJiM6x2KXcZBuAruNSl7Xtw1iMpAVO54lX++zGDR+FQgxtGM/9hPxjn3eC
         mmtX40XvoY0WoQUx3WOsYw4qJDxzex0ccJotUaDWylKbh9CFBRwniakOG3AO3kXXVswM
         Le+IXNnfAs8OnFGl6v657EmjA631f2YJV7qB41bv9eyKxYSZFlC2T9CT9jREc2MFB60I
         d58CMyTtBTFfo4d58UwRRUR4LE28j5KjKcdaRW5rNzYR8MG4STym7b+23Q9Vo32sjgJa
         bOfOWYGPm8OiWKUBthHQ2zUqQ9J7vd06Mb4ke++cPb6A1dOtcx9lECVJTNNZ4dx2Sxrz
         92Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682952695; x=1685544695;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSCPrqXOc+jiMcJ1awitEwssb+M8Ttbck4A1Ax5no44=;
        b=Sx2KgLJR+P5KhaItTIp+s38XnFYLucnzaHLyIAdTGqCjn52Yuc9MjPgEyCxCuAICUI
         KvgwrChy+MOTq3sB+H0dd4LHnlqGplpxB9m5w+C37b3FxztvAZvFR+qeVYWimjCbLH4v
         dsEHG/3o3UymvttCYYRvCNrn0BeLAslIBNtwgbX5PjiHbf3SPUVYQRB6L709vbC5QSzD
         S8WK+mt7H1j1+f9MnWh4Pq1UaxbXDYh3KO4w8yyyh7rMmuAXdY33RbKWCVbVBEhSzoVh
         hCdzpnPuLrQs/Db0Sh3SHbgQj1bsNl0Bpp/800WNqynoPB2694dDWVV33iH13scE5HSB
         KKMA==
X-Gm-Message-State: AC+VfDy16M3Fx55wn5J9/8REiJdGZQhppUHGULwnBP0lP+qGZRvt1E7M
        MIoXqafGrgpqYapz4ZgeVSKXHA==
X-Google-Smtp-Source: ACHHUZ5aEFOivTZdix1xXoRRVIMgqofu0C4xXvvL7s7jLIzvzf4ndKucq5upDgWfeN6qK/SLr+DrpQ==
X-Received: by 2002:a17:90a:f3d5:b0:24d:e504:67b1 with SMTP id ha21-20020a17090af3d500b0024de50467b1mr7946089pjb.7.1682952694904;
        Mon, 01 May 2023 07:51:34 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a8c8d00b0024deb445265sm2976704pjo.47.2023.05.01.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:51:34 -0700 (PDT)
Date:   Mon, 01 May 2023 07:51:34 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 07:51:13 PDT (-0700)
Subject:     Re: [PATCH 2/4] RISC-V: don't parse dt isa string to get rv32/rv64
In-Reply-To: <20230424194911.264850-3-heiko.stuebner@vrull.eu>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-5ab61a7c-cccb-45d9-8c0f-5fbd8dc5931d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 12:49:09 PDT (-0700), heiko@sntech.de wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> When filling hwcap the kernel already expects the isa string to start with
> rv32 if CONFIG_32BIT and rv64 if CONFIG_64BIT.
>
> So when recreating the runtime isa-string we can also just go the other way
> to get the correct starting point for it.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/kernel/cpu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ebc478f0a16c..06c2f587a176 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -244,7 +244,7 @@ static void strcat_isa_ext(char *isa_str)
>   */
>  static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>
> -static char *riscv_create_isa_string(const char *isa)
> +static char *riscv_create_isa_string(void)
>  {
>  	int maxlen = 4;
>  	char *isa_str;
> @@ -261,7 +261,11 @@ static char *riscv_create_isa_string(const char *isa)
>  		return ERR_PTR(-ENOMEM);
>
>  	/* Print the rv[64/32] part */
> -	strncat(isa_str, isa, 4);
> +#if IS_ENABLED(CONFIG_32BIT)
> +	strncat(isa_str, "rv32", 4);
> +#elif IS_ENABLED(CONFIG_64BIT)
> +	strncat(isa_str, "rv64", 4);
> +#endif
>
>  	for (i = 0; i < sizeof(base_riscv_exts); i++) {
>  		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> @@ -280,7 +284,7 @@ static void print_isa(struct seq_file *f, const char *isa)
>
>  	seq_puts(f, "isa\t\t: ");
>
> -	isa_str = riscv_create_isa_string(isa);
> +	isa_str = riscv_create_isa_string();
>  	if (!IS_ERR(isa_str)) {
>  		seq_write(f, isa_str, strlen(isa_str));
>  		kfree(isa_str);

Conor pointed out this one, I just looked at the cover letter and got 
distracted by uABI stuff.  It's not directly fixing anything so I'm 
going to leave it out of this merge window, particularly given that it's 
tied up with the rest.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
