Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F336E394E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjDPOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AB1FD7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56366115C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BB3C433EF;
        Sun, 16 Apr 2023 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655618;
        bh=7pAQdp9zOWqx4avhF2Eg2nBD/7QWu9T59ZFFoTswNMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QHh9ZH95o94PQUzy68vuDqHSGC22vg3Bwk+P2SC6x0wkqD/rwcwlr/l/bbv4SQVzd
         fR2tDRhzTIAw3QHBOoRajU1jbxs6ZYXkTIUU7xMUZUz3R48vY1sCrDP1GkMZTickrk
         hDTm5BOdocydSm8ZgRdz/unhNV/ncpWolWTFhbNMvMMOrn8mgWaOE6m5/G2bwWm6Gv
         McDlV28jnKiMBDRxlTqJ+1Bui6ekq0VSBTMJCuL5eb16BmPYnS6Ay1ql/gUpyYNdyR
         UtbUFw37rAz0YV/55Fdqwj8b2b/I3MPQq7XEud19i5qsY0Gl2KkRm1QPLnG1cNeBvR
         pfJ1yoJIXEWBw==
Message-ID: <b7604342-1d56-1c15-1526-380a4fdbbb41@kernel.org>
Date:   Sun, 16 Apr 2023 22:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: stop parsing non-compact HEAD index if clusterofs
 is invalid
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
References: <20230410173714.104604-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230410173714.104604-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 1:37, Gao Xiang wrote:
> Syzbot generated a crafted image [1] with a non-compact HEAD index of
> clusterofs 33024 while valid numbers should be 0 ~ lclustersize-1,
> which causes the following unexpected behavior as below:
> 
>   BUG: unable to handle page fault for address: fffff52101a3fff9
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 23ffed067 P4D 23ffed067 PUD 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 1 PID: 4398 Comm: kworker/u5:1 Not tainted 6.3.0-rc6-syzkaller-g09a9639e56c0 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
>   Workqueue: erofs_worker z_erofs_decompressqueue_work
>   RIP: 0010:z_erofs_decompress_queue+0xb7e/0x2b40
>   ...
>   Call Trace:
>    <TASK>
>    z_erofs_decompressqueue_work+0x99/0xe0
>    process_one_work+0x8f6/0x1170
>    worker_thread+0xa63/0x1210
>    kthread+0x270/0x300
>    ret_from_fork+0x1f/0x30
> 
> Note that normal images or images using compact indexes are not
> impacted.  Let's fix this now.
> 
> [1] https://lore.kernel.org/r/000000000000ec75b005ee97fbaa@google.com
> 
> Reported-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com
> Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
> Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
