Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B776B26E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjCIOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCIOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:30:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72526DF252
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC9A0B81F05
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E642EC433D2;
        Thu,  9 Mar 2023 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678372219;
        bh=29b1Xoc/WLcRlHoQ3CO6W52Ad1oWwKJf2jlU6m/7htc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Te6hDaVlj4PpLcOiT1SZdJNfAL/FFsGXbIVRs2h1YKFtfVEOEcvBkJM5GNmCEPtrU
         yzKdNHaArrYrpf93lY7R3K8iti3C0QNjDPML3XfFVuvJe9HvdMrTTWaxHd1qOQM05R
         R2vjz3KmY7kr5Ss7PvnGrM6ww1TiFoP/iCdNpXcm9pPj8BtohI690Zt4ta75zYL4is
         P91Ps0pDjl0pB6G7XJP47vB7jiF109cSuGpACLGHiljN9ZHx73iucF72yyWQ9z3muQ
         oB3fmb2r2xVeAqOdKcGeOt87q90SnSgJuWQjP7qTbwoO0atKZzzFBTFasmt984r8qR
         XOuun0XoQhycw==
Message-ID: <69463ce0-2ee7-6676-017d-06f0edd47570@kernel.org>
Date:   Thu, 9 Mar 2023 22:30:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] erofs: Revert "erofs: fix kvcalloc() misuse with
 __GFP_NOFAIL"
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/9 13:31, Gao Xiang wrote:
> Let's revert commit 12724ba38992 ("erofs: fix kvcalloc() misuse with
> __GFP_NOFAIL") since kvmalloc() already supports __GFP_NOFAIL in commit
> a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc").  So
> the original fix was wrong.
> 
> Actually there was some issue as [1] discussed, so before that mm fix
> is landed, the warn could still happen but applying this commit first
> will cause less.
> 
> [1] https://lore.kernel.org/r/20230305053035.1911-1-hsiangkao@linux.alibaba.com
> Fixes: 12724ba38992 ("erofs: fix kvcalloc() misuse with __GFP_NOFAIL")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
