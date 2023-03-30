Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0E6D0513
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC3Mmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjC3Mmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:42:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 127C47D8B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:42:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C7C92F4;
        Thu, 30 Mar 2023 05:43:34 -0700 (PDT)
Received: from [10.57.54.53] (unknown [10.57.54.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1653F6C4;
        Thu, 30 Mar 2023 05:42:47 -0700 (PDT)
Message-ID: <d398a5c4-90f1-e717-fb73-d621f5ea845b@arm.com>
Date:   Thu, 30 Mar 2023 13:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/13] coresight: Fix loss of connection info when a
 module is unloaded
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230329115329.2747724-1-james.clark@arm.com>
 <20230329115329.2747724-7-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230329115329.2747724-7-james.clark@arm.com>
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

Hi James

On 29/03/2023 12:53, James Clark wrote:
> child_fwnode should be a read only property based on the DT. If it's
> cleared on the parent device when a child is unloaded, then when the
> child is loaded again the connection won't be remade.
> 
> child_dev should be cleared instead which signifies that the connection
> should be remade when the child_fwnode registers a new coresight_device.
> 
> Similarly the reference count shouldn't be decremented as long as the
> parent device exists. The correct place to drop the reference is in
> coresight_release_platform_data() which is already done.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

This looks like a bug in the existing driver. Please could you keep this
at the beginning of the series, so that it is easier to backport for
stable ?

Also, please add :

Fixes: 37ea1ffddffa ("coresight: Use fwnode handle instead of device names")
Fixes: 2af89ebacf29 ("coresight: Clear the connection field properly")


> ---
>   drivers/hwtracing/coresight/coresight-core.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index bfe1b93aca4e..12cbb68e8e1c 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1414,13 +1414,8 @@ static int coresight_remove_match(struct device *dev, void *data)
>   		if (csdev->dev.fwnode == conn->dest_fwnode) {
>   			iterator->orphan = true;
>   			coresight_remove_links(iterator, conn);
> -			/*
> -			 * Drop the reference to the handle for the remote
> -			 * device acquired in parsing the connections from
> -			 * platform data.
> -			 */
> -			fwnode_handle_put(conn->dest_fwnode);
> -			conn->dest_fwnode = NULL;
> +
> +			conn->dest_dev = NULL;
>   			/* No need to continue */
>   			break;
>   		}
> @@ -1553,7 +1548,6 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   		 * is going away
>   		 */
>   		fwnode_handle_put(conns[i].dest_fwnode);
> -		pdata->out_conns[i].dest_fwnode = NULL;

This change is not required, as we are freeing the pdata anyway.
Keeping this might be beneficial if someone else comes looking
for references while we are going out. I don't see how we could
hit that, but just to be safe.

Suzuki

