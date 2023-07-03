Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A3745ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGCLOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:14:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA72BC4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:14:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2032B2F4;
        Mon,  3 Jul 2023 04:14:58 -0700 (PDT)
Received: from [10.57.76.95] (unknown [10.57.76.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2443F762;
        Mon,  3 Jul 2023 04:14:13 -0700 (PDT)
Message-ID: <c7dbaa5e-f5ae-5dc5-4063-b8099a3058e0@arm.com>
Date:   Mon, 3 Jul 2023 12:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Content-Language: en-GB
To:     =?UTF-8?Q?Joan_Bruguera_Mic=c3=b3?= <joanbrugueram@gmail.com>,
        zhengqi.arch@bytedance.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <2d44a1bd-eb80-7724-ff4e-a0fc3bfd8b72@bytedance.com>
 <20230521135733.1076395-1-joanbrugueram@gmail.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230521135733.1076395-1-joanbrugueram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2023 14:57, Joan Bruguera Micó wrote:
> On 2023/5/3 13:37, Qi Zheng wrote:
>>> +void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
>>> +{
>>
>> It would be better to add a check:
>>
>> 	if (!debugfs_entry)
>> 		return;
>>
>>> +	debugfs_remove_recursive(debugfs_entry);
>>> +	ida_free(&shrinker_debugfs_ida, debugfs_id);
>>> +}
> 
> As a practical matter, both `debugfs_remove_recursive(NULL)` and
> `ida_free(_, -1);` are documented as no-ops, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/debugfs/inode.c?id=0dd2a6fb1e34d6dcb96806bc6b111388ad324722#n748
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc82bbf4dede758007763867d0282353c06d1121
> 
> Sorry for the late reply (the patch already reached the mainline tree).

Note that commit 69cb69ea5542 ("ida: Remove assertions that an ID was
allocated") currently in linux-next makes ida_free(..., -1) illegal.

I see a crash on boot on my test platform (Firefly-RK3288) with
linux-next because of this. Qi's suggested change fixes this.

I'm not sure whether Matthew's change removing the ((int)id < 0) check
was intentional or not. Reinstating that check would also fix the crash.

Steve
