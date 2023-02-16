Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B94698BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBPFaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBPF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:29:52 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEE212B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:29:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BDDF341F5F;
        Thu, 16 Feb 2023 05:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1676525377;
        bh=e6DAgQRi5MFXTXSKQZA5Z1t1Z/OvapR2NonqZSP/OUw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NU3rs1LqYtg8Hh/lQkJIUmAKRvW2ml0vNJvOELF8xlQqbflM+up8ovJSjPEd6zjoE
         zd3yVg4cvasPJCorOA6pOMi2H5XFMhEWM2m4cKNXop8FAt2YsM9iXc3UCFENJWd3+J
         wXua6CiNIQ1z3NZBHyU7fuS13t9DWxO6puuIBJxmJ6z7oL9vNS3LQiI1oJcYIVbR2c
         on5eln9raV/kdlqgACd4+zXLClEWqxlpvuBEW1jAehPFUdHkwcq6++ASBVlorca9vj
         F3MmKP0TLOdk0rdgDQU9vyi2iISdiaowsUc0eaD8yTAwW9nsk0gVRkgH2Jh8Q8EiNs
         2RrBNtKCvh6ig==
Message-ID: <90f3e529-715c-f7b1-da2d-1de7798aa248@asahilina.net>
Date:   Thu, 16 Feb 2023 14:29:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm_pmu: Invert fallback armpmu_filter() return value
 (*6.2 regression*)
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 20.27, Janne Grunau wrote:
> Fixes a regression in "perf: Rewrite core context handling" for arm_pmu
> based drivers without a filter function pointer as the Apple M1 PMU.
> The event is ignored if filter() returns 'true' opposite to
> filter_match(). The refactoring failed to invert the return value if
> arm_pmu has no filter() function pointer of its own.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/perf/arm_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 9b593f985805..9cb22f36cf66 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -556,7 +556,7 @@ static bool armpmu_filter(struct pmu *pmu, int cpu)
>  	if (ret && armpmu->filter)
>  		return armpmu->filter(pmu, cpu);
>  
> -	return ret;
> +	return !ret;
>  }
>  
>  static ssize_t cpus_show(struct device *dev,
> 
> ---
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
> change-id: 20230215-arm_pmu_m1_regression-b6dd48d0c792
> 
> Best regards,

Tested-by: Asahi Lina <lina@asahilina.net>

This fixes `perf` being completely broken on 6.2. Adding a note to the
subject, I hope this can get picked up before release...

~~ Lina
