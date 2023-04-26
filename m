Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3E6EEDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbjDZF7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZF7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:59:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5D2681;
        Tue, 25 Apr 2023 22:59:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1prYBY-0003p8-9c; Wed, 26 Apr 2023 07:59:24 +0200
Message-ID: <872f3ba1-1771-2ef4-1353-4cadd92eb5e1@leemhuis.info>
Date:   Wed, 26 Apr 2023 07:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: build failure from drm/ttm commit now in mainline (was: linux-next:
 build failure after merge of the drm tree)
Content-Language: en-US, de-DE
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Justin Forbes <jforbes@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230411164714.2ce79bcb@canb.auug.org.au>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230411164714.2ce79bcb@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682488776;d38ea619;
X-HE-SMSGID: 1prYBY-0003p8-9c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo!

Sometimes the regression tracker runs into regressions himself... :-D

On 11.04.23 08:47, Stephen Rothwell wrote:
> 
> After merging the drm tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified 'global_write_combined' at file scope
>    73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
>       |                             ^~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/ttm/ttm_pool.c:74:29: error: variably modified 'global_uncached' at file scope
>    74 | static struct ttm_pool_type global_uncached[TTM_DIM_ORDER];
>       |                             ^~~~~~~~~~~~~~~
> drivers/gpu/drm/ttm/ttm_pool.c:76:29: error: variably modified 'global_dma32_write_combined' at file scope
>    76 | static struct ttm_pool_type global_dma32_write_combined[TTM_DIM_ORDER];
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/ttm/ttm_pool.c:77:29: error: variably modified 'global_dma32_uncached' at file scope
>    77 | static struct ttm_pool_type global_dma32_uncached[TTM_DIM_ORDER];
>       |                             ^~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   322458c2bb1a ("drm/ttm: Reduce the number of used allocation orders for TTM pages")
> 
> PMD_SHIFT is not necessarily a constant on ppc (see
> arch/powerpc/include/asm/book3s/64/pgtable.h).
> 
> I have reverted that commit for today.

Did anyone look into this? I today ran into what looks like the same
compiler error when building a mainline snapshot using a Fedora rawhide
config for ppc64le:

```
 drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified
'global_write_combined' at file scope
    73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
       |                             ^~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/ttm/ttm_pool.c:74:29: error: variably modified
'global_uncached' at file scope
    74 | static struct ttm_pool_type global_uncached[TTM_DIM_ORDER];
       |                             ^~~~~~~~~~~~~~~
 drivers/gpu/drm/ttm/ttm_pool.c:76:29: error: variably modified
'global_dma32_write_combined' at file scope
    76 | static struct ttm_pool_type
global_dma32_write_combined[TTM_DIM_ORDER];
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/ttm/ttm_pool.c:77:29: error: variably modified
'global_dma32_uncached' at file scope
    77 | static struct ttm_pool_type global_dma32_uncached[TTM_DIM_ORDER];
       |                             ^~~~~~~~~~~~~~~~~~~~~
```

Full build log:

https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/mainline/fedora-37-ppc64le/05850588-mainline-mainline-releases/build.log.gz

Ciao, Thorsten
