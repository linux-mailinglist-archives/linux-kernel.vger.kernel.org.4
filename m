Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086AA5B3C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiIIPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIIPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:50:18 -0400
Received: from p3plwbeout22-02.prod.phx3.secureserver.net (p3plsmtp22-02-2.prod.phx3.secureserver.net [68.178.252.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCC5F7ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:50:17 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id WgGjobKzWimR6WgGkodAum; Fri, 09 Sep 2022 08:50:14 -0700
X-CMAE-Analysis: v=2.4 cv=U/ZXscnu c=1 sm=1 tr=0 ts=631b60b8
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10 a=i0EeH86SAAAA:8
 a=zk3y8DHZygHQSc2CZO8A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  WgGjobKzWimR6
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oWgGj-0006By-8N; Fri, 09 Sep 2022 16:50:13 +0100
Message-ID: <46301691-6196-ca3b-7a20-099d7b87c2ec@squashfs.org.uk>
Date:   Fri, 9 Sep 2022 16:50:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] squashfs: add the mount parameter
 theads=<single|multi|percpu>
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, wangbing6@huawei.com,
        zhongjubin@huawei.com, chenjianguo3@huawei.com
References: <20220816010052.15764-1-nixiaoming@huawei.com>
 <20220902094855.22666-1-nixiaoming@huawei.com>
 <20220902094855.22666-2-nixiaoming@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220902094855.22666-2-nixiaoming@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGLM3x0WOFt7xmsMp5kIeAcrsgrUKYM0sprjQIUWNUvvOBVoy6T81dqx+WtrSCbEi/36lH3XPlVJx61/0remlrQsYxPTc8t47TzbUfxowZDvOwQXdkFF
 FyWALWOYqcjNO2S62LEi6ZgBnBSAVDz0Q3CjRcVY0OwJf8CVqdAMp5uNHs0oRCSBD2jKT/3fNYcFyjnRRfL+0hlNYssPYnP+UNo=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 10:48, Xiaoming Ni wrote:
> Squashfs supports three decompression concurrency modes:
> 	Single-thread mode: concurrent reads are blocked and the memory overhead
> is small.
> 	Multi-thread mode/percpu mode: reduces concurrent read blocking but
> increases memory overhead.
> 
> The corresponding schema must be fixed at compile time. During mounting,
> the concurrent decompression mode cannot be adjusted based on file read
> blocking.
> 
> The mount parameter theads=<single|multi|percpu> is added to select
> the concurrent decompression mode of a single SquashFS file system
> image.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Additional review comment ...

[SNIP]

> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 32565dafa7f3..fd4e70d45f3c 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -47,10 +47,12 @@ enum Opt_errors {

[SNIP]

> +#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
> +	opts->thread_ops = &squashfs_decompressor_single; > +#elif CONFIG_SQUASHFS_DECOMP_MULTI

this should be

#elif defined CONFIG_SQUASHFS_DECOMP_MULTI

> +	opts->thread_ops = &squashfs_decompressor_multi;
> +#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU

this should be

#elif defined CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU

Phillip

> +	opts->thread_ops = &squashfs_decompressor_percpu;
> +#endif
>   	fc->fs_private = opts;
>   	fc->ops = &squashfs_context_ops;
>   	return 0;

