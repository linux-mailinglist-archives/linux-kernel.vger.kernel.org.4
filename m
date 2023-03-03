Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ECD6AA025
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCCTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCCTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:36:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586C2BF13;
        Fri,  3 Mar 2023 11:35:59 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323J1sQC023508;
        Fri, 3 Mar 2023 19:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GI5hE38Wh5pXzaZ45T9z12pC0vn9FRpTmeBegJGP+GI=;
 b=G5XuCF2X7W/GDVdKoGB1Z+QLlAmffgftDEVSo4MEZRxmNzsH6Jn4riNGJjkrPLIz4VrZ
 zo+JO+7R/3kgvLV+53upiOibjo2piMlTtJC0EH6Odc8Hh7ZZcibz/uA2lWLhBZjNXOta
 R6Rut22x4szWbuWtpIQwOV6N4AjFQCl1PPu4QQD3VLNPlP4j5LNoL4niwLviCejsjOcv
 7XG4f0YWX/HZvEyo8tySJ1iwme5PZhIR4uftTgcO2YOn5GfPxn9Rvl+FpDmUxgj26SdM
 SCu1anvPmywBLaT4ShY0hjilWMywsd08l4zEO+6ZCFSGCbm+4vy+IUDoBilOIDogt2We zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3801tr3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 19:35:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323JZupO029331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 19:35:56 GMT
Received: from [10.110.79.137] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 11:35:56 -0800
Message-ID: <e1fd0c4b-037e-6112-7698-dd46307246e4@quicinc.com>
Date:   Fri, 3 Mar 2023 11:35:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20230301033234.21024-1-quic_wcheng@quicinc.com>
 <20230301224445.4gmkrhw467lopstg@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230301224445.4gmkrhw467lopstg@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZG7CQKFMje_EydBg5c2ndRQ5sdfZcg4b
X-Proofpoint-GUID: ZG7CQKFMje_EydBg5c2ndRQ5sdfZcg4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_05,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=609 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303030166
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 3/1/2023 2:44 PM, Thinh Nguyen wrote:
> On Tue, Feb 28, 2023, Wesley Cheng wrote:
>> Previously, there was a 100uS delay inserted after issuing an end transfer
>> command for specific controller revisions.  This was due to the fact that
>> there was a GUCTL2 bit field which enabled synchronous completion of the
>> end transfer command once the CMDACT bit was cleared in the DEPCMD
>> register.  Since this bit does not exist for all controller revisions, add
> 
> Can we also note here that we rely on End Transfer command completion
> interrupt on newer versions.
> 
>> the delay back in, and increase the duration to 1ms for the controller to
>> complete the command.
>>
>> An issue was seen where the USB request buffer was unmapped while the DWC3
>> controller was still accessing the TRB.  However, it was confirmed that the
>> end transfer command was successfully submitted. (no end transfer timeout)
>> In situations, such as dwc3_gadget_soft_disconnect() and
>> __dwc3_gadget_ep_disable(), the dwc3_remove_request() is utilized, which
>> will issue the end transfer command, and follow up with
>> dwc3_gadget_giveback().  At least for the USB ep disable path, it is
>> required for any pending and started requests to be completed and returned
>> to the function driver in the same context of the disable call.  Without
>> the GUCTL2 bit, it is not ensured that the end transfer is completed before
>> the buffers are unmapped.
>>
> 
> I think this also needs a Fixes tag.
> 
> Everything else looks good to me.
> 

Thanks for the reviews, Thinh.  Will fix the above and resubmit.

Thanks
Wesley Cheng
