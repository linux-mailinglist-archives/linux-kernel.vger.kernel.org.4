Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71863AB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiK1Oxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiK1Oxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:53:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976022B2C;
        Mon, 28 Nov 2022 06:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB202611F4;
        Mon, 28 Nov 2022 14:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE823C433C1;
        Mon, 28 Nov 2022 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669647218;
        bh=uw2Pi5jCM9SNVGuWQrPxGM8G6h+A6DL8Wbgr4ldBBK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iai5b6NNmqzWlethjpBpunwrT1Jaq9dt0GsD7syLzt3NXZiYe0Ko+Dkb6gz/uRVhx
         zIAP+o+tUBQAPZFq3CZEtce4DVsBqurzE7Mko8zZMoyeqrNuM86LqdKbadDaMhhD+v
         Yvb78+7XWytsMg8d6+XXHoQPudnNkPQXL6UxGbUz/779AuFkoKTzN0RB6YM0dzZJ+f
         aID1F7ZxlfbBVPxK5JuPi6NqZXnw08RiMfEFmYkWKWTTJ7Qs0nOvb0HIXI5V7HU3Pz
         EXqCmkd0e/GrMfxc34Q7qm95yF3mHA4gzR4SPRSrEsrkMATaPw8unTJx1EgiyN0L24
         7yni1H4zKOvdA==
Date:   Mon, 28 Nov 2022 20:23:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/16] ufs: core: mcq: Add Multi Circular Queue support
Message-ID: <20221128145321.GE62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <91d17ea9623b06d66027699257816bb2fb7176cb.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d17ea9623b06d66027699257816bb2fb7176cb.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:18PM -0800, Asutosh Das wrote:
> Add support for multi-circular queue (MCQ) which has been added
> in UFSHC v4.0 standard in addition to the Single Doorbell mode.
> The MCQ mode supports multiple submission and completion queues.
> Add support to configure the number of queues.
> 

The patch subject is pretty opaque. Please use something like "Add initial
Multi Circular Queue support" or something similar to specify that this patch
only adds support for configuring the queues and not the full MCQ support.

Also, this patch adds the module params for queues, so that should be mentioned
in the description.

> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/Makefile      |   2 +-
>  drivers/ufs/core/ufs-mcq.c     | 125 +++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |   1 +
>  drivers/ufs/core/ufshcd.c      |  12 ++++
>  include/ufs/ufshcd.h           |   4 ++
>  5 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ufs/core/ufs-mcq.c
> 
> diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
> index 62f38c5..4d02e0f 100644
> --- a/drivers/ufs/core/Makefile
> +++ b/drivers/ufs/core/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_SCSI_UFSHCD)		+= ufshcd-core.o
> -ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
> +ufshcd-core-y				+= ufshcd.o ufs-sysfs.o ufs-mcq.o
>  ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> new file mode 100644
> index 0000000..3818f45
> --- /dev/null
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center. All rights reserved.
> + *
> + * Authors:
> + *	Asutosh Das <quic_asutoshd@quicinc.com>
> + *	Can Guo <quic_cang@quicinc.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include "ufshcd-priv.h"
> +
> +#define UFS_MCQ_MIN_RW_QUEUES 2
> +#define UFS_MCQ_MIN_READ_QUEUES 0
> +#define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
> +#define UFS_MCQ_MIN_POLL_QUEUES 0
> +

Remove extra new line

