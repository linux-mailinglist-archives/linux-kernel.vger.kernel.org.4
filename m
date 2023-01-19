Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A667452E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjASVoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjASVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:40:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085AB9FDFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:31:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674163887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpLGkp7TW3vMSv6Ch08YsOSSkac6mSrH3tdNKGcKrTA=;
        b=WqVmr62Yz1+gEStX8aVtZcB/rMuQyay0eAvJoqhCGlQhsGot5ok21q1YXXEMAb7SYBGWZW
        qWEeYlQWJe5D4jHo4oxzM8+TDwtoGtlGXUidZFwgeJY7UK9iPqCJ9uaJ4IYnhX3uodnHVw
        6kdqG4RR8HpSbJFL4uPOo2HEYhqdaWnLEiCdal/Tdi4lDQYkVrr3SJmKklPil85Rivz9pq
        oIT+JyWINCxt+Ppn6kpXFStKSx7959F99J28QW3EbND5qG0mBk0y2JX45drpPx90i3m5iO
        ZGWtLOGmVx6uAfJ9npqjlBgEUamWpdMLv8uM1SIs/o5pVnmytIkMWTHgq5UMFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674163887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpLGkp7TW3vMSv6Ch08YsOSSkac6mSrH3tdNKGcKrTA=;
        b=2JSBiIV6G3QTOfLM2pkSn1rkkucbgtYAFO0EXPd97m9XM8NDKyvvaZsMTlFAOzLTVgS+/z
        EDySbq6Ge3jhaWBQ==
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v17 3/6] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20230118213544.2128-4-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
 <20230118213544.2128-4-eric.devolder@oracle.com>
Date:   Thu, 19 Jan 2023 22:31:26 +0100
Message-ID: <878rhyi53l.ffs@tglx>
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

Eric!

On Wed, Jan 18 2023 at 16:35, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
>
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().

This sentence does not make sense. The callback is not registered to
capture CPUHP_AP_ONLINE_DYN events.

What this does is: It installs a dynamic CPU hotplug state with
callbacks for online and offline. These callbacks store information
about a CPU coming up and going down. Right?

But why are they required and what's the value?

This changelog tells WHAT it does and not WHY. I can see the WHAT from
the patch itself. 

Don't tell me the WHY is in the cover letter. The cover letter is not
part of the commits and changelogs have to be self contained.

Now let me cite from your cover letter:

> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).

The CPU hotplug state you are using for this is patently inaccurate
too. With your approach the CPU is tracked as online very late in the
hotplug process and tracked as offline very early on unplug.

So if the kernel crashes before/after the plug/unplug tracking event
then your recorded state is bogus and given the amount of callbacks
between the real online/offline and the recording point there is a
pretty large window.

You can argue that this is better than the current state and considered
good enough for whatever reason, but such information wants to be in the
changelog, no?

Thanks,

        tglx

Hint: The requirements for changelogs are well documented in Documentation/process/


