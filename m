Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E4698766
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBOVc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBOVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:32:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D027982
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:32:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so3761745pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kfYEghNnaEjUfoOcnZ4G0+8zAvGSYgSt957kdbuuys4=;
        b=d1rnikvOvf/SGy/v2+qrDhe4dbC1eCnXDz2MDCEFQFrQmdniFgCZOM0UH4WI+8mPwQ
         rlJUw1nQQEmDoXRV0zbXQF6kb7rEpfJHHVQHdB3XjGdjohKrW7Iwhl5w5fjc/7y68clN
         O0NbwwIz7iyeQ9gHUSU7DHnh/S+DprlGjeGqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfYEghNnaEjUfoOcnZ4G0+8zAvGSYgSt957kdbuuys4=;
        b=3CVLpsHTpHYWiwn8ru9vLAYCi72dUom1DQJvKjVGFGvVBdu+cLOqmrANWrlpLWXS9K
         dcnb5e3YXIOVU7G6j5nzjjeQU8a2B/cwf+ptZZvRQ1fJuOc1ueKwjRfD6kw0kMOKpWhF
         VXGo2MBtQKnex+sIzlmuPWUfNd4YYJJt1X2qsLVnIMg20ieGYDFBTDoOQpANzaazGmj5
         HrTjHGmOe07OY7t3q6WS5zeZoXYZHGdo7aVTlAHCSBZoJxvZ0jHMUmQOGhGx8cb1T7m6
         3/dJvufqj6WpqohDV9Ug9ZDH5xuAsxHZiCC461PGiAOuUfsRWoq+l2A33173UKTOJwTJ
         M7rw==
X-Gm-Message-State: AO0yUKU+hkq3r2bK5K857idIrmf8Cybj+oN8k7CQ6nOiGpnJkeXLBok+
        ifz7rJbzqIPsPdmKehmzx96HeGGhId48QN97
X-Google-Smtp-Source: AK7set+wTlRh8SP7In9F+w0tsSMTRd836XZmLAJXyqYif3yvQ2ETEmZh7wyNqIPWtp3PhiL6eWURgA==
X-Received: by 2002:a17:903:120e:b0:197:35fc:6a5d with SMTP id l14-20020a170903120e00b0019735fc6a5dmr4153057plh.30.1676496741565;
        Wed, 15 Feb 2023 13:32:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001991e4e0bdcsm12548670pls.233.2023.02.15.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:32:21 -0800 (PST)
Message-ID: <63ed4f65.170a0220.b2f75.8a8f@mx.google.com>
X-Google-Original-Message-ID: <202302151330.@keescook>
Date:   Wed, 15 Feb 2023 13:32:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] scsi: ipr: work around fortify-string warning
References: <20230214132831.2118392-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214132831.2118392-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:28:08PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ipr_log_vpd_compact() function triggers a fortified memcpy() warning
> about a potential string overflow with all versions of clang:
> 
> In file included from drivers/scsi/ipr.c:43:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __write_overflow_field(p_size_field, size);
>                         ^
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> 2 errors generated.
> 
> I don't see anything actually wrong with the function, but this is the
> only instance I can reproduce of the fortification going wrong in the
> kernel at the moment, so the easiest solution may be to rewrite the
> function into something that does not trigger the warning.
> 
> Instead of having a combined buffer for vendor/device/serial strings,
> use three separate local variables and just truncate the whitespace
> individually.
> 
> Fixes: 8cf093e275d0 ("[SCSI] ipr: Improved dual adapter errors")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Reproduced this locally -- I agree your fix looks like the best
approach. I think Clang was seeing the old "i + 2" return as potentially
overflowing in the case where there was no space-padding on any strings.

-- 
Kees Cook