> +
> +static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
> +				     num_possible_cpus());
> +}
> +
> +static const struct kernel_param_ops rw_queue_count_ops = {
> +	.set = rw_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int rw_queues;
> +module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
> +MODULE_PARM_DESC(rw_queues,
> +		 "Number of interrupt driven I/O queues used for rw. Default value is nr_cpus");
> +
> +static int read_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_READ_QUEUES,
> +				     num_possible_cpus());
> +}
> +
> +static const struct kernel_param_ops read_queue_count_ops = {
> +	.set = read_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int read_queues;
> +module_param_cb(read_queues, &read_queue_count_ops, &read_queues, 0644);
> +MODULE_PARM_DESC(read_queues,
> +		 "Number of interrupt driven read queues used for read. Default value is 0");
> +
> +static int poll_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_POLL_QUEUES,
> +				     num_possible_cpus());
> +}
> +
> +static const struct kernel_param_ops poll_queue_count_ops = {
> +	.set = poll_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int poll_queues = 1;
> +module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
> +MODULE_PARM_DESC(poll_queues,
> +		 "Number of poll queues used for r/w. Default value is 1");
> +
> +static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
> +{
> +	int i;
> +	u32 hba_maxq, rem, tot_queues;
> +	struct Scsi_Host *host = hba->host;
> +
> +	hba_maxq = FIELD_GET(GENMASK(7, 0), hba->mcq_capabilities);

It'd be good to add a definition for GENMASK(7, 0).

> +
> +	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
> +			rw_queues;
> +
> +	if (hba_maxq < tot_queues) {
> +		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
> +			tot_queues, hba_maxq);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rem = hba_maxq - UFS_MCQ_NUM_DEV_CMD_QUEUES;
> +
> +	if (rw_queues) {
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
> +		rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
> +	} else {
> +		rw_queues = num_possible_cpus();
> +	}
> +
> +	if (poll_queues) {
> +		hba->nr_queues[HCTX_TYPE_POLL] = poll_queues;
> +		rem -= hba->nr_queues[HCTX_TYPE_POLL];
> +	}
> +
> +	if (read_queues) {
> +		hba->nr_queues[HCTX_TYPE_READ] = read_queues;
> +		rem -= hba->nr_queues[HCTX_TYPE_READ];
> +	}
> +
> +	if (!hba->nr_queues[HCTX_TYPE_DEFAULT])
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(rem, rw_queues,
> +							 num_possible_cpus());
> +
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		host->nr_hw_queues += hba->nr_queues[i];
> +
> +	hba->nr_hw_queues = host->nr_hw_queues + UFS_MCQ_NUM_DEV_CMD_QUEUES;
> +	return 0;
> +}
> +
> +int ufshcd_mcq_init(struct ufs_hba *hba)
> +{
> +	int ret;
> +
> +	ret = ufshcd_mcq_config_nr_queues(hba);
> +
> +	return ret;
> +}
> +
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index a9e8e1f..9368ba2 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -61,6 +61,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
>  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, u8 index, bool *flag_res);
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
> +int ufshcd_mcq_init(struct ufs_hba *hba);
>  
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 42c49ce..0c4cd8f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8196,6 +8196,11 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +static int ufshcd_alloc_mcq(struct ufs_hba *hba)
> +{
> +	return ufshcd_mcq_init(hba);
> +}
> +
>  /**
>   * ufshcd_probe_hba - probe hba to detect device and initialize it
>   * @hba: per-adapter instance
> @@ -8245,6 +8250,13 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  			goto out;
>  
>  		if (is_mcq_supported(hba)) {
> +			ret = ufshcd_alloc_mcq(hba);
> +			if (ret) {
> +				/* Continue with SDB mode */
> +				use_mcq_mode = false;
> +				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
> +					 ret);
> +			}
>  			ret = scsi_add_host(host, hba->dev);
>  			if (ret) {
>  				dev_err(hba->dev, "scsi_add_host failed\n");
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 70c0f9f..dee0b37 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -833,6 +833,8 @@ struct ufs_hba_monitor {
>   *	ufshcd_resume_complete()
>   * @ext_iid_sup: is EXT_IID is supported by UFSHC
>   * @mcq_sup: is mcq supported by UFSHC
> + * @nr_hw_queues: number of hardware queues configured
> + * @nr_queues: number of Queues of different queue types
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -984,6 +986,8 @@ struct ufs_hba {
>  	bool complete_put;
>  	bool ext_iid_sup;
>  	bool mcq_sup;
> +	unsigned int nr_hw_queues;
> +	unsigned int nr_queues[HCTX_MAX_TYPES];

Can these two members added before bool types to avoid any holes?

Thanks,
Mani

>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
