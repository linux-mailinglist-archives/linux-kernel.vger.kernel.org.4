Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6755FF817
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJOCuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOCuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1A3B46A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383CF61BD4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED403C433C1;
        Sat, 15 Oct 2022 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665802204;
        bh=DC9cQh2iywyg4Y6PZKDaIDzvavBQlm9a/fexbxAjr0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MvXRlz+lKRXYZ7f+hCajHWH7xh9Y4gXeXKX9s+H1pNwHPsC4uB2l46ONHV14DU0om
         XzUxnKE4QH4KTo4LCkTUO+/z16stjftGzUPAgNQ79gq7pIeBeYHY/aOQ5iArUMfebk
         yg6FaVw22RVhjDPUlOJnvvmEsH2CQAKTNJI5qyTqlg9WJyhrY2UkTO4yglKa6QlPvA
         3VvdQlDqzxIyOz1VXT4NfUZsPGLcnpb2Ini9CnvgekVAQBJOlyzyIbuYeywWUKnzzJ
         lq8wnYJE85BEUOH5zX3vZvQU8f/4HKNxf/YtTS4o9FSnVrSqEoJYM2MkfsutOMhxv5
         hUGd10phwRMqw==
Message-ID: <cb1474f7-b1fd-f22a-4250-77f2e931a742@kernel.org>
Date:   Sat, 15 Oct 2022 10:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] erofs: shouldn't churn the mapping page for duplicated
 copies
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221012045056.13421-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221012045056.13421-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/12 12:50, Gao Xiang wrote:
> If other duplicated copies exist in one decompression shot, should
> leave the old page as is rather than replace it with the new duplicated
> one.  Otherwise, the following cold path to deal with duplicated copies
> will use the invalid bvec.  It impacts compressed data deduplication.
> 
> Also, shift the onlinepage EIO bit to avoid touching the signed bit.
> 
> Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
