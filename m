Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200806447BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiLFPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiLFPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:13:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF602F3B1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE090B81A19
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1741CC433C1;
        Tue,  6 Dec 2022 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670339358;
        bh=+JcHD2fgJ20Y5Ga8vP9xc8ZWJSsLdzLTyYcLglXSHoo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dOw7DB1rthod/ATG10j7eSN1i1cwE4kYqTn501nuEHEErFUTP/4wH/NNQZRONz+ov
         q+f1d9dDjIzLec3ukh0piDqRovFVZLIvfwTfBI7G1/id5BOBqxlO631NACMvEr7VJm
         Ewz744z33wjCJGRW+1Qe9WDQQw9S/CuPXYysYLZ5VXNHsGPM3CY53KIJw16neNGxna
         b9jHqhRI08YNB3FukZeYU9u7TX8bfiG/J8z2VPzlaUf2W/QytC6icBlRsKWUooP6Nc
         KtqBLU7iXbBGGnCGyfGdorFJJ8G9fU/xo8anxiGtetDbSoJY3JsaPfRx8vBPkeOynn
         jxMj4adJb2cHA==
Message-ID: <3f0b9ff1-eea5-150c-c57e-4e1d0a06e220@kernel.org>
Date:   Tue, 6 Dec 2022 23:09:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] erofs: validate the extent length for uncompressed
 pclusters
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
 <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/5 23:00, Gao Xiang wrote:
> syzkaller reported a KASAN use-after-free:
> https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2
> 
> The referenced fuzzed image actually has two issues:
>   - m_pa == 0 as a non-inlined pcluster;
>   - The logical length is longer than its physical length.
> 
> The first issue has already been addressed.  This patch addresses
> the second issue by checking the extent length validity.
> 
> Reported-by: syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
> Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
