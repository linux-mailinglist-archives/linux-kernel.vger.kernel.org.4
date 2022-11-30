Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123763D5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiK3Mmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiK3Mmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:42:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFB2BD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3979B81A7C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D3C433C1;
        Wed, 30 Nov 2022 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669812152;
        bh=GRjGS5i/zixu/d/rdcqZ1QlptYxr8aRxr16aqJBrgSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6VNy9M/8qVMjEaOzq0nbrSDjKyYFaa1YPhUg7z7kP7supC/LHoQY8t4kv7zL0Qli
         3Me6o1t/v0bAkBodB07aoJnWQDlZXTRlSDUcI5C7lcpOGYGkOP1CiNWH6Iho7PQtkm
         LywRW0iIlHTLsWcnhWO06Tq+k4YATnhjVHOGtQoY=
Date:   Wed, 30 Nov 2022 13:42:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     stable@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zi Fan Tan <zifantan@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 5.10 0/6] binder: backports for data leak and UAF
Message-ID: <Y4dPrxKjnUOtvwIc@kroah.com>
References: <20221130035805.1823970-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:57:59AM +0000, Carlos Llamas wrote:
> This series of backports consists of 3 main patches from Todd submitted
> upstream in [1]. The intention is to avoid untranslated data from the
> senders to be visible to the target processes. More details of this
> issue can be found in the same thread.
> 
> Furthermore, Todd's patches also fix a use-after-free issue introduced
> by commit 32e9f56a96d8 ("binder: don't detect sender/target during
> buffer cleanup"). In which invalid userspace input causes unprocessed
> objects to be incorrectly released. Any subsequent references to these
> objects will trigger a UAF as noted by the following KASAN trace:
> 
>  [  244.748468] ==================================================================
>  [  244.750486] BUG: KASAN: use-after-free in binder_ioctl+0xb88/0x32e0
>  [  244.751276] Read of size 8 at addr ffff67b1865bea58 by task poc/593
>  [  244.752074] 
>  [  244.752725] CPU: 0 PID: 593 Comm: poc Not tainted 5.10.156 #1
>  [  244.753683] Hardware name: linux,dummy-virt (DT)
>  [  244.754717] Call trace:
>  [  244.755216]  dump_backtrace+0x0/0x2a0
>  [  244.755836]  show_stack+0x18/0x2c
>  [  244.756306]  dump_stack+0xf8/0x164
>  [  244.756807]  print_address_description.constprop.0+0x9c/0x538
>  [  244.757590]  kasan_report+0x120/0x200
>  [  244.758236]  __asan_load8+0xa0/0xc4
>  [  244.758756]  binder_ioctl+0xb88/0x32e0
>  [  244.759283]  __arm64_sys_ioctl+0xd4/0x120
>  [  244.759677]  el0_svc_common.constprop.0+0xac/0x270
>  [  244.760184]  do_el0_svc+0x38/0xa0
>  [  244.760540]  el0_svc+0x1c/0x2c
>  [  244.760898]  el0_sync_handler+0xe8/0x114
>  [  244.761419]  el0_sync+0x180/0x1c0
> 
> This second issue along with the reference to the commit fixing it was
> first reported by Zi Fan.
> 
> The other 3 commits included in this series are simply upstream fixes
> for the main patches.
> 
> I've tested this series applied to 5.10 and 5.4 which fixes the issues
> above as expected. So please pick these up for 5.10 and 5.4 stable.
> 
> [1] https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/
> 
> Thanks,
> Carlos Llamas
> 
> Cc: Zi Fan Tan <zifantan@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 

All now queued up, thanks.

greg k-h
