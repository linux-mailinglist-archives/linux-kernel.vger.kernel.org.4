Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D87194ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjFAIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjFAIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:00:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA41AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:58:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q4dCh-00013e-Hr; Thu, 01 Jun 2023 09:58:39 +0200
Message-ID: <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
Date:   Thu, 1 Jun 2023 09:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Christian Brauner <brauner@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
In-Reply-To: <20230519-vormittag-dschungel-83607e9d2255@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1685606327;6ba24a72;
X-HE-SMSGID: 1q4dCh-00013e-Hr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.23 14:15, Christian Brauner wrote:
> On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
>> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
>>> This patch allows the vhost and vhost_task code to use CLONE_THREAD,
>>> CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
>>> normal testing, haven't coverted vsock and vdpa, and I know you guys
>>> will not like the first patch. However, I think it better shows what
>>
>> Just to summarize the core idea behind my proposal is that no signal
>> handling changes are needed unless there's a bug in the current way
>> io_uring workers already work. All that should be needed is
>> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
[...]
>> So it feels like this should be achievable by adding a callback to
>> struct vhost_worker that get's called when vhost_worker() gets SIGKILL
>> and that all the users of vhost workers are forced to implement.
>>
>> Yes, it is more work but I think that's the right thing to do and not to
>> complicate our signal handling.
>>
>> Worst case if this can't be done fast enough we'll have to revert the
>> vhost parts. I think the user worker parts are mostly sane and are
> 
> As mentioned, if we can't settle this cleanly before -rc4 we should
> revert the vhost parts unless Linus wants to have it earlier.

Meanwhile -rc5 is just a few days away and there are still a lot of
discussions in the patch-set proposed to address the issues[1]. Which is
kinda great (albeit also why I haven't given it a spin yet), but on the
other hand makes we wonder:

Is it maybe time to revert the vhost parts for 6.4 and try again next cycle?

[1]
https://lore.kernel.org/all/20230522025124.5863-1-michael.christie@oracle.com/

Ciao, Thorsten "not sure if I'm asking because I'm affected, or because
it's my duty as regression tracker" Leemhuis
