Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF02E6E9C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjDTS6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDTS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC218D;
        Thu, 20 Apr 2023 11:58:48 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KIlbA6031252;
        Thu, 20 Apr 2023 18:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QWNb0g0AsBar2IhuOc3a3AQN67E5s8QGdktcb2USMek=;
 b=YXU2MBDnaTaACfsrXWmqxvVdVsjG+HSYHoMhVpaWBeO1qowekW9YHF161Y1ASydocIHC
 QXDrUd1g1/bqqrCOJU7oVl3NVhNQQZy6Erngzbt7rYnkCbRO+3YOlrKeFMq/aqvxnEah
 vmG7nyXxHDtVsaiX/q9/gGs5mnC8DiMfI3jXUFQLC/YtwhKgPzNqhqgqcnkbQRDUvFYi
 vkc+FzpifcnAzYwgHP9lbYOgGmxCOv/Am4m2JCTWKBDjvYHcGD3PWYK4CDw5kW3syxj4
 L8vkjGE6tWsF1CwuXPrN6HxuGu/3VqLinK3X2Xpa8vzbrFtVoqPZQMpQhiS7NwgQLI0h 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3ayygax6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 18:58:38 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33KIrtae026867;
        Thu, 20 Apr 2023 18:58:37 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3ayygawj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 18:58:37 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33KG4F5a013985;
        Thu, 20 Apr 2023 18:58:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pykj7n1k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 18:58:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33KIwZla8127094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 18:58:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD6F5805F;
        Thu, 20 Apr 2023 18:58:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C6E85805D;
        Thu, 20 Apr 2023 18:58:34 +0000 (GMT)
Received: from [9.163.17.132] (unknown [9.163.17.132])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Apr 2023 18:58:34 +0000 (GMT)
Message-ID: <f4c397ef-937d-8731-35a4-28ea60551d4f@linux.vnet.ibm.com>
Date:   Thu, 20 Apr 2023 13:58:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: ipr: remove several unused variables
To:     Tom Rix <trix@redhat.com>, brking@us.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420125035.3888188-1-trix@redhat.com>
Content-Language: en-US
From:   Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <20230420125035.3888188-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z68SMVE2clDG24_p0dwsZXevS0ew8SSz
X-Proofpoint-ORIG-GUID: JJvbQy8spWqYVcuIe6lQs6xykbO7ZPPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=954 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304200154
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Brian King <brking@linux.vnet.ibm.com>

Thanks for submitting this.

Martin - this should address the compile bot warnings that had been reported.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


