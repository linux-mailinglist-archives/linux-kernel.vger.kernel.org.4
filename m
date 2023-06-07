Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347F0725247
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbjFGDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjFGDAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:00:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64865193
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:00:47 -0700 (PDT)
X-QQ-mid: bizesmtp71t1686106811ti8n2dsz
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 11:00:08 +0800 (CST)
X-QQ-SSF: 00200000000000807000000A0000000
X-QQ-FEAT: cbck7jzG4waKVMffVip+VyqfV5Z36XYIUvLy0PixwlM0lc1yqZ0MZuNefq0R5
        XtFnqTSYdCssVL8QKKhB2ihmwNy6PVhh862+9YYdeAQFjCdonGUL/OL7FbB/q7YPFEjqEWv
        eGnjSP52p5KSCq8bxRWwieHOQS88L7Ov+83woYZUaMOBp0rxFm/aF8OMTvRT7V+pG6zliri
        cmU35qMRkfTcHucla9hps2AScHZSmtFZA58IRs16u1G3DH0HCYaNggO9b3xCmT3jRTu20fd
        9iedYBpZ3uPzEMDqx2EhRdYbiaxId3tVmaqCJOYZmo4gqpE4wUzx7v7xX+iaSsxY7IJm0U6
        Dkjvs6DK0+0jBtFMeKh/un1tmU5T8y2sbALpcM86sPuJULJbfk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17331428298007680521
Message-ID: <A8B3B45A0174F0B8+98d9d1e1-fe9f-9173-e5a7-b31113da861a@tinylab.org>
Date:   Wed, 7 Jun 2023 11:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] arm64: hibernate: remove WARN_ON in
 save_processor_state
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, steven.price@arm.com,
        vincenzo.frascino@arm.com, pcc@google.com, wangxiang@cdjrlc.com,
        ajones@ventanamicro.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230525025555.24104-1-songshuaishuai@tinylab.org>
 <20230525025555.24104-3-songshuaishuai@tinylab.org>
 <20230605142857.GE21212@willie-the-truck>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230605142857.GE21212@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/5 22:28, Will Deacon 写道:
> On Thu, May 25, 2023 at 10:55:53AM +0800, Song Shuai wrote:
>> During hibernation or restoration, freeze_secondary_cpus
>> checks num_online_cpus via BUG_ON, and the subsequent
>> save_processor_state also does the checking with WARN_ON.
>>
>> So remove the unnecessary checking in save_processor_state.
> 
> This is a very terse summary of why this is safe.
> 
> Looking at the code, freeze_secondary_cpus() does indeed check
> num_online_cpus(), or it returns an error which then causes the hibernation
> to fail. However, this is all in the CONFIG_PM_SLEEP_SMP=y case and it's
> far less clear whether your assertion is true if that option is disabled.
> 
> Please can you describe your reasoning in more detail, and cover the case
> where CONFIG_PM_SLEEP_SMP=n as well, please?

With HIBERNATION enabled, the sole possible condition to disable 
CONFIG_PM_SLEEP_SMP
is !SMP where num_online_cpus is always 1. We also don't have to check 
it in save_processor_state.

> 
> Will
> 

-- 
Thanks
Song Shuai
