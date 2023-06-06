Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B529A723BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjFFIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFFIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:34:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 915FEF4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:34:09 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxPutc7n5k4AwAAA--.340S3;
        Tue, 06 Jun 2023 16:29:16 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxGOVZ7n5kSAUCAA--.8978S3;
        Tue, 06 Jun 2023 16:29:14 +0800 (CST)
Subject: Re: [PATCH v4 1/2] selftests/clone3: Fix broken test under
 !CONFIG_TIME_NS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <1685968410-5412-1-git-send-email-yangtiezhu@loongson.cn>
 <1685968410-5412-2-git-send-email-yangtiezhu@loongson.cn>
 <87jzwh3swu.ffs@tglx>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d6c79a40-18e4-1566-a5dd-6a5dcb8db04c@loongson.cn>
Date:   Tue, 6 Jun 2023 16:29:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87jzwh3swu.ffs@tglx>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxGOVZ7n5kSAUCAA--.8978S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1ruFyDtF1xZr43tryfKrX_yoW5ZFyUpF
        y093ZFkFZYgry7KF97Zw4DWFWYkrn7Jr40yr1fZ34jyr1SgF1fGr47t3WrAr15Kr40y3yF
        vayxGa13ur15X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2023 04:18 PM, Thomas Gleixner wrote:
> On Mon, Jun 05 2023 at 20:33, Tiezhu Yang wrote:
>> When execute the following command to test clone3 on LoongArch:
>>
>>   # cd tools/testing/selftests/clone3 && make && ./clone3
>>
>> we can see the following error info:
>>
>>   # [5719] Trying clone3() with flags 0x80 (size 0)
>>   # Invalid argument - Failed to create new process
>>   # [5719] clone3() with flags says: -22 expected 0
>>   not ok 18 [5719] Result (-22) is different than expected (0)
>>
>> This is because if CONFIG_TIME_NS is not set, but the flag
>> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
>> will return -EINVAL in copy_time_ns().
>>
>> Here is the related code in include/linux/time_namespace.h:
>>
>>   #ifdef CONFIG_TIME_NS
>>   ...
>>   struct time_namespace *copy_time_ns(unsigned long flags,
>> 				      struct user_namespace *user_ns,
>> 				      struct time_namespace *old_ns);
>>   ...
>>   #else
>>   ...
>>   static inline
>>   struct time_namespace *copy_time_ns(unsigned long flags,
>> 				      struct user_namespace *user_ns,
>> 				      struct time_namespace *old_ns)
>>   {
>> 	  if (flags & CLONE_NEWTIME)
>> 		  return ERR_PTR(-EINVAL);
>>
>> 	  return old_ns;
>>   }
>>   ...
>>   #endif
>
> There is really no point in copying that code into the changelog. The
> textual explanation that it returns -EINVAL is good enough.

OK, let me remove the code in the commit message.

>> Here is the complete call stack:
>>
>>   clone3()
>>     kernel_clone()
>>       copy_process()
>>         copy_namespaces()
>>           create_new_namespaces()
>>             copy_time_ns()
>>               clone_time_ns()
>
> Uninteresting too.

Will remove it too.

>
>> If kernel does not support CONFIG_TIME_NS, /proc/self/ns/time
>> will be not exist, and then we should skip clone3() test with
>> CLONE_NEWTIME.
>
> Correct.
>
>> With this patch under !CONFIG_TIME_NS:
>>
>>   # cd tools/testing/selftests/clone3 && make && ./clone3
>>   ...
>>   # Time namespaces are not supported
>>   ok 18 # SKIP Skipping clone3() with CLONE_NEWTIME
>>   # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:1 error:0
>
>> Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/testing/selftests/clone3/clone3.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
>> index e495f89..c721f8a 100644
>> --- a/tools/testing/selftests/clone3/clone3.c
>> +++ b/tools/testing/selftests/clone3/clone3.c
>> @@ -196,7 +196,12 @@ int main(int argc, char *argv[])
>>  			CLONE3_ARGS_NO_TEST);
>>
>>  	/* Do a clone3() in a new time namespace */
>> -	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
>> +	if (access("/proc/self/ns/time", F_OK) == 0) {
>> +		test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
>> +	} else {
>> +		ksft_print_msg("Time namespaces are not supported\n");
>> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWTIME\n");
>> +	}
>
> Patch looks good otherwise.

Thank you, I will send v5 on Friday with updated commit message
if no more comments.

Thanks,
Tiezhu

