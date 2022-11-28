Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C847963ACF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiK1Ps7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiK1Psq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:48:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A16242;
        Mon, 28 Nov 2022 07:48:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17EE361214;
        Mon, 28 Nov 2022 15:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD57C433D6;
        Mon, 28 Nov 2022 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669650524;
        bh=8s1xocsJoOsK4HXAjeRa4nP/W1XvJIgVrtzVlhSAdwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+QJiHqRfzKxe8K04cnPN6h76C2uxslYHpnGIP0NJzNWbt4UbSj8z0SSgYm/tvJDZ
         p6ySauQYOLTkTwhrZSaSZh+ghsZyTAWSVbTFPlCBHGO+0LmQ72sIp1fIZ06D9DiICP
         ejTuTFziAas4gCKXpP08C0QlEJGvizziIqSBoquQbdkKpuAib2Ep0FbA/EmxAYiQnW
         pYexanqfAH+ZxyCtY3LbRlBDcpU/1+uoYn0oRNrWH05t5/r0kCg7iSRQ2FKKdzUQma
         kYFSjAJi3juX35fKljgCeS9QwfjW8Qwcu5IUnlIoLKCTxNPm97YifR5WdNziziNm2u
         oSTJZq09BjZgQ==
Date:   Mon, 28 Nov 2022 21:18:29 +0530
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/16] ufs: core: mcq: Allocate memory for mcq mode
Message-ID: <20221128154829.GG62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <ba753579ac3a349ee4ab61d3b0a8f705db2a9670.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba753579ac3a349ee4ab61d3b0a8f705db2a9670.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:21PM -0800, Asutosh Das wrote:
> To read the bqueuedepth, the device descriptor is fetched
> in Single Doorbell Mode. This allocated memory may not be
> enough for MCQ mode because the number of tags supported
> in MCQ mode may be larger than in SDB mode.
> Hence, release the memory allocated in SDB mode and allocate
> memory for MCQ mode operation.
> Define the ufs hardware queue and Completion Queue Entry.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 58 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/ufs/core/ufshcd-priv.h |  1 +
>  drivers/ufs/core/ufshcd.c      | 42 +++++++++++++++++++++++++++---
>  include/ufs/ufshcd.h           | 19 ++++++++++++++
>  include/ufs/ufshci.h           | 22 ++++++++++++++++
>  5 files changed, 137 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index e95f748..51f0e40 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -247,15 +247,69 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> +int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	size_t utrdl_size, cqe_size;
> +	int i;
> +
> +	for (i = 0; i < hba->nr_hw_queues; i++) {
> +		hwq = &hba->uhq[i];
> +
> +		utrdl_size = sizeof(struct utp_transfer_req_desc) *
> +			     hwq->max_entries;
> +		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
> +							 &hwq->sqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->sqe_dma_addr) {
> +			dev_err(hba->dev, "SQE allocation failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		cqe_size = sizeof(struct cq_entry) * hwq->max_entries;
> +		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
> +							 &hwq->cqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->cqe_dma_addr) {
> +			dev_err(hba->dev, "CQE allocation failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int ufshcd_mcq_init(struct ufs_hba *hba)
>  {
> -	int ret;
> +	struct ufs_hw_queue *hwq;
> +	int ret, i;
>  
>  	ret = ufshcd_mcq_config_nr_queues(hba);
>  	if (ret)
>  		return ret;
>  
>  	ret = ufshcd_mcq_config_resource(hba);
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	hba->uhq = devm_kzalloc(hba->dev,
> +				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
> +				GFP_KERNEL);
> +	if (!hba->uhq) {
> +		dev_err(hba->dev, "ufs hw queue memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < hba->nr_hw_queues; i++) {
> +		hwq = &hba->uhq[i];
> +		hwq->max_entries = hba->nutrs;
> +	}
> +
> +	/* The very first HW queue serves device commands */
> +	hba->dev_cmd_queue = &hba->uhq[0];
> +	/* Give dev_cmd_queue the minimal number of entries */
> +	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
> +
> +	return 0;
>  }
>  
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 9f40fa5..4d2bde2 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -63,6 +63,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
>  int ufshcd_mcq_init(struct ufs_hba *hba);
>  int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
> +int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
>  
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae065da..45686e8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3740,6 +3740,12 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  	}
>  
>  	/*
> +	 * Not freed if MCQ is configured see ufshcd_release_sdb_queue() and
> +	 * ufshcd_config_mcq()

The comment is vague. Use something like,

"Skip allocating memory for utmrdl if it has been allocated during the first
pass (i.e., prior to MCQ enablement)"

> +	 */
> +	if (hba->utmrdl_base_addr)
> +		goto skip_utmrdl;
> +	/*
>  	 * Allocate memory for UTP Task Management descriptors
>  	 * UFSHCI requires 1024 byte alignment of UTMRD
>  	 */
> @@ -3755,6 +3761,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  		goto out;
>  	}
>  
> +skip_utmrdl:
>  	/* Allocate memory for local reference block */
>  	hba->lrb = devm_kcalloc(hba->dev,
>  				hba->nutrs, sizeof(struct ufshcd_lrb),
> @@ -8197,6 +8204,22 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +/* SDB - Single Doorbell */
> +static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
> +{
> +	size_t ucdl_size, utrdl_size;
> +
> +	ucdl_size = sizeof(struct utp_transfer_cmd_desc) * nutrs;
> +	dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
> +			   hba->ucdl_dma_addr);
> +
> +	utrdl_size = sizeof(struct utp_transfer_req_desc) * nutrs;
> +	dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
> +			   hba->utrdl_dma_addr);
> +
> +	devm_kfree(hba->dev, hba->lrb);
> +}
> +
>  static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>  {
>  	int ret;
> @@ -8208,12 +8231,25 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>  
>  	hba->nutrs = ret;
>  	ret = ufshcd_mcq_init(hba);
> -	if (ret) {
> -		hba->nutrs = old_nutrs;
> -		return ret;
> +	if (ret)
> +		goto err;
> +

A comment should be added here on why the allocation happens again even though
it is part of the commit description. This helps while going through the code
later.

> +	if (hba->nutrs != old_nutrs) {
> +		ufshcd_release_sdb_queue(hba, old_nutrs);
> +		ret = ufshcd_memory_alloc(hba);
> +		if (ret)
> +			goto err;
> +		ufshcd_host_memory_configure(hba);
>  	}
>  
> +	ret = ufshcd_mcq_memory_alloc(hba);
> +	if (ret)
> +		goto err;
> +
>  	return 0;
> +err:
> +	hba->nutrs = old_nutrs;
> +	return ret;
>  }
>  
>  /**
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index e03b310..e478bab 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -863,6 +863,8 @@ enum ufshcd_res {
>   * @nr_queues: number of Queues of different queue types
>   * @res: array of resource info of MCQ registers
>   * @mcq_base: Multi circular queue registers base address
> + * @uhq: array of supported hardware queues
> + * @dev_cmd_queue: Queue for issuing device management commands
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -1018,6 +1020,23 @@ struct ufs_hba {
>  	unsigned int nr_queues[HCTX_MAX_TYPES];
>  	struct ufshcd_res_info res[RES_MAX];
>  	void __iomem *mcq_base;
> +	struct ufs_hw_queue *uhq;
> +	struct ufs_hw_queue *dev_cmd_queue;
> +};
> +
> +/**

Kernel doc requires the description of the struct itself.

> + * @sqe_base_addr: submission queue entry base address
> + * @sqe_dma_addr: submission queue dma address
> + * @cqe_base_addr: completion queue base address
> + * @cqe_dma_addr: completion queue dma address
> + * @max_entries: max number of slots in this hardware queue
> + */
> +struct ufs_hw_queue {
> +	void *sqe_base_addr;
> +	dma_addr_t sqe_dma_addr;
> +	struct cq_entry *cqe_base_addr;
> +	dma_addr_t cqe_dma_addr;
> +	u32 max_entries;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index 67fcebd..1aae5b2 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -486,6 +486,28 @@ struct utp_transfer_req_desc {
>  	__le16  prd_table_offset;
>  };
>  
> +/* MCQ Completion Queue Entry */
> +struct cq_entry {
> +	/* DW 0-1 */
> +	__le64 command_desc_base_addr;
> +
> +	/* DW 2 */
> +	__le16  response_upiu_length;
> +	__le16  response_upiu_offset;
> +
> +	/* DW 3 */
> +	__le16  prd_table_length;
> +	__le16  prd_table_offset;
> +
> +	/* DW 4 */
> +	__le32 status;
> +
> +	/* DW 5-7 */
> +	u32 reserved[3];

It'd be good to use __le32 for the sake of uniformity even though these 3
DWORDS are reserved.

Thanks,
Mani

> +};
> +
> +static_assert(sizeof(struct cq_entry) == 32);
> +
>  /*
>   * UTMRD structure.
>   */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
