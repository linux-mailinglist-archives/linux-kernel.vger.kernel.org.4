Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D6638BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKYOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKYOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:00:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0D1B7B9;
        Fri, 25 Nov 2022 06:00:42 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so2577849qts.1;
        Fri, 25 Nov 2022 06:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTd5mVVHCF+VFulP23dkKuZNRYz38s8pGtAz4nT89ug=;
        b=jIkLeN5mrO9vTaEI7X57jj1BAXj3B+yN/pSig49ncDPgs4/0AAxA/trmoPfRKgR8SO
         na8N7BisR3BxuL40l5jcInmjKwFVnwVKPye7xDRr90CS38rBssG1NASDcvio5YXJpz1L
         NeHI/KwzyvDG8w5Amm1JhPfLsCtucVh5u6uaoLIqYln81yvN+TP0J+7+gvjHWzF9wvXc
         Zj8rLX0kP8r67ljQmmxbko1dYXI85hl/5IUnuBfyT8OOax5Z04PgmRxrpNqJ4fvf8ded
         CcJgGwvsdMWA7pQdH3sZS+jyF88OZZLnxKUZP6OFyuuvHb2emJt9wXMUWzjQSw9rG9pV
         dp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTd5mVVHCF+VFulP23dkKuZNRYz38s8pGtAz4nT89ug=;
        b=cC91UenGWZs/xhDcOBrEN+rDKZ0Xh+gxn4ZxxJ87U/nI/3037qbTt/W9QTRgMZ9M8C
         Kqo3KykWYxxVqDHh9NrNMBU8Zj3umg3psk3nCBdZ/gixMxLFIz/+TklMZ+rHJBt0CqdE
         5tp2RULe21KbnfPscA336rsrMmy544IidpLyfmkmwLn8MriAcMIYezG7/jmRemifNTWi
         fjUpFQ49J4VMHEEmR+Pa8tXY/Z5BkPazzlDFXaHhawTaMC23EzsGlg+/PGf46B4iHiJB
         GI38XugXvIOKa4/xiVPHAMsVuuCe2xQaz5k2jK9J/kckF+SvQIFOVfW0pYpNFR6+aBDE
         +jDA==
X-Gm-Message-State: ANoB5pkPoBMKxVlj9x1ONMyJf1OUm6nLqOraUVx2lpRXCcY2QsD4sjTU
        cyaaCIWSskE/kTamH/jfT6pi61sKZqE=
X-Google-Smtp-Source: AA0mqf58O+xDlueDQCaKFrh/tATkxwUXqjrwvMkaYr58aK5cZ2HAACp+edohGBT7P21mM3II9Rq0gA==
X-Received: by 2002:ac8:4802:0:b0:3a4:f056:1e81 with SMTP id g2-20020ac84802000000b003a4f0561e81mr18262600qtq.229.1669384841312;
        Fri, 25 Nov 2022 06:00:41 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id r139-20020a37a891000000b006e42a8e9f9bsm2740936qke.121.2022.11.25.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:00:40 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:00:39 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: liteuart: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <Y4DKh3/JHjj+pbYf@errol.ini.cmu.edu>
References: <20221125142756.3e51a28d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125142756.3e51a28d@endymion.delvare>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 02:27:56PM +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--G
 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.0.orig/drivers/tty/serial/Kconfig
> +++ linux-6.0/drivers/tty/serial/Kconfig
> @@ -1519,7 +1519,7 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
>  config SERIAL_LITEUART
>  	tristate "LiteUART serial port support"
>  	depends on HAS_IOMEM
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	depends on LITEX || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
