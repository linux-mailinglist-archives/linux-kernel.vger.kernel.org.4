Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD737185F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjEaPRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjEaPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633811D;
        Wed, 31 May 2023 08:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5FF63D31;
        Wed, 31 May 2023 15:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F24C433D2;
        Wed, 31 May 2023 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685546227;
        bh=F2oc/tidTrFnHhaHZr881PgbMLURyR5U4/nkSfN9YS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcEGyF8FybWmi/JDto/ddTnXqo/tO5zJ7DW2B/NakrvGKANUGraVuszAbwbfDKQ7Q
         82tu9gTevz0Yu6y6QFHRYgbbPngyHMw3fzUOQ7NQStlTrv4jbx1zaHoYTDrWAkDX8Z
         +4PE4X3KPwS5aLtKrJEdlT5etaaorkYQCcDOsIGSwRKj43RL8Yxu3kvH6Q1tUxsVKN
         xcPpGGblXTQdKGUNb881ojltavyXFriN2uKAfM4/YwuEbgTz05W8eisK3jvSVpYVhx
         unVOhSHeKnniSjj4JdRPKG1qgqnyK2CUmOSmd+NHTKDI18IkZhO8FrszGYeffoxXtP
         nAHIl41W14dWw==
Date:   Wed, 31 May 2023 23:05:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 04/10] serial: bflb_uart: add Bouffalolab UART Driver
Message-ID: <ZHdiSjajwbF3cKBK@xhacker>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-5-jszhang@kernel.org>
 <2023053010-gondola-luminous-f5e7@gregkh>
 <ZHdVNIQpgfCzimRg@xhacker>
 <2023053119-drab-cartwheel-29af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023053119-drab-cartwheel-29af@gregkh>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 03:34:02PM +0100, Greg Kroah-Hartman wrote:
> On Wed, May 31, 2023 at 10:09:56PM +0800, Jisheng Zhang wrote:
> > On Tue, May 30, 2023 at 11:36:00AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, May 18, 2023 at 11:22:38PM +0800, Jisheng Zhang wrote:
> > > > Add the driver for Bouffalolab UART IP which is found in Bouffalolab
> > > > SoCs such as bl808.
> > > 
> > > New uarts are being created that are NOT 8250-like?  Why????
> > 
> > Hi,
> > 
> > I'm not sure I understand your meaning. I guess you mean writing the new
> > uart driver following 8250 style. And the latest example is
> > sunplus-uart.c, it can be used as an example how to write a 8250 style
> > driver for new non-8250 uart IP. 
> 
> No, I mean, "why are hardware designers creating new UARTs in 2023 that
> are NOT 8250-based"?  Why do they want to constantly reinvent the wheel?

haha, to be honest, I dunno the reason either. For me, the HW has been there
and is linux capable, I want to mainline its support.
