Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE4702DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbjEONUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEONUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A82D55
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684156758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNZ58ncn4bTbnz3JgK1sPvomNHxhBGYZSP9178bl+vI=;
        b=EZjZaocXUX+WEtqkl6UCg16pmxRAPl684bJV/xmGQXPIEwY0M0aLgEsW9L/xXrOqMwxuB5
        Igo9eJ3FY+t6dFUolJqssyN8/K9TT5mohWVFeJcMBV1lArAlkN02d9/WRGWMU6WjMMN1vx
        e+/N5FrRfQ+Pd2MMyGsWYHJvqjDfmHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-bukVN5UuPjeAXFcvwBsnNA-1; Mon, 15 May 2023 09:19:17 -0400
X-MC-Unique: bukVN5UuPjeAXFcvwBsnNA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96ae3faf801so266571566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156755; x=1686748755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNZ58ncn4bTbnz3JgK1sPvomNHxhBGYZSP9178bl+vI=;
        b=OU9U0qWmHVXcB+Bq97hv+kKiV05eRBbsckmGIbaxiCmdXfAb3Hj2QJ018lwY9xcUYF
         sBdP50TrRj4Er3ASl7zHWj2jecAO8QGH/UQ3MwIC3puCQhNIdvJUoUhqPdcOYlxU9Omi
         KrYHdWSrtTTCLktu6iPE98gH/nhb0JhouX9hEfJlSm6AwUPI5NJgThaBiJzUAnACXJBF
         iDslP9fQSSDwLupPgcIju3rnyZs6TB1MxNRRmmKfKjCSEawoisRJwS0gaEVaujpHYggp
         hHE4jylKCtwzqqSFbLeoc3VixQ4b7xjaD6F+k0At/zZ3X75OCNbewGYIRIvd0v1CeOXm
         Yzrg==
X-Gm-Message-State: AC+VfDwQA4w6Bm28WjnoT/SiBkoPr6d3gn5ffc490uZLJ9JhV5EoqKAR
        ijea/jv77XBvPEHF4qOhaPLfDjwLozxa7rpyQAk0VqoPM8WEHOCrxg8WN/BaKUwdOeAP4aRz1uM
        asr27UfvRjipr5AucYye8uMTJSUVV0Tt6
X-Received: by 2002:a17:907:7da3:b0:96a:ee54:9f19 with SMTP id oz35-20020a1709077da300b0096aee549f19mr6096945ejc.48.1684156755562;
        Mon, 15 May 2023 06:19:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hyxM8ytx+OvsALSN//ajhR1ubhIBFsdQbkfbtTy1R+a4VNo6CkhFLefpuBUWNRQav4dbn+g==
X-Received: by 2002:a17:907:7da3:b0:96a:ee54:9f19 with SMTP id oz35-20020a1709077da300b0096aee549f19mr6096919ejc.48.1684156755092;
        Mon, 15 May 2023 06:19:15 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id hx7-20020a170906846700b00965a4350411sm9412581ejc.9.2023.05.15.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:19:14 -0700 (PDT)
Message-ID: <2e46bea9-c55f-6ca7-b68e-50dd8616736e@redhat.com>
Date:   Mon, 15 May 2023 15:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] mlxbf-bootctl: Add sysfs file for BlueField boot log
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
 <20230511144924.171585-1-limings@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230511144924.171585-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/23 16:49, Liming Sun wrote:
