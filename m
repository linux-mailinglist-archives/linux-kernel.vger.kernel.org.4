Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A766E2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjAQPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjAQPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:46:10 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70B43900;
        Tue, 17 Jan 2023 07:44:13 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pHo8B-001K4C-Ht; Tue, 17 Jan 2023 16:44:11 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pHo8B-002dI6-BQ; Tue, 17 Jan 2023 16:44:11 +0100
Message-ID: <4312c1f9-7926-6dc3-6a28-049612354d39@physik.fu-berlin.de>
Date:   Tue, 17 Jan 2023 16:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ia64: Fix build error due to switch case label appearing
 next to declaration
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        =?UTF-8?Q?=c3=89meric_Maschino?= <emeric.maschino@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230117151632.393836-1-james.morse@arm.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230117151632.393836-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James!

On 1/17/23 16:16, James Morse wrote:
> Since commit aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to
> report ITC frequency"), gcc 10.1.0 fails to build ia64 with the gnomic:
> | ../arch/ia64/kernel/sys_ia64.c: In function 'ia64_clock_getres':
> | ../arch/ia64/kernel/sys_ia64.c:189:3: error: a label can only be part of a statement and a declaration is not a statement
> |   189 |   s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> 
> This line appears immediately after a case label in a switch.
> 
> Move the declarations out of the case, to the top of the function.
> 
> Fixes: aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Found when build testing another series.
> I've only build tested this.
> 
>   arch/ia64/kernel/sys_ia64.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
> index f6a502e8f02c..6e948d015332 100644
> --- a/arch/ia64/kernel/sys_ia64.c
> +++ b/arch/ia64/kernel/sys_ia64.c
> @@ -170,6 +170,9 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
>   asmlinkage long
>   ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *tp)
>   {
> +	struct timespec64 rtn_tp;
> +	s64 tick_ns;
> +
>   	/*
>   	 * ia64's clock_gettime() syscall is implemented as a vdso call
>   	 * fsys_clock_gettime(). Currently it handles only
> @@ -185,8 +188,8 @@ ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *
>   	switch (which_clock) {
>   	case CLOCK_REALTIME:
>   	case CLOCK_MONOTONIC:
> -		s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> -		struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
> +		tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> +		rtn_tp = ns_to_timespec64(tick_ns);
>   		return put_timespec64(&rtn_tp, tp);
>   	}
>   

Thanks for the patch. I just gave it a try and it didn't make any difference for me.

The kernel builds fine in both cases (with CONFIG_WERROR disabled) on 6e50979a9c87.

I can boot-test the patch later tonight with my RX2600 at home.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

