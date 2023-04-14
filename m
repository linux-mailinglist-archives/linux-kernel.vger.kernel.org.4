Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BE6E22DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDNMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:11:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2ECF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:11:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PyZzx4lSzz4xDr;
        Fri, 14 Apr 2023 22:11:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681474287;
        bh=MYWkP1BdVX8PGN/iA6OZcWJO9svH3C1eZp+WN7k5FIo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mdwA45Eithl0Zfh3JUNb19wIcdyRVRZ5+KdBsT3YAyXLw3z1g+1I8L8QGKfAxZbw9
         3QEqORW7+p1AbJO1VYtkE8JsROYW8V50LJ0YsqMjkiM0B3t1sClAKD6gggatv53ux5
         nr9boy5RaVf64/96tp2nNHXgrevpYd5YXGb9WTJpzDuixJQX932mk1T7Zdc3oik3WZ
         W/jKAEENYrrj6IEaRX6zGcZ6sH6fCYNJh1ZBgMMv2SSEHbHLqHoYh3ySHzNJOiZmNG
         vcMArxorstICPmmWDIKnKj6VDX5Jw/fq0TZq+3b388J+GzfyksH+5ZRTdH3PkgAqjl
         d1RvGdNCIvjtg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     msuchanek@suse.de, nathanl@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pseries/smp: export the smt level in the SYS FS.
In-Reply-To: <0e668a82-3a3e-798a-8707-1a9b622b23b6@linux.ibm.com>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
 <20230331153905.31698-2-ldufour@linux.ibm.com>
 <87ttxjaonc.fsf@mpe.ellerman.id.au>
 <0e668a82-3a3e-798a-8707-1a9b622b23b6@linux.ibm.com>
Date:   Fri, 14 Apr 2023 22:11:24 +1000
Message-ID: <87leiuack3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> On 13/04/2023 15:37:59, Michael Ellerman wrote:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> There is no SMT level recorded in the kernel neither in user space.
>>> Indeed there is no real constraint about that and mixed SMT levels are
>>> allowed and system is working fine this way.
>>>
>>> However when new CPU are added, the kernel is onlining all the threads
>>> which is leading to mixed SMT levels and confuse end user a bit.
>>>
>>> To prevent this exports a SMT level from the kernel so user space
>>> application like the energy daemon, could read it to adjust their settings.
>>> There is no action unless recording the value when a SMT value is written
>>> into the new sysfs entry. User space applications like ppc64_cpu should
>>> update the sysfs when changing the SMT level to keep the system consistent.
>>>
>>> Suggested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/pseries.h |  3 ++
>>>  arch/powerpc/platforms/pseries/smp.c     | 39 ++++++++++++++++++++++++
>>>  2 files changed, 42 insertions(+)
>>
>> There is a generic sysfs interface for smt in /sys/devices/system/cpu/smt
>>
>> I think we should be enabling that on powerpc and then adapting it to
>> our needs, rather than adding a pseries specific file.
>
> Thanks Michael, I was not aware of this sysfs interface.
>
>> Currently the generic code is only aware of SMT on/off, so it would need
>> to be taught about SMT4 and 8 at least.
>
> Do you think we should limit our support to SMT4 and SMT8 only?

Possibly? Currently the SMT state is represented by an enum:

enum cpuhp_smt_control {
	CPU_SMT_ENABLED,
	CPU_SMT_DISABLED,
	CPU_SMT_FORCE_DISABLED,
	CPU_SMT_NOT_SUPPORTED,
	CPU_SMT_NOT_IMPLEMENTED,
};

Adding two states for SMT4 and SMT8 seeems like it might be acceptable.

On the other hand if we want to support artbitrary SMT values from 3 to
8 then it might be better to store that value separately from the state
enum.

TBH I'm not sure whether we want to support values other than 1/2/4/8
via this interface.

A user who wants some odd numbered SMT value can always configure that
manually using the existing tools.

But maybe it's less confusing if this interface supports all values?
Even if they're unlikely to get much usage.

>> There are already hooks in the generic code to check the SMT level when
>> bringing CPUs up, see cpu_smt_allowed(), they may work for the pseries
>> hotplug case too, though maybe we need some additional logic.
>>
>> Wiring up the basic support is pretty straight forward, something like
>> the diff below.
>
> I'll look into how to wire this up.
> Thanks a lot!

Thanks.

cheers
