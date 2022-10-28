Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E1610907
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiJ1Dth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1Dte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF98D73F3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D39625AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CFC433D6;
        Fri, 28 Oct 2022 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666928963;
        bh=H6SFLL4bcUVOWRhRZqguJi5kda2eJ/bOjwo8hs3owUw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=iZikFInJYhaAMCCwGaPVvurvFIWoLP7/CQBKZYHQL+QwByqoBp8DKh70uNY5+QofU
         ZQhBBSTabiy6kCrZav4F5dhTvhtpCucnjvcty5gb+VZBjztYgNHHYCfL1Thj20cEPl
         qLEzvNsr52rml8N1nCyAl1Ua+z5fpZiLoq09JUIGeBswhljZwwQP9mIeVFlVQrapcp
         5QMYeqM6vv4lS44RFWpj32Mh2C6Z1tEPeUlY1n2Yaxni9Xx+hUX3Hx9aUtgFnpzHKA
         onWzQ9+bU38r9V0RG6OsJD9yuVlOWGGNd2wUolx2D10zXw2SlPQujGlHcgCsey6tYa
         L2SQIfezBjjuA==
Message-ID: <eab56fc7-1a5d-1c56-9804-4bd690d2ea48@kernel.org>
Date:   Fri, 28 Oct 2022 11:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [syzbot] BUG: unable to handle kernel NULL pointer
 dereference in f2fs_stop_discard_thread
Content-Language: en-US
To:     syzbot <syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com>,
        changfengnan@vivo.com, frank.li@vivo.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
References: <000000000000f79f5905ec0fee38@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000f79f5905ec0fee38@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the report, the bug has been fixed w/ below patch:

https://lore.kernel.org/linux-f2fs-devel/20221021023422.3101585-1-chao@kernel.org/T/#u

On 2022/10/28 11:34, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 4d67490498acb4ffcef5ba7bc44990d46e66a44c
> Author: Fengnan Chang <changfengnan@vivo.com>
> Date:   Thu Aug 19 08:02:37 2021 +0000
> 
>      f2fs: Don't create discard thread when device doesn't support realtime discard
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17da7522880000
> start commit:   247f34f7b803 Linux 6.1-rc2
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=143a7522880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=103a7522880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=035a381ea1afb63f098d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d92d6a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e5dbba880000
> 
> Reported-by: syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com
> Fixes: 4d67490498ac ("f2fs: Don't create discard thread when device doesn't support realtime discard")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
