Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275D6EBE05
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDWIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:34:14 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Apr 2023 01:34:11 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B19201BC2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:34:11 -0700 (PDT)
Received: from 102.wangsu.com (unknown [59.61.78.234])
        by app2 (Coremail) with SMTP id SyJltAAn2AQn7ERkCi0AAA--.192S2;
        Sun, 23 Apr 2023 16:28:24 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     akpm@linux-foundation.org
Cc:     Ilia.Gavrilov@infotecs.ru, axboe@kernel.dk, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org, surenb@google.com,
        wuchi.zero@gmail.com, xu.panda@zte.com.cn, yangpc@wangsu.com,
        zhang.zhengming@h3c.com, zhou.kete@h3c.com, dwilder@us.ibm.com
Subject: Re: [PATCH] relayfs: fix out-of-bounds access in relay_file_read
Date:   Sun, 23 Apr 2023 16:28:22 +0800
Message-Id: <1682238502-1892-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20230419140325.b85d54794baaa828a19c138f@linux-foundation.org>
References: <20230419140325.b85d54794baaa828a19c138f@linux-foundation.org>
X-CM-TRANSID: SyJltAAn2AQn7ERkCi0AAA--.192S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Kry3JFykJFWDArWrXwb_yoW8Cw4kpr
        ZYkayFkws8Xa17uan3JFW5uFyrtr1xJFW5XrZ5Z343ZrnrJrs5AFWrGF1jgwn0q3yDGw4j
        gayj93sxJw4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
        8VW8GwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
        vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjfUFMa0DUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 20, 2023 5:04 AM, Andrew Morton wrote:
> On Wed, 19 Apr 2023 12:02:03 +0800 zhangzhengming <zhang.zhengming@h3c.com> wrote:
>
>> From: Zhang Zhengming <zhang.zhengming@h3c.com>
>> 
>> There is a crash in relay_file_read, as the var from 
>> point to the end of last subbuf.
>> The oops looks something like:
>> pc : __arch_copy_to_user+0x180/0x310
>> lr : relay_file_read+0x20c/0x2c8
>> Call trace:
>>  __arch_copy_to_user+0x180/0x310
>>  full_proxy_read+0x68/0x98
>>  vfs_read+0xb0/0x1d0
>>  ksys_read+0x6c/0xf0
>>  __arm64_sys_read+0x20/0x28
>>  el0_svc_common.constprop.3+0x84/0x108
>>  do_el0_svc+0x74/0x90
>>  el0_svc+0x1c/0x28
>>  el0_sync_handler+0x88/0xb0
>>  el0_sync+0x148/0x180
>> 
>> We get the condition by analyzing the vmcore:
>> 1). The last produced byte and last consumed byte
>>     both at the end of the last subbuf
>> 2). A softirq who will call function(e.g __blk_add_trace)
>>     to write relay buffer occurs when an program calling
>>     function relay_file_read_avail.
>>         relay_file_read
>>                 relay_file_read_avail
>>                         relay_file_read_consume(buf, 0, 0);
>>                         //interrupted by softirq who will write subbuf
>>                         ....
>>                         return 1;
>>                 //read_start point to the end of the last subbuf
>>                 read_start = relay_file_read_start_pos
>>                 //avail is equal to subsize
>>                 avail = relay_file_read_subbuf_avail
>>                 //from  points to an invalid memory address             
>>                 from = buf->start + read_start
>>                 //system is crashed
>>                 copy_to_user(buffer, from, avail)
>
> Thanks.  Hopefully Pengcheng Yang and Jens Axboe can comment.

This patch looks good to me.

Reviewed-by: Pengcheng Yang <yangpc@wangsu.com>

>
> I'm thinking we should backport this into earlier kernels and that the
> commit we're fixing is
>
> Fixes: 341a7213e5c1 ("kernel/relay.c: fix read_pos error when multiple readers")

I suggest starting backport with this tag:

Fixes: 8d62fdebdaf9 ("relay file read: start-pos fix")

