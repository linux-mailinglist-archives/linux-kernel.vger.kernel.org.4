Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F696A4C42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjB0UdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0UdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:33:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD59BB8C;
        Mon, 27 Feb 2023 12:33:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677529984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSq3U8vm3tPDYRLicDf/4tQ5XJoyg12J2HKCMxx/oIM=;
        b=UFgsDsc3BVDY0ST5cC8kRV6aW75Q8+Uw9k/qYdlIf7ai3haStL/5lo/odeUf9gCw40SHJq
        6bPqNPHdJIts50Shf5ToscR1yMe2XaXaYygeTY+11/8snbPkldMCBaXV70C3u4bxT9lUuE
        vFstBx2f1xYwlYmn2Azc6DsKNkZVMJIDkjNPTErYUUyGQidArBglOuOCsDwTOoB8FCkj49
        xC3+srFIBwVJ1actrV0d8wwyh/jaBAQuFt0sd5QDDKAbx+6tvRa6lD8+nR0kuNAsQ+c5ud
        za9ElFnVHThDhyj6lvOvvBL6FmIIbssdljrbef6L183i3iiJcmX/EllGu4gxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677529984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSq3U8vm3tPDYRLicDf/4tQ5XJoyg12J2HKCMxx/oIM=;
        b=WVcrt4Uz9bCFKMvLHR9CMqyT+IYdO23FfU0dOGi+I/89mxZG6bulg2jos4Ed66M4fzR1oI
        /WjIby+pfyEDQTBw==
To:     syzbot <syzbot+5093ba19745994288b53@syzkaller.appspotmail.com>,
        dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [keyrings?] [lsm?] WARNING in __mod_timer
In-Reply-To: <000000000000af8f7c05f5a673bb@google.com>
References: <000000000000af8f7c05f5a673bb@google.com>
Date:   Mon, 27 Feb 2023 21:33:03 +0100
Message-ID: <87ttz6n91c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26 2023 at 19:55, syzbot wrote:
> ODEBUG: assert_init not available (active state 0) object: ffffffff8d4fcbc0 object type: timer_list hint: key_gc_timer_func+0x0/0x80 security/keys/gc.c:117

>  WARNING: CPU: 1 PID: 10646 at lib/debugobjects.c:512 debug_object_assert_init+0x1f2/0x240 lib/debugobjects.c:899
>  debug_assert_init kernel/time/timer.c:837 [inline]
>  __mod_timer+0x10d/0xf40 kernel/time/timer.c:1020
>  key_reject_and_link+0x3f5/0x6e0 security/keys/key.c:610
>  key_negate_and_link include/linux/key-type.h:187 [inline]
>  complete_request_key security/keys/request_key.c:64 [inline]
>  call_sbin_request_key+0xa7b/0xcd0 security/keys/request_key.c:213
>  construct_key security/keys/request_key.c:244 [inline]
>  construct_key_and_link security/keys/request_key.c:503 [inline]
>  request_key_and_link+0x11e3/0x18e0 security/keys/request_key.c:637
>  __do_sys_request_key security/keys/keyctl.c:222 [inline]
>  __se_sys_request_key+0x271/0x3b0 security/keys/keyctl.c:167

This is odd. The timer object is statically allocated via
DEFINE_TIMER(). That macro sets

       timer.entry.next = TIMER_ENTRY_STATIC

which is used to detect statically allocated timer objects via
timer_is_static_object() and that checks for:

     timer.entry.pprev == NULL && timer.entry.next == TIMER_ENTRY_STATIC

The only function which touches key_gc_timer is

    key_reject_and_link()
      mod_timer()
        __mod_timer()
          debug_assert_init()
            debug_timer_assert_init()
              debug_object_assert_init()
                if (!lookup_object()) {
                   if (!check_for_static_object()) <- Invokes timer_is_static_object()
                      WARN()

If this is the first invocation of mod_timer(&key_gc_timer,...) then
key_gc_timer is corrupted.

If this is not the first invocation of mod_timer(&key_gc_timer,...) then
the debugobjects hash is corrupted.

Either way neither the timer code nor debugobjects have been changed
since the 6.2 release and certainly are innocent here.

That smells like a nasty memory corruption issue and the two other
syzbot reports which arrived in my filtered inbox:

 https://lore.kernel.org/all/000000000000d7894b05f5924787@google.com
 https://lore.kernel.org/all/000000000000840dae05f5a7fb53@google.com

point to memory corruption as well.

The first one has a C reproducer. Can that be used for bisection?

Thanks,

        tglx
