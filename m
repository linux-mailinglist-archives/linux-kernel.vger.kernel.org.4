Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DF5BDA33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiITCgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITCge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:36:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7246231
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663641393; x=1695177393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nk9gDyzIwubd+O3r5JYRHY7h56aCXeJ9B2IcQcqK5Pw=;
  b=KQZSDLzHo/wlXYpSSLrxLXM6tjTcosv/VyRAFhbWzR2GyJMKVf00fwac
   qRj6DFAG1ZEMaeRFUh4mABR4b5sSproPr6YsrKuDkagpzJNcbAJ5lOtJy
   emP/zqAoinndcPmIkxFLk0NvzQjIgisfAHn9NyLZwT/pgmzeuKucnKrUR
   V+1kjf+f2gk8IrjmD4I1H/BRjeyQtHJ5BUNibbcHNYbVJOJY3taHbcpJv
   IFIJs6w6Fiu+5cUmP85j+RsIm3dayVKdQvdC16eOeepnc+mCkqxlLEmsq
   fQiXrXC7o8QeQcjbL7ee9qseVzBxw7EnQcK70dy0RmOERRR0gFbQnZAeO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325874807"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325874807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 19:36:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="722552579"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.4.108]) ([10.238.4.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 19:36:29 -0700
Message-ID: <6ed22478-0c89-92ea-a346-0349be2dd99c@intel.com>
Date:   Tue, 20 Sep 2022 10:36:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 2/2] ipc/msg: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Manfred Spraul <manfred@colorfullife.com>,
        akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>, jiebin.sun@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-3-jiebin.sun@intel.com>
 <aadf6c7e-dea8-4dff-1815-cca9c2c2da9e@colorfullife.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <aadf6c7e-dea8-4dff-1815-cca9c2c2da9e@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/2022 8:53 PM, Manfred Spraul wrote:
> Hi Jiebin,
>
> On 9/13/22 21:25, Jiebin Sun wrote:
>> The msg_bytes and msg_hdrs atomic counters are frequently
>> updated when IPC msg queue is in heavy use, causing heavy
>> cache bounce and overhead. Change them to percpu_counter
>> greatly improve the performance. Since there is one percpu
>> struct per namespace, additional memory cost is minimal.
>> Reading of the count done in msgctl call, which is infrequent.
>> So the need to sum up the counts in each CPU is infrequent.
>>
>> Apply the patch and test the pts/stress-ng-1.4.0
>> -- system v message passing (160 threads).
>>
>> Score gain: 3.99x
>>
>> CPU: ICX 8380 x 2 sockets
>> Core number: 40 x 2 physical cores
>> Benchmark: pts/stress-ng-1.4.0
>> -- system v message passing (160 threads)
>>
>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Manfred Spraul <manfred@colorfullif.com>
>> @@ -495,17 +496,18 @@ static int msgctl_info(struct ipc_namespace 
>> *ns, int msqid,
>>       msginfo->msgssz = MSGSSZ;
>>       msginfo->msgseg = MSGSEG;
>>       down_read(&msg_ids(ns).rwsem);
>> -    if (cmd == MSG_INFO) {
>> +    if (cmd == MSG_INFO)
>>           msginfo->msgpool = msg_ids(ns).in_use;
>> -        msginfo->msgmap = atomic_read(&ns->msg_hdrs);
>> -        msginfo->msgtql = atomic_read(&ns->msg_bytes);
>> +    max_idx = ipc_get_maxidx(&msg_ids(ns));
>> +    up_read(&msg_ids(ns).rwsem);
>> +    if (cmd == MSG_INFO) {
>> +        msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
>> +        msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);
>
> Not caused by your change, it just now becomes obvious:
>
> msginfo->msgmap and ->msgtql are type int, i.e. signed 32-bit, and the 
> actual counters are 64-bit.
> This can overflow - and I think the code should handle this. Just 
> clamp the values to INT_MAX.
>
Hi Manfred,

Thanks for your advice. But I'm not sure if we could fix the overflow 
issue in ipc/msg totally by

clamp(val, low, INT_MAX). If the value is over s32, we might avoid the 
reversal sign, but still could

not get the accurate value.

