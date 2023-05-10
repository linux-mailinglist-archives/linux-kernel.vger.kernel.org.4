Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708F6FDF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjEJOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbjEJOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:05:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4AEDC5D;
        Wed, 10 May 2023 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683727531; x=1715263531;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cMkjpKeFvfP5K5sO9oI/oUSBFm0m8GII6glpbTa/kME=;
  b=R48rgMBWBgYwb/D2RzMQ0BAHeKof8x6h3PjTc3lIylFGQ+OFrhWxV6fd
   YyuCmVSldaYL+o5jhiPVljkU1d1Jz83b6r5TbVgt0hOD3YUT3rmjSeqby
   GXpavjIzLloNItEGuolT2DLrWKVuMXGYUyZwN6r1TG/1Qxkh4WgFQ+h1w
   cKS4fx0PsmS0x42eB33WW3xsNqckyuiNuegRC1MDjujN8NruSQR0CYeCR
   4Hu8hG6W/7JXuJJjpAkaKaj1KIuDG6evz+ELjfBom3ALSyWojh6DWo+HC
   WrRwfjYTXVzAqxWJg1attqAU6d7Y+CGk+gqK20YJexFt0JAIFhNkByBDh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="350253915"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="350253915"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="768925579"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="768925579"
Received: from sschutze-mobl.ger.corp.intel.com ([10.251.218.236])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:05:29 -0700
Date:   Wed, 10 May 2023 17:05:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Liming Sun <limings@nvidia.com>
cc:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot
 log
In-Reply-To: <20230510115434.50166-1-limings@nvidia.com>
Message-ID: <0a9ce95-e861-ad24-7147-59dde7727a37@linux.intel.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com> <20230510115434.50166-1-limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023, Liming Sun wrote:

> This commit adds sysfs interface to be used to write into the
> boot log which is 1KB HW buffer on BlueField SoC. The same log
> buffer is also used by firmware code like ATF/UEFI, and can be
> displayed by userspace tools or from external host via USB/PCIe.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
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
>  drivers/platform/mellanox/mlxbf-bootctl.c     | 141 ++++++++++++++++++
>  2 files changed, 150 insertions(+)
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
> index 1bad1d278672..e88ce68acb89 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -45,10 +45,38 @@ static const char * const mlxbf_bootctl_lifecycle_states[] = {
>  	[3] = "RMA",
>  };
>  
> +/* Log header format. */
> +#define MLXBF_RSH_LOG_TYPE_SHIFT	56
> +#define MLXBF_RSH_LOG_LEN_SHIFT		48
> +#define MLXBF_RSH_LOG_LEVEL_SHIFT	0

Use GENMASK_ULL() instead here and FIELD_PREP() below.

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
> +	MLXBF_RSH_LOG_ERR
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
> @@ -266,12 +294,111 @@ static ssize_t fw_reset_store(struct device *dev,
>  	return count;
>  }
>  
> +/* Size(8-byte words) of the log buffer. */
> +#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
> +
> +static int mlxbf_rsh_log_sem_lock(void)
> +{
> +	unsigned long timeout;
> +
> +	/* Take the semaphore. */
> +	timeout = jiffies + msecs_to_jiffies(100);
> +	while (readq(mlxbf_rsh_semaphore)) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;

readq_poll_timeout()

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
> +	int rc, idx, num, len, size = (int)count, level = MLXBF_RSH_LOG_INFO;

Why casting to int, why not keep sizes as size_t??

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
> +	num = (size + sizeof(u64) - 1) / sizeof(u64);

DIV_ROUND_UP()

> +	idx = readq(mlxbf_rsh_scratch_buf_ctl);
> +	if (idx + num + 1 >= RSH_SCRATCH_BUF_CTL_IDX_MASK)
> +		num = RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1;

min() ?

> +	if (num <= 0)
> +		goto done;
> +
> +	/* Write Header. */
> +	data = (MLXBF_RSH_LOG_TYPE_MSG << MLXBF_RSH_LOG_TYPE_SHIFT) |
> +		((u64)num << MLXBF_RSH_LOG_LEN_SHIFT) |
> +		((u64)level << MLXBF_RSH_LOG_LEVEL_SHIFT);
> +	writeq(data, mlxbf_rsh_scratch_buf_data);
> +
> +	/* Write message. */
> +	for (idx = 0, len = size; idx < num && len > 0; idx++) {

size_t -> int conversion, why? Why you need another variable besides size 
anyway?

How can len <= 0 occur when idx < num is true?

> +		if (len <= sizeof(u64)) {

Why = ?

> +			data = 0;
> +			memcpy(&data, buf, len);
> +			len = 0;
> +		} else {
> +			memcpy(&data, buf, sizeof(u64));
> +			len -= sizeof(u64);
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
> @@ -280,6 +407,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_lifecycle_state.attr,
>  	&dev_attr_secure_boot_fuse_state.attr,
>  	&dev_attr_fw_reset.attr,
> +	&dev_attr_rsh_log.attr,
>  	NULL
>  };
>  
> @@ -345,6 +473,7 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
>  static int mlxbf_bootctl_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res = { 0 };
> +	void __iomem *reg;
>  	guid_t guid;
>  	int ret;
>  
> @@ -358,6 +487,18 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
>  	if (IS_ERR(mlxbf_rsh_boot_cnt))
>  		return PTR_ERR(mlxbf_rsh_boot_cnt);
>  
> +	/* Get the resource of the bootfifo counter register. */
> +	mlxbf_rsh_semaphore = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(mlxbf_rsh_semaphore))
> +		return PTR_ERR(mlxbf_rsh_semaphore);
> +
> +	/* Get the resource of the bootfifo counter register. */
> +	reg = devm_platform_ioremap_resource(pdev, 3);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +	mlxbf_rsh_scratch_buf_ctl = reg + MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
> +	mlxbf_rsh_scratch_buf_data = reg + MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
> +
>  	/* Ensure we have the UUID we expect for this service. */
>  	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
>  	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> 

-- 
 i.

