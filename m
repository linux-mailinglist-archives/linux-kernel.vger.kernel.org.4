Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2820563B0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiK1SHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiK1SGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:06:52 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9056EFA;
        Mon, 28 Nov 2022 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669657910; x=1701193910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CadsEG0q9KIeXpKiPUwPfa3n7odeNEMPY1wpvA775xc=;
  b=xrz/txrE+JD16ONRVaLToihVvi+ugyfle9P9uWPqE5Q0KeUpSn/SyE7h
   oEzCesaRqwy16gboCTF57CW5/GuF3z8qojTKSoH5uFOlU8tbI+VrAyRnR
   fabr7fbbUUB8j5/oYU4ylbdosZ2OjXBmsmAKZx63lxdAvzKzjrENgNimu
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Nov 2022 09:51:00 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:51:00 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 09:50:59 -0800
Date:   Mon, 28 Nov 2022 09:50:59 -0800
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/16] ufs: core: Defer adding host to scsi if mcq is
 supported
Message-ID: <20221128175059.GC20677@asutoshd-linux1.qualcomm.com>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <b75e35e1c23b428a6c55396c0fcda5ea22b4e33e.1669176158.git.quic_asutoshd@quicinc.com>
 <20221128144222.GD62721@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128144222.GD62721@thinkpad>
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

On Mon, Nov 28 2022 at 06:42 -0800, Manivannan Sadhasivam wrote:
>On Tue, Nov 22, 2022 at 08:10:17PM -0800, Asutosh Das wrote:
>> If MCQ support is present, enabling it after MCQ support
>> has been configured would require reallocating tags and memory.
>> It would also free up the already allocated memory in
>> Single Doorbell Mode. So defer invoking scsi_add_host() until
>> MCQ is configured.
>
>Why cannot we do it for non MCQ case as well?
>
Hello Mani,
Thanks for taking a look.

I don't think there was any specific reason to defer it for SDB mode.

-asd

>-- 
>மணிவண்ணன் சதாசிவம்
