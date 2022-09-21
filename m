Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF285C0444
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiIUQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiIUQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:34:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 368BCA8955
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:17:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8480C1FC4;
        Wed, 21 Sep 2022 09:17:16 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373FB3F5A1;
        Wed, 21 Sep 2022 09:17:09 -0700 (PDT)
Message-ID: <b341c342-954d-a261-7ebf-df20573fa2fb@arm.com>
Date:   Wed, 21 Sep 2022 17:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address
 offset field
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
References: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 8:54 pm, Ilkka Koskinen wrote:
> CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
> are required to be zero.
> 
> For CMN-650, the child node address offset field has been increased
> to include bits [29:0] while leaving only bit 30 set to zero.
> 
> Let's include the missing two bits and assume older implementations
> comply with the spec and set bits [29:28] to 0.

Just to add that other users have run into this as well, so getting it 
applied as a fix would be just lovely. Technically I think it's:

Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")

Cheers,
Robin.

> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> 
> I have tested this patch on CMN-600 and CMN-650.
> 
> drivers/perf/arm-cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 80d8309652a4..b80a9b74662b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -36,7 +36,7 @@
>   #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
>   #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>   
> -#define CMN_CHILD_NODE_ADDR		GENMASK(27, 0)
> +#define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>   
>   #define CMN_MAX_DIMENSION		12
