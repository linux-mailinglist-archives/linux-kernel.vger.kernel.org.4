Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E546F8E2D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjEFDBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjEFDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:01:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAA2718;
        Fri,  5 May 2023 20:01:45 -0700 (PDT)
Received: from kwepemm600019.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCshH30HszLpVf;
        Sat,  6 May 2023 10:58:55 +0800 (CST)
Received: from [10.136.112.228] (10.136.112.228) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 11:01:42 +0800
Subject: Re: BUG: KASAN: stack-out-of-bounds in __ip_options_echo
To:     Florian Westphal <fw@strlen.de>
CC:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
        <caowangbao@huawei.com>
References: <05324dd2-3620-8f07-60a0-051814913ff8@huawei.com>
 <20230502165446.GA22029@breakpoint.cc>
 <9dd7ec8f-bc40-39af-febb-a7e8aabbaaed@huawei.com>
 <20230505055822.GA6126@breakpoint.cc>
From:   "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>
Message-ID: <4f3d231e-5ba8-08a9-e2d3-95edf5bb2dc7@huawei.com>
Date:   Sat, 6 May 2023 11:01:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230505055822.GA6126@breakpoint.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.112.228]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 13:58, Florian Westphal wrote:
> Fengtao (fengtao, Euler) <fengtao40@huawei.com> wrote:
>> Hi
>>
>> I have tested the patch, the panic not happend.
>> And I search the similar issue in kernel, and found commit:
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed0de45a1008
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3da1ed7ac398
>>
>> So I tested another patch like this:
>> ------------[ cut here ]------------
>> --- .//net/ipv4/netfilter/nf_reject_ipv4.c      2023-05-02 13:03:35.427896081 +0000
>> +++ .//net/ipv4/netfilter/nf_reject_ipv4.c.new  2023-05-02 13:03:00.433897970 +0000
>> @@ -187,6 +187,7 @@ > 
>>  void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
>>  {
>> +       struct ip_options opt;
>>         struct iphdr *iph = ip_hdr(skb_in);
>>         u8 proto = iph->protocol;
>>
>> @@ -196,13 +197,18 @@
>>         if (hook == NF_INET_PRE_ROUTING && nf_reject_fill_skb_dst(skb_in))
>>                 return;
>>
>> +       memset(&opt, 0, sizeof(opt));
>> +       opt.optlen = iph->ihl*4 - sizeof(struct iphdr);
>> +       if (__ip_options_compile(dev_net(skb_in->dev), &opt, skb_in, NULL))
>> +               return;
>> +
>>         if (skb_csum_unnecessary(skb_in) || !nf_reject_verify_csum(proto)) {
>> -               icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
>> +               __icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0, &opt);
>>                 return;
>>         }
>>
>>         if (nf_ip_checksum(skb_in, hook, ip_hdrlen(skb_in), proto) == 0)
>> -               icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
>> +               __icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0, &opt);
>>  }
>>  EXPORT_SYMBOL_GPL(nf_send_unreach);
>> ------------[ cut here ]------------
>>
>> This can also fix the issue :)
> 
> No, it papers over the problem, by only fixing this specific instance
> (icmpv4).  What about ipv6?  What about all other IPCB accesses?
> 
That make sense

>> BTW, I think the problem is more then ipvlan? Maybe some other scenarios that can trigger such issue.
> 
> Such as?
> 
> I don't see how this is fixable, just have have a look at "git grep
> IPCB", how do you envision stack to know how such access is valid or
> not?
> 
> .
> 
Hi, Floian
I already tested your patch for 24 hours, and the panic never happened; Could you send your commit to kernel-upstream?
If you do not have time, I would be happy to sent this patch and add your SOB.

