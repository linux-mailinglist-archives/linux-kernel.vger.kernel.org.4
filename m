Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47269D295
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBTSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBTSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:11:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1871ABC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:11:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B73AB80ACE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D46C433EF;
        Mon, 20 Feb 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676916700;
        bh=5UZqyRioULyP4oLw7GNTR/gYtle1o0m+sXwVMukPX9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dg+jZ6pEtv0d7UryNlVA80uJfWvkfg1U3uGt4xUpRetKFfSb+joDNl4KYdi+GahgF
         /z8sYL5WiHvq33TPEJ5BT/roUle8XhxemIkHjxxpG1baLs9VWD65Vyu6GslRjAwoxZ
         dbofyzEQBPbTHZ7FjDVwr56Wom/h17iWyshdvzT4=
Date:   Mon, 20 Feb 2023 19:11:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Weifeng <suweifeng1@huawei.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com,
        zhanghongtao22@huawei.com
Subject: Re: [PATCH v2] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
Message-ID: <Y/O32v/KZt+RjoHQ@kroah.com>
References: <20230220171045.689736-1-suweifeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220171045.689736-1-suweifeng1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:10:44AM +0800, Su Weifeng wrote:
> From: Weifeng Su <suweifeng1@huawei.com>
> 
> The /dev/uioX device has concurrent operations in a few scenarios.
> 
> For example, when a process using the device exits abnormally,
> the management program starts the same process to operate the device.
> When the process exits and closes the /dev/uioX device,
> the master bit of the device is cleared. In this case, if the
> new process is issuing commands, I/Os are suspended and cannot be
> automatically recovered.
> 
> Therefore, reference counting is added to clear the master bit
> only when the last process exits.
> 
> Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
> ---
> The difference between the first patch and the first patch is that 
> the reference counting operation is performed using the atomic semantics, 
> just like other drivers under UIO:
> cdfa835c6e5e87d145f("uio_hv_generic: defer opening vmbus until first use").

And I would claim that that change too is incorrect.

Did you test this with dup()?  Lots of open/close cycles on the same
device node?  Passing around the file descriptor?

Logically, this is identical to your previous change, so why should it
be accepted?

Again, why not just use a real PCI driver for your device?

thanks,

greg k-h
