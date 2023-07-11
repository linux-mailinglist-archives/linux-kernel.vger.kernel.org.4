Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149474E3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGKBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGKBvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:51:25 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 18:51:08 PDT
Received: from smtp1.onthe.net.au (smtp1.onthe.net.au [203.22.196.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24882197;
        Mon, 10 Jul 2023 18:51:08 -0700 (PDT)
Received: from localhost (smtp2.private.onthe.net.au [10.200.63.13])
        by smtp1.onthe.net.au (Postfix) with ESMTP id 289AE619B5;
        Tue, 11 Jul 2023 11:13:39 +1000 (EST)
Received: from smtp1.onthe.net.au ([10.200.63.11])
        by localhost (smtp.onthe.net.au [10.200.63.13]) (amavisd-new, port 10028)
        with ESMTP id rLMolZfa5ziw; Tue, 11 Jul 2023 11:13:39 +1000 (AEST)
Received: from athena.private.onthe.net.au (chris-gw2-vpn.private.onthe.net.au [10.9.3.2])
        by smtp1.onthe.net.au (Postfix) with ESMTP id DCF1D6196C;
        Tue, 11 Jul 2023 11:13:38 +1000 (EST)
Received: by athena.private.onthe.net.au (Postfix, from userid 1026)
        id C349B68061C; Tue, 11 Jul 2023 11:13:38 +1000 (AEST)
Date:   Tue, 11 Jul 2023 11:13:38 +1000
From:   Chris Dunlop <chris@onthe.net.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux XFS <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: rm hanging, v6.1.35
Message-ID: <20230711011338.GB683098@onthe.net.au>
References: <20230710215354.GA679018@onthe.net.au>
 <ZKyoD7WDKfzsKAaT@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZKyoD7WDKfzsKAaT@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:53:35AM +0700, Bagas Sanjaya wrote:
> On Tue, Jul 11, 2023 at 07:53:54AM +1000, Chris Dunlop wrote:
>> Hi,
>>
>> This box is newly booted into linux v6.1.35 (2 days ago), it was previously
>> running v5.15.118 without any problems (other than that fixed by
>> "5e672cd69f0a xfs: non-blocking inodegc pushes", the reason for the
>> upgrade).
>>
>> I have rm operations on two files that have been stuck for in excess of 22
>> hours and 18 hours respectively:
>
> Smells like regression resurfaced, right? I mean, does 5e672cd69f0a53 not
> completely fix your reported blocking regression earlier?
>
> I'm kinda confused...

It looks like a completely different problem. I was wanting 5e672cd69f0a53 
as a resolution to this:

https://lore.kernel.org/all/20220510215411.GT1098723@dread.disaster.area/T/

In that case there were kernel stacks etc. showing inodegc stuff, and the 
problem eventually resolved itself once the massive amount of work had 
been processed (5e672cd69f0a53 puts that work into the background).

In this case it looks like it's just a pure hang or deadlock - there's 
apparently nothing happening.

Cheers,

Chris