> This commit adds sysfs interface to be used to write into the
> boot log which is 1KB HW buffer on BlueField SoC. The same log
> buffer is also used by firmware code like ATF/UEFI, and can be
> displayed by userspace tools or from external host via USB/PCIe.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v2->v3:
>     Fixes for comments from David:
>     - Add MLXBF_RSH_LOG_ASSERT;
>     - Use FIELD_PREP generate value in "data";
>     - Fix cut-and-paste comments;
>     Fixes for comments from Ilpo
>     - Use GENMASK_ULL();
>     - Use readq_poll_timeout() in mlxbf_rsh_log_sem_lock();
>     - No need to cast 'count' to int, keep 'size_t' instead;
>     - Use DIV_ROUND_UP;
>     - Use min() when calculating 'num' of words to write;
>     - Simplify the 'Write message' loop and removed 'len' from
>       the loop.
> v1->v2:
>     Fixes for comments from Hans:
>     - Add more details in Documentation about the log levels;
>     - Replace 0x0a with '\n';
>     - Solve comment 'Why len + 1, this seems intended to assume some
>       separator between prefix'. The change is to remove the '+ 1'
>       here to avoid confusion. Yes, it's trying to remove the space
>       separator. Since the next block 'Ignore leading spaces' already
>       has similar logic, no need for the '+ 1" here.
> v1: Initial version.
> ---
>  .../testing/sysfs-platform-mellanox-bootctl   |   9 ++
>  drivers/platform/mellanox/mlxbf-bootctl.c     | 144 +++++++++++++++++-
>  2 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> index 9b99a81babb1..4c5c02d8f870 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -75,3 +75,12 @@ KernelVersion:	6.4
>  Contact:	"Liming Sun <limings@nvidia.com>"
>  Description:
>  		The file used to access the BlueField boot fifo.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/rsh_log
> +Date:		May 2023
> +KernelVersion:	6.4
> +Contact:	"Liming Sun <limings@nvidia.com>"
> +Description:
> +		The file used to write BlueField boot log with the format
> +                "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is used by
> +                default if not specified.
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1bad1d278672..fb9f7815c6cd 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> @@ -45,10 +46,39 @@ static const char * const mlxbf_bootctl_lifecycle_states[] = {
>  	[3] = "RMA",
>  };
>  
> +/* Log header format. */
> +#define MLXBF_RSH_LOG_TYPE_MASK		GENMASK_ULL(59, 56)
> +#define MLXBF_RSH_LOG_LEN_MASK		GENMASK_ULL(54, 48)
> +#define MLXBF_RSH_LOG_LEVEL_MASK	GENMASK_ULL(7, 0)
> +
> +/* Log module ID and type (only MSG type in Linux driver for now). */
> +#define MLXBF_RSH_LOG_TYPE_MSG		0x04ULL
> +
> +/* Log ctl/data register offset. */
> +#define MLXBF_RSH_SCRATCH_BUF_CTL_OFF	0
> +#define MLXBF_RSH_SCRATCH_BUF_DATA_OFF	0x10
> +
> +/* Log message levels. */
> +enum {
> +	MLXBF_RSH_LOG_INFO,
> +	MLXBF_RSH_LOG_WARN,
> +	MLXBF_RSH_LOG_ERR,
> +	MLXBF_RSH_LOG_ASSERT
> +};
> +
>  /* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT register. */
>  static void __iomem *mlxbf_rsh_boot_data;
>  static void __iomem *mlxbf_rsh_boot_cnt;
>  
> +/* Mapped pointer for rsh log semaphore/ctrl/data register. */
> +static void __iomem *mlxbf_rsh_semaphore;
> +static void __iomem *mlxbf_rsh_scratch_buf_ctl;
> +static void __iomem *mlxbf_rsh_scratch_buf_data;
> +
> +/* Rsh log levels. */
> +static const char * const mlxbf_rsh_log_level[] = {
> +	"INFO", "WARN", "ERR", "ASSERT"};
> +
>  /* ARM SMC call which is atomic and no need for lock. */
>  static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
>  {
> @@ -266,12 +296,108 @@ static ssize_t fw_reset_store(struct device *dev,
>  	return count;
>  }
>  
> +/* Size(8-byte words) of the log buffer. */
> +#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
> +
> +/* 100ms timeout */
> +#define RSH_SCRATCH_BUF_POLL_TIMEOUT	100000
> +
> +static int mlxbf_rsh_log_sem_lock(void)
> +{
> +	unsigned long reg;
> +
> +	return readq_poll_timeout(mlxbf_rsh_semaphore, reg, !reg, 0,
> +				  RSH_SCRATCH_BUF_POLL_TIMEOUT);
> +}
> +
> +static void mlxbf_rsh_log_sem_unlock(void)
> +{
> +	writeq(0, mlxbf_rsh_semaphore);
> +}
> +
> +static ssize_t rsh_log_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int rc, idx, num, len, level = MLXBF_RSH_LOG_INFO;
> +	size_t size = count;
> +	u64 data;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	if (!mlxbf_rsh_semaphore || !mlxbf_rsh_scratch_buf_ctl)
> +		return -EOPNOTSUPP;
> +
> +	/* Ignore line break at the end. */
> +	if (buf[size - 1] == '\n')
> +		size--;
> +
> +	/* Check the message prefix. */
> +	for (idx = 0; idx < ARRAY_SIZE(mlxbf_rsh_log_level); idx++) {
> +		len = strlen(mlxbf_rsh_log_level[idx]);
> +		if (len + 1 < size &&
> +		    !strncmp(buf, mlxbf_rsh_log_level[idx], len)) {
> +			buf += len;
> +			size -= len;
> +			level = idx;
> +			break;
> +		}
> +	}
> +
> +	/* Ignore leading spaces. */
> +	while (size > 0 && buf[0] == ' ') {
> +		size--;
> +		buf++;
> +	}
> +
> +	/* Take the semaphore. */
> +	rc = mlxbf_rsh_log_sem_lock();
> +	if (rc)
> +		return rc;
> +
> +	/* Calculate how many words are available. */
> +	idx = readq(mlxbf_rsh_scratch_buf_ctl);
> +	num = min((int)DIV_ROUND_UP(size, sizeof(u64)),
> +		  RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1);
> +	if (num <= 0)
> +		goto done;
> +
> +	/* Write Header. */
> +	data = FIELD_PREP(MLXBF_RSH_LOG_TYPE_MASK, MLXBF_RSH_LOG_TYPE_MSG);
> +	data |= FIELD_PREP(MLXBF_RSH_LOG_LEN_MASK, num);
> +	data |= FIELD_PREP(MLXBF_RSH_LOG_LEVEL_MASK, level);
> +	writeq(data, mlxbf_rsh_scratch_buf_data);
> +
> +	/* Write message. */
> +	for (idx = 0; idx < num && size > 0; idx++) {
> +		if (size < sizeof(u64)) {
> +			data = 0;
> +			memcpy(&data, buf, size);
> +			size = 0;
> +		} else {
> +			memcpy(&data, buf, sizeof(u64));
> +			size -= sizeof(u64);
> +			buf += sizeof(u64);
> +		}
> +		writeq(data, mlxbf_rsh_scratch_buf_data);
> +	}
> +
> +done:
> +	/* Release the semaphore. */
> +	mlxbf_rsh_log_sem_unlock();
> +
> +	/* Ignore the rest if no more space. */
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(post_reset_wdog);
>  static DEVICE_ATTR_RW(reset_action);
>  static DEVICE_ATTR_RW(second_reset_action);
>  static DEVICE_ATTR_RO(lifecycle_state);
>  static DEVICE_ATTR_RO(secure_boot_fuse_state);
>  static DEVICE_ATTR_WO(fw_reset);
> +static DEVICE_ATTR_WO(rsh_log);
>  
>  static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_post_reset_wdog.attr,
> @@ -280,6 +406,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_lifecycle_state.attr,
>  	&dev_attr_secure_boot_fuse_state.attr,
>  	&dev_attr_fw_reset.attr,
> +	&dev_attr_rsh_log.attr,
>  	NULL
>  };
>  
> @@ -345,19 +472,32 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
>  static int mlxbf_bootctl_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res = { 0 };
> +	void __iomem *reg;
>  	guid_t guid;
>  	int ret;
>  
> -	/* Get the resource of the bootfifo data register. */
> +	/* Map the resource of the bootfifo data register. */
>  	mlxbf_rsh_boot_data = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mlxbf_rsh_boot_data))
>  		return PTR_ERR(mlxbf_rsh_boot_data);
>  
> -	/* Get the resource of the bootfifo counter register. */
> +	/* Map the resource of the bootfifo counter register. */
>  	mlxbf_rsh_boot_cnt = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(mlxbf_rsh_boot_cnt))
>  		return PTR_ERR(mlxbf_rsh_boot_cnt);
>  
> +	/* Map the resource of the rshim semaphore register. */
> +	mlxbf_rsh_semaphore = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(mlxbf_rsh_semaphore))
> +		return PTR_ERR(mlxbf_rsh_semaphore);
> +
> +	/* Map the resource of the scratch buffer (log) registers. */
> +	reg = devm_platform_ioremap_resource(pdev, 3);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +	mlxbf_rsh_scratch_buf_ctl = reg + MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
> +	mlxbf_rsh_scratch_buf_data = reg + MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
> +
>  	/* Ensure we have the UUID we expect for this service. */
>  	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
>  	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);

