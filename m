Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A365AF8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjABK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjABK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:28:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C579110E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:28:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so20292639wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ruN1yQRxsJ2H59E/8nRfHXr5P9ik8d8Ya3T8OD5cP4=;
        b=NCpqguz+0+y298G1i+bRdhu158D23TS0/cFqbuEH9uaQ0xUap1ZpBLZQ9gTqcfUNAE
         6FoOcm05bcdewGnsvzm0wI856YwCuLFKF/0q6rNRH0jUUBlaRqcBVLgkc2Q5/8/SHwjj
         K0Ivu9ZbwVGPsZTZJsl+7ennV5+20L1y2NpbPbDwfkMJ0iIHNsKx44FPJfBGlol1ZhGc
         OEv0DKWdxu1TzgksH1BdqoTr0wa6VWSaSh1hfvOjM/2bukI+YKACWxuewYYS8Yo/hh2s
         02KtK1YiNp5WZeWS+8rCsVN86tyXOvsxrXgDJlJ98q7nstUXJ1cfombZJuH5xIBMH7L0
         IqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ruN1yQRxsJ2H59E/8nRfHXr5P9ik8d8Ya3T8OD5cP4=;
        b=djPlzY4Vb30/OP70NTGY8RGLXutwOPzB26HWKtok4WfI8Y1NXzE9NKZlZSUc3sKifO
         r2CfvrfJZB7RQWBY74ISaZ2e42KYKVhri0542R16zr9n0fZBtSpWgyvl0hirMaOQ+3c/
         WapvFV6sBAOnzJfOZVVihtCSzxf6Od0fK47A9MK4EpTYwFT2LPXw4pIeYgJTUVM9x0wi
         7t6uFGI90L7YHPYJcmwZN3sUeIaI1qa01pwLB4ycm8gb2HSpELBR6/Au4wWS3bP0pW8O
         k6w51veqG4pjl842X0Zh24kiWZOYo9TvCW55romKMZ8OeY0P166z+RIscf47MwQfcnLB
         0VVA==
X-Gm-Message-State: AFqh2kqtvPs5vscK7EeoErvvWtTLWblaOnreK2nelrQV33PLHQKJK2jf
        W+R84hJyXFfFYMOxn5VWvhdkow==
X-Google-Smtp-Source: AMrXdXs3+oHqTiwD20iKTyXrSC1Y9q660G6druCOcY5YaX+HRighIfyyIvAnMk8DvfwOGNKnLzrE/w==
X-Received: by 2002:a05:600c:12c6:b0:3cf:6926:2abb with SMTP id v6-20020a05600c12c600b003cf69262abbmr30868798wmd.7.1672655284796;
        Mon, 02 Jan 2023 02:28:04 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:6950:757d:cd6e:92aa])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003c70191f267sm45465878wmc.39.2023.01.02.02.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:28:04 -0800 (PST)
Date:   Mon, 2 Jan 2023 11:27:57 +0100
From:   Marco Elver <elver@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: mm/kmsan/instrumentation.c:41:26: warning: no previous prototype
 for function '__msan_metadata_ptr_for_load_n'
Message-ID: <Y7KxrfQ5FQmqVBAn@elver.google.com>
References: <202301020356.dFruA4I5-lkp@intel.com>
 <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 11:01AM +0100, Vlastimil Babka wrote:
> +CC kmsan folks.
> 
> I think it's another side-effect where CONFIG_SLUB_TINY excludes KASAN which
> in turn allows KMSAN to be enabled and uncover a pre-existing issue.
> 
> On 1/1/23 20:10, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e4cf7c25bae5c3b5089a3c23a897f450149caef2
> > commit: e240e53ae0abb0896e0f399bdfef41c69cec3123 mm, slub: add CONFIG_SLUB_TINY
> > date:   5 weeks ago
> > config: x86_64-randconfig-a013-20230102
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e240e53ae0abb0896e0f399bdfef41c69cec3123
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout e240e53ae0abb0896e0f399bdfef41c69cec3123
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash mm/kmsan/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> mm/kmsan/instrumentation.c:41:26: warning: no previous prototype for function '__msan_metadata_ptr_for_load_n' [-Wmissing-prototypes]
> >    struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,

Probably needs a fix similar to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dd979bae4cf76558ff816abe83283308fb1ae8c
