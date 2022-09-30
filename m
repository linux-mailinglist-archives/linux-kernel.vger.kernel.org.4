Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33E65F058F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiI3HPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiI3HPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:15:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0598127C81;
        Fri, 30 Sep 2022 00:15:19 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TMi7vj000324;
        Fri, 30 Sep 2022 09:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=60MQAC6+SFctggkbrjVikkLTQskXZsVGNCwYxbEvJYo=;
 b=AQ1peT9Fa+OiNN4WWozDW6jM0kRs9IHsJebL3kFUHU01DEDoR6MnTuBQEqcS7hBPhpYp
 VwMDX1s0xsIMNk2nRIRIhX+GNN9JOXKFmdoki96ZuriBILERdK9CM3pOSqEmQkaKCZ1h
 3PrKiCyqu0+bg5H8oLiEoQOOJhfK37WcaVHfyD+ddrxh//JfzBSCabOYAQYK58/dJjaS
 P5/WI1XGxS30xjMcjyXYZf3AMST4J3AiHNcDuZEPy2j/XH5Fog5gfQB0XjiKgteJT+++
 HvXj9wvsIVKOS9sglvQJP8ktCD8GopeqN9AzRhDP9lSbfc8ymu1IUZCPdJdrKX94Y+74 vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsqamvcqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:15:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26B6110002A;
        Fri, 30 Sep 2022 09:15:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DD75214D28;
        Fri, 30 Sep 2022 09:15:09 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 09:15:08 +0200
Message-ID: <c2b922f2-b4c3-2361-cbb0-96fe30d636f9@foss.st.com>
Date:   Fri, 30 Sep 2022 09:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] usb: dwc3: st: Rely on child's compatible instead of name
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Audu <jerome.audu@st.com>
References: <20220930064406.510330-1-patrice.chotard@foss.st.com>
 <YzaRm4Jtbr4F26Gt@kroah.com>
Content-Language: en-US
In-Reply-To: <YzaRm4Jtbr4F26Gt@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 9/30/22 08:50, Greg Kroah-Hartman wrote:
> On Fri, Sep 30, 2022 at 08:44:06AM +0200, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> To ensure that child node is found, don't rely on child's node name
>> which can take different value, but on child's compatible name.
>>
>> Cc: Jerome Audu <jerome.audu@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> What commit id does this fix?

A fix has been already merged [1]
The goal of this patch is to hardened the child's check, but okay,
i will add a Fixes reference.

> 
> Who reported the problem?

Ah, sorry, i forgot to add reported-by Felipe Balbi <felipe@balbi.sh>

Will send a v2

Thanks
Patrice

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220926124359.304770-1-patrice.chotard@foss.st.com

> 
> thanks,
> 
> greg k-h
