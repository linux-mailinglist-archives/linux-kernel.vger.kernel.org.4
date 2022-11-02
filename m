Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415406166AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBP6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKBP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:58:02 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22B2A70A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:57:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CFC03240026
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.eu; s=2017;
        t=1667404677; bh=TXw9bmFqmvwkICnHKRf9HU/0WQCtu3aGxJIdAtZv4Sg=;
        h=Date:From:Subject:To:Cc:From;
        b=hv5PT0qqiboAwsPXiSRY1PJjIYv9QBO5WxdsKDFMEb2wJzzz46swXQaoFjpqZ53Qi
         Ch5AWS1A0E9u7T/CzCGCTZu/NnBWtx3Uh2GJwD1dYrYskxL6/eouOw5NG7aWf2ebvd
         9Jjrcg2keTmBN1HQpoPO8jlVEYcJuM+t1XhKiVpj+n0vkHydR69x53N2pGMDtT0dqx
         D1jccy25WEmoMR3tj147D0eEEWhBo/N0v5TrUW7DKQMjwrlxbbiht7tcWDFB0/rZSb
         7lGekF8mUZDY0my/gd1x8H47ZOhe3hMz4I8/vW5wllAqzfL4tqunGUvPMTsaFY94SO
         RWjQLKh7tfLOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N2WkY0Blhz6tnX;
        Wed,  2 Nov 2022 16:57:56 +0100 (CET)
Message-ID: <25d7e982-f959-d86c-a6e7-5efd1db1e75c@posteo.de>
Date:   Wed,  2 Nov 2022 15:57:56 +0000
MIME-Version: 1.0
From:   postix@posteo.eu
Subject: Re: Fwd: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tiwai@suse.de
References: <e693eb6b-28d0-d091-3df3-60f2b591c0e7@posteo.de>
 <71829e56-a13f-0462-37a7-a4d64c16f561@posteo.de>
Content-Language: en-US, de-DE
Reply-To: 20221031144850.5522b036@rorschach.local.home
In-Reply-To: <71829e56-a13f-0462-37a7-a4d64c16f561@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I have added lot's of debug printk's to see what's happening and I found 
that the "cpu" counter, which is used to access the buffer's array 
elements (cpu_buffer = buffer->buffers[cpu]) in the ring_buffer_wake_waiters
function, exceeds the maximum number of total of total cores, namely in 
my case 24, which means, it should only run from 0..23. However, upon 
debugging, it runs up to 31, and thus causing a NULL pointer dereference 
(&cpu_buffer->irq_work).

After adding a return statement in case cpu > 24, the bug is no longer 
reproducible.

You can find the diff between v6.1-rc2 and the patched version with 
added debug log in [1].
The corresponding dmesg output can be found in [2].

I hope this gives you a good hint to find the root cause!

[1] https://paste.opensuse.org/e60601aa
[2] https://paste.opensuse.org/bf1398ce


