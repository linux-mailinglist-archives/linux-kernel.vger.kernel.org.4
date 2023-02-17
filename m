Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9569B101
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBQQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBQQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:32:41 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5827874411;
        Fri, 17 Feb 2023 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fdyKvwYgQMyYOvs0tXMattzjV5AJbXrXbx9GVNi92gc=; b=rB70gVJYdKjUfB2yk/iVq2XOG1
        Kgz5TPxBW/7arPV6XSZz1yZ12auLu2TXIoaD7K1FW7uVqa7Wsyapj81K0uh4ETQJe0YucyxwXfZpy
        JAWsOqemDPnYuCoYmLLtqw4gPH5njmPZcee71RnsRhqjJqZk5RvQeRKNKHrtD7lssDjdYV5n1amOe
        eKJ4MgDUEax7LfqUoDPNYve/gQX9vV9j0+WlUmBSa9sdoJQdCjuzI1JKc36+uMNZ3/Ue/j/mXAhwL
        UCjZUecALDmF/lsNq1WZWU3DfsBUsTMeVWxjcMsU5G8HWJEn2M+viihT0izK/FZKldRpU0JBFzo8l
        N5Mx9YRg==;
Received: from p200300ccff0dfd001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:fd00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pT3de-00064j-S3; Fri, 17 Feb 2023 17:31:11 +0100
Date:   Fri, 17 Feb 2023 17:31:08 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 15/17] gpio: omap: Convert to immutable irq_chip
Message-ID: <20230217173108.1448ce92@aktux>
In-Reply-To: <Y+8xkV5aUrAajLNP@atomide.com>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
        <20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
        <Y+8xkV5aUrAajLNP@atomide.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 09:49:37 +0200
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Linus Walleij <linus.walleij@linaro.org> [230216 09:38]:
> > Convert the driver to immutable irq-chip with a bit of
> > intuition.
> > 
> > This driver require some special care: .irq_ack() was copied
> > from dummy_irq_chip where it was defined as noop. This only
> > makes sense if using handle_edge_irq() that will unconditionally
> > call .irq_ack() to avoid a crash, but this driver is not ever
> > using handle_edge_irq() so just avoid assigning .irq_ack().
> > 
> > A separate chip had to be created for the non-wakeup instance.  
> 
> Nice, works for me.
> 
> BTW, I still see these warnings remaining on boot:
> 
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> 
> Seems like we might be able to get rid of those too now or are
> there still some dependencies with /sys/class/gpio for example?
> 
on what are you testing? on -next? I thought I have fixed theese warning with
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=92bf78b33b0b463b00c6b0203b49aea845daecc8

Regards,
Andreas
