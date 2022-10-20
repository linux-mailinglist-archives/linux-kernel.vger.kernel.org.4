Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531EC605B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJTJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJTJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:28:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11441C19FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:28:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BDBB1F381;
        Thu, 20 Oct 2022 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666258086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GIeFesqoPVDLGuMTiujmZeuxlDUx092KNDrnzgeJWXs=;
        b=mYZOLgLK1yliL2zk1vvyi9P11BlK6wNhApGpIotJjsA/EMUcMroedb3M7BInJeyxc0dUUn
        b3fw6ZU/JFMWqQ5sXwUSmvGSgGBT1w7IvPhATnEPS0ivfdqhzzyPNCrGtCuRKRbBPCvcPS
        G+VBgzYPSghZekXGsMP7GwbebzahlQo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07DF02C15C;
        Thu, 20 Oct 2022 09:28:06 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:28:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, konrad.wilk@oracle.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1EUpXnGeUh9yslc@alley>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019194159.2923873-1-jane.chu@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 13:41:59, Jane Chu wrote:
> Having stepped on a local kernel bug where reading sysfs has led to
> out-of-bound pointer dereference by vsprintf() which led to GPF panic.
> And the reason for GPF is that the OOB pointer was turned to a
> non-canonical address such as 0x7665645f63616465.
> 
> vsprintf() already has this line of defense
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                 return "(efault)";
> Since a non-canonical pointer can be detected by kern_addr_valid()
> on architectures that present VM holes as well as meaningful
> implementation of kern_addr_valid() that detects the non-canonical
> addresses, this patch adds a check on non-canonical string pointer by
> kern_addr_valid() and "(efault)" to alert user that something
> is wrong instead of unecessarily panic the server.
> 
> On the other hand, if the non-canonical string pointer is dereferenced
> else where in the kernel, by virtue of being non-canonical, a crash
> is expected to be immediate.

Just for record, this patch is going to be abandoned.

Some reasons are mentioned in this thread. Others are in the threads
for previous versions, see
https://lore.kernel.org/r/20221017194447.2579441-1-jane.chu@oracle.com
https://lore.kernel.org/r/20221017191611.2577466-1-jane.chu@oracle.com

Best Regards,
Petr
