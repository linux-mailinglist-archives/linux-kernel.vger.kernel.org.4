Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51E5E78FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIWLCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIWLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:01:55 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC23D8251;
        Fri, 23 Sep 2022 04:01:52 -0700 (PDT)
Date:   Fri, 23 Sep 2022 20:01:44 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663930910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzTqdtOB2X4wc0DpIuKM08/B89OG1P8P6SGFQopNwSY=;
        b=TRYOC6RhzxleRuqmDK5iERb3eo0j9NNehNKHClbd2hkk2bqGazUtPjFPVho5lEU5KV1hBd
        8BWTuvyFiuo7HONDXqE25umWKagS8RZVzdkmazGgyd9+QVcMGIxhJp7v1TteEzYRtokbav
        bckRxKimgcYYuGpbvIqnonpD5w9CpVg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Michael Walle <michael@walle.cc>
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        naoya.horiguchi@nec.com
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220923110144.GA1413812@ik1-406-35019.vs.sakura.ne.jp>
References: <20220923175554.59431f7b@canb.auug.org.au>
 <20220923095013.1151252-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923095013.1151252-1-michael@walle.cc>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:50:13AM +0200, Michael Walle wrote:
> Hi,
> 
> > After merging the mm tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > drivers/base/memory.c: In function 'memory_block_online':
> > drivers/base/memory.c:186:34: error: 'struct memory_block' has no member na=
> > med 'nr_hwpoison'
> >   186 |         if (atomic_long_read(&mem->nr_hwpoison))
> >       |                                  ^~
> > drivers/base/memory.c: In function 'remove_memory_block_devices':
> > drivers/base/memory.c:870:61: error: 'struct memory_block' has no member na=
> > med 'nr_hwpoison'
> >   870 |                 clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hw=
> > poison));
> >       |                                                             ^~
> > 
> > Caused by commit
> > 
> >   69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> > 
> > This build has CONFIG_MEMORY_FAILURE not set.

Sorry for inconvenience, I submitted a possible fix hours ago,
https://lore.kernel.org/linux-mm/20220923081827.GA1357512@ik1-406-35019.vs.sakura.ne.jp/T/#t
I think the above build error should be fixed by this.

(the updated patch is here https://lore.kernel.org/linux-mm/20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp/T/#u)

But ...

> 
> There also seems be more missing stubs. I'm getting:
> 
> aarch64-linux-gnu-ld: mm/memory-failure.o: in function `unpoison_memory':
> memory-failure.c:(.text+0x1c38): undefined reference to `memblk_nr_poison_sub'
> aarch64-linux-gnu-ld: mm/memory-failure.o: in function `num_poisoned_pages_inc':
> memory-failure.c:(.text+0x2c8c): undefined reference to `memblk_nr_poison_inc'
> aarch64-linux-gnu-ld: memory-failure.c:(.text+0x2cbc): undefined reference to `memblk_nr_poison_inc'
> 
> On a board where CONFIG_MEMORY_HOTPLUG is not set, but
> CONFIG_MEMORY_FAILURE is. So either there are stubs missing or
> MEMORY_FAILURE should depend MEMORY_HOTPLUG (?!).

Yes, the new field ->nr_hwpoison is meaningful only when both settings are
enabled, so I need/will update #ifdef condition to check MEMORY_HOTPLUG.
In x86, CONFIG_MEMORY_HOTPLUG=n and CONFIG_MEMORY_FAILURE=y does not show
this error.  So this error might be caused by arch dependency.
Anyway I'll update the patch again soon.
Thank you for the report.

- Naoya Horiguchi
