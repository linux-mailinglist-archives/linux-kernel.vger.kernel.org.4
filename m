Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD1704A88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjEPK2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjEPK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3A469E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684232868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MjdPblvsubV0ZcmrPIsBIv52NXZV0pYrbN1nLC8pk0=;
        b=X6HJO6LdEADaXN5aF89vbbaUBv0UYcmTgnxq7F4q91a+qhvQz0B3bui/aKcq8eh5CAkop/
        x06fYzi2NgT13T9WjVv7X0lB1PXYqU0ZuOtKrYm5lBNkdC1r/ytKxRuj9yUQ1H2xHC7A+G
        gpXSnJ88BVaVlzIX4b2QTjI7hbneiA4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-eW2To5DcMga7DkkFDQu4ng-1; Tue, 16 May 2023 06:27:45 -0400
X-MC-Unique: eW2To5DcMga7DkkFDQu4ng-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9532170e883so1780233166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232864; x=1686824864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MjdPblvsubV0ZcmrPIsBIv52NXZV0pYrbN1nLC8pk0=;
        b=IdCuoZvthgjlVi2BR0o4BR9cgxHEBgem+MiLutJ0TID4J/oDyPaUX1T3HEKQBRaoiJ
         jB4Z6EnQX4Y2Wmcugkv7LziqPZ/ZyNuv8Fuh8xqdLL91dvSl2ucWJWMrbY7OJo1C1xUr
         AQ0Y6exoLzqMSoSTOv6YGcoVCjlHAmZr7Pl9t9FoRtiP2RNz0OK2MPEB8xWN56z6CO5b
         7U48M0wIvYnwDdQobSUimtU+4418SvFJpPfjnYgeqCmRHT7UrEdW+WAFRS/bqr/b6koY
         Jv9GiCymY2guLS2SW6tA2XkHyAAwplTBDYJiWSSAy4xTWVspBz9JkR8sWMjo4szvsG6D
         f14A==
X-Gm-Message-State: AC+VfDwCQQgqyYpe/VWdS3922psAiC1HpBDqaF3d4qMTyXlSRc4uc2Wd
        2Mih1VdFwzPXoYgc18SadTpMSqCNSTk5711nWMXxOuWmAB37PPwNAG4AEDMyJl9pJ4Y6ReRg7c3
        S9EW0ozeRtrPzGC2rbRkZ30cQ
X-Received: by 2002:a17:907:7f18:b0:966:7a0a:28ae with SMTP id qf24-20020a1709077f1800b009667a0a28aemr30201631ejc.22.1684232864135;
        Tue, 16 May 2023 03:27:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7beuUFxcuFNfIzXC8AEPhTYQHtBurcsN01BGYToHqbHsyPizkh6M7o82Mm3z5SaeL3If4Uqg==
X-Received: by 2002:a17:907:7f18:b0:966:7a0a:28ae with SMTP id qf24-20020a1709077f1800b009667a0a28aemr30201614ejc.22.1684232863792;
        Tue, 16 May 2023 03:27:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906838100b009662b4230cesm10999703ejx.148.2023.05.16.03.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:27:43 -0700 (PDT)
Message-ID: <56f2f65b-150d-3cf6-95f9-2dd8232d2717@redhat.com>
Date:   Tue, 16 May 2023 12:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: drivers/platform/x86/apple-gmux.c:276:15: sparse: sparse: cast to
 restricted __be32
Content-Language: en-US, nl
To:     kernel test robot <lkp@intel.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202305161712.5l3f4iI4-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202305161712.5l3f4iI4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/16/23 12:16, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> commit: 0c18184de990e63f708b090bcb9fc6c0fbc427cd platform/x86: apple-gmux: support MMIO gmux on T2 Macs
> date:   9 weeks ago
> config: i386-randconfig-s001-20230515
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c18184de990e63f708b090bcb9fc6c0fbc427cd
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0c18184de990e63f708b090bcb9fc6c0fbc427cd
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305161712.5l3f4iI4-lkp@intel.com/

<snip>

> vim +276 drivers/platform/x86/apple-gmux.c
> 
>    265	
>    266	static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
>    267	{
>    268		u32 val;
>    269	
>    270		mutex_lock(&gmux_data->index_lock);
>    271		gmux_mmio_wait(gmux_data);
>    272		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
>    273		iowrite8(GMUX_MMIO_READ | sizeof(val),
>    274			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
>    275		gmux_mmio_wait(gmux_data);
>  > 276		val = be32_to_cpu(ioread32(gmux_data->iomem_base));

Ok, so sparse does not like this line.

>    277		mutex_unlock(&gmux_data->index_lock);
>    278	
>    279		return val;
>    280	}
>    281	
>    282	static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
>    283				       u32 val)
>    284	{
>    285		mutex_lock(&gmux_data->index_lock);
>  > 286		iowrite32(cpu_to_be32(val), gmux_data->iomem_base);

Nor this line. But this is what we want (convert to/from be32 to CPU
when reading/writing).

There is iowrite32be() but that always unconditionally swabs
the byte order independent of the CPU byte-order.

Now this is an x86 driver so always swapping is fine, still
I wonder if there is a better option here then using
iowrite32be() and ioread32be() ?

Regards,

Hans




>    287		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
>    288		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
>    289			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
>    290		gmux_mmio_wait(gmux_data);
>    291		mutex_unlock(&gmux_data->index_lock);
>    292	}
>    293	
> 

