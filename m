Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81316C58A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:17:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41338131
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:17:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679519842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ysHgSVzR07quGP5Go4T+VaoIwNGQVyPDWF/vUAc+rqA=;
        b=n/iEYw/4ZuHRa/SxKOGXV+pG1Rv/3nlvONeuYermaOa1THD/DjcWY4TP3S4z21AD3Fh1/x
        uR6Sv+Tv23lMEmSa3AgfKZqbtz3zqz+Lb8PTNlURV3nb63+eX4iA7Fluek7bH1o4cBBY6N
        RfZIoJl6NcKHcwPtsSN1ggtB13TuMWCkfP51HWV0efJFE+AhyJ9NX/ihommeM7djy7hUGB
        oA1qoa9zkeTXMPaSuAI5auaP1GaYkhar7ct1P0Sa8AATHJqFkMeuY6/1802yFH9TcvVutC
        Du/dOgFBa4LNqE/NgF/fvv92Nz3BVFSbnP3iLeMd9sUA4l+pGINZ5xIyz5x0vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679519842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ysHgSVzR07quGP5Go4T+VaoIwNGQVyPDWF/vUAc+rqA=;
        b=ST9q88mmmXBX4ZPjAKdlWF9jsc0JJ0cWESW8tis9TxlYpMtScchMW6SPo8djYok1zV7Gok
        bI/1UBz3c0ThVDDw==
To:     Schspa Shi <schspa@gmail.com>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
In-Reply-To: <m2r0tgmze9.fsf@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx>
 <m2r0tgmze9.fsf@gmail.com>
Date:   Wed, 22 Mar 2023 22:17:21 +0100
Message-ID: <87mt448p0e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2023 at 01:55, Schspa Shi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Which requirement? The is_static_object() call takes the address of the
>> actual object and has nothing to do with the tracking object at all.
>>
>
> This is for the fellowing test case, actually we calls
> debug_object_free() from a static object in our selftest, if we don't
> report any thing when call debug_object_free from a static object, we
> there is no such issues.

That's an artifical and completely pointless test case. As I told you
before the memory subsystem will warn when it's tried to free a static
object. debug_objects_free() is invoked from the memory subsystem *free*
functions.

What is the value of another warning?

Nothing at all.

So why would we add extra code just to keep track of something
completely redundant?

Thanks,

        tglx
