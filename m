Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC46379A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:04:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B385A30
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:04:10 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHylH3Ky6zqSgh;
        Thu, 24 Nov 2022 21:00:11 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:04:07 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:04:07 +0800
Subject: Re: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221114022946.66255-1-yangjihong1@huawei.com>
 <20221117164003.6e655615@gandalf.local.home>
 <188a48b7-f426-6348-086e-22e56bb07206@huawei.com>
 <20221120144956.30bb1725@rorschach.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <894153aa-0dab-dc26-7c31-2bdda7c665b4@huawei.com>
Date:   Thu, 24 Nov 2022 21:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221120144956.30bb1725@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/11/21 3:49, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 18:21:12 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>>> That way we can see the broken trace event and not just silently drop it.
>>>    
>> Ok, will change in next version.(Because iter->seq.seq.len may be
>> smaller than strlen(dots), direct subtraction here may not be appropriate.)
> 
> We should only need to do this if the len is maxed out.
> 
> Hmm, len is only updated if it did actually copy it.
> 
> Perhaps we could just add:
> 
> 	trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
> 
The v3 patch has been sent according to this solution.

Thanks,
Yang
