Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35E74D956
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjGJOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGJOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:54:16 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39643BC;
        Mon, 10 Jul 2023 07:54:15 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso95944639f.1;
        Mon, 10 Jul 2023 07:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689000854; x=1691592854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knPR9yYz2WPKjMufisii9UreVZbTEUXAVqzrTii1/pc=;
        b=iB2P/liM2qawVfb9Mg8keb3ejKKJLhkE80DwSaDp8wfgTRiH5J+NPxsK/ovH+lSYA8
         k37yq30ka8a7/hUBeY85uZ+DOUFKaEr2swKFxU8ZWPDgt3lujjZHbJUo0Yw/ZrmIxjXa
         uEoxitcrAcecgpf7hTCHgDmT+nnytQZ18Ptc+7qUPU4OJ9qscWdVM6e3jZ2Sy0IR/Rvz
         llpGEo5H5tC/hstM86lg7/G12C+y7IzMfS35sy06HRPAi2639Q2g+haejUDW7XW8cG6+
         T8wks9DrZ522kfT9ZvNcPjeO4CYgeut85F89MgyIVmLSu0TFSdeC/XFgza5VnE58lT6f
         nAGQ==
X-Gm-Message-State: ABy/qLb6nz6qo82ndIID0aKEBQqeicQj+wQ1yGbTFFOoGgY1/YAbHxi2
        /K5gEXRn8bmeVh3Jgm+Arw==
X-Google-Smtp-Source: APBJJlGPm/9hK472s8BUH0Uh4raLcJ8oAan5K6rZW4ED77sMyiI/8jfWetBwTIUn6yLeXrs3JcbMWw==
X-Received: by 2002:a6b:e817:0:b0:783:63d6:4c3 with SMTP id f23-20020a6be817000000b0078363d604c3mr6441287ioh.10.1689000854497;
        Mon, 10 Jul 2023 07:54:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a22-20020a6b6616000000b0078702f4894asm1629889ioc.9.2023.07.10.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:54:13 -0700 (PDT)
Received: (nullmailer pid 1959292 invoked by uid 1000);
        Mon, 10 Jul 2023 14:54:10 -0000
Date:   Mon, 10 Jul 2023 08:54:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     devicetree@vger.kernel.org, mturquette@baylibre.com,
        kernel test robot <lkp@intel.com>,
        Jonathan.Cameron@huawei.com, maz@kernel.org, vkoul@kernel.org,
        dragan.cvetic@amd.com, edumazet@google.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
        frowand.list@gmail.com, eli.billauer@gmail.com,
        derek.kiernan@amd.com, kuba@kernel.org, sboyd@kernel.org,
        schnelle@linux.ibm.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, arnd@arndb.de, pabeni@redhat.com,
        davem@davemloft.net, linux-mm@kvack.org, akpm@linux-foundation.org,
        linux@dominikbrodowski.net, gregkh@linuxfoundation.org,
        joyce.ooi@intel.com
Subject: Re: [PATCH 8/8] of: make OF_EARLY_FLATTREE depend on HAS_IOMEM
Message-ID: <168900051598.1946989.3367114616050746231.robh@kernel.org>
References: <20230707135852.24292-1-bhe@redhat.com>
 <20230707135852.24292-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707135852.24292-9-bhe@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 21:58:52 +0800, Baoquan He wrote:
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=n, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
> 
> In LKP error report at below on s390:
> ------
> ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
> coherent.c:(.text+0x102): undefined reference to `memremap'
> ld: coherent.c:(.text+0x226): undefined reference to `memunmap'
> ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
> coherent.c:(.text+0x8b8): undefined reference to `memunmap'
> ld: kernel/dma/coherent.o: in function `dma_release_coherent_memory':
> coherent.c:(.text+0x9aa): undefined reference to `memunmap'
> ------
> 
> In the config file, several Kconfig options are:
> ------
> '# CONFIG_PCI is not set'
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_DMA_DECLARE_COHERENT=y
> ------
> 
> So, enabling OF_EARLY_FLATTREE will select DMA_DECLARE_COHERENT
> and cause above building errors even though they are not needed
> because CONFIG_PCI is disabled.
> 
> Here let OF_EARLY_FLATTREE depend on HAS_IOMEM so that it won't
> be built to cause compiling error if PCI is unset.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/of/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

