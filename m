Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742C6105E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiJ0Wor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJ0Wom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:44:42 -0400
Received: from p3plwbeout26-03.prod.phx3.secureserver.net (p3plsmtp26-03-2.prod.phx3.secureserver.net [216.69.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04F65D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:44:37 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id oBc4o9BUeGLwaoBc5ohVU2; Thu, 27 Oct 2022 15:44:37 -0700
X-CMAE-Analysis: v=2.4 cv=Xus/hXJ9 c=1 sm=1 tr=0 ts=635b09d5
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=FXvPX3liAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=F6JCwgpozKJYaf9-k9MA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  oBc4o9BUeGLwa
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ooBc3-00075e-Dr; Thu, 27 Oct 2022 23:44:36 +0100
Message-ID: <0c8d66ee-af80-1569-69c5-0c28723e148c@squashfs.org.uk>
Date:   Thu, 27 Oct 2022 23:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 0/2] squashfs: Add the mount parameter "threads="
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, zhongjubin@huawei.com,
        chenjianguo3@huawei.com
References: <20220930091406.50869-1-nixiaoming@huawei.com>
 <20221019030930.130456-1-nixiaoming@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20221019030930.130456-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfKwnhruVPoTaPGb/ZjU0RGhTMMPBgm0Hc4VohZ1/vbQmgDwwGpj04zhYmMjfrKqGI3K2t32GJbLoKFKjlXe/6FofWBVjx2lg87r3ANhQ/juGmD+UVdvq
 k2cV0vQNZIjBRwHm05TOo4HfRawq4NYF4qvVSwJl3Fm6NLNE3k+Q/Bm7sLz6sxzSS1UGJtGNxp09pmUCE4SjBSbOnvlvtHA/p/I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 04:09, Xiaoming Ni wrote:
> Currently, Squashfs supports multiple decompressor parallel modes. However, this
> mode can be configured only during kernel building and does not support flexible
> selection during runtime.
> 
> In the current patch set, the mount parameter "threads=" is added to allow users
> to select the parallel decompressor mode and configure the number of decompressors
> when mounting a file system.
> 
> "threads=<single|multi|percpu|1|2|3|...>"
> The upper limit is num_online_cpus() * 2.
> 
> v6: fix opt->thread_ops unassigned if CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set.
> 

This version looks good to me.  Thanks.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

> v5: https://lore.kernel.org/lkml/20220930091406.50869-1-nixiaoming@huawei.com/
>    fix a low-level mistake in patching:
>    fs/squashfs/super.c:492:7: warning: "CONFIG_SQUASHFS_DECOMP_MULTI" is
>    not defined, evaluates to 0 [-Wundef]
> 
> v4: https://lore.kernel.org/lkml/20220916083604.33408-1-nixiaoming@huawei.com/
>   Based on Philip Lougher's suggestion, make the following updates:
>   1. Use static modifiers to avoid changing symbol names.
>   2. Fixed some formatting issues
> 
> v3: https://lore.kernel.org/lkml/20220902094855.22666-1-nixiaoming@huawei.com/
>    Based on Philip Lougher's suggestion, make the following updates:
>    1. The default configuration is the same as that before the patch installation.
>    2. Compile the three decompression modes when the new configuration is enabled.
>    3. "threads=1" supports only the SQUASHFS_DECOMP_SINGLE mode.
> 
> v2: https://lore.kernel.org/lkml/20220816010052.15764-1-nixiaoming@huawei.com/
>    fix warning: sparse: incorrect type in initializer (different address spaces)
>    Reported-by: kernel test robot <lkp@intel.com>
> 
> v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/
> *** BLURB HERE ***
> 
> Xiaoming Ni (2):
>    squashfs: add the mount parameter theads=<single|multi|percpu>
>    squashfs: Allows users to configure the number of decompression
>      threads
> 
>   fs/squashfs/Kconfig                     | 51 +++++++++++--
>   fs/squashfs/block.c                     |  2 +-
>   fs/squashfs/decompressor.c              |  2 +-
>   fs/squashfs/decompressor_multi.c        | 20 +++--
>   fs/squashfs/decompressor_multi_percpu.c | 23 ++++--
>   fs/squashfs/decompressor_single.c       | 15 +++-
>   fs/squashfs/squashfs.h                  | 23 ++++--
>   fs/squashfs/squashfs_fs_sb.h            |  4 +-
>   fs/squashfs/super.c                     | 97 ++++++++++++++++++++++++-
>   9 files changed, 203 insertions(+), 34 deletions(-)
> 

