Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F860C164
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJYBuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJYBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:49:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE92AD8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72C2EB8171B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B00C433D6;
        Tue, 25 Oct 2022 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666662326;
        bh=2oFVmjIn9m9WJjC2ZDlPGx0e3SXtjNWV9+Dh/HY/3JY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hG9NROEexa5EbY349L4h8+E4KqEKN0+cn33M8cBVQ4mqKaByQDcXyStZQgfdY0gmt
         5vCIRz9q3ndIm34suz1hQT5p4KAOt3T8UUXzrp982HXZBP7kNPLyZR+no8F2BMcbO2
         u/IbdTzyx2kAVRMvALdem90jSlh+w1q6CUnIKXc5y3oeUwhNVQORvVc9EIq3EqySOi
         ORcqgbdR9cT0xaNhyMyik42YOsIb05v0jW/ktObfxy09DZq7SCMP27IV/JZm6FCn7Z
         D777Z1uVfDn8toJ8F75xjBN58UMkEusrw1ZxpfYKZVM07CVYbCtmZlOBjmwPZ0SRIp
         TpuBjECt7uqjw==
Message-ID: <c2333196-df50-ad98-948f-aed4b83ec7ab@kernel.org>
Date:   Tue, 25 Oct 2022 09:45:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: show more debug info for discard pend list
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221021092435.17124-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021092435.17124-1-frank.li@vivo.com>
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

On 2022/10/21 17:24, Yangtao Li wrote:
> This patch shows the discard pend list information:
> 
> Discard pend list(X:exist .:not exist):
>    0   X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X
>    32  X X X X . X X . X X X X X X X X X X X X . X X . X X . X X . X X
>    64  . . X X . X X . . X . . . X X . X . X . X X . X . X X . . . X .
>    96  . X . . . . X . . . . X . . . X X . . . . . . . . . X . . X X .
>    128 . X . . . X . . X X X . . . . . X X X . . X . . . . . . . X . X
>    160 . . X . . . . . X . . . . . . . . . X . . . X X . . . X . X . .
>    192 . . . . . . . . . . . . . . . . X . . . . . . . . . . . . . . .
>    224 . X . . . . X . . X . . . . . . . X . . . . . . . X . . . X . .
>    256 . . . . . . X . . . . . . . . . . . . . . . . . . . . . . . X .
>    288 . . . . . . . . . . X . . . . . . . X . . . . . . . . . . . . .
>    320 . . . . . . X X . . X . . . X X . . . . . . . X . . . . . . . .
>    352 . . . . . X . . . . . . . . . . . . . . X . . . . . . . . X . .
>    384 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . X
>    416 X . . . . X . . . . . . . . . . . . . . . . . . . . . . . . . .
>    448 . . . . . . . . X . . . . . . . . . . . . . . . . X . . . . . .
>    480 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

How about adding this into a procfs entry?

Thanks,
