Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CF6E5D87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjDRJhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDRJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:37:13 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795210D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:37:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgPSzNt_1681810626;
Received: from 30.221.129.246(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VgPSzNt_1681810626)
          by smtp.aliyun-inc.com;
          Tue, 18 Apr 2023 17:37:07 +0800
Message-ID: <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
Date:   Tue, 18 Apr 2023 17:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>,
        akpm <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew picked ocfs2 patches into -mm tree before.

Thanks,
Joseph

On 4/18/23 5:17 PM, Christian Brauner wrote:
> 
> On Mon, 17 Apr 2023 22:56:24 +0200, Arnd Bergmann wrote:
>> On 32-bit architectures with KASAN_STACK enabled, the total stack usage
>> of the ocfs2_ioctl function grows beyond the warning limit:
>>
>> fs/ocfs2/ioctl.c: In function 'ocfs2_ioctl':
>> fs/ocfs2/ioctl.c:934:1: error: the frame size of 1448 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
>>
>> Move each of the variables into a basic block, and mark ocfs2_info_handle()
>> as noinline_for_stack, in order to have the variable share stack slots.
>>
>> [...]
> 
> Going by git log, ocfs2 patches don't go through a separate tree.
> So unless there are objections I'm taking this through fs.misc,
> 
> tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
> branch: fs.misc
> [1/1] ocfs2: reduce ioctl stack usage
>       commit: 85ef56bc2d65215f43ceb7377ca14a779468928d
> 
> Christian
