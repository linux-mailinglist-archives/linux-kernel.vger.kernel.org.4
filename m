Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B06DA9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjDGIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjDGIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:17:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5789EEA;
        Fri,  7 Apr 2023 01:16:38 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PtB0T2lfSz17RG4;
        Fri,  7 Apr 2023 16:11:37 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Apr 2023 16:15:04 +0800
Subject: Re: [PATCH] scsi: hisi_sas: work around build failure in suspend
 function
To:     Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yihang Li <liyihang9@huawei.com>
References: <20230405083611.3376739-1-arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <ef58d36e-9b67-d2b6-5671-be27d739f928@hisilicon.com>
Date:   Fri, 7 Apr 2023 16:15:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230405083611.3376739-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


在 2023/4/5 16:36, Arnd Bergmann 写道:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The suspend/resume functions in this driver seem to have multiple
> problems, the latest one just got introduced by a bugfix:
>
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
>   5142 |         if (atomic_read(&device->power.usage_count)) {
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
>   5142 |         if (atomic_read(&device->power.usage_count)) {
>
> As far as I can tell, the 'usage_count' is not meant to be accessed
> by device drivers at all, though I don't know what the driver is
> supposed to do instead.

Thank you for reporting the issue.
There is a extreme situation that hisi_sas driver tries to resume 
controller when it is in the process of suspend, which will cause a 
deadlock.
So we check usage_count of controller, and if usage_count > 0, failed to 
suspend to avoid the issue. But there is no common function defined
in pm_runtime.h which check the usage_count of device, so use it 
directly (i saw the check also be used in other drivers).
But i didn't realize that member usage_count is defined only under 
CONFIG_PM=y.


>
> Another problem is the use of the deprecated UNIVERSAL_DEV_PM_OPS(),
> and marking functions as __maybe_unused to avoid warnings about
> unused functions.  This should probably be changed to using
> DEFINE_RUNTIME_DEV_PM_OPS().

We use UNIVERSAL_DEV_PM_OPS() just because runtime callbacks 
runtime_{suspend|resume} and system callbacks {suspend|resume} use the same
operations in the driver, otherwise, we need to use 
DEFINE_RUNTIME_DEV_PM_OPS() to define runtime callbacks and use 
DEFINE_SIMPLE_DEV_PM_OPS()
to define system callbacks.

>
> Both changes require actually understanding what the driver needs to
> do, and being able to test this, so instead here is the simplest
> patch to make it pass the randconfig builds instead.
>
> Fixes: e368d38cb952 ("scsi: hisi_sas: Exit suspend state when usage count is greater than 0")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Maintainers: If possible, please revisit this to do a proper fix.
> If that takes too much time, this patch can be applied as a
> workaround in the meantime, and might also help in case the
> e368d38cb952 patch gets backported to stable kernels.

It is ok to apply the patch as a workaround as soon as possible.

Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>

Thanks!

> ---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index d160b9b7479b..12d588454f5d 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -5139,11 +5139,13 @@ static int _suspend_v3_hw(struct device *device)
>   	flush_workqueue(hisi_hba->wq);
>   	interrupt_disable_v3_hw(hisi_hba);
>   
> +#ifdef CONFIG_PM
>   	if (atomic_read(&device->power.usage_count)) {
>   		dev_err(dev, "PM suspend: host status cannot be suspended\n");
>   		rc = -EBUSY;
>   		goto err_out;
>   	}
> +#endif
>   
>   	rc = disable_host_v3_hw(hisi_hba);
>   	if (rc) {
> @@ -5162,7 +5164,9 @@ static int _suspend_v3_hw(struct device *device)
>   
>   err_out_recover_host:
>   	enable_host_v3_hw(hisi_hba);
> +#ifdef CONFIG_PM
>   err_out:
> +#endif
>   	interrupt_enable_v3_hw(hisi_hba);
>   	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
>   	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);

