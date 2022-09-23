Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386765E75F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWIkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiIWIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:40:28 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86491CF486;
        Fri, 23 Sep 2022 01:40:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=cambda@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQW6EEv_1663922415;
Received: from smtpclient.apple(mailfrom:cambda@linux.alibaba.com fp:SMTPD_---0VQW6EEv_1663922415)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 16:40:16 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Syscall kill() can send signal to thread ID
From:   Cambda Zhu <cambda@linux.alibaba.com>
In-Reply-To: <87illeedc5.fsf@oldenburg.str.redhat.com>
Date:   Fri, 23 Sep 2022 16:40:15 +0800
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <613994F7-054D-4992-A159-96D34B17BC7F@linux.alibaba.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
 <87pmfn5tu1.fsf@email.froward.int.ebiederm.org>
 <87r102ejwo.fsf@oldenburg.str.redhat.com>
 <0CC7D0E7-71C5-4DAC-8A01-F9E13659F864@linux.alibaba.com>
 <87illeedc5.fsf@oldenburg.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 23, 2022, at 15:53, Florian Weimer <fweimer@redhat.com> wrote:
> 
>> I don't quite understand what you mean, sorry. But if kill() returns
>> -ESRCH for tid which is not equal to tgid, kill() can only send signal
>> to thread group via main thread id, that is what BSD did and manual
>> said. It seems not odd?
> 
> It's still odd because there's one TID per process that's valid for
> kill by accident.  That's all.
> 
> Thanks,
> Florian

As far as I know, there is no rule forbidding 'process ID'(TGID on Linux)
equals to main thread ID, is it right? If one wants to send signal to a
specific thread, tgkill() can do that. As far as I understand, the difference
between kill() and tgkill() is whether the signal is set on shared_pending,
whatever the ID is a process ID or a thread ID. For Linux, the main thread ID
just equals to the process ID. So the meaning of kill(main_tid, sig) is sending
signal to a process, of which the PID equals to the first argument. It's not odd,
I think.

Thanks,
Cambda
