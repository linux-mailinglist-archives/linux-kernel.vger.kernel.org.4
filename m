Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB975C046F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIUQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:39:59 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F805A3D7F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:26:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g23so4489623qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OGtVaFbmvkKkr8Xz9aWusHyXLSvDGZfPxyBLLNJ4Svg=;
        b=HCE22T6O3dEFzy3SRcoWu+OWKHf/h35XioF9ZJtwykxpazwiP175GSyS44xH/PMrHo
         gYj0Cll9loczdPaqfJicSFKtHCSQT8ayKDfSTgpt25XwpC5+OCg3cN3ZXnziLAB5hUxe
         OwQ70+4rBMDiHQfH315DgJ58FjopaKx4mbOwwyyl7C4KLAZyKbQ/1trpofNqt0LwBs6T
         UeXAHHEtXuQR2WPFMl2MCwQ4O/Bz4Nd3DIvEyKLae8GuNMY+NDevudvzH4TW92vvPWn5
         MNrtLxBkDPtTnrtWdbhPteFPMPUwuASKSIekm4jb3EkZl7vzrRq7Ig712b5/l1FQCUXu
         bTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OGtVaFbmvkKkr8Xz9aWusHyXLSvDGZfPxyBLLNJ4Svg=;
        b=Zp6IKyXBwjqigIz/ZcbyN5H9YJlIxcy9boXo6DCQ54WFZq0lWNofYt9yccxnfZK5uH
         ZtoOOjCyBt8IvxN/SBkHhexA2Hy24pwHWl03QKbqqGizgmCMPIW0bwt2QuJOTe9jQJz7
         hTn1GM0ymdxe54cnhw9lpyEaFTF1wZYbUewX2y07y2+6XUudTyAdQHvF7O1xWkwfztpB
         5ylTcd7lI8vsSRWYgZn4g27R40fsTeItXj1BD4xAkHbw6IPnGVJmbj9sprYFBJivIvFL
         JZdAp2HxKtkEfsjceLxSDURR8vkA/wQp+oNNdQSug4Dtx3kEP30HxUiIJJm6oBvqduzv
         rl0A==
X-Gm-Message-State: ACrzQf1t5ECZDJ6E08eACX6+sRiV1KTRrmIzJ0p+qrGBQ5EjtSv19yKQ
        yspSZrIGu8ECH2iG3Wqywkpl7A==
X-Google-Smtp-Source: AMsMyM7vYpTjlRzbEegvszJlI4tNQCZauY7gMEN5zAe8S7T1/Xq146dS3OoUNQyhWNporBG6sBkpow==
X-Received: by 2002:ac8:7d92:0:b0:35c:be77:5e2b with SMTP id c18-20020ac87d92000000b0035cbe775e2bmr23897430qtd.505.1663777591242;
        Wed, 21 Sep 2022 09:26:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f3-20020ac81343000000b00346414a0ca1sm1899053qtj.1.2022.09.21.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:26:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ob2YQ-0014AS-3y;
        Wed, 21 Sep 2022 13:26:30 -0300
Date:   Wed, 21 Sep 2022 13:26:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     longli@microsoft.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, edumazet@google.com,
        shiraz.saleem@intel.com, Ajay Sharma <sharmaajay@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [Patch v6 12/12] RDMA/mana_ib: Add a driver for Microsoft Azure
 Network Adapter
Message-ID: <Yys7NoXN45IVD67O@ziepe.ca>
References: <1663723352-598-1-git-send-email-longli@linuxonhyperv.com>
 <1663723352-598-13-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663723352-598-13-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:22:32PM -0700, longli@linuxonhyperv.com wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b9a50756c7e..7bcc19e27f97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9426,6 +9426,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Wei Liu <wei.liu@kernel.org>
>  M:	Dexuan Cui <decui@microsoft.com>
> +M:	Long Li <longli@microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> @@ -9444,6 +9445,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
>  F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
> +F:	drivers/infiniband/hw/mana/
>  F:	drivers/input/serio/hyperv-keyboard.c
>  F:	drivers/iommu/hyperv-iommu.c
>  F:	drivers/net/ethernet/microsoft/
> @@ -9459,6 +9461,7 @@ F:	include/clocksource/hyperv_timer.h
>  F:	include/linux/hyperv.h
>  F:	include/net/mana
>  F:	include/uapi/linux/hyperv.h
> +F:	include/uapi/rdma/mana-abi.h
>  F:	net/vmw_vsock/hyperv_transport.c
>  F:	tools/hv/

This is not the proper way to write a maintainers entry, a driver
should be stand-alone and have L: entries for the subsystem mailing
list, not be bundled like this. If you do this patches will not go to
the correct lists and will not be applied.

Follow the example of every other rdma driver please.

Jason
