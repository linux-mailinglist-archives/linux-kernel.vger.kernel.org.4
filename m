Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3170273250D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjFPCLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFPCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:11:28 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830532962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:11:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VlDwYUZ_1686881481;
Received: from 30.221.130.155(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VlDwYUZ_1686881481)
          by smtp.aliyun-inc.com;
          Fri, 16 Jun 2023 10:11:22 +0800
Message-ID: <bb92b1f4-8433-de5c-0ce1-b23e693b8ad5@linux.alibaba.com>
Date:   Fri, 16 Jun 2023 10:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [BUG] ocfs2/dlm: possible data races in
 dlm_drop_lockres_ref_done() and dlm_get_lock_resource()
To:     Tuo Li <islituo@gmail.com>, mark@fasheh.com, jlbec@evilplan.org,
        akpm@linux-foundation.org
Cc:     ocfs2-devel@oss.oracle.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
References: <CADm8TekHVfLHzKBLRfj7TwZiw=eL=VSgPpuhdpx_FSjNUXNtHQ@mail.gmail.com>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CADm8TekHVfLHzKBLRfj7TwZiw=eL=VSgPpuhdpx_FSjNUXNtHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/13/23 4:23 PM, Tuo Li wrote:
> Hello,
> 
> Our static analysis tool finds some possible data races in the OCFS2 file
> system in Linux 6.4.0-rc6.
> 
> In most calling contexts, the variables  such as res->lockname.name and
> res->owner are accessed with holding the lock res->spinlock. Here is an
> example:
> 
>   lockres_seq_start() --> Line 539 in dlmdebug.c
>     spin_lock(&res->spinlock); --> Line 574 in dlmdebug.c (Lock
> res->spinlock)
>     dump_lockres(res, ...); --> Line 575 in fs/ocfs2/dlm/dlmdebug.c
>       stringify_lockname(res->lockname.name, ...);  --> Line 493 in
> dlmdebug.c (Access res->lockname.name)
>       scnprintf(..., res->owner, ...);  -->Line 498 in dlmdebug.c (Access
> res->owner)
> 
> However, in the following calling contexts:
> 
>   dlm_deref_lockres_worker() --> Line 2439 in dlmmaster.c
>     dlm_drop_lockres_ref_done() --> Line 2459 in dlmmaster.c
>       lockname = res->lockname.name; --> Line 2416 in dlmmaster.c (Access
> res->lockname.name)

lockname won't changed during the lockres lifecycle.
So this won't cause any real problem since now it holds a reference.

> 
>   dlm_get_lock_resource() --> Line 701 in dlmmaster.c
>     if (res->owner != dlm->node_num) --> Line 1023 in dlmmaster.c (Access
> res->owner)

Do you mean in dlm_wait_for_lock_mastery()?
Even if owner changes suddenly, it will recheck, so I think it is also fine.

Thanks,
Joseph

> 
> The variables res->lockname.name and res->owner are accessed respectively
> without holding the lock res->spinlock, and thus data races can occur.
> 
> I am not quite sure whether these possible data races are real and how to
> fix
> them if they are real.
> 
> Any feedback would be appreciated, thanks!
> 
> Reported-by: BassCheck <bass@buaa.edu.cn> <bass@buaa.edu.cn>
> 
> Best wishes,
> Tuo Li
> 
