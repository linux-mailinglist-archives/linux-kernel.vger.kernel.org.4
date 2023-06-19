Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1024C73499F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFSBFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSBFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB4AF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379BC60F2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8685C433C8;
        Mon, 19 Jun 2023 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687136730;
        bh=aENsRAPrMxi7xNcA1r1l3GGPPzWOxpUMPH8pO4uywNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KokKEq/MYrbE2WoxaShiUkoYn+myF0HmnnWBY6I9at51U7XrV6LJw721kmTSGWqAl
         7P/1cHTtaBvGXLdQ5y2fmUZYjb0z8Px+4MJXWO22NaIaSUJOBUoUUeJ37eWujbBbsB
         6180SmuhAnNXTlPdYO5ne73RiuzAWR6+4vz0I/kKeQ0w/2GwOpxlAZEmZurx6dU8Jf
         m/jGSwrpCRnPohM9NEC5LRYeTOIp8vo8XsYcK3srUyiGxIHRnsJq5faEuBq3+0YrS6
         B6YO+8PzMssi+BnaofabON6nxoJ3Mtb814ZVMkEmL1TJoFlVWajrVh3/G6+7NGGM68
         awNSclZKrQPjw==
Message-ID: <53c85f6c-c776-b364-5098-613b2e911067@kernel.org>
Date:   Mon, 19 Jun 2023 09:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] f2fs: enable nowait async buffered writes
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613072912.52249-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230613072912.52249-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 15:29, Yangtao Li wrote:
> This adds the async buffered write support to f2fs,
> the following is the relevant test data.
> 
> iodepth      | 1    | 2    | 4    | 8    | 16   |
> before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
> after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |
> 
> The following is the fio configuration:
> 
> [global]
> ioengine=io_uring
> sqthread_poll=1
> threads=1
> iodepth=32
> hipri=0
> direct=0
> fixedbufs=0
> uncached=0
> nowait=0
> force_async=0
> randrepeat=0
> time_based=0
> size=256M
> filename=/data/test/local/io_uring_test
> group_reporting
> [read256B-rand]
> bs=4096
> rw=randwrite
> numjobs=1
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Jaegeuk, it may be late, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
