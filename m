Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8B6B27B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjCIOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCIOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:47:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA77F5AA4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:45:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12C3618C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D53C433EF;
        Thu,  9 Mar 2023 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678373089;
        bh=zrYURnupAcZKwbSUe+BQ3bCWxqT1l18tkCg/VQZm2Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rg1z2CXB5nG0xCRCS3dx8pMBg0p8U9rjBw0AmP1062tNFqDjaCNoEL8QhCqtZfYIR
         4amL6ZiJcpqXAcImvLK4yJMj35maOjBmEAeNrKQFP9wDzneEWzHcyZ0kg7LF1iIarb
         pWBXHky+lxV7H1Nb9IWsJUE9W1PQnDTISPul5+UY=
Date:   Thu, 9 Mar 2023 15:44:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, ritesh.list@gmail.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vishalc@linux.vnet.ibm.com,
        vschneid@redhat.com
Subject: Re: [RESEND PATCH v2] sched/debug: Put sched/domains files under the
 verbose flag
Message-ID: <ZAnw3aKvR/9i9kkU@kroah.com>
References: <20230119150758.880189-1-pauld@redhat.com>
 <20230303183754.3076321-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303183754.3076321-1-pauld@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:37:54PM -0500, Phil Auld wrote:
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the sched verbose debug flag. Allow changes to verbose to trigger
> generation of the files. This lets a user batch the updates but still
> have the information available.  The detailed topology printk messages
> are also under verbose.
> 
> Discussion that lead to this approach can be found in the link below.
> 
> Simplified code to maintain use of debugfs bool routines suggested by
> Michael Ellerman <mpe@ellerman.id.au>.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Tested-by: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/
> ---
> 
>  v2: fix comment typo and use cpumask_empty()
> 
>  kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)

As no one has picked this up yet, and it is really a debugfs issue, I'll
queue this up in the driver-core tree (which takes debugfs changes) for
6.4-rc1 unless someone screams.

thanks,

greg k-h
