Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080C63AD4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiK1QIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiK1QIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:08:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7AAD2E1;
        Mon, 28 Nov 2022 08:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D326109A;
        Mon, 28 Nov 2022 16:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E42C433C1;
        Mon, 28 Nov 2022 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669651702;
        bh=e/d2HLSoJ+Cdl/Iiy7G2SbF+wQYwslyvQLPYZpiYBoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNCs2MeppHulQTgTmrer17mO4DnNbVeJH54HpOBXpdrHvH+BE+pXfzXZSK8vGho61
         WV9JNSazBdG7yo/a9EPW4Mmgy8ewrm+U0sjmy/WSyI058oE4caZj6K52DbpMlaG/vu
         0xd+XzUadbBoygbYIT545X58jDoNS9kSD81FIUYbrE3zK5S9+MdsVOb+4vjNF73D6N
         t3FrQEje71Hqw/YU+9xi9bG7ukipKbZYabREB7nXkqh8WYw4Ju6CATb/abd1k2/Rir
         q6cM3YJ5raMyLsRVZclch0QVJKBmMObeTNHPrc8ZTy5icREumgCyrKCMgncXSaiHYj
         wBPnSHIoQy4dg==
Date:   Mon, 28 Nov 2022 21:38:07 +0530
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/16] ufs: core: mcq: Find hardware queue to queue
 request
Message-ID: <20221128160807.GK62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <479ce0c60d1be1c182f55efa9b53dd4850bb8f12.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <479ce0c60d1be1c182f55efa9b53dd4850bb8f12.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:25PM -0800, Asutosh Das wrote:
> Adds support to find the hardware queue on which the request
> would be queued.
> Since the very first queue is to serve device commands, an offset
> of 1 is added to the index of the hardware queue.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

One small nitpick below...

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 20 ++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  3 +++
>  drivers/ufs/core/ufshcd.c      |  3 +++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 7179f86..10a0d0d7 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -94,6 +94,26 @@ static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
>  };
>  
>  /**
> + * ufshcd_mcq_req_to_hwq - find the hardware queue on which the
> + * request would be issued.
> + * @hba - per adapter instance
> + * @req - pointer to the request to be issued
> + *
> + * Returns the hardware queue instance on which the request would
> + * be queued.
> + */
> +struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
> +					 struct request *req)
> +{
> +	u32 utag = blk_mq_unique_tag(req);
> +	u32 hwq = blk_mq_unique_tag_to_hwq(utag);
> +
> +	/* uhq[0] is used to serve device commands */
> +	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
> +}
> +

Remove extra newline.

Thanks,
Mani

> +
> +/**
>   * ufshcd_mcq_decide_queue_depth - decide the queue depth
>   * @hba - per adapter instance
>   *
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 5616047..14df7ce 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -67,7 +67,10 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
>  void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
>  void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
>  void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
> +struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
> +					   struct request *req);
>  
> +#define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
>  #define SD_ASCII_STD true
>  #define SD_RAW false
>  int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 93a9e38..52c0386 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2921,6 +2921,9 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  		goto out;
>  	}
>  
> +	if (is_mcq_enabled(hba))
> +		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
> +
>  	ufshcd_send_command(hba, tag, hwq);
>  
>  out:
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
