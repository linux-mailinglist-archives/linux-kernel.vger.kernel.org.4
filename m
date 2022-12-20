Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C46518F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLTCpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTCpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:45:08 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75212D29;
        Mon, 19 Dec 2022 18:45:07 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5DB2D80CB0;
        Tue, 20 Dec 2022 03:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671504305;
        bh=IprEi+qVnctNMnKAlyk6243hIepwAWWu6ePom6r/wMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ARtCj1wmZcCyOZI5N/kIaiLe+nT7YwpX6LLMVl6zseUgGZkHnh411bc1vcS94DgaL
         envbGCEUP423Xn/dFjhvRa8Pif0ffQHfUpDMsxM+KKOZwQEizXvV0z4bgyncaKMDxw
         YsAS7qQecit0OiyFDpA4QnpWwzChui0dikPadfEwVF+77rsQnrripx//ryzXqe/jPd
         7DtYqrJHg9RhKl2OzcLJgB/hN57UWTWGvso/StWtehGO3GNxvcS59TVVE6xq19xjRl
         ZaUktmvc4szac42IqVUUeqPW6p5czJlSBnmJAy8anbUZPRIr2dgWaLJ37G6yZ4Qf3g
         aaTF2cLyY4X2g==
Message-ID: <a5880060-c5ef-b12d-fb41-4f7f71cfe316@denx.de>
Date:   Tue, 20 Dec 2022 03:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] kbuild: Optionally enable schema checks for %.dtb targets
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220013233.2890335-1-robh@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221220013233.2890335-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 02:32, Rob Herring wrote:
> While not documented, schema checks for single dtb targets mostly work
> already by setting 'CHECK_DTBS=1'. However, the dependencies are not
> handled and it only works if 'make dt_bindings_check' was run first and
> generated processed-schema.json. In addition, changing a binding file
> doesn't cause the schema to be rebuilt and dtb to be revalidated.
> 
> Making this work turns out to be simple. Whenever CHECK_DTBS is set,
> make 'dt_binding_check' a 'dtbs_prepare' dependency.
> 
> I reimplemented here what Masahiro had originally come up with a while
> back.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Makefile | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 6aa709df6bde..a99d5c4de0fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1467,7 +1467,10 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
>   
>   ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>   export CHECK_DTBS=y
> -dtbs: dt_binding_check
> +endif
> +
> +ifneq ($(CHECK_DTBS),)
> +dtbs_prepare: dt_binding_check
>   endif
>   
>   dtbs_check: dtbs

Tested-by: Marek Vasut <marex@denx.de>

Thank you!
