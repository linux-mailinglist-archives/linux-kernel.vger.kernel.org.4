Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343C68F155
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBHOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBHOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:55:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710DCDFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:55:22 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318ElhlD028531;
        Wed, 8 Feb 2023 14:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dht7AcD6/u8H0DoBeF9sWTQSYCKhK8JhR2msGTM2KU8=;
 b=VbYpEoKTsidOTaC299a0BIkUgeN9MeapnUvQLnAKqOFPk+376yud3RA8d+MYA1/VNU7d
 qST1jPt5BJ6AQrfUNiFns/InMkaQoUmwj6vccU5LFANoOLYpNvd+rsqbX0dFGSjgt4mg
 Uht46KQKRlLOF+Z6W/FC1HbC4Xck3uZUY90JOaL9hBQyAkUxCq7FxkxSPRbICKeeEPZ1
 mgJSyPk1gVjitoDXAUd5RXeUGtz3rHi/sXQ6rbssgrntH2LY9cF6QERn07I+hflfAf61
 hxOO6Uu1nZhnxvMf4OFSZAtNCDSVYZcXv1h1oYYpv6h+v8lSwpWu5/nUDfcWCtlDjK8L pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf1ptq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 14:55:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318Et2vU021538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 14:55:02 GMT
Received: from [10.216.17.83] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 06:54:57 -0800
Message-ID: <8f40873d-8a9c-bcec-6742-885478365e4c@quicinc.com>
Date:   Wed, 8 Feb 2023 20:24:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <shakeelb@google.com>, <mhocko@suse.com>,
        <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1675690847.git.quic_charante@quicinc.com>
 <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
 <CAJuCfpH7Jag9qEcKjGTx9Qv_oekM6qRVkGwzTrXShgYbLdLKtg@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAJuCfpH7Jag9qEcKjGTx9Qv_oekM6qRVkGwzTrXShgYbLdLKtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1oXqyltMsC9PZFzNhxog8zLNCz6aOlp-
X-Proofpoint-GUID: 1oXqyltMsC9PZFzNhxog8zLNCz6aOlp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_06,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=764 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080131
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Suren!!

On 2/8/2023 4:18 AM, Suren Baghdasaryan wrote:
>> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>> +{
>> +       loff_t endbyte;
>> +       pgoff_t start_index;
>> +       pgoff_t end_index;
>> +       struct address_space *mapping;
>> +       struct inode *inode = file_inode(file);
>> +       int ret = 0;
>> +
>> +       if (S_ISFIFO(inode->i_mode))
>> +               return -ESPIPE;
>> +
>> +       mapping = file->f_mapping;
>> +       if (!mapping || len < 0 || !shmem_mapping(mapping))
>> +               return -EINVAL;
>> +
>> +       endbyte = fadvise_calc_endbyte(offset, len);
>> +
>> +       start_index = offset >> PAGE_SHIFT;
>> +       end_index   = endbyte >> PAGE_SHIFT;
>> +       switch (advice) {
>> +       case POSIX_FADV_DONTNEED:
> Should (SHMEM_I(inode)->flags & VM_LOCKED) be checked here too?
> 
Is this w.r.t context from shmem_lock() perspective which does set this
flag?  If so, Isn't the PageUnevictable check cover this part? And to
avoid unnecessary Unevictable check later on the locked shmem file, How
about just checking mapping_unevictable() before performing
shmem_fadvise_dontneed)()? Please let me know If I failed to get your point.

>> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
>> +               break;
>> +       case POSIX_FADV_WILLNEED:
>> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
>> +               break;
>> +       case POSIX_FADV_NORMAL:
>> +       case POSIX_FADV_RANDOM:
>> +       case POSIX_FADV_SEQUENTIAL:
>> +       case POSIX_FADV_NOREUSE:

--Charan
