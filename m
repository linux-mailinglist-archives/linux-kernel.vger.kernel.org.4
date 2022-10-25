Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8B60C94B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiJYKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiJYKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:02:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62848E98A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D76BB81C9C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE6CC433C1;
        Tue, 25 Oct 2022 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666691695;
        bh=Sn5QxHUGW0MLxrbMYVVS6I63hpzFrJ1YWuKaNZyOvS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YHVpMCJMF0uOk2HMwX+HJOl3KTD/hatY7LAC+l1uKyFN4Nto1lmHY0iJ52cMa/jdU
         4ygFcDKm4xhCOp61ntTub1YFFnnSwreArUgKgjH1KYqEmdim2doGT/gZzWkXgtNSRD
         AYkyotinH5HZ3aFs0okM5T7un8T1klvltA1L6JQ0grPtGzazlzSRTL2NKrXi4N3KAy
         1NOEjkkIMkx2j/08HnJhc1pPsXSybJYMcW4nox2USpujeocx3CafFNLTiIJR5yg8eM
         UIICr8jEkGMmXEpcovyy3vJXJTFqzj/6E14BUrLFDQLnyAhW0bjuqVO8koQ/dgtFa9
         ZLueJ6IYRxuig==
Message-ID: <7d0e122b-763e-300a-0f14-5903f788ab56@kernel.org>
Date:   Tue, 25 Oct 2022 17:54:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] f2fs: fix normal discard process
Content-Language: en-US
To:     zhangdongdong <zhangdongdong1@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1666690836-388913-1-git-send-email-zhangdongdong1@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1666690836-388913-1-git-send-email-zhangdongdong1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 17:40, zhangdongdong wrote:
> From: Dongdong Zhang <zhangdongdong1@oppo.com>
> 
> In the DPOLICY_BG mode, there is a conflict between
> the two conditions "i + 1 < dpolicy->granularity" and
> "i < DEFAULT_DISCARD_GRANULARITY". If i = 15, the first
> condition is false, it will enter the second condition
> and dispatch all small granularity discards in function
>   __issue_discard_cmd_orderly. The restrictive effect
> of the first condition to small discards will be
> invalidated. These two conditions should align.
> 
> Fixes: 20ee4382322c ("f2fs: issue small discard by LBA order")
> Signed-off-by: Dongdong Zhang <zhangdongdong1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
