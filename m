Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1235F3707
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJCU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJCU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:26:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77824F1D;
        Mon,  3 Oct 2022 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664828761; x=1696364761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8GkMKwa4wMokBkGs+5Lle5e/G1YSm7WhGMCxCCqFiOk=;
  b=jOtpkGl3SG3fxHr22gR1v9OkD9h5abrrbptwVF5Or5WsWjwDQfNKQunF
   6bTwGFNFRjVPgVJ+T/DfjgW0rvdMgsz3fFdehNuSjXcr9qgQvD0siZSMc
   WT0XDoGMjnpkNbyBwoUEcrzUmeicBCTMYbnqbZXXxR5B218dSaGDLJ+/9
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Oct 2022 13:25:59 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:25:58 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 3 Oct 2022 13:25:57 -0700
Date:   Mon, 3 Oct 2022 13:25:51 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_richardp@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 07/16] ufs: core: mcq: Allocate memory for mcq mode
Message-ID: <20221003202551.GA25671@asutoshd-linux1.qualcomm.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <66d2f7b0794b4f95ad8db223408b710d7a5e2b8c.1663894792.git.quic_asutoshd@quicinc.com>
 <20220926154532.GH101994@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926154532.GH101994@thinkpad>
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

On Mon, Sep 26 2022 at 08:46 -0700, Manivannan Sadhasivam wrote:
>On Thu, Sep 22, 2022 at 06:05:14PM -0700, Asutosh Das wrote:
>> To read the bqueuedepth, the device descriptor is fetched
>> in Single Doorbell Mode. This allocated memory may not be
>> enough for MCQ mode because the number of tags supported
>> in MCQ mode may be larger than in SDB mode.
>> Hence, release the memory allocated in SDB mode and allocate
>> memory for MCQ mode operation.
>> Defines the ufs hardware queue and Completion Queue Entry.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> ---
>>  drivers/ufs/core/ufs-mcq.c     | 59 ++++++++++++++++++++++++++++++++++++++++--
>>  drivers/ufs/core/ufshcd-priv.h |  1 +
>>  drivers/ufs/core/ufshcd.c      | 39 +++++++++++++++++++++++++---
>>  include/ufs/ufshcd.h           | 19 ++++++++++++++
>>  include/ufs/ufshci.h           | 21 +++++++++++++++
>>  5 files changed, 134 insertions(+), 5 deletions(-)
>>
[...]

>> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>> index 6d16beb..f624682 100644
>> --- a/drivers/ufs/core/ufshcd-priv.h
>> +++ b/drivers/ufs/core/ufshcd-priv.h
>> @@ -52,6 +52,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
>>  int ufshcd_mcq_init(struct ufs_hba *hba);
>>  u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>> +int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
>>
>>  #define SD_ASCII_STD true
>>  #define SD_RAW false
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index a71b57e..5fc1e5e 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -3676,6 +3676,8 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>>  		goto out;
>>  	}
>>
>> +	if (hba->utmrdl_base_addr)
>> +		goto skip_utmrdl;
>
>Is this change belongs to this patch?
>
Yes.
This change frees and reallocates the descriptor memory by calling
ufshcd_memory_alloc() if MCQ is supported and configured, see
ufshcd_config_mcq().
I will add a comment here.

-asd

>
>-- 
>மணிவண்ணன் சதாசிவம்
