Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59885E77BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiIWJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiIWJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EA1323E8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF51DB81E4A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ADEC433D6;
        Fri, 23 Sep 2022 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663927001;
        bh=3YzWaYVKLDnaykSI1CaTdsvmaJpgRbryOIAdxEWqL6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmR+fNNVcYD7dbhPMv35iuWAgsBD621/Uvy7XtcqfBklYlGULbusAMfLeYlncgIN/
         SkGeTabccOjTnhq8Z2+yuCLYXVB9zDJhZFcMcclagC/E2AHHHd8aO5f+e7VS7K6Fhs
         Bm6HXT9/3bxcckC+3gsF0NVnQ4j4APTh7KSM6VW4=
Date:   Fri, 23 Sep 2022 11:56:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: moxa: add missing pci_disable_device()
Message-ID: <Yy2C1gKxIENxMiT3@kroah.com>
References: <20220923092530.3088080-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923092530.3088080-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:25:30PM +0800, ruanjinjie wrote:
> Driver should call pci_disable_device() if it returns from
> moxa_pci_probe() with error.

Why?

That is not a normal thing to do, as you can disable other PCI devices
attached to it, right?

> Meanwhile, the driver calls pci_enable_device() in
> moxa_pci_probe(), but never calls pci_disable_device() during removal.

And is that really a problem?

> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/tty/moxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Do you have this hardware to test with?

How did you find this issue?

thanks,

greg k-h
