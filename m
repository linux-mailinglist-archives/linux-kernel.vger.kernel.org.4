Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E131166308F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjAITiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjAITiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:38:13 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14996171;
        Mon,  9 Jan 2023 11:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673293092; x=1704829092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+nSkl3nf47aICAlHJic69nCJD7igzHmBHn2JiTZ1cJs=;
  b=ZONG6QbuYRlWq29Ea9xnRprFFGp0CK8qBeEOdiS7FdMT+Dh7L7Evbime
   ZyAIhTG7HupvXuWPl0YNRyRWVPkEBZlU3cigj4Y+ZlZeJ5Xlen+8lxpKl
   azEGr7vl6uNG6VrHXaXrRgkO0zxcMRwd8k3OPNnY/3h6N4gfLYiqv3xgU
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jan 2023 11:38:11 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:38:11 -0800
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 11:38:10 -0800
Message-ID: <bea00abc-b137-945e-e0ad-67ba41e4d691@quicinc.com>
Date:   Mon, 9 Jan 2023 11:38:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 12/28] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-13-quic_eberman@quicinc.com>
 <20230109090553.GA1737564@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230109090553.GA1737564@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:05 AM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:33]:
> 
>> +config GUNYAH_VM_MANAGER
> 
> Any reason why this needs to be a separate config? IOW CONFIG_GUNYAH should
> enable VM management functionality also.
> 
>> @@ -550,14 +580,29 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>>   	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>>   	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
>>   
>> -	return gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
>> +	ret = gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
>>   				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
> 
> Bail on error here.
> 
> [snip]
> 
>> +static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>> +{
>> +	struct gunyah_vm *ghvm;
>> +	int vmid;
>> +
>> +	vmid = gh_rm_alloc_vmid(rm, 0);
>> +	if (vmid < 0)
>> +		return ERR_PTR(vmid);
>> +
>> +	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
>> +	if (!ghvm)
> 
> dealloc_vmid here (as well as few other error paths)?
> 
>> +		return ghvm;
>> +
>> +	get_gh_rm(rm);

Applied all of these.

Thanks,
Elliot
