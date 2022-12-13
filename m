Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D464BB39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiLMRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiLMRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:40:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1923178;
        Tue, 13 Dec 2022 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=j0UALbMgWQAz5SBhNk+ZMMQCCxLWBTsG/ugs2SigX6o=; b=vCmNDThnkvzF3Biq7JJkRv7Xcg
        aTFh6YkGjF35i1JLHTPvsrfPImXzCU7eOVVkI/ZQoHnryV9KObeBeF/Eco9A0EFzhx2sVqgfHikFN
        GFL8t6pu9lATlmlSrs1lodMlJxNjllhEH1o0R8Rky9dSL3CmoJTck11v2E+9/bZ8UmsissbqOmLhz
        IBbnVgBSTY6DLUII/lQ0zgx9PzhtML+pHEAH44iirFg7apYqSOtWv/rjVdw6/HhOHvJ3XTm0Eg1Yy
        6woAwfosCYydMeZ+y+A3knS3QIhyABCHUz1pXK/XMm0fVUtjihuxzZ5VANIsdS+ws3rdyMZ9hJoqR
        1jbBmqIA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p59Gm-003nu3-Vf; Tue, 13 Dec 2022 17:40:45 +0000
Message-ID: <33fd0ddb-c2dc-c403-a742-bac32d24825c@infradead.org>
Date:   Tue, 13 Dec 2022 09:40:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arch: change variable types to match those of what is
 assigned to them
Content-Language: en-US
To:     "Seija K." <doremylover123@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <CAA42iKx2f2LsAQ9C5rxnCTPhOB6n+L35Winc5WK1K2EySAjvXA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAA42iKx2f2LsAQ9C5rxnCTPhOB6n+L35Winc5WK1K2EySAjvXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please look at
  https://lore.kernel.org/lkml/CAA42iKx2f2LsAQ9C5rxnCTPhOB6n+L35Winc5WK1K2EySAjvXA@mail.gmail.com/T/#u

and see if that matches what you thought you sent as a patch.

The gmail web interface is notorious for dropping tabs in emails.


On 12/13/22 09:35, Seija K. wrote:
> There are many places where "int len = strlen(foo);" is written, just
> for len to be passed as a parameter of size_t. This causes truncation
> and then expansion back from int to size_t. Not to mention this is
> poor logic and needless truncations can add extra unneeded
> instructions.
> 
> This patch aims to fix the worst offenders.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>  arch/arm/mm/mmu.c                      | 30 +++++++++++++-------------
>  arch/arm/probes/kprobes/test-core.c    |  8 +++----
>  arch/arm/vfp/vfpmodule.c               |  4 ++--
>  arch/arm/xen/p2m.c                     |  4 ++--
>  arch/mips/alchemy/common/irq.c         |  2 +-
>  arch/mips/alchemy/common/prom.c        |  2 +-
>  arch/mips/alchemy/devboards/bcsr.c     |  2 +-
>  arch/mips/alchemy/devboards/platform.c |  8 +++----
>  arch/mips/ar7/prom.c                   |  4 ++--
>  arch/mips/boot/compressed/dbg.c        | 14 +++++-------
>  arch/mips/fw/arc/cmdline.c             |  4 ++--
>  arch/xtensa/platforms/iss/console.c    |  4 ++--
>  12 files changed, 41 insertions(+), 45 deletions(-)
> 


-- 
~Randy
