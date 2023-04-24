Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26936EC34C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjDXAom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXAok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:44:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B210D7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KnTrtTm+OMCxuJ2cui1HShdRgBlCVQjiqFOyYRdpUv4=; b=RSfblOJjwSmzlEGHhYs57Ku4Uk
        +q/ZmAVRNInmIhRwLWGAqo7WDH44SD2SnYL85cuh4prbt8DWsgAhy2QtcEp23PJHyylrflbJpfEyw
        DsYrdlleZSLqDCbFrgjR3HR5hqD6qCCzDRgVkX8tTeH22XrvNGqwth543XqJdkDBiUksDH+pkfc3y
        qPh5emtAU9DL8aZtlefwGH9OBXxk98QxUThVg/TL/PMWh9wSwGLOsAd/H1TvKDpDg3gGBJTp6P93j
        MU1G7qvkCh1sxK2Jhy9FW2X0DsJI4k6j4SZGYFZ/8886p8PVaxQKYrpIZM0NECAz2ETbzaG2eeA2E
        tiHtjp2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqkJj-00BxTH-0T;
        Mon, 24 Apr 2023 00:44:31 +0000
Date:   Mon, 24 Apr 2023 01:44:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Message-ID: <20230424004431.GG3390869@ZenIV>
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:55:58AM +0900, Tetsuo Handa wrote:
> On 2023/04/24 8:34, Al Viro wrote:
> > As for the original report - add a (failing) ->splice_read() in hung_ut_tty_fops
> > to deal with the original problem.
> 
> Yes, adding a dummy splice_read callback is OK for avoiding NULL pointer dereference.
> But we need more changes for avoiding KCSAN race reporting.
> 
> Are you OK with https://lkml.kernel.org/r/6bec279c-07b3-d6f1-0860-4d6b136a2025@I-love.SAKURA.ne.jp
> which will require touching so many locations ?
> 
> If you want tty layer handle this race without rewriting all f_op dereferences,
> we would need to replace
> 
>   filp->f_op = &hung_up_tty_fops;
> 
> with
> 
>   data_race(filp->some_flags_for_tty = true);
> 
> rather than
> 
>   data_race(filp->f_op = &hung_up_tty_fops);
> 
> and check
> 
>   if (data_race(filp->some_flags_for_tty)) {
>     return error;
>   }
> 
>  from each "struct tty_operations" callback function.

What struct tty_operations?  It's file_operations, unfortunately, and
their calls are on quite a few fast paths.

Do you mean doing that in method instances that are present in tty_fops
you mean doing that in method instances that are present in tty_fops
and different in hung_up_tty_fops?
