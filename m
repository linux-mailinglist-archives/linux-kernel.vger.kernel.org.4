Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E148717954
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjEaH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjEaH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:56 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBCE183;
        Wed, 31 May 2023 00:58:37 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae86a.dynamic.kabel-deutschland.de [95.90.232.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3010B61DFA908;
        Wed, 31 May 2023 09:57:55 +0200 (CEST)
Message-ID: <da8aacb2-ec52-ed7a-8857-1cf89e7de751@molgen.mpg.de>
Date:   Wed, 31 May 2023 09:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next v3 6/7] md/raid1-10: don't handle pluged bio by
 daemon thread
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-7-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230529131106.2123367-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patch. Some minor nits in case you should resend this.

In the summary/title it should be plug*g*ed.

Am 29.05.23 um 15:11 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> current->bio_list will be set under submit_bio() context, in this case
> bitmap io will be added to the list and wait for current io submission to

1.  I’d use present tense: s/will be set/is set/; s/will be added/is added/
2.  wait*s*

> finish, while current io submission must wait for bitmap io to be done.
> commit 874807a83139 ("md/raid1{,0}: fix deadlock in bitmap_unplug.") fix
> the deadlock by handling plugged bio by daemon thread.
> 
> On the one hand, the deadlock won't exist after commit a214b949d8e3
> ("blk-mq: only flush requests from the plug in blk_mq_submit_bio"). On
> the other hand, current solution makes it impossible to flush plugged bio
> in raid1/10_make_request(), because this will cause that all the writes
> will goto daemon thread.

s/goto/go to/


Kind regards,

Paul


> In order to limit the number of plugged bio, commit 874807a83139
> ("md/raid1{,0}: fix deadlock in bitmap_unplug.") is reverted, and the
> deadlock is fixed by handling bitmap io asynchronously.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid1-10.c | 14 ++++++++++++++
>   drivers/md/raid1.c    |  4 ++--
>   drivers/md/raid10.c   |  8 +++-----
>   3 files changed, 19 insertions(+), 7 deletions(-)

[…]
