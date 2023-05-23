Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3D70D3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjEWGZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjEWGZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82617118
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C8C62F79
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272FFC433D2;
        Tue, 23 May 2023 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684823123;
        bh=hAj2m2Dt0UOHATVzNL8YUz4SIC5ygDHcCMyKr8UTkcs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gw3Wxa7WUB/ZQ8B/NhvDOOj0ETRn8v1trv1+nWoDMJ81Ij0VZceFA9QlpyyJGOmFH
         zf/vLWvdYtU/MOlHV/YRpTRva7PR+eGNaFBYqHY61BbP0mmH9hKXG7XQKQNDBv7jNt
         pWdMp4XJYiBK3od94vZlzvi+sf/5p8zFOPRLkJfqnT22RcbGNdPsS3ZubDcvf3RbUT
         JxXrLMDhdybPJ+WhhZV3OAdtr593EevEBTZzA9UgOHFghRHpD1aLBITlOrB3q9hpxN
         0VijNurvR//HQHiHUtlL2vU7X4lGm/9ruVFA4rQt69rnNJYhpa15CQRL70j4yBGBHk
         SA0eAyhAQrhig==
Message-ID: <161736a2-1a79-b30a-002c-61ef9c237a22@kernel.org>
Date:   Tue, 23 May 2023 14:25:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] erofs: fix null-ptr-deref caused by
 erofs_xattr_prefixes_init
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/15 18:39, Jingbo Xu wrote:
> Fragments and dedupe share one feature bit, and thus packed inode may not
> exist when fragment feature bit (dedupe feature bit exactly) is set, e.g.
> when deduplication feature is in use while fragments feature is not.  In
> this case, sbi->packed_inode could be NULL while fragments feature bit
> is set.
> 
> Fix this by accessing packed inode only when it exists.
> 
> Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
> Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
