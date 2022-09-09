Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B95B4073
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiIIUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiIIUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:21:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB9BA9EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D677B824FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 20:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68592C433C1;
        Fri,  9 Sep 2022 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662754906;
        bh=GKpxAviIRf0Cm5Wh0WlIJnPelOqjKCHbR94gPvMQyCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PEoFgf9678ZZKfCRW/iY3TZ1QT5zzs1XjdCPolznYEGyMpDx+SY0gUs4HzvJgtzSD
         8If15nTuUngVqYWIR0ZH/UJOL4TPc4x0YuzcD/kZyWPoewc9ienTCyUtqcF7D8BgUL
         s0XIZV5SdEKZqP95oV1dh/yWT/2dV1peQsiUZlb78Knfm20sM++wqvLpvUsyJejTmT
         AULxkvaK0h3/mfg8ngKALehmsWZ2+boOcdyMRkBH/hV6vSSmiOJEWN9ISVyGakwdOi
         pWq2xXCNLxNskQN8s7jzsa0PdlOK2YoiS5sK+up+KnlrYbm0ki71MNpXz6OnUCvj+/
         XY7uHwUrl3kCw==
Message-ID: <8abfed2c-2499-b2da-1e06-ecc188f7c7b0@kernel.org>
Date:   Fri, 9 Sep 2022 22:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Muchun Song <muchun.song@linux.dev>, Chao Yu <chao@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20220830141009.150075-1-chao@kernel.org>
 <BAC9CE6A-5873-429F-ACE2-E0A9E507D807@linux.dev>
 <dbef29b2-ab0a-c3df-638c-381916a0d15a@kernel.org>
 <Yxucs30FNkbWQHVh@casper.infradead.org>
Content-Language: en-US
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <Yxucs30FNkbWQHVh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 22:06, Matthew Wilcox wrote:
> On Thu, Sep 08, 2022 at 11:25:08PM +0200, Vlastimil Babka (SUSE) wrote:
>> > I tend to agree with you. A mount operation shouldn’t panic the
>> > kernel.
>> 
>> Hmm kmalloc(64) shouldn't normally due that due to the the underlying page
>> allocation falling into the "too small to fail" category, wonder if
>> syzkaller was doing anything special here?
> 
> Here's the repro:
> 
> https://syzkaller.appspot.com/x/repro.c?x=17cd7fa3080000
> 
> you can see it does:
> 
>   fd = open("/proc/thread-self/fail-nth", O_RDWR);
>   if (fd == -1)
>     exit(1);
>   char buf[16];
>   sprintf(buf, "%d", nth);
>   if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
> 
> so this is the kind of stupid nitpicky bug that we shouldn't be
> reporting, let alone fixing, IMO.

Ah, thanks.

Well I'm ok with eventually removing all such BUG_ONs including what
Christophe Jaillet suggested, but it certainly isn't urgent nor deserves Cc:
stable then.
