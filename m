Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E0606520
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJTPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJTPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AF17E22C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8567D61C19
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BA1C433D6;
        Thu, 20 Oct 2022 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666281340;
        bh=zh6GFYYrquB2z2mNbDmS6j7AtYwbrWzX5LJWcUl1VXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+CfmbwgGv64kAhx+CghDb5W0GCYc2pAFQGlac76HLTHxXlkHmr2ZH57eC2TwL5Es
         FjdPFs2y09lDbZP9p97ojxR5NgaFp4LBkASmW4Ttc0glRsx72HEvpdczRZsSOPjAgL
         lx1ik7H1EkGLv9r6brMxe5abVxzgHCr655gb1AWs=
Date:   Thu, 20 Oct 2022 17:55:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>
Subject: Re: [PATCH 1/1] kernel/utsname_sysctl.c: Add missing enum uts_proc
 value
Message-ID: <Y1FveWRHUA0nz8n8@kroah.com>
References: <20221020150645.11719-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020150645.11719-1-pvorel@suse.cz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:06:45PM +0200, Petr Vorel wrote:
> bfca3dd3d068 added new struct ctl_table uts_kern_table[], but not new
> enum uts_proc value. It broke the notification mechanism between the
> sethostname syscall and the pollers of /proc/sys/kernel/hostname.
> 
> The table uts_kern_table is addressed within uts_proc_notify by the enum
> value, that's why new enum value is needed.
> 
> Fixes: bfca3dd3d068 ("kernel/utsname_sysctl.c: print kernel arch")
> 
> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> I'm sorry to introduce a regression.
> 
> Torsten Hilbrich reported [1] that hostnamectl set-hostname foo
> which does poll() got affected by bfca3dd3d068. He also wrote a
> reproducer [2] which does not require systemd, I tested the patch on
> dracut initramfs.

Thanks for the quick response, I'll queue this up in my tree now.

greg k-h
