Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF3709759
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjESMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjESMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59EB2106;
        Fri, 19 May 2023 05:40:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E83171FB;
        Fri, 19 May 2023 05:40:52 -0700 (PDT)
Received: from [10.57.73.119] (unknown [10.57.73.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990F13F762;
        Fri, 19 May 2023 05:40:05 -0700 (PDT)
Message-ID: <c498eb81-7b3f-a32c-02d7-572c17876a2d@arm.com>
Date:   Fri, 19 May 2023 13:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V3 6/6] coresight: platform: acpi: Ignore the absence of
 graph
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
 <20230519052149.1367814-7-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230519052149.1367814-7-anshuman.khandual@arm.com>
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
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Some components may not have graph connections for describing
> the trace path. e.g., ETE, where it could directly use the per
> CPU TRBE. Ignore the absence of graph connections
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Please could you move this before the Patch 5, where we add
ACPI support for etm4x with system instructions ? That way
the support is up with that patch, without an error that
is fixed by this patch.

Suzuki


> ---
>   drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 475899714104..c4b4fbde8550 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -692,8 +692,12 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>   
>   	pdata->nr_inport = pdata->nr_outport = 0;
>   	graph = acpi_get_coresight_graph(adev);
> +	/*
> +	 * There are no graph connections, which is fine for some components.
> +	 * e.g., ETE
> +	 */
>   	if (!graph)
> -		return -ENOENT;
> +		return 0;
>   
>   	nlinks = graph->package.elements[2].integer.value;
>   	if (!nlinks)

