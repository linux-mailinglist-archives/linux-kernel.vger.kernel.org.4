Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB763AE43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiK1RAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiK1RAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:00:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E6221;
        Mon, 28 Nov 2022 09:00:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DEA7B80E54;
        Mon, 28 Nov 2022 17:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2B6C433C1;
        Mon, 28 Nov 2022 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669654830;
        bh=gd4m9ArrBoMN6mAP0/4pNU/hxXbns/+fZGp4s0bPo1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXzgvcstEH5BTSLpU7ux0q3Mmjixk1SlUSHKdwZTIa5z6s5yp2vHqN10pJ8WXhv/O
         7Ch45qNe/fVcaxdwUzdWZ9XP71AjdQ0JYPSoahiJJ+hf7IgiLupfrEfPKkwsW5vP7f
         xCxMkn3oZfsOZZ7npYJghOqr2BoWevnBYJ9HiNkcPLZRrh0IC2dL3HAbiA8CALF5pM
         142aoCw3kF6ZGix5l/8v6pIC+QqTmggSGgGq1WVu/zSyjuNNfzRx+7gPvvPrOZTyGL
         IpT2C/7MgDHApb30TT2XeQ+1Gpk/DvK3wmlAT9mdD4Rb3OGCRZvKpDxDZWdT6gXnf2
         P3xWmoM1rUGzA==
Date:   Mon, 28 Nov 2022 22:30:15 +0530
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/16] ufs: mcq: Add completion support of a cqe
Message-ID: <20221128170015.GM62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <32219cb9b058d7329ad8234a8a287701af1a0e34.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32219cb9b058d7329ad8234a8a287701af1a0e34.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:27PM -0800, Asutosh Das wrote:
> Add support for completing requests from Completion Queue.
> Some host controllers support vendor specific registers
> that provide a bitmap of all CQ's which have at least one
> completed CQE. Add this support.
> The MCQ specification doesn't provide the Task Tag or its
> equivalent in the Completion Queue Entry.
> So use an indirect method to find the Task Tag from the
> Completion Queue Entry.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>

What is this reported by for?

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h | 43 +++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd.c      | 37 +++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-qcom.c    | 16 ++++++++++++
>  drivers/ufs/host/ufs-qcom.h    |  4 +++
>  include/ufs/ufshcd.h           |  7 ++++++
>  include/ufs/ufshci.h           |  3 +++
>  7 files changed, 167 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 10a0d0d7..365ad98 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -28,6 +28,7 @@
>  	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
>  #define MCQ_QCFG_SIZE	0x40
>  #define MCQ_ENTRY_SIZE_IN_DWORD	8
> +#define CQE_UCD_BA GENMASK_ULL(63, 7)
>  
>  static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
>  {
> @@ -333,6 +334,59 @@ static void __iomem *mcq_opr_base(struct ufs_hba *hba,
>  	return opr->base + opr->stride * i;
>  }
>  
> +u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
> +{
> +	return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
> +}
> +
> +void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
> +{
> +	writel(val, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
> +}
> +

It'd be good to add a comment about tag extraction as you did in description.

> +static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> +				     struct ufs_hw_queue *hwq,
> +				     struct cq_entry *cqe)
> +{
> +	dma_addr_t dma_addr;
> +
> +	/* sizeof(struct utp_transfer_cmd_desc) must be a multiple of 128 */
> +	BUILD_BUG_ON(sizeof(struct utp_transfer_cmd_desc) & GENMASK(6, 0));
> +
> +	/* Bits 63:7 UCD base address, 6:5 are reserved, 4:0 is SQ ID */
> +	dma_addr = le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA;
> +
> +	return (dma_addr - hba->ucdl_dma_addr) /
> +		sizeof(struct utp_transfer_cmd_desc);
> +}
> +

[...]

> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index dd53e85..89d29a1 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1454,6 +1454,21 @@ static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
>  	return MAX_SUPP_MAC;
>  }
>  
> +static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
> +					unsigned long *ocqs)
> +{
> +	u32 cqis_vs;
> +	struct ufshcd_res_info *mcq_vs_res = &hba->res[RES_MCQ_VS];
> +
> +	if (!mcq_vs_res->base)
> +		return -EINVAL;
> +
> +	cqis_vs = readl(mcq_vs_res->base + UFS_MEM_CQIS_VS);
> +	*ocqs = cqis_vs;

Why can't you assign readl to *ocqs?

Thanks,
Mani
> +
> +	return 0;
> +}
> +
>  /*
>   * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
>   *
> @@ -1479,6 +1494,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.program_key		= ufs_qcom_ice_program_key,
>  	.get_hba_mac		= ufs_qcom_get_hba_mac,
>  	.op_runtime_config	= ufs_qcom_op_runtime_config,
> +	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
>  };
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 44466a3..7769f03 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -72,6 +72,10 @@ enum {
>  	UFS_UFS_DBG_RD_EDTL_RAM			= 0x1900,
>  };
>  
> +enum {
> +	UFS_MEM_CQIS_VS		= 0x8,
> +};
> +
>  #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
>  #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
>  
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 853c525..d5fde64 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -300,6 +300,7 @@ struct ufs_pwr_mode_info {
>   * @event_notify: called to notify important events
>   * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
>   * @op_runtime_config: called to config Operation and runtime regs Pointers
> + * @get_outstanding_cqs: called to get outstanding completion queues
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -340,6 +341,8 @@ struct ufs_hba_variant_ops {
>  				enum ufs_event_type evt, void *data);
>  	int	(*get_hba_mac)(struct ufs_hba *hba);
>  	int	(*op_runtime_config)(struct ufs_hba *hba);
> +	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
> +				       unsigned long *ocqs);
>  };
>  
>  /* clock gating state  */
> @@ -1064,6 +1067,8 @@ struct ufs_hba {
>   * @id: hardware queue ID
>   * @sq_tp_slot: current slot to which SQ tail pointer is pointing
>   * @sq_lock: serialize submission queue access
> + * @cq_tail_slot: current slot to which CQ tail pointer is pointing
> + * @cq_head_slot: current slot to which CQ head pointer is pointing
>   */
>  struct ufs_hw_queue {
>  	void __iomem *mcq_sq_head;
> @@ -1079,6 +1084,8 @@ struct ufs_hw_queue {
>  	u32 id;
>  	u32 sq_tail_slot;
>  	spinlock_t sq_lock;
> +	u32 cq_tail_slot;
> +	u32 cq_head_slot;
>  };
>  
>  static inline bool is_mcq_enabled(struct ufs_hba *hba)
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index c85bdf2..1e557ba 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -262,6 +262,9 @@ enum {
>  /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
>  #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
>  
> +/* CQISy - CQ y Interrupt Status Register  */
> +#define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
> +
>  /* UICCMD - UIC Command */
>  #define COMMAND_OPCODE_MASK		0xFF
>  #define GEN_SELECTOR_INDEX_MASK		0xFFFF
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
