Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05E617523
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKCDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiKCDie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:38:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08005140CE;
        Wed,  2 Nov 2022 20:38:33 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2qGp38ctzmVCW;
        Thu,  3 Nov 2022 11:38:26 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 11:38:31 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 11:38:30 +0800
Subject: Re: [PATCH v2] ftrace: Fix use-after-free for dynamic ftrace_ops
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20221103031010.166498-1-lihuafei1@huawei.com>
 <20221102232334.0c1ae93b@rorschach.local.home>
 <20221102232437.6e2b1ebd@rorschach.local.home>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <e925893e-1099-777e-7485-6dc8f1f37333@huawei.com>
Date:   Thu, 3 Nov 2022 11:38:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20221102232437.6e2b1ebd@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/3 11:24, Steven Rostedt wrote:
> On Wed, 2 Nov 2022 23:23:34 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> I think you misunderstood me. What I was suggesting was to get rid of
>> the ftrace_enabled check. The DYNAMIC part is most definitely needed.
>>
>> 	if (!command) {
>> 		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
>> 			goto out;
>> 		return 0;
>> 	}
> 
> 
> Nevermind, I forgot that the out is before the DYNAMIC check.
> 
>    ;-)
> 

Yes. There we have the DYNAMIC check.

> -- Steve
> 
> .
> 
