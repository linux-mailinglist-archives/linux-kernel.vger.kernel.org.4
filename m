Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963363EC1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiLAJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLAJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:14:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0532655ABF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:14:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m19so1478650edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ+kWHZHwj+iACmb2u6Cu3JDoLA7ZyuXRVYodkgg1Bg=;
        b=gZmWK1FtAjVvJJ5FWTShzqLnADCXlyqM1RNaOW7Y2Fef+Lrz50KogMzXhYmJKgguEn
         fJYVwvYfdNhPv4hMbO7Tfe6j8hG+4xY7hVw+EY5VDz+j6eXx+OD8CnbChs6ZWNuEXL5j
         yS7ClHhuOlplJOt2lbo9uRJUJk6k+C7t+t5DK5FyL2kqI+lPFgN1LLRcJNoDjJONXegE
         90P450GiGm2bZbqTITkfRiK8585fo6fv+SyIm23aYQBdEQ8KyqvN8RtdeOeDQGpniqo4
         CpCtuJ9vKfdPp51EG8Lqj55JknIFTVdRI5RcES4TE3w8NgZr+Wg3Kcc9sIs3vKxUUSQL
         /Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ+kWHZHwj+iACmb2u6Cu3JDoLA7ZyuXRVYodkgg1Bg=;
        b=Ill2SjuEjMnJoA2bpgtYUlEgokw7+AiwXc5uQoXtNwHFEFGv/cKUtchmBtzwoeA7AC
         9uncOjEYqnuhT7vhXQetkWet5uV6wf8q4LwR8v4pVh7Uw9C7Nk7r4Lcf2vLijnXNhBIK
         nq3YN4gWzqSdBtFQ7wjimc0usdsvl9qJPES/Zu6nk0F+te4DIUWorGDKWzSLphPltBZ2
         jzxOab6DDeLgUdv5eWuQDvXzSNoX0Z9e4Fweake0wTCZ/an3EpCp8B9KVva8v7g17YCu
         PguwLUAQHEm07Y0TQpnWkIsOw5AkLz2DzYWrvQeDFADHo/b/oYdACgOlb6GzLCCmJO28
         2mOw==
X-Gm-Message-State: ANoB5pnm+XIcftBxpvc2OAFr8GBsron9g3HhVBN98mUtqiEQcUGVKxXR
        0DjYh4n9q3+bCWhXgDbgNibWgA==
X-Google-Smtp-Source: AA0mqf70unPfwc4AqZklJ4TK7P8phujtuTUWFR4aVjNeYQN4uWVpaaiuo2HgNhD5LaSrEbZsol3YIQ==
X-Received: by 2002:a05:6402:505:b0:46b:aa:856a with SMTP id m5-20020a056402050500b0046b00aa856amr20078382edv.171.1669886090590;
        Thu, 01 Dec 2022 01:14:50 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090632c200b0078db18d7972sm1511405ejk.117.2022.12.01.01.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:14:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:14:49 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Documentation: riscv: add a section about ISA
 string ordering in /proc/cpuinfo
Message-ID: <20221201091449.q5zyfb2ubsnh6slt@kamzik>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-4-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130234125.2722364-4-conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:41:26PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The RISC-V specs are permissive in what they allow as the ISA string,
> but how we output this to userspace in /proc/cpuinfo is quasi uAPI.

uABI

> 
> Formalise this as part of the uAPI, by documenting the list of rules

uABI

> we use at this point in time.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I've not "tested" these docs. The NIPA-esque pwbot should go and
> test it AFAICT. If it doesn't, I'll go add that.
> ---
>  Documentation/riscv/uabi.rst | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 21a82cfb6c4d..bc3c8ced644b 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -3,4 +3,46 @@
>  RISC-V Linux User ABI
>  =====================
>  
> +Misaligned accesses
> +-------------------
> +
>  Misaligned accesses are supported in userspace, but they may perform poorly.
> +
> +ISA string ordering in /proc/cpuinfo
> +------------------------------------
> +
> +The canonical order of ISA extension names in the ISA string is defined in
> +chapter 27 of the unprivileged specification.
> +The specification uses vague wording, such as should, when it comes to
> +ordering, so for our purposes the following rules apply:
> +
> +#. Single-letter extensions come first, in "canonical order", so
> +   "IMAFDQLCBKJTPVH".
> +
> +#. All multi-letter extensions will be separated from other multi-letter
> +   extensions by an underscore.
> +
> +#. Additional standard extensions (starting with 'Z') will be sorted after
> +   single-letter extensions and before any higher-privileged extensions.
> +
> +#. The first letter following the 'Z' conventionally indicates the most
> +   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> +   If multiple 'Z' extensions are named, they should be ordered first by
> +   category, then alphabetically within a category.
> +
> +#. Standard supervisor-level extensions (starting with 'S') will be listed
> +   after standard unprivileged extensions.  If multiple

nit: Seems like a short line, at what character are we required to wrap at
in this file?

> +   supervisor-level extensions are listed, they will be ordered
> +   alphabetically.
> +
> +#. Standard machine-level extensions (starting with 'Zxm') will be listed
> +   after any lower-privileged, standard extensions.  If multiple
> +   machine-level extensions are listed, they will be ordered
> +   alphabetically.
> +
> +#. Non-standard extensions (starts with 'X') will be listed after all
> +   standard extensions.
> +
> +An example string following the order is:
> +   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> +
> -- 
> 2.38.1
>

If this uABI hasn't "shipped" yet, giving us the freedom to discuss it
more, then I'd prefer we don't publish this (which looks like "shipping"
it) until we're 100% sure that this is the uABI we want.

(I feel like if we can still change the order in proc, as the previous
patch did, then we haven't yet shipped it.)

Thanks,
drew
