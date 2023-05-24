Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A170ECE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjEXFKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjEXFKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:10:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACDB5;
        Tue, 23 May 2023 22:10:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O4Rl07001172;
        Wed, 24 May 2023 05:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fXlhhgotv+zjBaI7kXw+A5yCd+ZQWu/NGIrjHlelH5I=;
 b=WrOmJT0EqmZYpfjOgYl/ZHCw009d34gy6N7RyVUu9GwmVyCYjxyuKfbv7+yya6k7tEwm
 ZUMx27RtL1C7bVK8SwJENm4mjK6W90eWq5mVNBOmSUGvuV6JxP5aFncLoeS3MuZjZShY
 YJEwquwz5LPNbHLehtI3o0ZJsNaoJDM88jq3Ny4nrks5O+N3V7PaV5CCuDBgAT3Cq4K1
 RvvucdiVej/IkBff0WS3cWTxScrkLOamfUAqkIFuif3JAWHRyCmuh9KaYXoEVOOcoive
 7NgYoHdmegY1X5599S6JDZZnP24+k2ZN/LihlDvqieJtFfr3AQdbYkONolFD/FwTYGri MA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42urtwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:10:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O5AOe1006626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:10:24 GMT
Received: from [10.110.74.38] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 22:10:23 -0700
Message-ID: <6b3b33c1-0186-3a3f-0d6a-03bf0725fb73@quicinc.com>
Date:   Tue, 23 May 2023 22:10:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V23 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
 <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: csK27XIL3la5b1AArh6lGkSjXrTw374m
X-Proofpoint-GUID: csK27XIL3la5b1AArh6lGkSjXrTw374m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=958 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240042
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 11:36 PM, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data during system
> crash or software triggers. The DCC operates based on user inputs via
> the debugfs interface. The user gives addresses as inputs and these
> addresses are stored in the dcc sram. In case of a system crash or a
> manual software trigger by the user through the debugfs interface, the
> dcc captures and stores the values at these addresses. This patch
> contains the driver which has all the methods pertaining to the debugfs
> interface, auxiliary functions to support all the four fundamental
> operations of dcc namely read, write, read/modify/write and loop. The
> probe method here instantiates all the resources necessary for dcc to
> operate mainly the dedicated dcc sram where it stores the values. The
> DCC driver can be used for debugging purposes without going for a reboot
> since it can perform software triggers as well based on user inputs.
> 
> Also update the documentation for debugfs entries which explains the
> functionalities of each debugfs file that has been created for dcc.
> Update the documentation to reflect new module name for dcc.
> 
> The following is the justification of using debugfs interface over the
> other alternatives like sysfs/ioctls
> 
> i) As can be seen from the debugfs attribute descriptions, some of the
> debugfs attribute files here contains multiple arguments which needs to
> be accepted from the user. This goes against the design style of sysfs.
> 
> ii) The user input patterns have been made simple and convenient in this
> case with the use of debugfs interface as user doesn't need to shuffle
> between different files to execute one instruction as was the case on
> using other alternatives.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Alex Elder <elder@linaro.org>


Bjorn, do you have any remaining comments here? Are you going to provide 
  your Reviewed-by here and other patches?

If there are no comments then I would like this series to be picked by 
the maintainer you suggest.

---Trilok Soni
