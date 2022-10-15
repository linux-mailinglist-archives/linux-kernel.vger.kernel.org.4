Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418105FFB31
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJOQ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJOQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:26:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DE3E761
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:26:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so11963324wrm.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNKwwUuvrgZ46xwoGGuVcYvN6TXI2tCIVd9WU2CVGOQ=;
        b=JluM3QD05PT6gVppLGJyJaOsBmS9w+f9HdZ/rv1gXA30MjMECsYItnh96r7BPeN6Vc
         Q/lON8XcAThALGZmSrjIRUYbDxj6YSCnMpXCR5IBuLFyEMxRmfOHoFmo/eK7zCthY0Pe
         71lrRasStpjrlwiWcvqsw8OV8TzK2XyRGGOBoUQxTBWRP0lkT8hBKaYhK3jDcYxUEdJF
         UTGvq4ubkjR0/6jQ0QfhhtRk3uM0gkSS7vk/NnC+ZsYmHNb/VQsY29DfOX9Tm9pr0oSf
         2tIPpp0UhZn8Hrsy9n3Ejt5mrOZcI+xD/d9EAuOKBSYdzn6tkqkl+q3WuBE9WQ+J9TYs
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKwwUuvrgZ46xwoGGuVcYvN6TXI2tCIVd9WU2CVGOQ=;
        b=biaHpt00AaSMY5delHl0TvtoH5ce50GpQlb84HtLMD8XRaZbOEB9TjYrFsNYWaf/QZ
         Tv5JlVl+fqPZtNodA+EN8cYeHjY2rTk/Ks8dj2IU0VXXjFqnqpH+JRdpL2MMw7zI0Aw7
         1dCyaYT1bU3mFVE2pA05Cqd6Kq6Vg60bADIBbtVtjcu7iLz+hVKcNV29F/ib/xuZHf+7
         nEKRZoQGO6NPsf/TFxgbtaGKArFB7LjP+b0Cx3ygMURAYi5NYlUNkK3wPByax6jhMyPU
         tBRg893ejhDlRtyKe44Eo4KkzV/8kdhCwfbiKEByiSRnjOD+1JjTettv0W7U5yJTx34U
         VI3Q==
X-Gm-Message-State: ACrzQf2zvVf3A0ZdN/VFH1/+sogtqfxmkZBPl3xsTeSsmASQVrQV92o4
        Iz37piR+AwUB5kaO7RqMF2sPxxZDZJE=
X-Google-Smtp-Source: AMsMyM71VpkOhoy31kwvj7hvjMDnCb6bByCRJVgIqksFM6+DvDOk642WbK3ppITSUWEeZzLHarGR3g==
X-Received: by 2002:a05:6000:178e:b0:22e:6d9f:1592 with SMTP id e14-20020a056000178e00b0022e6d9f1592mr1917812wrg.6.1665851158988;
        Sat, 15 Oct 2022 09:25:58 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm5204196wmz.34.2022.10.15.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 09:25:52 -0700 (PDT)
Date:   Sat, 15 Oct 2022 16:25:51 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 openrisc
Message-ID: <Y0rfD8y9m54Zrc4C@oscomms1>
References: <20221013214637.30893-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013214637.30893-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Thu, Oct 13, 2022 at 02:46:37PM -0700, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.

Thanks, I will queue this for 6.1 right away.  I saw you originally had this as
a mega patch now split it up.  Either way is good with me, ghouth taking this
on.

> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 796ba37dd4ff..9a9ca93b63fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15234,7 +15234,7 @@ M:	Stafford Horne <shorne@gmail.com>
>  L:	openrisc@lists.librecores.org
>  S:	Maintained
>  W:	http://openrisc.io

FWIW: Our website should be https:// too.  I will sumbit a patch for that as
well.

Stafford

> -T:	git git://github.com/openrisc/linux.git
> +T:	git https://github.com/openrisc/linux.git
>  F:	Documentation/devicetree/bindings/openrisc/
>  F:	Documentation/openrisc/
>  F:	arch/openrisc/
> -- 
> 2.38.0
> 
