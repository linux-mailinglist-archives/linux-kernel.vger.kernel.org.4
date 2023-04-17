Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418306E3F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDQGLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQGLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:11:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837B9C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:11:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H2tLOG031643;
        Mon, 17 Apr 2023 06:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0L2GsiArAQ0KHo+J66zk+d6GqegkJ7AgxORPHbMMORA=;
 b=fIC3e+5wkSvdbpOkJQyJaiQS2T9kmHT0pgQ4mJIrhrsQb2m4B80+BSRAKbsHfklOkqjq
 yzF2E4k/cz+J0g6JEpDZaV9jjYGJuXXXNqLto+exiKQPkRvkRxUvnVb5Aup5fiVrTAfW
 rWyA/sKTVj9B1s0bcMovW+EW+Wtn/iAdLn+RnPq0KWCq8QB3lZYjIGVsfuBh0ncdoEBh
 22G5aRddCU3h3VOfxbUEl6V0qEA50hUUaecMmcIj9jFoOFbpwd+TglCMUKJbeCj8QG4j
 QLhVsoXsAcEaKc7sULRpvSFQkp8gjs94pvSWSAdA2tlxBSYOgwt+lXrWr8LYHrIc7ytz eA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymppanyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:11:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H6B8iY011327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:11:08 GMT
Received: from [10.216.36.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 23:11:04 -0700
Message-ID: <e6cd1f1e-e54c-87ae-ed23-cc1eca26837c@quicinc.com>
Date:   Mon, 17 Apr 2023 11:41:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
Content-Language: en-US
To:     Frank van der Linden <fvdl@google.com>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
 <CAPTztWadceJtPUrSab1Tj2WV=uAhLo+CrxqyeSQ8rLn0FtM_zA@mail.gmail.com>
 <0853b4b0-770f-f742-95bc-eb74a1859138@quicinc.com>
 <CAPTztWZ-PTmF=AazhCuC3u-Ca_mY+QsJGgMdu4W0DC05zk3-iA@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAPTztWZ-PTmF=AazhCuC3u-Ca_mY+QsJGgMdu4W0DC05zk3-iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cF2e-jBVb6DNIvzZe6tIhl1wtVm5d3xI
X-Proofpoint-GUID: cF2e-jBVb6DNIvzZe6tIhl1wtVm5d3xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=563
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170056
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/2023 3:32 AM, Frank van der Linden wrote:
> However, that can
> be addressed later, my comments weren't intended to raise an objection
> - merely that there is a chance here to address this usecase. But that
> shouldn't block anything. It's something to keep in mind, though.
>
Noted. Thanks!!
> I'll do some experiments to see what the best solution is here
Sure. We can work and add the support for mapped pages too which will go
on top of these patches.

Thanks,
Charan
