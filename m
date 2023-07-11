Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA874F69F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGKRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGKRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D7A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C41C61584
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EECC433C8;
        Tue, 11 Jul 2023 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689095462;
        bh=InfyI8SICKvF4zmJpauBWDNo/zPPdtTLtpODWeNYZJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S32dMWGzpZI0vlWdhqWHPysllb8jt18+0TZ9/J6/kdL5p8gbnh9eiPh2pkxP+RwDr
         d0EN67ZYCRaVoqoGTdUn7tSaPbpFLOvIKB9W3RfO7Khnv/gc5uueJyhHejEN0QUEtp
         pIyQddscMT7tKiSD9x3pG9DciqYaTJHBdkJJC3KpKwgrjuvUf6W/QY5q9XxkZ/Pi6L
         1gBsJQrRHm4KyQfkOzRIQfxTcHDyonHFTlhpw5HM9BDRs6j2HX+m+JAAOzoLO50WgT
         kTSiEJqjA5aP5GKAdjVoyApZESK4B7ir78UtN6hH91vgx3PoLSGiIsfyDB0tfShxUw
         r4Qhhl88+yrXQ==
Date:   Tue, 11 Jul 2023 20:10:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711171058.GT41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
 <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
 <20230711133259.GS41919@unreal>
 <ZK1csjLgGM+ezG/J@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK1csjLgGM+ezG/J@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:44:18PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 04:32:59PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 11, 2023 at 03:45:34PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > > > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > > So what is the outcome of "int - bool + bool" in the line above?
> > > > > 
> > > > > The same as with int - int [0 .. 1] + int [0 .. 1].
> > > > 
> > > > No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> > > > you are mixing types int - _Bool + _Bool.
> > > 
> > > 1. The original code already does that. You still haven't reacted on that.
> > 
> > The original code was int - int + int.
> 
> No. You missed the callers part. They are using boolean.

I didn't miss and pointed you to the exact line which was implicitly
changed with your patch.

> 
> > > 2. Is what you are telling a problema?
> > 
> > No, I'm saying that you took perfectly correct code which had all types
> > aligned and changed it to have mixed type arithmetic.
> 
> And after this change it's perfectly correct code with less letters and hidden
> promotions (as a parameter to the function) and hence requires less cognitive
> energy to parse.
> 
> So, the bottom line is the commit message you don't like, is it so?

Please reread my and Paolo replies.

Thanks

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
