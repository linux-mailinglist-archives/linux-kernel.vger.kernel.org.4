Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5270A90E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjETQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3517EA;
        Sat, 20 May 2023 09:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBFF60A57;
        Sat, 20 May 2023 16:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546EC433D2;
        Sat, 20 May 2023 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684599567;
        bh=ugiadNWSoNuydJxHZiQ17RzFYdehOsMHj7S3NCIs7F4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGnrTE/i3PipThBBr4VVMcvJcbq6tHzduYH+WD//jOc8FMAnmThTIzL28prMBvKaX
         j2o2DnhyES5jqxm8tzxuFnqPdQteMQWsYlonmtPiiUEy/xz44cMBOzF6EZR10RNJbw
         pohhv1+A5fVv9tkND+ThHnOuPVxpfe/6IPkK0YXVKsoaO9RioI9/J503H4i80du0Cy
         9let/d2cwclWqNA78PPrOYdxso/LcB5KEjralPsEFusmcK9Y1VEpPYnKVWT5Z3TC+A
         QS3kZEjoBzNm9PU58OF+3VyLYYn1zZe/Oy1gWiif5iQhOzmBPFNG3oHZJNmHsATTz0
         Ho+E175KjNfwQ==
Date:   Sat, 20 May 2023 17:35:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <20230520173536.6597aa21@jic23-huawei>
In-Reply-To: <ZGNawohZTDhPazil@arbad>
References: <ZFUCf059+PSR+3Wb@arbad>
        <ZFUC/3zBFQRBsYUk@arbad>
        <20230506170420.71bead77@jic23-huawei>
        <ZGNawohZTDhPazil@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 12:28:18 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jonathan,
> 
> thanks for your review. I have one comment.
> 
> Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 06. Mai 17:04:
> > > +	int                     scale;          /* int part of scale */
> > > +	int                     scale2;         /* nano part of scale */
> > > +	int                     offset;         /* int part of offset */
> > > +	int                     offset2;        /* nano part of offset */
> > > +	struct gpio_desc	*gpiod_reset;	/* reset */
> > > +	int			irq;		/* end of conversion irq */  
> > 
> > Only needed in probe, no need for a copy in here.  
> 
> It's also used in mpr_read_pressure() to distinguish the two possible operation
> modes:
> - waiting for an interrupt
> - reading in a loop until status indicates data ready
> 
Oops.  Thanks for pointing that out!

> Andreas

