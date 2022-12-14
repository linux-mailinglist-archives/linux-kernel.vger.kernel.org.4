Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7464D293
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLNWsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLNWsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:48:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D531EEB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:48:31 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w23so4927573ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMEJ8qWvU17qF8Iw6KkCvqlY5TEaxk9MDPpeFJN2leo=;
        b=aXfHEhtI9R9soKDZaToBP0eHoF2wK2L4yt464De59nc6HszERIRBsqLpZZ+DFxc96F
         ErGuCCGWsqQeO+Y1l54z466jTHAlyVTnV523ltKdLyfd0Iho/DTDTk578EVfOjG7+STh
         xQf2eoCCBBhAtR68zaS7SgJiOTnl2XhSwFrvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMEJ8qWvU17qF8Iw6KkCvqlY5TEaxk9MDPpeFJN2leo=;
        b=PqbFDdN9NL3vFIE7gfn2BtNeiRAvic76JW4+7jvyOAB+9IBMeMOIFLl8nx2A5GqyrZ
         leS2oupWiBl4ger3oaI7g2anOxYcXCdJ4d1gYkRi4TgaNRipFkQQIywu6Q1uu6p6OtgG
         8CbSfKw8DJAYL5pPzWWEmwLf3h61d6Olc70OnoAkc9/fOnqmzM4Rnp4eXLHmEPs97tVr
         SKJdKNQZ5GbxLudz9ZSOHZoWK+aQ7cJ98WvektrRCMmA4WkzkfewCnOhAzwYi4hXfnE9
         rOMELhNMMDJlrl0rtykIDU/rAlLZVNve1qh2WVpDUS1VZ4wmCxp0ayKvpmhht61XxrIX
         mFVQ==
X-Gm-Message-State: ANoB5plBUkVS3nxpT+cuCFXSBCTXxXrfVut33RRQJY50H+CjyuzIn8SC
        YKyB0SsvwylLae2FGTH04CcekQ==
X-Google-Smtp-Source: AA0mqf7qKN79UVZEaW0Ls76RahKulLM3pvcDvRzXwGVbF7i+MXNF8rKr0K5wWQE/acWibVQATBg9tQ==
X-Received: by 2002:a05:6a20:429a:b0:af:89c2:ad01 with SMTP id o26-20020a056a20429a00b000af89c2ad01mr1690943pzj.40.1671058110782;
        Wed, 14 Dec 2022 14:48:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b00172f6726d8esm2327431plk.277.2022.12.14.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:48:29 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:48:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Dan Li <ashimida@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Message-ID: <202212141448.03552F3@keescook>
References: <20220416001103.1524653-1-keescook@chromium.org>
 <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
 <202212072221.A9FCC905CF@keescook>
 <ba52dac5-2ce7-a567-41af-841b857abbed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba52dac5-2ce7-a567-41af-841b857abbed@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 05:34:41PM +0000, Kristina Martsenko wrote:
> Subject: [PATCH] lkdtm: cfi: Make PAC test work with GCC 7 and 8
> 
> The CFI test uses the branch-protection=none compiler attribute to
> disable PAC return address protection on a function. While newer GCC
> versions support this attribute, older versions (GCC 7 and 8) instead
> supported the sign-return-address=none attribute, leading to a build
> failure when the test is built with older compilers. Fix it by checking
> which attribute is supported and using the correct one.
> 
> Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
> Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Link: https://lore.kernel.org/all/CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com/

Thanks! Added to my tree.

> ---
>  drivers/misc/lkdtm/cfi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index 5245cf6013c9..d4bb8e31a2fe 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -54,7 +54,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>  # ifdef CONFIG_ARM64_BTI_KERNEL
>  #  define __no_pac             "branch-protection=bti"
>  # else
> -#  define __no_pac             "branch-protection=none"
> +#  ifdef CONFIG_CC_HAS_BRANCH_PROT_PAC_RET
> +#   define __no_pac             "branch-protection=none"
> +#  else
> +#   define __no_pac             "sign-return-address=none"
> +#  endif
>  # endif
>  # define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
>  #else
> 

-- 
Kees Cook
