Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C06B313C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCIWpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCIWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:45:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3735CECC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:44:27 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329KAXNU012333;
        Thu, 9 Mar 2023 22:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=75uXFJtBYBbHk7SDm66SC83Kfd79NUBz5sBieEVhkfY=;
 b=DYUbx4VYUImmB/L0fbSuuCYqVF0X90fTRxZy3aeWAB9fm3utaXwf6dK2W+P+LnKjmrkJ
 qSM2hTX/uRtCnkmZNJbEWBDfjXzbo8CttO/BNW0h0mMs5qP92sFB5OkgFilwdPi0gc5a
 I9az9sWoqc2AcN4FFbG7uH+O1sHXIOJlE5mmE+EpH5oa0N0M2/GgavC18FR+a90+xcmt
 tMdQygsLIO5gRvDB2ESP8jgRX3DjnIIvvgMo2dpebtJn1LBKRzzFbnpNJcwbIT9PrwSV
 TaA3AX9petWwRgPVR5/SXsgm2cMpFZen0x2H8IWplDtmBWv0pXQID0Mft1+oZbuiI+7+ kg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3c8k7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:43:33 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329KLxVB022254;
        Thu, 9 Mar 2023 22:43:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3p6fhhxnp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:43:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329MhUnc26542772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 22:43:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD7465805C;
        Thu,  9 Mar 2023 22:43:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC0545805A;
        Thu,  9 Mar 2023 22:43:29 +0000 (GMT)
Received: from [9.65.194.48] (unknown [9.65.194.48])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 22:43:29 +0000 (GMT)
Message-ID: <29a94bb3-10fe-0a85-cc09-ee4b784f6c43@linux.ibm.com>
Date:   Thu, 9 Mar 2023 16:43:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fsi: aspeed: Reset master errors after CFAM reset
To:     Joel Stanley <joel@jms.id.au>, Joachim Fenkes <FENKES@de.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, alistair@popple.id.au, jk@ozlabs.org
References: <20230306225249.975495-1-eajames@linux.ibm.com>
 <CACPK8Xda32NL8hvFD0fMTKeQnoBOKCz63W=vMJ+X4p_TJ2LCjw@mail.gmail.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xda32NL8hvFD0fMTKeQnoBOKCz63W=vMJ+X4p_TJ2LCjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4JkCH63fdZKT84BFZsNgj-9KngIZ-Nc3
X-Proofpoint-ORIG-GUID: 4JkCH63fdZKT84BFZsNgj-9KngIZ-Nc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/23 23:38, Joel Stanley wrote:
> On Mon, 6 Mar 2023 at 22:53, Eddie James <eajames@linux.ibm.com> wrote:
>> It has been observed that sometimes the FSI master will return all 0xffs
>> after a CFAM has been taken out of reset, without presenting any error.
>> Resetting the FSI master errors resolves the issue.
> Eddie, you mentioned that Joachim was going to provide input on this
> change. Did you hear from him?


Yes, he mentioned it's possibly an addressing issue, with 
absolute/relative/same-address-again type of access. The FSI master 
doesn't know the slave is reset in this case so it needs to go back to 
absolute addressing. Resetting the port on the master is a good solution 
here, though Joachim was surprised that the BREAK command to the master 
didn't clear out the addressing state.


I collected some additional data that perhaps supports this theory: 
After the CFAM reset, I actually get back the data at CFAM address 0x00 
when I read the previously used address. All other addresses return 
0xff. I dumped the master state but there's nothing interesting, and no 
errors.

# /tmp/fsimaster-aspeed cfam 0x9c
CFAM09c: 00000000
# /tmp/fsimaster-aspeed dump master
MMODE[000]: 70080210
MDLYR[004]: ffff0000
MCRSP0[008]: 00000000
MENP0[010]: 80000000
MLEVP0[018]: 80000000
MREFP0[020]: 00000000
MHPMP0[028]: 00000000
MSIEP0[030]: 00000000
MAESP0[050]: 00000000
MAEB[070]: 00000000
MVER[074]: e0050101
MBSYP0[078]: 00000000
MSTAP0[0d0]: 00000000
MSTAP1[0d4]: 00000000
MSTAP2[0d8]: 00000000
MSTAP3[0dc]: 00000000
MSTAP4[0e0]: 00000000
MSTAP5[0e4]: 00000000
MSTAP6[0e8]: 00000000
MSTAP7[0ec]: 00000000
MESRB0[1d0]: 00000000
MSCSB0[1d4]: 90000001
MATRB0[1d8]: 0040013b
MDTRB0[1dc]: 00000000
MECTRL[2e0]: 0000c000
# echo 1 > /sys/class/fsi-master/fsi0/device/cfam_reset
# /tmp/fsimaster-aspeed cfam 0x9c
CFAM09c: c0020da6
# /tmp/fsimaster-aspeed cfam 0x0
CFAM000: ffffffff
# /tmp/fsimaster-aspeed dump master
MMODE[000]: 70080210
MDLYR[004]: ffff0000
MCRSP0[008]: 00000000
MENP0[010]: 80000000
MLEVP0[018]: 80000000
MREFP0[020]: 00000000
MHPMP0[028]: 00000000
MSIEP0[030]: 00000000
MAESP0[050]: 00000000
MAEB[070]: 00000000
MVER[074]: e0050101
MBSYP0[078]: 00000000
MSTAP0[0d0]: 00000000
MSTAP1[0d4]: 00000000
MSTAP2[0d8]: 00000000
MSTAP3[0dc]: 00000000
MSTAP4[0e0]: 00000000
MSTAP5[0e4]: 00000000
MSTAP6[0e8]: 00000000
MSTAP7[0ec]: 00000000
MESRB0[1d0]: 00000000
MSCSB0[1d4]: b0000001
MATRB0[1d8]: 00400003
MDTRB0[1dc]: ffffffff


>
> Cheers,
>
> Joel
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-master-aspeed.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
>> index 7cec1772820d..5eccab175e86 100644
>> --- a/drivers/fsi/fsi-master-aspeed.c
>> +++ b/drivers/fsi/fsi-master-aspeed.c
>> @@ -454,6 +454,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
>>          gpiod_set_value(aspeed->cfam_reset_gpio, 1);
>>          usleep_range(900, 1000);
>>          gpiod_set_value(aspeed->cfam_reset_gpio, 0);
>> +       usleep_range(900, 1000);
> Is the delay required? How did you arrive at this time?
>
>> +       opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
>>          mutex_unlock(&aspeed->lock);
>>          trace_fsi_master_aspeed_cfam_reset(false);
>>
>> --
>> 2.31.1
>>
