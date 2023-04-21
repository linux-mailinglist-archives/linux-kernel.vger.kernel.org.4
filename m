Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE56EA635
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjDUItB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjDUIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:48:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DAF6A5D6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:46:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 643431480;
        Fri, 21 Apr 2023 01:47:00 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B0D3F5A1;
        Fri, 21 Apr 2023 01:46:15 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:46:11 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue()
 invocation
Message-ID: <ZEJNU1om5IhQHB2J@e120937-lin>
References: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:33:49AM -1000, Tejun Heo wrote:
> scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
> Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
> interface and using 0 for @max_active for the default setting.
> 

Hi Tejun,

my bad I messed up the params in the call.

LGTM.

Thanks,
Cristian

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/firmware/arm_scmi/raw_mode.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/firmware/arm_scmi/raw_mode.c
> +++ b/drivers/firmware/arm_scmi/raw_mode.c
> @@ -1066,7 +1066,7 @@ static int scmi_xfer_raw_worker_init(str
>  
>  	raw->wait_wq = alloc_workqueue("scmi-raw-wait-wq-%d",
>  				       WQ_UNBOUND | WQ_FREEZABLE |
> -				       WQ_HIGHPRI, WQ_SYSFS, raw->id);
> +				       WQ_HIGHPRI | WQ_SYSFS, 0, raw->id);
>  	if (!raw->wait_wq)
>  		return -ENOMEM;
>  
