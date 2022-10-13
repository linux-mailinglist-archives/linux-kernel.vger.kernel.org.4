Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA15FE5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJMXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:00:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA65B9379F;
        Thu, 13 Oct 2022 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665702018; x=1697238018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j8NPJhobSjrTW6bjQXlYZSYkhG0tbDt3mMbxMdeVS4Q=;
  b=TOTNMWNj/B9eQCe8iGIiRaNWMgFIcp5XnXU6TqKx/+80u0ooqlaAsHzj
   sWI9whTdPkgYuRVfmQWhtemmm2+12qp1PB8zRqhykR7SUJCS4Z67HsjEa
   v6wDFyCiDzyJ5sVooo6M+Q7oov9V4ncC1kjAQcP7KOhHWUeMUCC4RQ3Y6
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Oct 2022 16:00:12 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:00:12 -0700
Received: from [10.110.38.147] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 16:00:10 -0700
Message-ID: <2f313bf8-b366-e094-b5b6-c601458f5cfa@quicinc.com>
Date:   Thu, 13 Oct 2022 16:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 06/13] virt: gunyah: Identify hypervisor version
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-7-quic_eberman@quicinc.com>
 <Y0UJgcc0+AEbHTIM@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y0UJgcc0+AEbHTIM@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 11:13 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 10, 2022 at 05:08:33PM -0700, Elliot Berman wrote:
> 
> EXPORT_SYMBOL_GPL()?  I have to ask.

typo only :)

> 
> But why is it exported at all?  No one is using it in this patch.
> 
It's used later in the series by the message queue driver. The idea here 
now is that gunyah.ko is capable of identifying Gunyah and other drivers 
can check if they are individually compatible with the reported version 
of Gunyah.

 From Patch 9:

+static int __init gh_msgq_init(void)
+{
+	if (GH_API_INFO_API_VERSION(gunyah_api.api_info) != GUNYAH_API_V1) {
+		pr_warn("Unrecognized gunyah version: %llu. Currently supported: %d\n",
+			GH_API_INFO_API_VERSION(gunyah_api.api_info), GUNYAH_API_V1);
+		return -ENODEV;
+	}
+
+	return 0;
+}

>> +
>> +static int __init gunyah_init(void)
>> +{
>> +	u32 uid[4];
>> +
>> +	gh_hypercall_get_uid(uid);
>> +
>> +	if (!(gh_uid_matches(GUNYAH, uid) || gh_uid_matches(QC_HYP, uid)))
>> +		return 0;
> 
> Why return success if this is not true?  Shouldn't you return an error
> and fail to load?
> 
That's fair -- easy to fix.

>> +
>> +	gh_hypercall_hyp_identify(&gunyah_api);
>> +
>> +	pr_info("Running under Gunyah hypervisor %llx/v%lld\n",
>> +		  GH_API_INFO_VARIANT(gunyah_api.api_info),
>> +		  GH_API_INFO_API_VERSION(gunyah_api.api_info));
>> +
>> +	return 0;
>> +}
>> +arch_initcall(gunyah_init);
>> +
>> +static void __exit gunyah_exit(void)
>> +{
>> +}
>> +module_exit(gunyah_exit);
> 
> Why do you need a module_exit() call?
> 

I can remove.

>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
> 
> What will cause this module to be properly automatically loaded?  I do
> not see that happening here at all.
> 
>> diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
>> index 86eb59e203ef..8f9d4c649ba8 100644
>> --- a/include/asm-generic/gunyah.h
>> +++ b/include/asm-generic/gunyah.h
>> @@ -85,6 +85,8 @@ static inline int gh_remap_error(int gh_error)
>>   	((uid)[0] == prefix ## _UID0 && (uid)[1] == prefix ## _UID1 && \
>>   	 (uid)[2] == prefix ## _UID2 && (uid)[3] == prefix ## _UID3)
>>   
>> +#define GUNYAH_API_V1			1
> 
> You do not use this define anywhere in this patch.
> 
> 
>> +
>>   #define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)
>>   #define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
>>   #define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
>> @@ -103,6 +105,7 @@ struct gh_hypercall_hyp_identify_resp {
>>   	u64 api_info;
>>   	u64 flags[3];
>>   };
>> +extern struct gh_hypercall_hyp_identify_resp gunyah_api;
> 
> Again, not used.
> 
> thanks,
> 
> greg k-h
