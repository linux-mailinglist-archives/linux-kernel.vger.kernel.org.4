Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D957767837F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjAWRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjAWRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:42:45 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1829408;
        Mon, 23 Jan 2023 09:42:42 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i185so13767754vsc.6;
        Mon, 23 Jan 2023 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGWIu9K4UcSFLqrrHmOv0/+CrooEl9yB5aeR+zgz0J8=;
        b=Sv/Om1Jfyc6ZLLbWT74tGxalqp1IxGF9s2AeRJyO2ZCSO0PlnXgvpeMp0lKpMWsTlg
         9sF6w4Q7vwVHv5JNtnPrLdGIfkIxMM22TfbeIBpXB4bReiznOVM1/ijQ4d/hs7koW4wC
         l+W7o33q5szypaOrXH5Jb1f4kxc3ZJOqB0k9ScE8GhOpKMjwXjxLUSAzF2ch4a5JDj/I
         bUgQsHxyZ1EPgW3+Xn9Xsjbw6uCNUerfHIf3wNwPb/mbw6Mt+Iy+W8jTBlMgYfGT46qJ
         LCE2A655FGVjjtRlpx1xDgBuzzM0oe1Vz2f1hsWiYAqKyevgO2UUb4Q83z+EJg5AiWfL
         Pavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGWIu9K4UcSFLqrrHmOv0/+CrooEl9yB5aeR+zgz0J8=;
        b=5NhDspjkmQ+Kxpv5ZNEeBAR46QYlzNc7fEzTCTjCDLkOFx7n9KL77ogqMS5rHZOe9a
         9dDTq9I5BCSLqvwHlOQ9V3vLcnnhsX73GAmYUgn4xeMg/EeSe6R/TnwefjawEKIP+DfP
         Gf/f46hRU1dx4Wjp84xaBC/WYkXSvZrZMfoL+o6+UOeJWIs4UlaigyfjNDU5zIXzPeN5
         /pAY5MwsSnPRbIoxJ1hMvOYfoZCrf8hXF8PkBl0/Mf88g/d6w7FzENxQE8yPMo8x38c2
         SnM08ycQZyFQyVELEgCRX+oZNROou+Px5Ks/0Szp7MhVUBatFZzcJho5m3wXyWT3PUSR
         Ge9A==
X-Gm-Message-State: AFqh2krJ6kFMD/PxVUio86EChnLQbfKGwWCIoc5rtGGq4zBBpC+Q6iCW
        NW+qC3Rtey9xAsiSPGrGbNk=
X-Google-Smtp-Source: AMrXdXs05vPc4L7PeW2St5ykNMD7MiePuu0nF/qAPc6amyhZE9km1V6+KUJ8xTliL54vHMiSYlrNww==
X-Received: by 2002:a05:6102:2998:b0:3ce:88b3:d7d8 with SMTP id dl24-20020a056102299800b003ce88b3d7d8mr13981539vsb.19.1674495761922;
        Mon, 23 Jan 2023 09:42:41 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm15682689qkj.58.2023.01.23.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:42:41 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:42:39 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 2/2] serial: liteuart: Correct error rollback
Message-ID: <Y87HD7kEVp5mO/85@errol.ini.cmu.edu>
References: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
 <20230123173857.40695-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123173857.40695-3-ilpo.jarvinen@linux.intel.com>
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

On Mon, Jan 23, 2023 at 07:38:57PM +0200, Ilpo Järvinen wrote:
> Goto to the correct rollback label instead of directly returning.
> 
> Fixes: 5602cf99dcdc ("serial: liteuart: add IRQ support for the RX path")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/liteuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index ef557d59e4c8..192ad681de35 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -313,7 +313,7 @@ static int liteuart_probe(struct platform_device *pdev)
>  
>  	ret = platform_get_irq_optional(pdev, 0);
>  	if (ret < 0 && ret != -ENXIO)
> -		return ret;
> +		goto err_erase_id;

That was my mistake, sorry, and thanks for the super-quick fix! :)

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

>  	if (ret > 0)
>  		port->irq = ret;
>  
> -- 
> 2.30.2
> 
