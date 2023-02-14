Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E004696C60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjBNSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjBNSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95830192
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:07:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EAA617E9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376EC433D2;
        Tue, 14 Feb 2023 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676398042;
        bh=nSR8hVUSauHMlrOcczG32O1VhiEbOlM8in7Lm4PwEhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dxg+Mhsn4lxcC06z+dkoCPWr3JaiUr3WDh04awWbGuBj6UtkM8hMA2isJvKD7cTOm
         QkZL2TUqA1r1oUrnfKpsn2EkXjrpfT48N6UybcdOT0Z4d3JDJyOMJ1h8rwUNqtyC55
         y//2VPHYA362k7I5o3Xgtrw1hQA+anp5/qEaSo7Wjmp4mDiLpkEZmNKwAmV6Wz98ET
         C54fJrAMqUEKuKziPKSSX9b2g965bSdffDP3VeVNHOssbHZrenkbuRJH1zBxavnud7
         KPv34WV5SXe4ygNFaRP0CxnRJM0cwTzJXmnCsxMxqn+yr/EX4C4XBzbKcL9KC6Qbyb
         7MKkxr5s6XfYw==
Date:   Tue, 14 Feb 2023 10:07:19 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
Message-ID: <Y+vN18flpTqWwvll@google.com>
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
 <Y+p4jezz5asWoPhu@google.com>
 <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14, Chao Yu wrote:
> On 2023/2/14 1:51, Jaegeuk Kim wrote:
> > On 02/13, Chao Yu wrote:
> > > On 2023/2/9 11:20, Thomas Weiﬂschuh wrote:
> > > > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > > > the driver core allows the usage of const struct kobj_type.
> > > > 
> > > > Take advantage of this to constify the structure definitions to prevent
> > > > modification at runtime.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > 
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > 
> > Hi Chao,
> > 
> > Note that, next time, I won't apply/modify any patches merged in -dev,
> > unless it has a problem.
> 
> Hi Jaegeuk,
> 
> Oh, any particular reason, to avoid unneeded commit id change when the time is
> close to merge window?

Hi Chao,

I'm trying to avoid breaking the -next branch.

> 
> Is there any period of grace before merging patches from dev-test branch into dev
> branch? Maybe a week is reasonable? so I may have time to catch up in time.

No rule, but I'm trying to wait for several days while running my local tests.
If the patch looks okay, sometimes I'll queue it right away.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
