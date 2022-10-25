Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D062D60D738
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYWhL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Oct 2022 18:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiJYWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:37:08 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2065624BCD;
        Tue, 25 Oct 2022 15:37:06 -0700 (PDT)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29PMTNiP006450;
        Tue, 25 Oct 2022 17:29:24 -0500
Message-ID: <49d97f97e63edb70392279845186547d73b2290e.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lei Yu <yulei.sh@bytedance.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Oct 2022 09:29:23 +1100
In-Reply-To: <CAGm54UE1oS1N_hn4RKuF8a+OWgfvJ-OCc0-uju4mXbtz-jw8VA@mail.gmail.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
         <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
         <CAGm54UE1oS1N_hn4RKuF8a+OWgfvJ-OCc0-uju4mXbtz-jw8VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-25 at 14:21 +0800, Lei Yu wrote:
> 

> This case is treated as an error and we do not care about the
> following data.
> Similarly, if we change the MTU in BMC and let BMC ping the OS, the
> OS
> kernel does not crash and it gets RX errors, and the ping fails.
> 
>  # ifconfig usb0
>  usb0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>          ...
>          RX packets 85  bytes 15380 (15.0 KiB)
>          RX errors 51  dropped 0  overruns 0  frame 51
> 
> With this patch, we get the similar behavior on BMC that the RX
> errors
> are increasing.
> 
> > Additionally, I'm curious, why in this specific case is the device
> > sending more data than
> > the buffer can hold ? The MTU change should have resulted in
> > buffers being re-allocated no ?
> 
> The issue is found in a rare case during BIOS boot, we assume that
> BIOS is sending unexpected data to BMC for unknown reasons.

Ok thanks.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> > Or did you change the MTU on the remote and not on the local device
> > ?
> > 
> 
> Yes, the MTU is changed to 2000 in OS and kept 1500 on BMC, then the
> issue is reproduced. (see detailed steps in the above email).
> 
> The reason we made the above test is because we are trying to
> reproduce the behavior as BIOS, and from the logs it looks like it's
> sending a packet larger than MTU. Then we tried to adjust the MTU on
> the OS side and reproduced the issue.

