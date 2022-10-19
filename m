Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020860500E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiJSTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJSS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:59:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB5DEF1F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:59:49 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIwaps018231;
        Wed, 19 Oct 2022 18:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2zSjT1ihjCgtAbo1luJedK+avILgBZb1jxYz+ueZHFs=;
 b=eYS2XKn0fDwcA72GEZ6tZwqDe1zDRjogNgMl3QCQBHUu54SaX+FVwOMDpbmtXS5MLuvP
 bO6eTpGgmW+jXMNCOgU8B0g7m2gkgZUtOlZvK3CF3gnZZnnl2CFv91NaxTlH8/yi0Mmw
 RAI0/9ujzR1vN2yBWpDg6cR09XgZ0hSQ5B835bFFxLk1avl+pHmyhwUj8xJcoGZgIynQ
 KQOgJQDDMpEs93MleWv4vKaVkJZKlRR0H6h9Tx7kiTids8Ekt50hSPT+t9Ju5G5RtOc9
 2oeTs6vgrfDZOoYVEptl1Hx9HFmLgIRqHvWVzrgRaUDXP1FiyaJHSQvhqPZqN1mf8whQ QA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kanyj1xmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:59:33 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JIoHmC024413;
        Wed, 19 Oct 2022 18:59:26 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3k7mgadcxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:59:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JIxSGo34669000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 18:59:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA3C5805D;
        Wed, 19 Oct 2022 18:59:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B79E58058;
        Wed, 19 Oct 2022 18:59:24 +0000 (GMT)
Received: from [9.160.7.147] (unknown [9.160.7.147])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 18:59:24 +0000 (GMT)
Message-ID: <ac1ffdbe-809b-698f-b8aa-b4d0955b1d1d@linux.ibm.com>
Date:   Wed, 19 Oct 2022 13:59:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     joel@jms.id.au, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
References: <20221014220540.55570-1-eajames@linux.ibm.com>
 <Y02SztthO39FYIeu@sirena.org.uk>
 <36908c1d-4672-807a-d157-d3ccd0b03148@linux.ibm.com>
 <Y07pqhpm/1hzx9LR@sirena.org.uk>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Y07pqhpm/1hzx9LR@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kRQR8QC9WPr0DHazFyTh1Y-I25A91lXJ
X-Proofpoint-ORIG-GUID: kRQR8QC9WPr0DHazFyTh1Y-I25A91lXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=911 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/22 13:00, Mark Brown wrote:
> On Tue, Oct 18, 2022 at 09:02:33AM -0500, Eddie James wrote:
>> On 10/17/22 12:37, Mark Brown wrote:
>>> Is there any great reason to provide support in the regmap core for this
>>> rather than just implementing in drivers/fsi?  AFAICT this is just
>>> ending up as an implementation detail of shared code in drivers/fsi and
>>> won't have any external users?
>> One reason is to have a common interface with the new FSI regmap. That way
>> abstracting out the bus transfer is trivial in the new SBEFIFO driver,
>> assuming the SBEFIFO driver should switch to use the FSI regmap.
>> But you are correct, I doubt anyone else will use this. I suppose SBEFIFO
>> may as well not use the regmap and just use some callbacks for whichever bus
>> transfer...
> I'm not saying don't use regmap, I'm saying why not just do this in the
> driver - you can just as easily set the reg_read() and reg_write()
> callbacks in an individual driver without needing to create a new regmap
> bus type for just that one driver to use.


I understand. That sounds like a good approach then, I'll work on that 
for v2.

Thanks,

Eddie


