Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4486D2A65
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjCaVxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjCaVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:53:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE2CA0B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:52:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680299571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Hyu7B5PMD/6Hjx3PVFsOPviX5E90ag0vc/ISSLayx4=;
        b=Jb+3UqWAMcMCm/IW5t98tTatXDLNhFaDT2PAQ17N7MvuDRPIQFkECCVaAbMTNkBR1MSoS6
        OtHV+jOQJqRzzsfWXBV4j6t8S/xrZ71Tmlud0yfIfr6OlEbZ9pzz5odKzezLIUeiXfmqCv
        e0QWbpYrH7zKpntNUUxHU67KPX3dNlO0P2VQ4lqs5hfrZF6+UVsuajR5ExtGkH+LWB3UXe
        c3fLQLLHgf7VrTC5GliyQ0W854umpcauoNH73Uag6ZKJFH+Ua0yTLw3J7JYFxpRviQrDJJ
        +GTLBGs4hYpCiV7RXNf/PsQIu1thkWu1iojooX+vWKVME7adcHIijjBmSzwjIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680299571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Hyu7B5PMD/6Hjx3PVFsOPviX5E90ag0vc/ISSLayx4=;
        b=mNy/akH/qQWxhte5iHap01uZz88g/ZXpEUvUU7mQYy1cdFIZMk+SuHC23Ln7e1K3HStM76
        MZWc70grf26T8wAQ==
To:     "Yang, WenYou" <WenYou.Yang@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "Li, Ying" <YING.LI@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
In-Reply-To: <DM6PR12MB3531340547BE346D07E88BE3FD8F9@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
 <20230329085023.GO4253@hirez.programming.kicks-ass.net>
 <DM6PR12MB3531933678779C5923989925FD899@DM6PR12MB3531.namprd12.prod.outlook.com>
 <DM6PR12MB3531340547BE346D07E88BE3FD8F9@DM6PR12MB3531.namprd12.prod.outlook.com>
Date:   Fri, 31 Mar 2023 23:52:50 +0200
Message-ID: <87pm8osi4t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2023 at 05:49, WenYou Yang wrote:

<SNIP>
        Removing pointlessly copied mail headers. Please fix your email
        client
</SNIP>

>> >
>> > So what do you want to have happen when someone goes and manually
>> > offlines all the SMT siblings using
>> > /sys/devices/system/cpu/cpu*/online
>> > ?
>> 
>> I don't consider this situation.  Any suggestions will be deeply appreciated.
>
> Hi Peter,
>
> I don't find a good method to handle this situation.
> Yes, manually offlining all the SMT sibling will get the same result of SMT disabling on the fly.
>
> Actually, the normal way to enable/disable SMT on the fly is to echo on/off > /sys/device/system/cpu/smt/control

That's the most convenient way, right.

But why do we need a kernel notifier for this, if you can do the same
with a sysfs knob for your driver?

Then user space can fiddle with SMT control in sysfs and afterwards tell
the driver that it should reconfigure.

That makes a ton more sense than this random notifier.

Thanks,

        tglx
