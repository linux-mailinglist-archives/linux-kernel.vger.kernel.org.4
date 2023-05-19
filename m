Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76852709750
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjESMi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjESMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:38:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D6BFF4;
        Fri, 19 May 2023 05:38:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBDE1FB;
        Fri, 19 May 2023 05:39:08 -0700 (PDT)
Received: from [10.57.73.119] (unknown [10.57.73.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C83D3F762;
        Fri, 19 May 2023 05:38:21 -0700 (PDT)
Message-ID: <b40b3512-1782-80ad-2bcc-6a7558fc64a2@arm.com>
Date:   Fri, 19 May 2023 13:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V3 3/6] coresight: etm4x: Drop pid argument from
 etm4_probe()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230519052149.1367814-1-anshuman.khandual@arm.com>
 <20230519052149.1367814-4-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230519052149.1367814-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 06:21, Anshuman Khandual wrote:
> Coresight device pid can be retrieved from its iomem base address, which is
> stored in 'struct etm4x_drvdata'. This drops pid argument from etm4_probe()
> and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives the
> coresight device pid with a new helper coresight_get_pid(), right before it
> is consumed in etm4_hisi_match_pid().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   .../coresight/coresight-etm4x-core.c          | 29 ++++++++++---------
>   include/linux/coresight.h                     | 12 ++++++++
>   2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 748d2ef53cb0..914ef6eb85d1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>   static enum cpuhp_state hp_online;
>   
>   struct etm4_init_arg {
> -	unsigned int		pid;
>   	struct device		*dev;
>   	struct csdev_access	*csa;
>   };
> @@ -370,9 +369,17 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>   }
>   
>   static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
> -				      unsigned int id)
> +				     struct csdev_access *csa)
>   {
> -	if (etm4_hisi_match_pid(id))
> +	/*
> +	 * coresight_get_pid() fetches device PID from the iomem
> +	 * register based accesses, which cannot be performed on
> +	 * system instruction based devices.
> +	 */

Minor nit: Please fix the comment to say something like :

	/*
	 * TRCPIDR* registers are not required for ETMs with system
	 * instructions. They must be identified by the MIDR+REVIDRs.
	 * Skip the TRCPID checks for now.
	 */

Rest looks good to me.

Suzuki

