Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D096151C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKASrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKASrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:47:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93C1C435;
        Tue,  1 Nov 2022 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667328440; x=1698864440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2KZLVil44AFwc3j/NZFKMhHht0bWuCBekDUWiGR5VNs=;
  b=IPh3M0I4yRmy6IWCOGT5GFWOEknndPolQOu1ZC8T/2eMfKR5bgi9xiLN
   iEvnASXv3iYn1EKAFBDG0s39TiZMCg6nKTIKr/a/XpitLUcRVhZB31qWB
   sJT4SUk1UKo9fPbrcsWgS1PGHCw4g0NK5tI2pbfXz64JF6z8fjYIkfwXY
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Nov 2022 11:47:20 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:47:19 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 1 Nov 2022 11:47:19 -0700
Date:   Tue, 1 Nov 2022 11:47:19 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <eddie.huang@mediatek.com>, <daejun7.park@samsung.com>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 17/17] ufs: qcom-host: Enable multi circular queue
 capability
Message-ID: <20221101184718.GG9077@asutoshd-linux1.qualcomm.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <4d21c867708a9d37e53293510d81013088d01c39.1666288432.git.quic_asutoshd@quicinc.com>
 <c03ac1f5-e4a4-c26a-c1f5-b4e78cae3472@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <c03ac1f5-e4a4-c26a-c1f5-b4e78cae3472@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28 2022 at 15:08 -0700, Bart Van Assche wrote:
>On 10/20/22 11:03, Asutosh Das wrote:
>>diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>index 36c40210..b740299 100644
>>--- a/drivers/ufs/host/ufs-qcom.c
>>+++ b/drivers/ufs/host/ufs-qcom.c
>>@@ -853,6 +853,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
>>  	hba->caps |= UFSHCD_CAP_CRYPTO;
>>  	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
>>  	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
>>+	hba->caps |= UFSHCD_CAP_MCQ_EN;
>
>Shouldn't we have a flag that disables MCQ rather than a flag that 
>enables MCQ? Otherwise the above line will be duplicated in every 
>single host controller driver that supports MCQ.
>
Thanks, that makes sense.
I will drop this change and add a cap to disable MCQ via module parameter.

>Thanks,
>
>Bart.

-asd
