Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0D6A605F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjB1U3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB1U3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:29:14 -0500
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F513DCB;
        Tue, 28 Feb 2023 12:29:11 -0800 (PST)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SJqEA4027037;
        Tue, 28 Feb 2023 20:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=mTg/dH4ekf3J1ZLQ/mdEbLG/NeaT5kadx8gHaQruoac=;
 b=FBDYs0N8lo3jtO2TqZknQbD69jPDh4o7x0XisVYdNTZGfSVm1q/9sYQec41Hn+aUqRiE
 Nfe4kktuJPB8ZGUys3aU3W67/cXJR0yeI+MCmBCQVFX802aSriACLgwy/UugDRMxvS7q
 cVz9WBS8ty7zrJ5NZmMYBSaoySjJ5ZixWo/FpoKOX9J258r2cYCuWhSryndsKAAXkzJo
 F98KIUU+XbsvGvD/PG1++Em16jRpVG8cwOy28dwOTTaXZdvNTr+cmUFESZoiflR5z4Wx
 je2jMZTWyHg02v8LnLjR6j90ER6XR/l6BDa10cllV/vLvfJH/EgEnAZxgT7DEWxBe93E Yg== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3nyav71a9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:29:00 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31SG9sjJ032046;
        Tue, 28 Feb 2023 12:28:08 -0800
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 3nyh6fpt0c-1;
        Tue, 28 Feb 2023 12:28:08 -0800
Received: from [172.19.33.208] (bos-lpa4700a.bos01.corp.akamai.com [172.19.33.208])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 3039F54504;
        Tue, 28 Feb 2023 20:28:08 +0000 (GMT)
Message-ID: <757793a7-6b05-f81d-e1e7-55878c47377c@akamai.com>
Date:   Tue, 28 Feb 2023 15:28:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] dyndbg: let's use the module notifier callback
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <cover.1677612539.git.jbaron@akamai.com>
 <Y/5hkFJsRnAuoRBN@bombadil.infradead.org>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <Y/5hkFJsRnAuoRBN@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=283 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280168
X-Proofpoint-ORIG-GUID: pLiJHWVCCaQU89k02NeGUmwO0kxqG-aM
X-Proofpoint-GUID: pLiJHWVCCaQU89k02NeGUmwO0kxqG-aM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=244 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280169
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 3:18 PM, Luis Chamberlain wrote:
> On Tue, Feb 28, 2023 at 02:34:20PM -0500, Jason Baron wrote:
>> Hi,
>>
>> Jim Cromie hit a BUG() while toggling jump label branches in a module
>> before they were properly initialized. This isn't currently an issue,
>> but will be as part of his pending classmap series. Seems like we
>> should covert to using module callback notifier for dynamic debug
>> anyways. First patch is just a cleanup.
>>
>> Link: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/__;!!GjvTz_vk!RcYAOcwdnCTVPf9WgS4GmmVwClimlsK1BfnLrRh4Oxlf1fJeOfBHa7zgCXDFiV8gw3YCGIbcdiYG$
>>
>> Thanks,
>>
>> -Jason
>>
>> v2:
>> -Fix: error: field 'dyndbg_info' has incomplete type
>>   Reported-by: kernel test robot <lkp@intel.com>
>>   Link: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/__;!!GjvTz_vk!RcYAOcwdnCTVPf9WgS4GmmVwClimlsK1BfnLrRh4Oxlf1fJeOfBHa7zgCXDFiV8gw3YCGJKpcyr8$
>> -make ddebug_remove_module() static
> 
> Do you have tests to ensure no regressions have occurred? If so what
> are they? If there are no tests, can you come up with some basic ones?
> 
>    Luis


Hi Luis,

Yes, I've run the test case that prompted this series here:

https://lore.kernel.org/lkml/20230125203743.564009-20-jim.cromie@gmail.com/

Note that this is for new functionality that Jim is working on and he 
plan to include this series when he re-posts his series. And thus I've 
added Jim's Tested-by: in patches 1 and 2.

There is also a 'test_dynamic_debug' module which I've run as follows:

# modprobe test_dynamic_debug dyndbg

And confirmed the appropriate prints to the log. This exercises the code 
paths that were changed here.

Thanks,

-Jason
