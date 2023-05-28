Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3595713810
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjE1G2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1G2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537DDF
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685255245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd1HsDPoIQCA1W8M9wRkc4OBlzVkt6/Jqm85Xt985zA=;
        b=VoAnEOLvwQPpXS7B1WHtXlhuhwwb8FtoIkCfqONequm3c0nt43u38jndYC3IzGvBzZddwI
        PK6vwicUSxnFkmcECyV6RKj+R0SbDdzShYT/AKvVoDCzDGjiKOQIOCpXJ78N909NUlBYHV
        8P9YwER4v8rKONczqqfAw0gJc4cqyaU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-GH7Y7CzhNHOCgUqot4c1Eg-1; Sun, 28 May 2023 02:27:24 -0400
X-MC-Unique: GH7Y7CzhNHOCgUqot4c1Eg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30a88dc5d9fso1257939f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685255242; x=1687847242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd1HsDPoIQCA1W8M9wRkc4OBlzVkt6/Jqm85Xt985zA=;
        b=EQqXBHBJtKb0njBZn4EoIGxqQibEjKe9u3SV3UHFB9Ue9CfEJWELQiMXxHZhroXSOk
         WH5WeCmufpOC+gnMCVbtnF5LIQt9P0/p2Bd/ocUKIv7ZOMIFkaPGOyRivkt6tRIhmmVy
         PJy4m6ydg3HkrxDxHiuddlM+AFyW0w40fhGW0jL7JyyByEWu2ZvzuD6gM2laI1J6itHC
         dh034Ic6lkU1Im0/PwE9HEeewfJiEGnHhW+dg53hWTO7ad/iQWcr4L7CN9zUcjfDveOK
         ulSh9WSni2X3M2IaUSEKDHnKmyR+aTExV7lZ6dyJEbedh5eN3X+BMmiresI0TSt0rhOz
         3CTA==
X-Gm-Message-State: AC+VfDwwMhz1F2bjwF7ZTLQN4H1hDlhxrZovPy80HQqFlvqwG/tI/8zU
        jKJhcU4OeHtA8YH53ou8yoaARb2mQzN+x+lBc6X3SuvCUJq6wovrEsT8WjZpkWK9eNpJgnL1TQp
        S5k0XkF4IYER10auIR4nzMImenRvDLLvu
X-Received: by 2002:a5d:4746:0:b0:307:a36b:e7b1 with SMTP id o6-20020a5d4746000000b00307a36be7b1mr6251103wrs.5.1685255242762;
        Sat, 27 May 2023 23:27:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45TZmWQVMRhP5RvxBOirJj2cEFa5HQb7lqFSHk19mNXmZUM8pT5LmgfgqJSeZVjSeHHK6LuA==
X-Received: by 2002:a5d:4746:0:b0:307:a36b:e7b1 with SMTP id o6-20020a5d4746000000b00307a36be7b1mr6251097wrs.5.1685255242491;
        Sat, 27 May 2023 23:27:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id q1-20020a1ce901000000b003f423dfc686sm10083677wmc.45.2023.05.27.23.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 23:27:21 -0700 (PDT)
Date:   Sun, 28 May 2023 02:27:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
        oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <20230528022658-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-2-liangchen.linux@gmail.com>
 <202305262334.GiFQ3wpG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305262334.GiFQ3wpG-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 12:11:25AM +0800, kernel test robot wrote:
> Hi Liang,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230526054621.18371-2-liangchen.linux%40gmail.com
> patch subject: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230526/202305262334.GiFQ3wpG-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/bfba563f43bba37181d8502cb2e566c32f96ec9e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
>         git checkout bfba563f43bba37181d8502cb2e566c32f96ec9e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305262334.GiFQ3wpG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: vmlinux.o: in function `virtnet_find_vqs':
> >> virtio_net.c:(.text+0x901fb5): undefined reference to `page_pool_create'
>    ld: vmlinux.o: in function `add_recvbuf_mergeable.isra.0':
> >> virtio_net.c:(.text+0x905618): undefined reference to `page_pool_alloc_pages'
>    ld: vmlinux.o: in function `xdp_linearize_page':
>    virtio_net.c:(.text+0x906b6b): undefined reference to `page_pool_alloc_pages'
>    ld: vmlinux.o: in function `mergeable_xdp_get_buf.isra.0':
>    virtio_net.c:(.text+0x90728f): undefined reference to `page_pool_alloc_pages'


you need to tweak Kconfig to select PAGE_POOL I think.

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

