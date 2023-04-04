Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A46D64D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjDDOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjDDOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:11:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E400AF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:11:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5220D75;
        Tue,  4 Apr 2023 07:03:06 -0700 (PDT)
Received: from [10.57.53.173] (unknown [10.57.53.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC413F762;
        Tue,  4 Apr 2023 07:02:20 -0700 (PDT)
Message-ID: <8cb0be8c-8ff2-d643-2dba-135974c8bc3b@arm.com>
Date:   Tue, 4 Apr 2023 15:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 01/13] coresight: Fix loss of connection info when a
 module is unloaded
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230404135401.1728919-1-james.clark@arm.com>
 <20230404135401.1728919-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230404135401.1728919-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 14:53, James Clark wrote:
> child_fwnode should be a read only property based on the DT. If it's

minor nit: Not restricted to DT. This also covers the ACPI.

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
> Reproducible on Juno with the following steps:
> 
>    # load all coresight modules.
>    $ cd /sys/bus/coresight/devices/
>    $ echo 1 > tmc_etr0/enable_sink
>    $ echo 1 > etm0/enable_source
>    # Works fine ^
> 
>    $ echo 0 > etm0/enable_source
>    $ rmmod coresight-funnel
>    $ modprobe coresight-funnel
>    $ echo 1 > etm0/enable_source
>    -bash: echo: write error: Invalid argument
> 
> Fixes: 37ea1ffddffa ("coresight: Use fwnode handle instead of device names")
> Fixes: 2af89ebacf29 ("coresight: Clear the connection field properly")
> Signed-off-by: James Clark <james.clark@arm.com>

Looks good to me.

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

