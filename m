Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA06D0154
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjC3Kep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC3Kel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:34:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40CB211C;
        Thu, 30 Mar 2023 03:34:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 488202F4;
        Thu, 30 Mar 2023 03:35:15 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FED43F663;
        Thu, 30 Mar 2023 03:34:29 -0700 (PDT)
Message-ID: <3b95e362-300a-12af-0d55-76672c60be9f@arm.com>
Date:   Thu, 30 Mar 2023 11:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] perf/arm-cmn: fix regitster offset of
 CMN_MXP__CONNECT_INFO_P2-5
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
References: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-30 10:47, Jing Zhang wrote:
> In the CMN700 specification, it is described that the address offset
> of the mxp_device_connect_info_p0-5 register is 16'h8 + #{8*index}.
> Therefore, the address offset of the CMN_MXP__CONNECT_INFO_P2-5 macro
> defined in the code is wrong, which causes the cmn700 topology map
> incorrect printed in debugfs.
> 
> So correct the address offset value to make the cmn700 topology map
> correct in debugfs.
> 
> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")

Ugh, these offsets are correct for CI-700, so strictly that commit is 
fine. What I failed to notice is that CMN-700 shuffled the 
mesh_port_connect_info registers out of the way, so it's commit 
23760a014417 which should have added more handling for this difference.

Thanks,
Robin.

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   drivers/perf/arm-cmn.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 1deb61b..e9f844b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -59,10 +59,10 @@
>   /* XPs also have some local topology info which has uses too */
>   #define CMN_MXP__CONNECT_INFO_P0	0x0008
>   #define CMN_MXP__CONNECT_INFO_P1	0x0010
> -#define CMN_MXP__CONNECT_INFO_P2	0x0028
> -#define CMN_MXP__CONNECT_INFO_P3	0x0030
> -#define CMN_MXP__CONNECT_INFO_P4	0x0038
> -#define CMN_MXP__CONNECT_INFO_P5	0x0040
> +#define CMN_MXP__CONNECT_INFO_P2	0x0018
> +#define CMN_MXP__CONNECT_INFO_P3	0x0020
> +#define CMN_MXP__CONNECT_INFO_P4	0x0028
> +#define CMN_MXP__CONNECT_INFO_P5	0x0030
>   #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
>   
>   /* PMU registers occupy the 3rd 4KB page of each node's region */
