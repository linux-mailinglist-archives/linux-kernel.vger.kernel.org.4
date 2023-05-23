Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4729D70DDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjEWNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjEWNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:47:46 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0483132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:47:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VjKTIpJ_1684849653;
Received: from 30.0.185.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjKTIpJ_1684849653)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 21:47:35 +0800
Message-ID: <0318d80c-4a4b-41af-1005-75947ba510d2@linux.alibaba.com>
Date:   Tue, 23 May 2023 21:47:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] Follow-up "Fix excessive CPU usage during compaction"
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230515113344.6869-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Mel,

On 5/15/2023 7:33 PM, Mel Gorman wrote:
> The series "Fix excessive CPU usage during compaction" [1] attempted to
> fix a bug [2] but Vlastimil noted that the fix was incomplete [3]. While
> the series was merged, fast_find_migrateblock was still disabled. This
> series should fix the corner cases and allow 95e7a450b819 ("Revert
> "mm/compaction: fix set skip in fast_find_migrateblock"") to be safely
> reverted. Details on how many pageblocks are rescanned are in the
> changelog of the last patch.
> 
> [1] https://lore.kernel.org/r/20230125134434.18017-1-mgorman@techsingularity.net
> [2] https://bugzilla.suse.com/show_bug.cgi?id=1206848
> [3] https://lore.kernel.org/r/a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz

I've run this series on my machine, which can solve the regression I met 
before [1], and no other issues found. So please feel free to add:
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

[1] 
https://lore.kernel.org/all/3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com/

> 
>   mm/compaction.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
