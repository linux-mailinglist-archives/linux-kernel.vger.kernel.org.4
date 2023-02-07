Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0268CE58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBGEqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBGEqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:46:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566413647D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:46:41 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3174I9F3005921;
        Tue, 7 Feb 2023 04:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t2JrZkTNoAC8sbAtJTUTJzdMO13KhFylQrwKNlTmAko=;
 b=HotiWq+SJ017YTwqEpawdceyXcbrMVYiLdYfsz+Iya/QfkzIlH711js9WR2kjFIywbft
 dOZdUpNKOgI5xeBYHG+LTnKJbnf4L7vEFPahLD9FksJ22LdhoJRYbgcvI4QNSMPlc2Ad
 IpcpCL8G2GErVGpYGeRBYEKZE7dfUMMCyrtHzg6+wH0K4GHp2rWOIfkP9ZY8MDO42Yk3
 mbA3cuKjZGPUXroOy7us4FhhVxl+/0pZX4jxiIEI41W59n9dqxrfOEk+C6vzZgfm2QDS
 zZb6/L/GeMQBAhgI8JcOdyxCZUbvIX8Lj17GsRtn4WvOg46XMGUwdM3/y9ZF+srcY06g WA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhg4rn9da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 04:46:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3174kP7G005455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 04:46:25 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 20:46:20 -0800
Message-ID: <bec5361f-ba2b-6685-11d1-445f7379a7ba@quicinc.com>
Date:   Tue, 7 Feb 2023 10:16:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <markhemm@googlemail.com>, <rientjes@google.com>,
        <surenb@google.com>, <shakeelb@google.com>, <mhocko@suse.com>,
        <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1675690847.git.quic_charante@quicinc.com>
 <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
 <Y+EoTPqkSOrOZlyq@casper.infradead.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <Y+EoTPqkSOrOZlyq@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZsyuDWR9Bj0yOxs_vT2QecngFL2eBepa
X-Proofpoint-GUID: ZsyuDWR9Bj0yOxs_vT2QecngFL2eBepa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=687 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070041
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Matthew!!

On 2/6/2023 9:48 PM, Matthew Wilcox wrote:
>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>> +				 pgoff_t start, pgoff_t long end)
>> +{
>> +	struct page *page;
>> +	pgoff_t index;
>> +
>> +	xa_for_each_range(&mapping->i_pages, index, page, start, end) {
>> +		if (!xa_is_value(page))
>> +			continue;
>> +		page = shmem_read_mapping_page(mapping, index);
>> +		if (!IS_ERR(page))
>> +			put_page(page);
>> +	}
>> +
>> +	return 0;
>> +}
> Hm, that's a gap in the shmem folio API.  Patches imminent.
I will change this piece of code to folios based on your recent set of
patches. Will wait for more reviews before update.

Thanks,
Charan
