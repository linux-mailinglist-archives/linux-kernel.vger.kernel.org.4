Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78561691CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjBJK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjBJK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:27:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B86C7FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:27:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE1E0B824B9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2635AC4339B;
        Fri, 10 Feb 2023 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676024826;
        bh=gKj9QpeU0wStT/o7m4pzCoyb7ftuy2qjhdlpWAcKNXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z05vmwWmPMOQjq0PlmK8YEzls3AWkSgA0u/8FmZALs3Q2XNwJk0b0OpeP+j/Yuz22
         YLocJ/34iXtCOwaoezZsa0Gg25lE0+1xCphpnITYufBvQr/o63dBXydCxOhBMDa+PT
         pNqAgK0cq9n4oMV+dX3N7nG/rdnfm6tNZwpg40eE=
Date:   Fri, 10 Feb 2023 11:27:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     chenwandun@huawei.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next v2 0/3] cleanup of devtmpfs_*_node()
Message-ID: <Y+Yb9/UIBJ70ugPa@kroah.com>
References: <20230210095444.4067307-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210095444.4067307-1-xialonglong1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:54:41AM +0000, Longlong Xia wrote:
> In one test, when modprobe zram, no zram device was found in the /dev. 
> But don't see any errors printed in jouranls/dmesg. Later we found out 
> that the reason was that device_add() did not check its return value when
> calling devtmpfs_create_node().
> 
> The test steps:
> 1. Set the SElinux label of /dev to user_home_t 
> 2. modprobe zram num_devices=1000
> 
> v1 -> v2:
> - New patch 1 to add error handling for devtmpfs_create_node().
> - use dev_err() to replace pr_err_ratelimited in [2].
> - only remove return value of devtmpfs_delete_node() in [3].
> 
> Longlong Xia (3):
>   driver core: add error handling for devtmpfs_create_node()
>   devtmpfs: add debug info to handle()
>   devtmpfs: remove return value of devtmpfs_delete_node()
> 
>  drivers/base/base.h     |  4 ++--
>  drivers/base/core.c     |  6 +++++-
>  drivers/base/devtmpfs.c | 20 ++++++++++++++------
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 

Thanks for the quick resend, nice work, all now queued up!

greg k-h
