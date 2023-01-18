Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87805671BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjARMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjARMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:23:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDDC65F00;
        Wed, 18 Jan 2023 03:45:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491331477;
        Wed, 18 Jan 2023 03:45:45 -0800 (PST)
Received: from [10.1.196.46] (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5EE3F71A;
        Wed, 18 Jan 2023 03:45:02 -0800 (PST)
Message-ID: <99b295ed-7157-0c95-cafb-9cf8afdf41f2@arm.com>
Date:   Wed, 18 Jan 2023 11:44:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ia64: Fix build error due to switch case label appearing
 next to declaration
Content-Language: en-GB
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        =?UTF-8?Q?=c3=89meric_Maschino?= <emeric.maschino@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230117151632.393836-1-james.morse@arm.com>
 <20230117193109.5650fd6f@nz>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230117193109.5650fd6f@nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On 17/01/2023 19:31, Sergei Trofimovich wrote:
> On Tue, 17 Jan 2023 15:16:32 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Since commit aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to
>> report ITC frequency"), gcc 10.1.0 fails to build ia64 with the gnomic:
>> | ../arch/ia64/kernel/sys_ia64.c: In function 'ia64_clock_getres':
>> | ../arch/ia64/kernel/sys_ia64.c:189:3: error: a label can only be part of a statement and a declaration is not a statement
>> |   189 |   s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
>>
>> This line appears immediately after a case label in a switch.
>>
>> Move the declarations out of the case, to the top of the function.
>>
>> Fixes: aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency")
>> Signed-off-by: James Morse <james.morse@arm.com>

> Out of curiosity what compiler version behaves like that? I think I and
> matoro build-/run-tested it on gcc-12 and maybe gcc-11.

| # ia64-linux-gcc --version
| ia64-linux-gcc (GCC) 10.1.0
| Copyright (C) 2020 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.  There is NO
| warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

The toolchain originally came from https://mirrors.edge.kernel.org/pub/tools/crosstool/

The really odd thing I'm doing is cross compiling for ia64 on arm64 ... but I wouldn't
have thought the toolchain configuration was any different.


> Thank you!
> 
> Reviewed-by: Sergei Trofimovich <slyich@gmail.com>


Thanks,

James
