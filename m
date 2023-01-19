Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3F6743CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjASU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASUzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:55:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED223C7B;
        Thu, 19 Jan 2023 12:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CEF61D67;
        Thu, 19 Jan 2023 20:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E2C433F0;
        Thu, 19 Jan 2023 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674161647;
        bh=Hs6+0egYkD9Ch/shwE8Q18wr7As8+2EM0RtkvZRlVEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPENkz6W0s/MOFuIF4Vvw8Pd6B9RxELE74ooLOV8BE5ZOdhwFxdthiEhOQ3D75qFf
         vjDoA8CDnpRbHEbm70DN6th9UX3jmrh1+UGuYILdN3VxZtLEdED9TK9azPgMW2BlHR
         TA6H4BkLP7xanPXLKoJqWst1wGkWGzLYV/WK6HoF8Wh2F5TrvMK2S64ZwrE2DKTKnW
         WkEjC4gs/I0AYPg/Ci1ZJxpDjj1SCcT9Hd+PGjEmKL8XEsdPwEiOWomilBjZAIlg8z
         k+P3wj+C+em2ZWA9gCKTlq50LrxfiV+67lNYDWDpyFxr6xEtGD9/ZjjotBIO+pNtNc
         FBeqGooRpxLpQ==
Date:   Thu, 19 Jan 2023 20:54:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <Y8mt6ZCMf4YZvDYA@google.com>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
 <20230119175135.GA2085792-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119175135.GA2085792-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023, Rob Herring wrote:

> On Fri, Dec 02, 2022 at 06:32:26AM -0500, Jesse Taube wrote:
> > Some devices may want to use this driver without having a specific
> > compatible string. Add a generic compatible string to allow this.
> 
> What devices need this?
> 
> Is that no specific compatible string at all or just in the kernel? 
> Because the former definitely goes against DT requirements. The latter 
> enables the former without a schema.
> 
> > 
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> >  drivers/mfd/simple-mfd-i2c.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index f4c8fc3ee463..0bda0dd9276e 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
> >  };
> >  
> >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > +	{ .compatible = "simple-mfd-i2c-generic" },
> 
> Simple and generic? There is no such device. Anywhere.
> 
> This is also not documented which is how I found it (make 
> dt_compatible_check). But this should be reverted or dropped rather than 
> documented IMO.

I thought it would be better than having a huge list here.

Devices should *also* be allocated a specific compatible string.

$ git grep simple-mfd -- arch

-- 
Lee Jones [李琼斯]
