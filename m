Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D770D258
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjEWD0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315590
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7434862DC3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF4C433D2;
        Tue, 23 May 2023 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684812393;
        bh=HT49vkUy5eZ0ZBZi3mTVCBueo3VRnPSV1wZa21TSs4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CMyRmZAS1lVU3R9ErqaPZpq2u6k0W7wQNqyU+h3GEEk6FutipdJ/F94mtYIwKoQU1
         cjKJk4uR3sK/enYOfzrp484C0VC2tjLgkTpGS8k0r/BAauqc/mi0vhZfWuwz+RdSt4
         g9X+tZNOBIgWq79wITr6j2xrqVLiKXuueKqo8vowy4AGyi47aUl9bsd3TboRBvpFT5
         Ed6zKogR5xqOUtcBAuaoEksigXqKl/2u7sBJm/LlcqJc0DA+X7t09WO148Cs4lWNC1
         oKk7muH+lQkZSH3rVJP8jwBbSAf76xQvX5a7BpXbSLJLpU7B9zyfRbttjO4U1Bamsv
         oZbTCyqw87qFw==
Message-ID: <57c5f06c-ac41-d6c7-3a07-45d07f676577@kernel.org>
Date:   Tue, 23 May 2023 11:26:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sandeep Dhavale <dhavale@google.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
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

On 2023/5/22 17:21, Gao Xiang wrote:
> As Sandeep shown [1], high priority RT per-cpu kthreads are
> typically helpful for Android scenarios to minimize the scheduling
> latencies.
> 
> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> EROFS_FS_PCPU_KTHREAD.
> 
> Also clean up unneeded sched_set_normal().
> 
> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> Cc: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
