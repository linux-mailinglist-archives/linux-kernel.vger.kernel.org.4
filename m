Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65636B1026
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCHRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9C22025
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678296276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPQJ89LugumAZFsgY4YTmoOcQfUcQJ8Obmpk4rX3dbQ=;
        b=RpmnDQPlZC+sRew7pi/JdyZUKF2rvMqHA4jAALOVJXvy0uBnqJn/5vptvhMdA+ikU0esK/
        tezTKnt2KFQIrqIdWDEN/kSSaH6iRReP5d8zexbU+MUlqchPF/BG7s8t3cZBpKEIKxbib1
        moA0kM67x/4IY8C2Nh2MVA0AEdblvwo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-PLIFhnJlNoq1JWbK46fUcg-1; Wed, 08 Mar 2023 12:24:34 -0500
X-MC-Unique: PLIFhnJlNoq1JWbK46fUcg-1
Received: by mail-qt1-f199.google.com with SMTP id g13-20020ac8124d000000b003bfba5d76a3so9504679qtj.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPQJ89LugumAZFsgY4YTmoOcQfUcQJ8Obmpk4rX3dbQ=;
        b=0PJXYlRNXbnmrQXnMARb7dlNXX2CLUptsGZ4uCAUeYyEiCBpdxuVHz1Tc6C4LCl5iz
         RNGfFXHQkba6fe4d+79YlDi45I3hCtm61vzQ9jTf5+ORmlGBroj8HwIUWIQYcziSJKZz
         SvzgSpLSz4upJcRCmvY6GSKnqwHwcMjKCfA8AsTAVSz2mIbN/kR82S4B6FTcC5EuFHMV
         Ijcsk8++fenH73P1Uetbw9A0DyfDHjB/Q6+zRDvItK4EFLCn7snSKFDJbvHCHXvBCs+g
         1oXO2X9ySjqzWix9DykM41sF/UKYFDPrAHm5J4m9iDuUEvfQRmUEBsC4VXAzUX1p1x11
         25hg==
X-Gm-Message-State: AO0yUKU+Fb3V/kgCl0N+sLnEuSKdtO5bVYLJ1JfJMnqaN92yxvSKHYbj
        GJW7UbgmC4IW3HIeufNN4nyIlkE7dli871depP6uNsUmAfDt0/AVM6LCDnK00EbesIasxk35ZP4
        WOANWMi8NfnW8Bnj09AqEoENU
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id f28-20020a05622a1a1c00b003b86788bf25mr31680506qtb.23.1678296274308;
        Wed, 08 Mar 2023 09:24:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/O2FzdqotFaGnCpsXoZJ+sIqm3xrIxOl15eWdAqcdkdwA+CLA5ctetlB0UcvXYkd3YXuF88g==
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id f28-20020a05622a1a1c00b003b86788bf25mr31680478qtb.23.1678296274062;
        Wed, 08 Mar 2023 09:24:34 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8429a000000b003b8484fdfccsm12094243qtl.42.2023.03.08.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:24:33 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:24:31 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Message-ID: <20230308172431.pcjyhc2dq6geuk76@halaney-x13s>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:44:01PM +0100, Johan Hovold wrote:
> This series fixes some of the fallout after a recent series adding
> support for DMA transfers to the Qualcomm geni serial driver.
> 
> Most importantly it fixes a hang during reboot when using a serial
> console and the getty is stopped during reboot.
> 
> Doug just posted an equivalent fix here:
> 
> 	https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> 
> but the commit message only mentions the regression with respect to
> kgdb, which is not as widely used serial consoles generally, so I
> figured I'd post my version for completeness.
> 
> Either version of that fix should address the immediate regression, but
> fixing the underlying problems which have been there since the driver
> was first merged is going to be a bit more involved.
> 
> The rest of the series fixes a few bugs in the new DMA support that I
> found while investigating the console regression.
> 
> Johan
> 
> 
> Johan Hovold (4):
>   serial: qcom-geni: fix console shutdown hang
>   serial: qcom-geni: fix DMA mapping leak on shutdown
>   serial: qcom-geni: fix mapping of empty DMA buffer
>   serial: qcom-geni: drop bogus uart_write_wakeup()
> 
>  drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.2
> 

Realized this has been affecting me (with me blaming it on something
else prior) off and on. Thanks for the fix!

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride

