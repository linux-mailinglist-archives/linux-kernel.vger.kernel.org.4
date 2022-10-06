Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD75F6EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJFUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:15:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084AA02DF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:15:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665087325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwpPOlYCS85qc1YpNruI7rje5teNtWicQtAVcUz+CVw=;
        b=JeKOMg/L46on+VSwXNzEiu1BCdZ5KEPWcMKOcwF1JwwznwnuldL6K7BGEEgiohDIMzG3ik
        4mUtkVzcSOHl2cJlfozZ9gYpSf1K7wSJlcT19ppzXYj4q7i78J/2GQssduSsaRDi9D1qJ4
        XfEEGAZHGZgfOBbz6dwpid13heOHRir5E11uzYcI/ZBlwjq5V6zzYqKOhY5s/po564zjZJ
        8POH9MdvKUui+vNYflMjbNZQwdr7o4ufd/L4D0PnrQOIxiH+t2RMB8jTEE7VTwNolSHxjm
        lA1MqLu784QMUmvQmChBlS/Ty3rp4oAN9Pb32ENoj74tKnKTQjCifubQOOB96w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665087325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwpPOlYCS85qc1YpNruI7rje5teNtWicQtAVcUz+CVw=;
        b=tF28kg7R0TjGfYFr0uSV3c561CfnrmZMMvAAeqRecmU/d9jVo/Rc0FAmJ+PBYDs3Ut3dhD
        eM/D+6bcKqoOmZBw==
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one)
 to avoid userspace regression
In-Reply-To: <9d9d2d5c-1b7a-721b-f0e2-f591bb170723@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9d9d2d5c-1b7a-721b-f0e2-f591bb170723@igalia.com>
Date:   Thu, 06 Oct 2022 22:15:24 +0200
Message-ID: <87pmf4bter.ffs@tglx>
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

On Wed, Sep 28 2022 at 17:56, Guilherme G. Piccoli wrote:
> On 28/09/2022 17:24, Luck, Tony wrote:
>> [...] 
>> Why not just use the workaround suggested in that bug report:
>> 
>>    "so manual switching from default setting to split_lock_detect=off helps as workaround here"
>> 
>> If you add this extra mode, I'm going to argue that the kernel default
>> should be "seq" rather than "warn". So these game players will need
>> to add a split_lock_detect=off (or warn) option.
>> 
>
> Hi Tony, thanks for your response. The workaround is the way to
> circumvent the issue for now, but not all users want (or know how) to
> deal with the kernel parameters. If a distro wants to default to show a
> warning only, but don't break performance so hard, this would be
> currently impossible.

That Kconfig knob is patently bad. The only sane choice for a generic
distro kernel is to slow down the offenders simply because split lock is
a trivial unpriviledged DoS. Run a split locker in a tight loop and
watch your shiny new multicore system degrading into a machine from the
80s. So unless the distro provides a "special broken games" kernel the
users will still need to fiddle with the command line.

Attack vector prevention has precedence over broken applications. That's what
command line options or sysctls are for.

> The main/big issues here are two: defaulting to the disruptive behavior
> (with no way of building a kernel not defaulting to that without
> patching), and not having a way to warn about split locking without
> breaking the performance, hence the new mode "seq".

Which is a misnomer and tells absolutely nothing. If we add a new
parameter then we name it something like "mitigate" and make it the
default.

But a way better solution is to add a sysctl knob which allows to
disable the slowdown mechanics and that allows distros to give the user
an trivial knob in the GUI to switch to "I don't care. My broken game is
more important!" mode, while still maintaining the only sensible default
of preventing damage for the general use case of the generic distro
kernel.

Thanks,

        tglx
