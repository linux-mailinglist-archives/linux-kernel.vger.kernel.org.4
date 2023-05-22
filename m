Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA170B4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEVGT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEVGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:19:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40981DB;
        Sun, 21 May 2023 23:19:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5oxFG000742;
        Mon, 22 May 2023 06:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1lCXXxUTaK6UlBzZ6u15E8nDyXP9qzd4TfuBYWAu5pA=;
 b=K1d4EdMAMoCeqkbqRtV2bOJD5DibRg57qMY2b967nCTDJF7F98fYVNWPw8jhfoOUuXPm
 m9fxWUiU7Gpg2dWKpiT0S9jmkeceJJx42FI96zwb2umUDk4hK/6wJXktpTbhvIqrDNsM
 KHlNUk5kIs76m9vlNuOdjlfLAhSVtDesmLgUlwZ3lKKoUDcEfmbIESS6iwO+zyXPht7i
 QC4jW4Zo8WsinlsZ3gz+SgUCw6+xSrSk2fQXYdPkGvTet/egOrJXvmCRmHQje+S/Q51H
 vN8bWwnn8STwR1fQTLLHVYjWbhDZzf3DGkQfl/zvY0B3VuiQDZWxkqEz01Eh7TWDEyPI Og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypar2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:19:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M6Jb4I019199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:19:37 GMT
Received: from [10.218.32.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 23:19:35 -0700
Message-ID: <b1b7e7f1-55c2-4833-040f-6cdb75f8c11b@quicinc.com>
Date:   Mon, 22 May 2023 11:49:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
To:     Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a29dcfa5-bb6a-d3b9-9fb7-cce87a8f8620@huaweicloud.com>
 <4648819c-2115-a981-1b74-0495b94d4233@huaweicloud.com>
Content-Language: en-US
From:   Pradeep Pragallapati <quic_pragalla@quicinc.com>
In-Reply-To: <4648819c-2115-a981-1b74-0495b94d4233@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aK76tzMR98PU8ZyJZc0G6qzmcZqv5z1M
X-Proofpoint-GUID: aK76tzMR98PU8ZyJZc0G6qzmcZqv5z1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=921 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2023 6:14 PM, Yu Kuai wrote:
> Hi,
>
> 在 2023/05/18 20:16, Yu Kuai 写道:
>
>> @@ -173,18 +171,17 @@ void ioc_clear_queue(struct request_queue *q)
>>   {
>>          LIST_HEAD(icq_list);
>>
>> +       rcu_read_lock();
>
> Sorry that I realized this is still not enough, following list_empty()
> and list_entry() can still concurrent with list_del(). Please try the
> following patch:
sure will try and update the results.
>> spin_lock_irq(&q->queue_lock);
>>          list_splice_init(&q->icq_list, &icq_list);
>>          spin_unlock_irq(&q->queue_lock);
>>
>> -       rcu_read_lock();
>>          while (!list_empty(&icq_list)) {
>>                  struct io_cq *icq =
>>                          list_entry(icq_list.next, struct io_cq, 
>> q_node);
>>
>>                  spin_lock_irq(&icq->ioc->lock);
>> -               if (!(icq->flags & ICQ_DESTROYED))
>> -                       ioc_destroy_icq(icq);
>> +               ioc_destroy_icq(icq);
>>                  spin_unlock_irq(&icq->ioc->lock);
>>          }
>>          rcu_read_unlock();
>>
>> .
>>
>
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 63fc02042408..47684d1e9006 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -78,6 +78,9 @@ static void ioc_destroy_icq(struct io_cq *icq)
>
>         lockdep_assert_held(&ioc->lock);
>
> +       if (icq->flags & ICQ_DESTROYED)
> +               return;
> +
>         radix_tree_delete(&ioc->icq_tree, icq->q->id);
>         hlist_del_init(&icq->ioc_node);
>         list_del_init(&icq->q_node);
> @@ -128,12 +131,7 @@ static void ioc_release_fn(struct work_struct *work)
>                         spin_lock(&q->queue_lock);
>                         spin_lock(&ioc->lock);
>
> -                       /*
> -                        * The icq may have been destroyed when the 
> ioc lock
> -                        * was released.
> -                        */
> -                       if (!(icq->flags & ICQ_DESTROYED))
> -                               ioc_destroy_icq(icq);
> +                       ioc_destroy_icq(icq);
>
>                         spin_unlock(&q->queue_lock);
>                         rcu_read_unlock();
> @@ -175,19 +173,16 @@ void ioc_clear_queue(struct request_queue *q)
>
>         spin_lock_irq(&q->queue_lock);
>         list_splice_init(&q->icq_list, &icq_list);
> -       spin_unlock_irq(&q->queue_lock);
>
> -       rcu_read_lock();
>         while (!list_empty(&icq_list)) {
>                 struct io_cq *icq =
>                         list_entry(icq_list.next, struct io_cq, q_node);
>
>                 spin_lock_irq(&icq->ioc->lock);
> -               if (!(icq->flags & ICQ_DESTROYED))
> -                       ioc_destroy_icq(icq);
> +               ioc_destroy_icq(icq);
>                 spin_unlock_irq(&icq->ioc->lock);
>         }
> -       rcu_read_unlock();
> +       spin_unlock_irq(&q->queue_lock);
>  }
>  #else /* CONFIG_BLK_ICQ */
>  static inline void ioc_exit_icqs(struct io_context *ioc)
>
