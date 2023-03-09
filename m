Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EAB6B225A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCILLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjCILKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:10:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DECAE982C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:05:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6480561AB9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7987BC433D2;
        Thu,  9 Mar 2023 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678359909;
        bh=wWkL/7W+HjspFf9yXxiuNHJjlGxw3h1j6PgjMMNL1BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2TBWnn+TznwRXvDqVgOAH1iKYjKWx+JHTwHIRgqzPnI9PbZzzuJ7swjfItBTSAcU
         /aCUCLDfDKKcFxhGyy+HDcKpwmBHV69yehO6JvEjCkWF6CzPv+CkcfE++YJ9MYVWyt
         g0Q5YWoseaNE+SDzgkSCbBveVe/zTe9DUsDyMCDs=
Date:   Thu, 9 Mar 2023 12:05:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Weifeng <suweifeng1@huawei.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com,
        zhanghongtao22@huawei.com
Subject: Re: [PATCH v3] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
Message-ID: <ZAm9Y2O97doFXksF@kroah.com>
References: <20230304074316.736922-1-suweifeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304074316.736922-1-suweifeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 03:43:16PM +0800, Su Weifeng wrote:
> From: Weifeng Su <suweifeng1@huawei.com>
> 
> The /dev/uioX device has concurrent operations in a few scenarios.

And you just broke that :(

> For example, when a process is operating the uio0 device, someone executes
> like "cat /dev/uio0" command. In this case, the bus master bit is cleared
> unconditionally.

It is cleared when the close happens, not when "cat" runs.

So prevent userspace from doing that with permissions, why must the
kernel enforce this policy you are making?

> As a result, the running program cannot work commands
> or I/Os, which is usually unaware of. This happens after
> 865a11f("uio/uio_pci_generic: Disable bus-mastering on release");

Please always reference commits in the documented way.

> The restriction on the process that uses the PCI device is added. The new
> process can be used only after the process that uses the PCI device exits.
> Otherwise, the system returns a message indicating that the device is busy.

Again, you are changing the functionality of the kernel, are you sure
you did not just now break something else?

thanks,

greg k-h
