Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675D86ADAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCGJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCGJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:50:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491654CBF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:50:11 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PW9bS4gsszKqJx;
        Tue,  7 Mar 2023 17:47:32 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 17:49:36 +0800
Message-ID: <50e3be73-5fb1-0505-6ddb-422cee6e466b@huawei.com>
Date:   Tue, 7 Mar 2023 17:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230307063757.247430-1-xiafukun@huawei.com>
 <ZAby1q1kA71S2WCv@kroah.com>
 <396e6a21-5270-1624-1229-1e59701cce35@huawei.com>
 <ZAcDlAkujTLkbrqr@kroah.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <ZAcDlAkujTLkbrqr@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know how to modify it to meet your requirements:

	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
		if (strncmp(kobject_actions[action], buf, count_first) != 0)
			continue;
		if (strlen(kobject_actions[action]) > count_first)
			continue;
		if (args)
			*args = args_start;
		*type = action;
		ret = 0;
		break;
	}

So I will modify the patch and resubmit it. Please review it again

在 2023/3/7 17:27, Greg KH 写道:

> 
> On Tue, Mar 07, 2023 at 05:08:02PM +0800, Xia Fukun wrote:
>> Thanks for your reply.
>> Your understanding is correct."offline\0\0\0\0\0\0\0\0\0\0" is indeed blocked
>> from matching "offline" and returns a failed result.
>>
>> I'm not sure whether to relax the restrictions to make it match successfully.
>> After all, the incoming count is too large and not the actual length of
>> "offline".
> 
> But that doesn't matter at all.  Sometimes you do not have control over
> the buffer length when writing to a file like this, what matters is the
> content of the buffer and we should stop at the first \0 as that's the
> "end of a string" in this type of api.
> 
> So your change here might break existing userspace code, and we can't do
> that, sorry.
> 
> thanks,
> 
> greg k-h
