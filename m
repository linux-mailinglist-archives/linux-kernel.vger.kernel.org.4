Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E663EF44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiLALSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLALRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:17:22 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDE27146
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:14:53 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 548BD5FD07;
        Thu,  1 Dec 2022 14:14:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669893290;
        bh=LJwX7qGKA32N+tF46LoN08BqtM4I0sGUqznsrwk0dNU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=G7tEMd58WoljbM6X/ZvE58De7EPiGaqd9nhXRJpw2iHrUN0jg3u4vz+X5LWa2a2I3
         pYSnOdIrgLHyj0iDVGDf19OZhFp5At0/zZ4Ff+TzBXVpl2nTNUAHeXHO813ru/6E5U
         Kmtr1dnCZfJPH/jXYaEz3GFY8xNqRkzvu8lOQnthINfd+3JitTkPXmKKKgSAnvW6v5
         ZfUC39B6Mj2aHniGo2Ykwphl2LJehqSEVUA9yKnUUPHEVovVaKEcRmMztEJpTRyNmz
         AgJIuyemenlcyfepJAiuHwW98abLlB5apvJ4JUuRg1clfebmozNL1OjFbYWnPSYAR/
         Q2CMvjQuC9fPA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Dec 2022 14:14:49 +0300 (MSK)
Date:   Thu, 1 Dec 2022 14:14:48 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Aleksey Romanov <AVRomanov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <20221201111448.oepcy6jh77sjx3rd@CAB-WSD-L081021>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
 <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
 <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
 <Y4iGOTRvAS+WRrtq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4iGOTRvAS+WRrtq@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 00:48:00 #20630840
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:47:21PM +0900, Sergey Senozhatsky wrote:
> On (22/12/01 13:14), Dmitry Rokosov wrote:
> > Hello Sergey,
> > 
> > Hope you are doing well. Really sorry for the ping.
> > 
> > Did you get a chance to see the patch series, my questions, and
> > thoughts?
> 
> Hey,
> 
> Not really, sorry. It's a holidays season + pre-merge window week.
> I probably will start looking attentively next week or so.
> 
> In the meantime time I'll try to reach out to lawyers to get more
> clarifications on that patent thingy.

Yeah, got it. Thanks a lot for the support! Appreciate it!

BTW, happy holidays :)

-- 
Thank you,
Dmitry
