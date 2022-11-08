Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F036205AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiKHBQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:16:22 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F111E016;
        Mon,  7 Nov 2022 17:16:21 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5qq35Ns9zJnYV;
        Tue,  8 Nov 2022 09:13:19 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:16:19 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 09:16:19 +0800
Message-ID: <0f37ecd9-7859-ea41-80e2-9d4297f69b3d@huawei.com>
Date:   Tue, 8 Nov 2022 09:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ACPICA: Fix error code path in
 acpi_ds_call_control_method()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
References: <2669303.mvXUDI8C0e@kreacher>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <2669303.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/8 1:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A use-after-free in acpi_ps_parse_aml() after a failing invocaion of
> acpi_ds_call_control_method() is reported by KASAN [1] and code
> inspection reveals that next_walk_state pushed to the thread by
> acpi_ds_create_walk_state() is freed on errors, but it is not popped
> from the thread beforehand.  Thus acpi_ds_get_current_walk_state()
> called by acpi_ps_parse_aml() subsequently returns it as the new
> walk state which is incorrect.
>
> To address this, make acpi_ds_call_control_method() call
> acpi_ds_pop_walk_state() to pop next_walk_state from the thread before
> returning an error.
>
> Link: https://lore.kernel.org/linux-acpi/20221019073443.248215-1-chenzhongjin@huawei.com/
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpica/dsmethod.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpica/dsmethod.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/dsmethod.c
> +++ linux-pm/drivers/acpi/acpica/dsmethod.c
> @@ -517,7 +517,7 @@ acpi_ds_call_control_method(struct acpi_
>   	info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
>   	if (!info) {
>   		status = AE_NO_MEMORY;
> -		goto cleanup;
> +		goto pop_walk_state;
>   	}
>   
>   	info->parameters = &this_walk_state->operands[0];
> @@ -529,7 +529,7 @@ acpi_ds_call_control_method(struct acpi_
>   
>   	ACPI_FREE(info);
>   	if (ACPI_FAILURE(status)) {
> -		goto cleanup;
> +		goto pop_walk_state;
>   	}
>   
>   	next_walk_state->method_nesting_depth =
> @@ -575,6 +575,12 @@ acpi_ds_call_control_method(struct acpi_
>   
>   	return_ACPI_STATUS(status);
>   
> +pop_walk_state:
> +
> +	/* On error, pop the walk state to be deleted from thread */
> +
> +	acpi_ds_pop_walk_state(thread);
> +
>   cleanup:
>   
>   	/* On error, we must terminate the method properly */
>
>
LGTM

Reviewed-by: Chen Zhongjin <chenzhongjin@huawei.com>

