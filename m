Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1D67B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjAYLbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjAYLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:30:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0124491;
        Wed, 25 Jan 2023 03:30:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mg12so46790748ejc.5;
        Wed, 25 Jan 2023 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hiHRKTQOjlSRNS41pYDk4fNzVigtW+jgqLOn/vwxkM=;
        b=RhOvSaJi22/l2KQ8AmdYmC4rtIHRXb58eI9lhypQdtf73cB6yxJ3U55b1GtrvteDpd
         ghxp85Yxt5RDxG880roFCAQRLTlXies263yqzj7cz40sAvFJiQEAHKeqcYHYUm9VV0NQ
         IBcEIAic2+oxzadrnlBphfq9qjpx5opaFYWFE3EyRVlUrsgl2DblwCP1fQCHJGaaeqi9
         n5Ms0+1dI2es7CRH9dAs//Xk4ZFMucJr1T/5qeve6OuzNlVH/jKaw7+3gqd3aKbmPEU9
         U/wGmyncIHYBRLhh/xF59DxG8tf4KhO+p6KPbIJqqFDjnHuxYfA0d2Z49ifnjgUnbC8c
         hNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hiHRKTQOjlSRNS41pYDk4fNzVigtW+jgqLOn/vwxkM=;
        b=0/3ZbXhaAoGvymFIgmWanjA4Nb4hxXRmdQKqEYCEul37yL5zjsEBpfzCHYcWMzEvVZ
         OoUhopcaHoNc+bHDWdhvqPieTHJy++a9AqdXOpNqP4rvhX9V6TVxztkbz3RDUxgSrqfR
         SkYTpLqdeSRQHq1O0e2lKWblhCsS1UqVBq6+5OuCh+Ywg71pjwacUO7nGb52n+EB/7gM
         A65MSsPR4mmnz0YsDQRsyjj2BYB2LMmyMgjgcyNhTG00JBmqEALSu3rBOqGmIiX8HlEf
         Io5e25WskOg4zKhEyK+ik3z5K/VeczjeMT/+zajjKI32UWjVpkWysY/TxPOmNdocOdtE
         V05w==
X-Gm-Message-State: AFqh2kpKIQIdFCZyLNO5qvAsk2+hrI8O5iG/k8SAl+U0ufYV9TAkB7J/
        AJ/6wqDGRR+IQwY587LN+b0=
X-Google-Smtp-Source: AMrXdXsmgzfharAGB09qQB4e6d7wlaN5kct1WqwUvO982R+qQvIeOC8QLjR5SYi4grKmqdayRiMAdw==
X-Received: by 2002:a17:907:20e9:b0:7c0:dcc2:e7b1 with SMTP id rh9-20020a17090720e900b007c0dcc2e7b1mr33203713ejb.43.1674646245974;
        Wed, 25 Jan 2023 03:30:45 -0800 (PST)
Received: from gmail.com (1F2EF55F.nat.pool.telekom.hu. [31.46.245.95])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906c08500b00871390a3b74sm2277902ejz.177.2023.01.25.03.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:30:45 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 25 Jan 2023 12:30:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     David Rheinsberg <david@readahead.eu>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
Message-ID: <Y9ES4UKl/+DtvAVS@gmail.com>
References: <320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Rheinsberg <david@readahead.eu> wrote:

> Increase the allowed line-length of the insn-decoder-test to 4k to allow
> for symbol-names longer than 256 characters.
> 
> The insn-decoder-test takes objdump output as input, which may contain
> symbol-names as instruction arguments. With rust-code entering the
> kernel, those symbol-names will include mangled-symbols which might
> exceed the current line-length-limit of the tool.
> 
> By bumping the line-length-limit of the tool to 4k, we get a reasonable
> buffer for all objdump outputs I have seen so far. Unfortunately, ELF
> symbol-names are not restricted in length, so technically this might
> still end up failing if we encounter longer names in the future.
> 
> My compile-failure looks like this:
> 
>     arch/x86/tools/insn_decoder_test: error: malformed line 1152000:
>     tBb_+0xf2>
> 
> ..which overflowed by 10 characters reading this line:
> 
>     ffffffff81458193:   74 3d                   je     ffffffff814581d2 <_RNvXse_NtNtNtCshGpAVYOtgW1_4core4iter8adapters7flattenINtB5_13FlattenCompatINtNtB7_3map3MapNtNtNtBb_3str4iter5CharsNtB1v_17CharEscapeDefaultENtNtBb_4char13EscapeDefaultENtNtBb_3fmt5Debug3fmtBb_+0xf2>
> 
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
>  arch/x86/tools/insn_decoder_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> index 472540aeabc2..366e07546344 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -106,7 +106,7 @@ static void parse_args(int argc, char **argv)
>  	}
>  }
>  
> -#define BUFSIZE 256
> +#define BUFSIZE 4096

That hard-coded constant is a bit lame and will cause trouble the minute 
*that* size is exceeded - don't we have some more natural figure, such as 
KSYM_SYMBOL_LEN?

Thanks,

	Ingo
