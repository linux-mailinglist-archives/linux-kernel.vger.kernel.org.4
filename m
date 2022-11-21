Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A46318C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiKUC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUC7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:59:08 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7A752F3A6;
        Sun, 20 Nov 2022 18:59:04 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx3Nh26Xpj4AgJAA--.25036S3;
        Mon, 21 Nov 2022 10:59:02 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VZv6XpjyWgXAA--.42783S3;
        Mon, 21 Nov 2022 10:58:56 +0800 (CST)
Subject: Re: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
To:     Ian Rogers <irogers@google.com>
References: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
Date:   Mon, 21 Nov 2022 10:58:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx9VZv6XpjyWgXAA--.42783S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw4xAr48JFWfKw4fuF45Wrg_yoW8ZFWDpa
        4YkFWUtrn5Jry8Aan7JF4aqF1Syrs3tayrJrWrtF1UZFZ8JasYgr1xXF4jyFZxZrZ7Zr4r
        u39a9Fy8Cr45Z3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2022 02:17 AM, Ian Rogers wrote:
> On Fri, Nov 18, 2022 at 1:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The latest version of grep claims the egrep is now obsolete so the build
>> now contains warnings that look like:
>>         egrep: warning: egrep is obsolescent; using grep -E
>> fix this up by moving the related file to use "grep -E" instead.
>>
>>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/perf`
>>
>> Here are the steps to install the latest grep:
>>
>>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>>   tar xf grep-3.8.tar.gz
>>   cd grep-3.8 && ./configure && make
>>   sudo make install
>>   export PATH=/usr/local/bin:$PATH
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Hi Tiezhu,
>
> installing a newer grep tool in order to build/test perf is somewhat
> burdensome, as such I don't think we should merge this change. Looking
> at my Debian derived distro. I have grep 3.7, so I'd need to do this.
> I imagine the majority of people are using a grep earlier than 3.8. I
> agree there is a problem perhaps we can:
>  - rewrite to just need grep and not egrep;
>  - rewrite in a stable language with regex support, perhaps python;
>  - have a grep/egrep wrapper that selects based on version number.
>

Hi Ian,

I found this issue on Linux From Scratch system which uses grep 3.8 [0],
we can see the following NEWS in grep-3.8 release announcement [1]:

"The egrep and fgrep commands, which have been deprecated since
  release 2.5.3 (2007), now warn that they are obsolescent and should
  be replaced by grep -E and grep -F."

Additionally, the next grep rpm/deb version is 3.8 on Fedora [2]
and Debian [3], so use "grep -E" instead of "egrep" so we won't see
the warning for various versions of grep.

[0] https://linuxfromscratch.org/~thomas/multilib/chapter06/grep.html
[1] https://savannah.gnu.org/forum/forum.php?forum_id=10227
[2] https://packages.fedoraproject.org/pkgs/grep/grep/fedora-rawhide.html
[3] https://packages.debian.org/sid/grep

Thanks,
Tiezhu

