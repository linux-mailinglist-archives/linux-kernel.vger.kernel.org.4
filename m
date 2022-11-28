Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C463B292
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiK1Tyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiK1Tyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:54:40 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A2205C6;
        Mon, 28 Nov 2022 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669665276; x=1701201276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BBExrDnkjWsjGpmKtglk+k0BYBH3+NG7nm/E6mvN6rY=;
  b=euYYRF0xN2huwJSZS/Qo3zrwfW4iT5Jax7KE783TsN0QV2OFlRuSNotM
   m8n5xPvpBcdU8aIV3OZXtc/9Nd1ENOs6aymW7jPPc5Pt1+U/Pui9Tv298
   69CBacNGJg9R+Msx+xtgjeJhVHG4q+6tuIrH2/QZ2kt1/7OG0GDyBs3lC
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Nov 2022 11:54:35 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:54:31 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 11:54:30 -0800
Date:   Mon, 28 Nov 2022 11:54:30 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <eddie.huang@mediatek.com>, <daejun7.park@samsung.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/16] ufs: core: mcq: Calculate queue depth
Message-ID: <20221128195430.GD20677@asutoshd-linux1.qualcomm.com>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
 <20221128151512.GF62721@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128151512.GF62721@thinkpad>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28 2022 at 07:15 -0800, Manivannan Sadhasivam wrote:
>On Tue, Nov 22, 2022 at 08:10:20PM -0800, Asutosh Das wrote:
>> The ufs device defines the supported queuedepth by
>> bqueuedepth which has a max value of 256.
>> The HC defines MAC (Max Active Commands) that define
>> the max number of commands that in flight to the ufs
>> device.
>> Calculate and configure the nutrs based on both these
>> values.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> ---
>>  drivers/ufs/core/ufs-mcq.c     | 32 ++++++++++++++++++++++++++++++++
>>  drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
>>  drivers/ufs/core/ufshcd.c      | 17 ++++++++++++++++-
>>  drivers/ufs/host/ufs-qcom.c    |  8 ++++++++
>>  include/ufs/ufs.h              |  2 ++
>>  include/ufs/ufshcd.h           |  2 ++
>>  include/ufs/ufshci.h           |  1 +
>>  7 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
>> index 4aaa6aa..e95f748 100644
>> --- a/drivers/ufs/core/ufs-mcq.c
>> +++ b/drivers/ufs/core/ufs-mcq.c
>> @@ -18,6 +18,8 @@
>>  #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
>>  #define UFS_MCQ_MIN_POLL_QUEUES 0
>>
>> +#define MAX_DEV_CMD_ENTRIES	2
>> +#define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
>>  #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
>>  #define MCQ_QCFGPTR_UNIT	0x200
>>  #define MCQ_SQATTR_OFFSET(c) \
>> @@ -88,6 +90,36 @@ static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
>>  	{.name = "mcq_vs",},
>>  };
[...]

Hello Mani,
Thanks for taking a look.

>> +	WARN_ON(!hba->dev_info.bqueuedepth);
>
>Instead of panic, you could just print and return an error.
>
I'd make it WARN_ON_ONCE();

>> +	/*
>> +	 * max. value of bqueuedepth = 256, mac is host dependent.
>> +	 * It is mandatory for UFS device to define bQueueDepth if
>> +	 * shared queuing architecture is enabled.
>> +	 */
>> +	return min_t(int, mac, hba->dev_info.bqueuedepth);
>> +}
>> +
>>  static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
>>  {
>>  	struct platform_device *pdev = to_platform_device(hba->dev);
>> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>> index 9368ba2..9f40fa5 100644
>> --- a/drivers/ufs/core/ufshcd-priv.h
>> +++ b/drivers/ufs/core/ufshcd-priv.h
>> @@ -62,6 +62,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>>  	enum flag_idn idn, u8 index, bool *flag_res);
>>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
>>  int ufshcd_mcq_init(struct ufs_hba *hba);
>> +int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>>
>>  #define SD_ASCII_STD true
>>  #define SD_RAW false
>> @@ -227,6 +228,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>>  		hba->vops->config_scaling_param(hba, p, data);
>>  }
>>
>> +static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
>
>Again, no inline please.
>
It spits out the following warning for all files that include this header, when
inline is removed:
warning: 'ufshcd_mcq_vops_get_hba_mac' defined but not used [-Wunused-function]

[...]
>> +#define MAX_SUPP_MAC 64
>
>Similar definitions are part of ufs-qcom.h.
>
>Thanks,
>Mani
>
>
>-- 
>மணிவண்ணன் சதாசிவம்
