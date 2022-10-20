Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E62605910
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJTHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJTHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:53:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EE10C4F6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4FFBB8265F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD8C433C1;
        Thu, 20 Oct 2022 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666252395;
        bh=AUCcxQX+3OrFrZYEaeAKfPk2+T4/m43Mh3bvc3iiCLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4pVmq4Kha4+7FlaH0QBsbIpgQ3hjkl1Zq1mVKMCpXR8u5JWIXc6gG4lYbSvue9/y
         v8bvi1ilTWnuGFdkIgw4L19X6Tqtz0KJrV0nZrQB/N4bIv/67yLrBOCkeiYR9VMEkR
         AqI5i8Ja/gEJAfrlHhXcBSUzg8j4HzIM+u9JN9fY=
Date:   Thu, 20 Oct 2022 09:53:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
Message-ID: <Y1D+aPltJYNGhucW@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-34-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:55PM +0206, John Ogness wrote:
> Currently there exist races in console_register(), where the types
> of registered consoles are checked (without holding the console_lock)
> and then after acquiring the console_lock, it is assumed that the list
> has not changed. Also, some code that performs console_unregister()
> make similar assumptions.
> 
> Introduce a console_list_lock to provide full synchronization for any
> console list changes. The console_list_lock also provides
> synchronization for updates to console->flags.
> 
> Note that one of the various responsibilities of the console_lock is
> also intended to provide this synchronization. Later changes will
> update call sites relying on the console_lock for this purpose. Once
> all call sites have been updated, the console_lock will be relieved
> of synchronizing console_list and console->flags updates.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 20 ++++++++--
>  kernel/printk/printk.c  | 82 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 88 insertions(+), 14 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
