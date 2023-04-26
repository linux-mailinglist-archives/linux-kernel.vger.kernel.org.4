Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529BB6EFE00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjDZX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbjDZX12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:27:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D003A90;
        Wed, 26 Apr 2023 16:27:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q6FQH2HbHz4x1f;
        Thu, 27 Apr 2023 09:27:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682551640;
        bh=DLduUxDCqD+drsoher8gw60YxikLfg8+ksqsWYQD0bw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Fh7qn6Pl5yimaY+GizbnYDMfzarcELB7R7o/nr/1Wq/Mi43gfdVNFht9N8NI725ih
         HpEqObnXsKhZ3QV9/wIem1Mi86OwvJRXYYrDm+OA/z0cSpb++CPzgKT5sCIElZC6qK
         V81qxPEL0F+47s1rVAmuDoBC325PBICZtfU4vjr31MT4Edand2LmrrcTcktzqemI5y
         5mJw7RvGu03vKv29VUR2bBo0WlTum2/2I9KSfGmqqrfxSZbvHzxDlSOrPHd9mnNbyJ
         DNxMX4hTJrOnE5+U9X0/C7C1LiyOZAyNC9X5jDIoONpwg/ENhcIM5ANmGeijaHV8+5
         0DIqENnZjEvHw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Justin Forbes <jforbes@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: build failure from drm/ttm commit now in mainline (was:
 linux-next: build failure after merge of the drm tree)
In-Reply-To: <872f3ba1-1771-2ef4-1353-4cadd92eb5e1@leemhuis.info>
References: <20230411164714.2ce79bcb@canb.auug.org.au>
 <872f3ba1-1771-2ef4-1353-4cadd92eb5e1@leemhuis.info>
Date:   Thu, 27 Apr 2023 09:27:15 +1000
Message-ID: <87y1mexm0c.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:
> Lo!
>
> Sometimes the regression tracker runs into regressions himself... :-D
>
> On 11.04.23 08:47, Stephen Rothwell wrote:
>> 
>> After merging the drm tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>> 
>> drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified 'global_write_combined' at file scope
>>    73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
>>       |                             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:74:29: error: variably modified 'global_uncached' at file scope
>>    74 | static struct ttm_pool_type global_uncached[TTM_DIM_ORDER];
>>       |                             ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:76:29: error: variably modified 'global_dma32_write_combined' at file scope
>>    76 | static struct ttm_pool_type global_dma32_write_combined[TTM_DIM_ORDER];
>>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ttm/ttm_pool.c:77:29: error: variably modified 'global_dma32_uncached' at file scope
>>    77 | static struct ttm_pool_type global_dma32_uncached[TTM_DIM_ORDER];
>>       |                             ^~~~~~~~~~~~~~~~~~~~~
>> 
>> Caused by commit
>> 
>>   322458c2bb1a ("drm/ttm: Reduce the number of used allocation orders for TTM pages")
>> 
>> PMD_SHIFT is not necessarily a constant on ppc (see
>> arch/powerpc/include/asm/book3s/64/pgtable.h).
>> 
>> I have reverted that commit for today.
>
> Did anyone look into this?

Christian sent a revert:
  56e51681246e ("drm/ttm: revert "Reduce the number of used allocation orders for TTM pages"")

Which has been in linux-next since the 21st. But I guess it missed being
in the initial DRM pull request.

See also other thread:
  https://lore.kernel.org/all/ZEljCgVFnDl%2FC+l3@debian/

Where Christian says the revert is "on the way" to Linus.

cheers
