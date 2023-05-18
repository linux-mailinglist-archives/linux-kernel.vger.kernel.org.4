Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C9470781B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjERChM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjERChL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:37:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4862D77
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:37:09 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMDZD482NzLqKx;
        Thu, 18 May 2023 10:34:12 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 10:37:05 +0800
Message-ID: <111fa8ed-9031-a393-401c-0266a9bf7544@huawei.com>
Date:   Thu, 18 May 2023 10:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230517101957.14655-1-xiafukun@huawei.com>
 <2023051739-shrunk-reopen-b968@gregkh>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <2023051739-shrunk-reopen-b968@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/17 20:17, Greg KH wrote:
> On Wed, May 17, 2023 at 06:19:57PM +0800, Xia Fukun wrote:
>> --- a/include/linux/kobject.h
>> +++ b/include/linux/kobject.h
>> @@ -32,6 +32,9 @@
>>  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
>>  #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
>>  
>> +/* the maximum length of the string contained in kobject_actions[] */
>> +#define UEVENT_KACT_STRSIZE		16
> 
> Why does this value need to be in a global .h file when it is only used
> in one .c file?
> 
> And how are you going to keep it in sync with kobject_actions if it
> changes in the future?  And that variable isn't even in this file, how
> would anyone know to modify this if the structure changes in a .c file?


Your criticism is correct. UEVENT_KACT_STRSIZE should not be defined
in the global .h file here. I will move it to that .c file.


>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -66,7 +66,8 @@ static int kobject_action_type(const char *buf, size_t count,
>>  	enum kobject_action action;
>>  	size_t count_first;
>>  	const char *args_start;
>> -	int ret = -EINVAL;
>> +	int i, ret = -EINVAL;
>> +	char kobj_act_buf[UEVENT_KACT_STRSIZE] = "";
> 
> Why does this need to be initialized?


My initialization method has some flaws, which should be done as follows:

char kobj_act_buf[UEVENT_KACT_STRSIZE] = {0};

Initialize the string kobj_act_buf to "/0" and parse it
using sysfs_match_string after subsequent copy operations.


> And are you sure the size is correct?  If so, how?

UEVENT_KACT_STRSIZE is defined as the maximum length of the string
contained in kobject_actions[].

At present, the maximum length of strings in this array is 7. Based on
the actual meaning of these strings, these actions will not exceed 16
if there are any subsequent changes.

> And how was any of this tested?  Based on your prior submissions, we are
> going to require some sort of proof.  What would you do if you were in
> my position?

My testing method is to apply the patch, compile the kernel image,
and start the QEMU virtual machine. Then compile and execute the code
mentioned in the patch that triggers out-of-bounds issues.

In addition, the following operations will be performed to verify the
functions mentioned by Peter Rajnoha <prajnoha@redhat.com>:

# echo "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" >
/sys/block/ram0/uevent

# udevadm monitor --kernel --env
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[189.376386] add      /devices/virtual/block/ram0 (block)
ACTION=add
DEVPATH=/devices/virtual/block/ram0
SUBSYSTEM=block
SYNTH_UUID=fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed
SYNTH_ARG_A=1
SYNTH_ARG_B=abc
DEVNAME=/dev/ram0
DEVTYPE=disk
DISKSEQ=14
SEQNUM=3781
MAJOR=1
MINOR=0

> thanks,
> 
> greg k-h

Thank you for your suggestion. My submission was indeed negligent,
and your guidance has benefited me greatly.
