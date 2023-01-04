Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783365CAEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbjADAdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjADAc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:32:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C3140E2;
        Tue,  3 Jan 2023 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1672792375; x=1704328375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eIhpR/qxce8uXXnWI0sljvTxC15yx0vN5/MwkffQu8E=;
  b=zDiNrWNi9/Wm2xJWh0a/Y836cvfCQQrZVaLCUbZgLbNbCYLl4o7zjnfk
   3sjkxj6DV9crGmplszHWn+EVeJLXjEzSQo/io8MZsUKAHehwHqetSVzFL
   Kn7JtM0gwNwCOKZ8+7XSFDXPkoQ8bcYHagSKOKpYIYrZTVzEAG0qcvNg4
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Jan 2023 16:32:55 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:32:55 -0800
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 16:32:54 -0800
Message-ID: <e414d0f3-515a-17ac-e65a-53fc73692eae@quicinc.com>
Date:   Tue, 3 Jan 2023 16:32:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 09/28] mailbox: Add Gunyah message queue mailbox
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-10-quic_eberman@quicinc.com>
 <20230102061330.GA1836549@quicinc.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230102061330.GA1836549@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/2023 10:13 PM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:30]:
> 
>> +static inline bool gh_msgq_has_tx(struct gh_msgq *msgq)
>> +{
> 
> Consider possibility that msgq->tx_ghrc can be NULL?
> 
>> +	return msgq->tx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_TX;
>> +}
>> +
>> +static inline bool gh_msgq_has_rx(struct gh_msgq *msgq)
>> +{
> 
> Consider possibility that msgq->rx_ghrc can be NULL?
> 
>> +	return msgq->rx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_RX;
>> +}
>> +
>> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
>> +{
>> +	struct gh_msgq *msgq = data;
>> +	struct gh_msgq_rx_data rx_data;
>> +	unsigned long gh_err;
>> +	ssize_t ret;
>> +	bool ready = false;
>> +
>> +	do {
>> +		gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
>> +				(uintptr_t)&rx_data.data, sizeof(rx_data.data),
>> +				&rx_data.length, &ready);
>> +		if (gh_err == GH_ERROR_OK) {
>> +			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
>> +		} else if (GH_ERROR_MSGQUEUE_EMPTY) {
> 
> gh_err == GH_ERROR_MSGQUEUE_EMPTY
> 

Applied the 3 comments, thanks!
