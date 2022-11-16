Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0018062B5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiKPJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiKPJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:06:17 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 01:06:14 PST
Received: from abrecht.li (unknown [IPv6:2a05:41c0:8:f804::a3c:105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C7BF51
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:06:14 -0800 (PST)
Received: from mail.abrecht.li (unknown [IPv6:fc00:4::a3c:103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by abrecht.li (Postfix) with ESMTPSA id F25572D61423;
        Wed, 16 Nov 2022 08:48:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li F25572D61423
MIME-Version: 1.0
Date:   Wed, 16 Nov 2022 09:48:45 +0100
From:   Daniel Abrecht 
        <freedesktop-linux-dri-devel@nodmarc.danielabrecht.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Michel_D=C3=A4nz?= =?UTF-8?Q?er?= <michel@daenzer.net>,
        Christian Brauner <brauner@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Sean Paul <sean@poorly.run>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH] drm/atomic: do not branch based on the value of
 current->comm[0]
In-Reply-To: <20221105222012.4226-1-Jason@zx2c4.com>
References: <20221105222012.4226-1-Jason@zx2c4.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <26ef4a7059dd995731e2d4426c2400b2@abrecht.li>
X-Sender: freedesktop-linux-dri-devel@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-05 23:20, schrieb Jason A. Donenfeld:
> This reverts 26b1d3b527e7 ("drm/atomic: Take the atomic toys away from 
> X")

I'm in favor of reverting this commit. I've tried to get allowing to 
enable atomic in Xorg again in there in the past: 
https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/533

I've no illusions of getting this through though, after all mostly the 
same people control what's merged into Xorg, what drm stuff gets into 
the kernel and who disabled it in the kernel in the first place. And 
there doesn't seem much interest in dealing with anything Xorg either, 
in the merge request I linked, someone even called Xorg "abandonware". 
This is also why I didn't respond here until now.

I do see value in enabling this. When I looked at this 2 years ago, 
there were situations where enabling atomic brought clear improvements, 
and I would expect that it can still improve performance on some special 
systems. I think the users should have the option to use it if they want 
or need to.

There is also the concern that this may cause a regression, but I would 
argue, that there never was a regression to be fixed here in the first 
place. There may have been that one broken application in the past, but 
it was just that, a broken application, not something broken by the 
kernel. I do not think the kernel should modify it's behavior just to 
work around bugs in a specific program, which have always existed, and 
didn't come from a changer in behavior of the kernel APIs. If a program 
was written wrongly, the program should be fixed, and in case of Xorg, I 
think it is fixed already.

This probably won't mean much coming from me, but:
Acked-by: Daniel Abrecht <public@danielabrecht.ch>
