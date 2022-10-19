Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1811D604A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJSO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJSO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD095E303
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:51:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99CF61FB;
        Wed, 19 Oct 2022 07:51:31 -0700 (PDT)
Received: from [10.57.68.61] (unknown [10.57.68.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BF233F7D8;
        Wed, 19 Oct 2022 07:51:23 -0700 (PDT)
Message-ID: <61b38606-8006-30c3-d94c-8bc5e4f38bf7@arm.com>
Date:   Wed, 19 Oct 2022 15:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] coresight: cti: Fix hang in cti_disable_hw()
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, Sudeep.Holla@arm.com,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005131452.1506328-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221005131452.1506328-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On 05/10/2022 14:14, James Clark wrote:
> cti_enable_hw() and cti_disable_hw() are called from an atomic context
> so shouldn't use runtime PM because it can result in a sleep when
> communicating with firmware.
> 
> Since commit 3c6656337852 ("Revert "firmware: arm_scmi: Add clock
> management to the SCMI power domain""), this causes a hang on Juno when
> running the Perf Coresight tests or running this command:
> 
>    perf record -e cs_etm//u -- ls
> 
> This was also missed until the revert commit because pm_runtime_put()
> was called with the wrong device until commit 692c9a499b28 ("coresight:
> cti: Correct the parameter for pm_runtime_put")
> 
> With lock and scheduler debugging enabled the following is output:
> 

...

> 
> Fix the issue by removing the runtime PM calls completely. They are not
> needed here because it must have already been done when building the
> path for a trace.
> 
> Fixes: 835d722ba10a ("coresight: cti: Initial CoreSight CTI Driver")
> Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
> Reported-by: Cristian Marussi <Cristian.Marussi@arm.com>
> Signed-off-by: Suzuki Poulose <Suzuki.Poulose@arm.com>

I have applied this patch, changing the above to:

Suggested-by: ...

Suzuki

