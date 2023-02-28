Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3B6A61E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjB1V5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjB1V5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:57:21 -0500
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508417CE3;
        Tue, 28 Feb 2023 13:57:18 -0800 (PST)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 31SJmtmn029247;
        Tue, 28 Feb 2023 21:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=uoQOVrBMW7Xj+yJvCwKq8GYEq8oVWbao23ALPFIoPVo=;
 b=FSpKpQ0Bh31jFTq/18ExllqscQcy9ICzKWG3UjEZR4R4dgTfRKrT7sqYuUIvjVO+vy35
 rrc+wvsutu4bvYu7raYIwUqeDuxVnXhjLCz0o7bRtpOx4Cvw4Zwz4z4W2cQS0poMuyB+
 vYutRRlFAP8Y33cJCOd0NHzVSeAoHyQhPZnYFZAQ4L/H886ad28XgnIusOjdhwS3jmku
 Q78Xg5x7vGvDCWkYcCApNerWe9LXjz3EhGlT9XbFGfnWVLEoEGgxWI6Q53uacTvxNJr2
 GM7D6TDED6WndCScTJ0toLASgGIUkRfMJag32pkYW9W00/49idCPWy1kve55pGv6yjSi Ng== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 3nybmk0228-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 21:57:00 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31SKg6BD032110;
        Tue, 28 Feb 2023 13:56:59 -0800
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 3nyh6fq2vg-1;
        Tue, 28 Feb 2023 13:56:59 -0800
Received: from [172.19.33.208] (bos-lpa4700a.bos01.corp.akamai.com [172.19.33.208])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 526D05451C;
        Tue, 28 Feb 2023 21:56:59 +0000 (GMT)
Message-ID: <c0c38c08-a329-9d0a-ca75-0519b589731e@akamai.com>
Date:   Tue, 28 Feb 2023 16:56:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] dyndbg: use the module notifier callbacks
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <a775dcc14a10d0b3df34e087ee29ddb1d62fb517.1677612539.git.jbaron@akamai.com>
 <Y/5ntkYoKHvfU9S8@bombadil.infradead.org>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <Y/5ntkYoKHvfU9S8@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=806 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280176
X-Proofpoint-ORIG-GUID: AP_-8jXN7JxW4zXZbN66IuHKACUwUIDK
X-Proofpoint-GUID: AP_-8jXN7JxW4zXZbN66IuHKACUwUIDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=747
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280178
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 3:44 PM, Luis Chamberlain wrote:
> On Tue, Feb 28, 2023 at 02:35:02PM -0500, Jason Baron wrote:
>> As part of Jim Cromie's new dynamic debug classmap feature, the new code
>> tries to toggle a jump label from dynamic_debug_setup(). However,
>> dynamic_debug_setup() is called before the 'module_notify_list' notifier
>> chain is invoked. And jump labels are initialized via the module notifier
>> chain. Note this is an issue for a new feature not yet merged and doesn't
>> affect any existing codepaths.
> 
> I think we can summarize this to "in preperation for some future work where
> ordering matters with respect to jump labels" or something like that.
> 
> Because that is then making it specific to the future use case and
> creates the current justification.
> 
>> We could just move dynamic_debug_setup() earlier in load_module(). But
>> let's instead ensure the ordering via the 'priority' in the module list
>> notifier.
> 
> "becuase the notifier for jump labels jump_label_module_nb uses a
> priority of 1" or something like that would be nice to get added.
> 
>> This brings dynamic debug more in line with other subsystems and
>> pulls code out of the core module code.
> 
> This should be the main reason for this change, as explained in the
> commit log. A secondary benefit would be it fixes the first future bug
> mentioned.
> 
> With those changes I can take this into modules-next to start getting
> this tested sooner rather than later.
> 
>    Luis


Hi Luis,

Ok, I can fix up the commit message and re-post. I'm thinking maybe we 
should separate these patches as they are independent. The 2nd one I 
think makes sense to go through modules-next, but the first one is 
internal to dynamic debug and can be a part of Jim's series. Make sense?

Thanks,

-Jason
