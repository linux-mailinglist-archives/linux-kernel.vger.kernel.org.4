Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F715B3BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiIIPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIIPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:25 -0400
X-Greylist: delayed 231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 08:30:52 PDT
Received: from p3plwbeout24-02.prod.phx3.secureserver.net (p3plsmtp24-02-2.prod.phx3.secureserver.net [68.178.252.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455FE1475C4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:30:51 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id WfuCofxtiw2jOWfuDok3O6; Fri, 09 Sep 2022 08:26:57 -0700
X-CMAE-Analysis: v=2.4 cv=DZ/SFthW c=1 sm=1 tr=0 ts=631b5b43
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=AgdXCVuIJE-Ip5MHRPMA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  WfuCofxtiw2jO
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oWfuC-0009Mr-0b; Fri, 09 Sep 2022 16:26:56 +0100
Message-ID: <56f53190-c6dc-7d9f-71c7-6626163df15c@squashfs.org.uk>
Date:   Fri, 9 Sep 2022 16:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/2] squashfs: Add the mount parameter "threads="
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, wangbing6@huawei.com,
        zhongjubin@huawei.com, chenjianguo3@huawei.com
References: <20220816010052.15764-1-nixiaoming@huawei.com>
 <20220902094855.22666-1-nixiaoming@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220902094855.22666-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfIbT6N89EXZC9Ay38cwuwM4PXp/m/5Ff7PyKkve1Bb3IXsEngdwQp2PXnjGlh/6bmFCo41Slmu3vmaIaHsUQLvZFFGT6NcqMP1xol/4vKey7gROYZPTe
 BgdYYmOqqCGZPT6FQ/OFO7RW7vlFoHu4+Lg+djdrKxr6FEsIBgP97v36aGkSBTYUhvkMA9PMtn3q0FN7TI13n043Y0awT8T8ktY=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 10:48, Xiaoming Ni wrote:
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
> 
> 
> v3: Based on Philip Lougher's suggestion, make the following updates:
>    1. The default configuration is the same as that before the patch installation.
>    2. Compile the three decompression modes when the new configuration is enabled.
>    3. "threads=1" supports only the SQUASHFS_DECOMP_SINGLE mode.
> 

Hi,

This patch-set looks a lot better IMHO.  I only have a couple of
relatively minor issues, which will be dealt with as comments on
the patches.

Phillip

> v2: https://lore.kernel.org/lkml/20220816010052.15764-1-nixiaoming@huawei.com/
>    fix warning: sparse: incorrect type in initializer (different address spaces)
>    Reported-by: kernel test robot <lkp@intel.com>
> 
> v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/
> 
> Xiaoming Ni (2):
>    squashfs: add the mount parameter theads=<single|multi|percpu>
>    squashfs: Allows users to configure the number of decompression
>      threads.
> 
>   fs/squashfs/Kconfig                     | 51 ++++++++++++++++--
>   fs/squashfs/decompressor_multi.c        | 32 +++++++-----
>   fs/squashfs/decompressor_multi_percpu.c | 39 ++++++++------
>   fs/squashfs/decompressor_single.c       | 23 +++++---
>   fs/squashfs/squashfs.h                  | 43 +++++++++++++--
>   fs/squashfs/squashfs_fs_sb.h            |  4 +-
>   fs/squashfs/super.c                     | 93 ++++++++++++++++++++++++++++++++-
>   7 files changed, 237 insertions(+), 48 deletions(-)
> 

