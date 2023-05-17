Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873B707385
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEQVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEQVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:05:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6004EEF;
        Wed, 17 May 2023 14:05:29 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HKoIIP024587;
        Wed, 17 May 2023 21:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aGMKik4Rc3ffjarGbBT+eI3tE2LmH7lZlgAKxqb1dLM=;
 b=r9s+ikzK1ftLsDvteG5vGiZiUluWTpa/Xnb8ZXlJatN9mkLGu7+igvj1/dP8wrEFaKep
 lNSSLoLD0lfNm8BhaSdq+HOzKOs3JY97AMPZNrQHuC3a1EVqkYla5iOpMBNtiaTNU+ao
 lORRahEC7SGJ8/l9tO6lGaHgSjnDAKzFZMGq+gGcYwVUvK4IiKSYbPk6RqpjekieKaUZ
 WR878JIoj1XJr0cC1nGtPJw8QeZXZSjSVeR0XEqCMjGAkz42fXYUORK067WnYRncotcH
 COZsTTmS1gU+7lp5ZdSy/cdpJFJCCgg7gH6RdaWkDwXRCJo5F2rrkp4GthIStWEFUVHh 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qn4vctqky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 21:05:17 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HKoUll025125;
        Wed, 17 May 2023 21:05:05 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qn4vctp27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 21:05:03 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34HHwrbE007298;
        Wed, 17 May 2023 21:01:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qj2664y4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 21:01:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34HL1vR532768328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 21:01:57 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD3EB58043;
        Wed, 17 May 2023 21:01:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B57458053;
        Wed, 17 May 2023 21:01:55 +0000 (GMT)
Received: from [9.160.109.34] (unknown [9.160.109.34])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 21:01:55 +0000 (GMT)
Message-ID: <f99b3630-3b77-2dc3-6aa5-87b6cdedf493@linux.ibm.com>
Date:   Wed, 17 May 2023 14:01:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with
 strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
Content-Language: en-US
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S5Iizz3jwOMNXUXcc8mrCwTIdRGtRN22
X-Proofpoint-ORIG-GUID: f-YOoGHo1FEIuF9ABWEGnKCrBVkrqQt6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=806 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170174
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 07:34, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

