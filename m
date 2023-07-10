Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE2174CD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGJGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjGJGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:36:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005BC1B3;
        Sun,  9 Jul 2023 23:35:46 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A6HeJ0020521;
        Mon, 10 Jul 2023 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PWd1KtVu5tcz3AGh3rfiYhSla8+qNHDkbbvF41aTXsc=;
 b=W1awHsinyyv18C3rGyIpJanzG0H0FgqQnzmSNW5pSkeqnEQTTC9rDKplclTX/5QgUZ0u
 lmBFh99EoqGio5XM2lk7OONcVUNHo8yszyKO+SMEXLMQOaRg8pYnYfhR2Jz6TnbFkTSh
 XqHfeua/pOfOOWkVoXH+/4B0uUUzHi2sO4I+uPjbS0GTObyaV1tYo9xBJiAKk+GGhgbd
 0LunPKarh8CZnZg8xHv+XUzXm2q1nIlAUNe7PS/pU7irncLQ8BQw5s8ThbUm5y7Q2oGS
 W1cxWdDAKVEJLKvy005n+6Tz9egvzb3gjLPGR3HFjTtIzmO18Q6w8br+2Gj+jJAGwlmJ DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrckfgb2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:35:17 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36A6I92H022163;
        Mon, 10 Jul 2023 06:35:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrckfgb29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:35:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A3WV0m000522;
        Mon, 10 Jul 2023 06:35:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rpye50sm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:35:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A6ZBQv39518928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 06:35:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12C5D2004B;
        Mon, 10 Jul 2023 06:35:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 515F420040;
        Mon, 10 Jul 2023 06:35:10 +0000 (GMT)
Received: from [9.171.88.142] (unknown [9.171.88.142])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 06:35:10 +0000 (GMT)
Message-ID: <99bee917-d874-11af-5c78-30852e057732@linux.ibm.com>
Date:   Mon, 10 Jul 2023 08:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
To:     Simon Horman <simon.horman@corigine.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
 <20230707104359.3324039-2-schnelle@linux.ibm.com>
 <ZKlmeDUEZf7F8+HW@corigine.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZKlmeDUEZf7F8+HW@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6QOGgB02WWj_ZTG2uPXjoaw16H5qB-O5
X-Proofpoint-ORIG-GUID: VFTRrAy2vO8QxTANaiTDp3vkNj02GDXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=745 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100055
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.07.23 15:36, Simon Horman wrote:
> On Fri, Jul 07, 2023 at 12:43:57PM +0200, Niklas Schnelle wrote:
[...]
>> @@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
>>  		max_client--;
>>  	spin_unlock_irqrestore(&clients_lock, flags);
>>  	list_for_each_entry(ism, &ism_dev_list.list, list) {
>> +		spin_lock_irqsave(&ism->lock, flags);
> 
> Hi Niklas,
> 
> The lock is taken here.
> 
>> +		/* Stop forwarding IRQs and events */
>> +		ism->subs[client->id] = NULL;
>>  		for (int i = 0; i < ISM_NR_DMBS; ++i) {
>>  			if (ism->sba_client_arr[i] == client->id) {
>>  				pr_err("%s: attempt to unregister client '%s'"
>> @@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client)
>>  				goto out;
> 
> But it does not appear to be released
> (by the call to spin_unlock_irqrestore() below)
> if goto out is called here.
> 
>>  			}
>>  		}
>> +		spin_unlock_irqrestore(&ism->lock, flags);
>>  	}
>>  out:
>>  	mutex_unlock(&ism_dev_list.mutex);
> 

Great catch, Simon.
@Niklas, the missing unlock accidentially got moved to "[PATCH net v2 3/3] s390/ism: Do not unregister clients with registered DMBs"
