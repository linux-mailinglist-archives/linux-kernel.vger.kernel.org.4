Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8A65F02D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjAEPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjAEPfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:35:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BADB1;
        Thu,  5 Jan 2023 07:35:05 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305EKhcZ009738;
        Thu, 5 Jan 2023 15:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zHgdmc8R8jI/qiIFlZ6//cyCAK8Vu6Sc0RFgg6cOmTk=;
 b=S1r6wEfEUqYz0cj1QSrpsuXDkyX/WvtjLhLw9axqpJjLWN4kf1cnou1humdZ6XEQr66g
 TC2uyFp/MyOJwdyKihk6OSODiEM9PbK8EaCYOw4p4648DhLIrjQnKfY5mEeJH9glScK/
 Xj0WAb3vA5eacwqzu2labj5K85+FYi9wpdiIMAsboeiCWAZYizstaAwUYSnQ7xJJn4rq
 PKmApC2ltrpZr/JD+Oj/ASzpzplayRz89YDhWLmwZv7JIT58Kf7TDM6pzv3cR9k3GYV1
 fWBEBHElwXojlNsM3+8SAJgCto4FLYx9G/T/1/EkAPQuHaBZr409TuR0V8cSDj4UJfOl UQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mx07wswey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 15:35:04 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3059IZSX026929;
        Thu, 5 Jan 2023 15:35:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6n43h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 15:35:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 305FYwe145023622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jan 2023 15:34:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB93120049;
        Thu,  5 Jan 2023 15:34:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42E7F20040;
        Thu,  5 Jan 2023 15:34:58 +0000 (GMT)
Received: from osiris (unknown [9.171.8.98])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Jan 2023 15:34:58 +0000 (GMT)
Date:   Thu, 5 Jan 2023 16:34:56 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     yang.yang29@zte.com.cn
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next v3] s390/zcrypt: use strscpy() to instead of
 strncpy()
Message-ID: <Y7buIA1uVCa/Y1K+@osiris>
References: <202301052024349365834@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301052024349365834@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1CmTSdpNNZcQciAoBo1n7FZZ5zm_wDoB
X-Proofpoint-ORIG-GUID: 1CmTSdpNNZcQciAoBo1n7FZZ5zm_wDoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=608 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:24:34PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
> chang for v3
>  - fix the sign-off Email address
> chang for v2
>  - match the FROM with the Email
> ---
>  drivers/s390/crypto/zcrypt_api.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
