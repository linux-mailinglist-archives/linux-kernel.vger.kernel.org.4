Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287B25E798C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiIWL0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiIWLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:25:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206B1284B2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 450CCB8272B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890E0C433C1;
        Fri, 23 Sep 2022 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663932326;
        bh=FCMp2NppBvlJ71mrqbL5qfF7MT6CTtKCvTnrQ7M7V18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuD15lDmcmhq9Ybw0P6ZpUAyuXKdjaLs62x7He5OLg3/N45RPTC4MdmfAwLTMqr5O
         uaH3DAJEJV39olr8jkGuPnchewQzPlLcBzY6z8gbQ5ZYYNp3muuQGzISnsPtixOBXR
         8cjToqunzt0m+34BeFbIC1774ziRp+V2UQbZDRx0=
Date:   Fri, 23 Sep 2022 13:25:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: moxa: add missing pci_disable_device()
Message-ID: <Yy2Xo30/WB9rja13@kroah.com>
References: <20220923092530.3088080-1-ruanjinjie@huawei.com>
 <Yy2C1gKxIENxMiT3@kroah.com>
 <95e4a84f-dcc6-72cd-69a0-3ba59ea73a9c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e4a84f-dcc6-72cd-69a0-3ba59ea73a9c@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 06:12:03PM +0800, Ruan Jinjie wrote:
> 
> 
> On 2022/9/23 17:56, Greg KH wrote:
> > On Fri, Sep 23, 2022 at 05:25:30PM +0800, ruanjinjie wrote:
> >> Driver should call pci_disable_device() if it returns from
> >> moxa_pci_probe() with error.
> > 
> > Why?
> > 
> > That is not a normal thing to do, as you can disable other PCI devices
> > attached to it, right?
> > 
> >> Meanwhile, the driver calls pci_enable_device() in
> >> moxa_pci_probe(), but never calls pci_disable_device() during removal.
> > 
> > And is that really a problem?
> > 
> >>
> >> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> >> ---
> >>  drivers/tty/moxa.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Do you have this hardware to test with?
> > 
> > How did you find this issue?
> > 
> 
> We use static analysis via coccinelle to find the above issue. The
> command we use is below:
> 
> spatch -I include -timeout 60 -very_quiet -sp_file
> pci_disable_device_missing.cocci drivers/tty/moxa.c

Please test with real hardware and look up what pci_disable_device()
does.

greg k-h
