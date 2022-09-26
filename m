Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02ED5EABE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiIZQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiIZQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0957BF0;
        Mon, 26 Sep 2022 07:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35F860DEE;
        Mon, 26 Sep 2022 14:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27EBC433D6;
        Mon, 26 Sep 2022 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664203807;
        bh=89tkwdlJ8MMrAXQqIF+dkY5sEKAlYgkh9zDXoiDkyiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBg4ovLme5zoarWLqRsVfgji0h8aLcgjg+qeNWjVKtqlDYk9Zj/9/4EcfIf3TKo9k
         1eT4hBsLI9oriPXZQpnAl7ojVBPmKtClZRsDjVC2gJwkOja/xqjaNZW3rZLOEPQMFt
         LEZPQLnjjOaBvL3xpzmw3V2OJKtdkzLibk+OpvIBPllZkiVx/sKmj+7lJD1uXFanU1
         eiCOneQotiQ/r57xLOb7PrQgrmeFDHCmq/oHtffaFXULbz4M/4sYrqsxriM1aY81V6
         cUIVI3bcKnukmA2iuDCymz+M6fYJfJjtt82VoLIToby6+ZcEdGzm9+pg5aH4fjsYv+
         dvXktc19ugF8Q==
Date:   Mon, 26 Sep 2022 20:19:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        bvanassche@acm.org, avri.altman@wdc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 04/16] ufs: core: mcq: Introduce Multi Circular Queue
Message-ID: <20220926144957.GE101994@thinkpad>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:05:11PM -0700, Asutosh Das wrote:
> Introduce multi-circular queue (MCQ) which has been added
> in UFSHC v4.0 standard in addition to the Single Doorbell mode.
> The MCQ mode supports multiple submission and completion queues.
> Add support to configure the number of queues.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/Makefile      |   2 +-
>  drivers/ufs/core/ufs-mcq.c     | 132 +++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |   1 +
>  drivers/ufs/core/ufshcd.c      |  12 ++++
>  include/ufs/ufshcd.h           |   4 ++
>  5 files changed, 150 insertions(+), 1 deletion(-)
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
> index 0000000..934556f
> --- /dev/null
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -0,0 +1,132 @@
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
> +#define UFS_MCQ_MIN_POLL_QUEUES 0
> +
> +static unsigned int dev_cmd_queue = 1;

This looks like a constant, so consider switching to a macro.

> +
> +static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);

n is not used? While fixing, please use a better name.

> +	if (ret)
> +		return ret;

Newline

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
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret)
> +		return ret;

Same as above

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
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret)
> +		return ret;

Same as above

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
> +	int i, rem;
> +	u32 hbaq_cap, cmp, tot_queues;
> +	struct Scsi_Host *host = hba->host;
> +
> +	hbaq_cap = hba->mcq_capabilities & 0xff;

Define 0xff

hbaq_cap should be named after the define used for 0xff. It is not quite
understandable now.

> +
> +	if (!rw_queues)
> +		rw_queues = num_possible_cpus();
> +
> +	tot_queues = dev_cmd_queue + read_queues + poll_queues + rw_queues;
> +	if (hbaq_cap < tot_queues) {
> +		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
> +			tot_queues, hbaq_cap);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rem = hbaq_cap - dev_cmd_queue;
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(cmp, rw_queues,
> +						 num_possible_cpus());
> +	rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);

Hmm, so the driver is not using the number of queues set by the user?
If the number varies, I don't think it should be configurable.

Thanks,
Mani

> +	rem -= hba->nr_queues[HCTX_TYPE_POLL];
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_READ] = min(cmp, read_queues);
> +
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		host->nr_hw_queues += hba->nr_queues[i];
> +
> +	hba->nr_hw_queues = host->nr_hw_queues + dev_cmd_queue;
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
> index 8f67db2..cf6bdd8e 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -50,6 +50,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
>  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, u8 index, bool *flag_res);
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
> +int ufshcd_mcq_init(struct ufs_hba *hba);
>  
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 426867b..f4bb402 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8172,6 +8172,15 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +static int ufshcd_config_mcq(struct ufs_hba *hba)
> +{
> +	int ret;
> +
> +	ret = ufshcd_mcq_init(hba);
> +
> +	return ret;
> +}
> +
>  /**
>   * ufshcd_probe_hba - probe hba to detect device and initialize it
>   * @hba: per-adapter instance
> @@ -8221,6 +8230,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  			goto out;
>  
>  		if (is_mcq_supported(hba)) {
> +			ret = ufshcd_config_mcq(hba);
> +			if (ret)
> +				goto out;
>  			ret = scsi_add_host(host, hba->dev);
>  			if (ret) {
>  				dev_err(hba->dev, "scsi_add_host failed\n");
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index da7ec0c..298e103 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -827,6 +827,8 @@ struct ufs_hba_monitor {
>   *	ufshcd_resume_complete()
>   * @ext_iid_sup: is EXT_IID is supported by UFSHC
>   * @mcq_sup: is mcq supported by UFSHC
> + * @nr_hw_queues: number of hardware queues configured
> + * @nr_queues: number of Queues of different queue types
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -977,6 +979,8 @@ struct ufs_hba {
>  	bool complete_put;
>  	bool ext_iid_sup;
>  	bool mcq_sup;
> +	unsigned int nr_hw_queues;
> +	unsigned int nr_queues[HCTX_MAX_TYPES];
>  };
>  
>  static inline bool is_mcq_supported(struct ufs_hba *hba)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
