Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00967CE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjAZOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAZOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3B44BD5;
        Thu, 26 Jan 2023 06:32:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D4361853;
        Thu, 26 Jan 2023 14:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A11C433EF;
        Thu, 26 Jan 2023 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743578;
        bh=f9LSun52cCqwsxuwa0XRp6EZKI8omNUekwnnzl11fN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ave6yRlotlhXORIulF3rKwxB2SMEGkp2ByNYB9mbtA0UxGyBjfx9KVWjv7uyn1Fet
         QFNLBjKoUgTS+b9ETtnildtEcVryqs9HpGGntrioow1kQ0E/PLCyUmxjfBrOyAExpp
         fzOO/fHUBYCur4jyXvTu1twMPS7jMUAbsoBelE5SW7QSVLNqZE83Hkhcyw8w52c2G0
         UpZEfKAXRq9JRYhTY7N2i5sfLZcCSzjuavKlIIucK6u53prvNqMDwQhvMJsh4nrK+6
         Q7m531mIBb2XHovpQv/dNv+CzSnEVagWQfHS67PqNrEaw/tQioRhsjeivQRrs/m+8q
         8ye+itC5yCOrg==
Date:   Thu, 26 Jan 2023 14:32:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <Y9KPFbZO+FEgU9G6@google.com>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
 <20230119175135.GA2085792-robh@kernel.org>
 <Y8mt6ZCMf4YZvDYA@google.com>
 <CAL_JsqJQd4W5-8ej48hAebvyA6neH=2hTtzVU5HhFpQ2yKsQFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJQd4W5-8ej48hAebvyA6neH=2hTtzVU5HhFpQ2yKsQFw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Rob Herring wrote:

> On Thu, Jan 19, 2023 at 2:54 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 19 Jan 2023, Rob Herring wrote:
> >
> > > On Fri, Dec 02, 2022 at 06:32:26AM -0500, Jesse Taube wrote:
> > > > Some devices may want to use this driver without having a specific
> > > > compatible string. Add a generic compatible string to allow this.
> > >
> > > What devices need this?
> > >
> > > Is that no specific compatible string at all or just in the kernel?
> > > Because the former definitely goes against DT requirements. The latter
> > > enables the former without a schema.
> > >
> > > >
> > > > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > > > ---
> > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > > > index f4c8fc3ee463..0bda0dd9276e 100644
> > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
> > > >  };
> > > >
> > > >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > > > +   { .compatible = "simple-mfd-i2c-generic" },
> > >
> > > Simple and generic? There is no such device. Anywhere.
> > >
> > > This is also not documented which is how I found it (make
> > > dt_compatible_check). But this should be reverted or dropped rather than
> > > documented IMO.
> >
> > I thought it would be better than having a huge list here.
> 
> What indication is there that the list would be huge? We have 2 out of
> 137 MFD bindings. Usually if the MFD is simple, we'd make it a single
> node. It just needs to be clear what the conditions are for using it.
> 
> > Devices should *also* be allocated a specific compatible string.
> >
> > $ git grep simple-mfd -- arch
> 
> Why can't simple-mfd be used here?

Until this is clarified, agreed and documented, I'm dropping the patch.

-- 
Lee Jones [李琼斯]
