Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F07054FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjEPRaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEPR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:29:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268EFC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:29:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFM95s013845;
        Tue, 16 May 2023 12:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=nX+6DUK7G/R1lk8NZfBaDhbwn/YT2tXzUzxZD25/OSw=;
 b=Jcg+Gky4Na9GxAYUsBAkqJGF/AmdFxqZX99VLDFDgYh2/rbTap6LjBcBzy1GJJZTQ+HQ
 to6YEiz446W8kK62KxyHWMUSaRPOE6u4WN6rPMA4e7ceZEm/JjSjKG3N/LFEt5mMwwJl
 w1qdmQ74mb0bf5pJiI4KurjsaweBPRvm1eDkEtTMiSC+fdArNa3pXEXlIOqezvYSF6la
 qfE8Q0/T1oU7oiGhSoTRZ/3hnOlpCsdPSpgFkW91YCMD5G5uUICwyKNXHaUj9rNo9OQo
 E8B8fTUpoREiJpcqsY16bPPLb65n4BRiLsFABm4d21LzH0XpDJ+7LIcnXM241u/BMMtb yA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y14jaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:29:54 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 12:29:52 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 12:29:52 -0500
Received: from [198.61.64.66] (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8DB7311CA;
        Tue, 16 May 2023 17:29:52 +0000 (UTC)
Message-ID: <705c4511-bfba-ea46-1aad-b3783c1b21ae@opensource.cirrus.com>
Date:   Tue, 16 May 2023 18:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] debugfs: Prevent NULL dereference reading from string
 property
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-2-rf@opensource.cirrus.com>
 <2023051659-sinless-lemon-e3b1@gregkh>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <2023051659-sinless-lemon-e3b1@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 10vU0s08Zz8uPfV4JqvgIuCVonL9j4xK
X-Proofpoint-ORIG-GUID: 10vU0s08Zz8uPfV4JqvgIuCVonL9j4xK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/5/23 17:33, Greg KH wrote:
> On Tue, May 16, 2023 at 05:07:49PM +0100, Richard Fitzgerald wrote:
>> Check in debugfs_read_file_str() if the string pointer is NULL.
>>
>> It is perfectly reasonable that a driver may wish to export a string
>> to debugfs that can have the value NULL to indicate empty/unused/ignore.
> 
> Does any in-kernel driver do this today?

I don't know. The history here is that I was using debugfs_create_str()
to add a debugfs to a driver and made these improvements along the way.
Ultimately I had a reason to use a custom reader implementation.
But as I'd already written these patches I thought I'd send them.

> 
> If not, why not fix up the driver instead?
> 

Well... could do. Though it seems a bit odd to me that a driver
design should be forced by the debugfs API, instead of the debugfs API
fitting normal code design. It's pretty standard and idiomatic for code
to use if (!str) { /* bail */ } type logic, so why shouldn't the debugfs
API handle that?

>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   fs/debugfs/file.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>> index 1f971c880dde..2c085ab4e800 100644
>> --- a/fs/debugfs/file.c
>> +++ b/fs/debugfs/file.c
>> @@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>>   		return ret;
>>   
>>   	str = *(char **)file->private_data;
>> +	if (!str)
>> +		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);
> 
> Why not print "(NULL)"?
> 

Again, could do. My thought here is that a debugfs can be piped into
tools and having to insert a catch for "(NULL)" in the pipeline is a
nuisance. This is a bit different from a dmesg print, which is less
likely to be used this way or to guarantee machine-parsing.
However, I don't mind changing to "(NULL)" if you prefer.

> thanks,
> 
> greg k-h
