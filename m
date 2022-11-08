Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F13622077
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKHXvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:51:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A395D682;
        Tue,  8 Nov 2022 15:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C97A7B81C57;
        Tue,  8 Nov 2022 23:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766F6C433C1;
        Tue,  8 Nov 2022 23:51:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pucrpXY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667951464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIpTayP8e5DLYAF1ks9yHQeZPVCugHfqM/0zG2fIuMQ=;
        b=pucrpXY4vgk4NY2HPL1tlwaFtaPg3Ft3rGhF69CyJ17IfMpoQbbarGBVy5MH0t5J8JWdkm
        0Bj2Fhow3fL5R34r1JqGZp8Q5aGgx8kUVe+WBqrjw/V1b+boMzViwM3TUN9c+rVzoJeqrf
        +DzYZBRS00mFW0Db8EwjM6hPQzEx6OU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1a050be7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 23:51:04 +0000 (UTC)
Date:   Wed, 9 Nov 2022 00:51:03 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+25aae26fb74bd5909706@syzkaller.appspotmail.com>,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux@dominikbrodowski.net, olivia@selenic.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] linux-next boot error: WARNING in kthread_should_stop
Message-ID: <Y2rrZ8lIIMrKkb2Z@zx2c4.com>
References: <000000000000e915eb05ecf9dc4d@google.com>
 <Y2qjerZigLiO8YVw@zx2c4.com>
 <CACT4Y+a3bJmMf8JNm=SZYOKtgSVnOpY4+bgdT4ugLLhVV-NCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+a3bJmMf8JNm=SZYOKtgSVnOpY4+bgdT4ugLLhVV-NCEA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:39:22PM -0800, Dmitry Vyukov wrote:
> On Tue, 8 Nov 2022 at 10:44, 'Jason A. Donenfeld' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > Already fixed in the tree.
> 
> Hi Jason,
> 
> The latest commit touching this code in linux-next is this one. Is it
> the fixing commit?
> 
> commit e0a37003ff0beed62e85a00e313b21764c5f1d4f
> Author:     Jason A. Donenfeld <Jason@zx2c4.com>
> CommitDate: Mon Nov 7 12:47:57 2022 +0100
>     hw_random: use add_hwgenerator_randomness() for early entropy

It's this one: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=9807175c5515cea94f8ac6c157f20cc48c40465b

Couple hours more and there'll be a new linux-next with the fix.

Jason
