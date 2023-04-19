Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95236E7266
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDSEsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjDSEsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:48:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41523AB2;
        Tue, 18 Apr 2023 21:48:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f173af6712so20236035e9.1;
        Tue, 18 Apr 2023 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681879693; x=1684471693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuAJq4blX/O8RlbmBU9aH8uCfq+5leOuh2Fbv/l7p24=;
        b=sJ+GYpYQTLxnTUG13QTdmbhWC25D7w7hfCO8BFPxMjuYriAlvzlEoB/BjF+ULpFzdQ
         Leej5ztj4k66+/YjyYI0IwmscxntLHHe8rPXTIO04OoMsMil5DRlIpNVR34bJjWYGrjG
         RjN6hF/bPQG7yaJuamojM5oOtVQADcD7LAfYD7EhWUq/UcMAeEmu/6Eev2ZUMgnEbmJn
         dd1tmPr6qnLxaDL/i23Ow47QJCrL+MidR8ZXcvnLB/hPbUybs+DhBTYkbLTbIpii77i9
         9W+VOEhmo6rlfH6MpPo78uWHgOvWyys+ww4Vz7wW6LzjkBaEPF7DxDz/AWvJ+GcwN5mT
         zQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681879693; x=1684471693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuAJq4blX/O8RlbmBU9aH8uCfq+5leOuh2Fbv/l7p24=;
        b=kX7q/rkfE9RsIEwiFG3MrRjwHWPx4sTrGN4wpal31aGLof8fyPMDCoED4rd4ywY2AT
         Ojg6ZH6Zw0cZLiGGcA7C6UWl53AXcYfhH5sykQIaAoKT4FotAeTe3aUEhO2JPJr+8dTX
         c4Z+CgHLG0A7S30lNAE2JW1qFUSnpuBKubEQEZ/SWP5Vd61Ljx3v5ZvOaLC3Bnc7+/1g
         KPjU+k1L3mwROKqSucOeDXe1ZLWKB//y2ZwtWfx8CLtWkUIHMdd4WZKjMiNyKWO4EI2Z
         TvPy7EjrSP7ihdfkxMHt1Z+lFgd7jlMfJhQqj6KhAOU0pLgOjjFydVSeFhlpE3mSYu7l
         UoAQ==
X-Gm-Message-State: AAQBX9fV2gDiy9E8nhkqrepIr8VDdtNbDoYBgNyRiE9K7khLgPToT1GG
        UPLxvbdKjHJGXyhTEh+neu8=
X-Google-Smtp-Source: AKy350YET1L5bLEk6BV2LpnogWlAT1RhfX1CdhSMZpYVhbgdmxBOfO9ptGf6270+UW14vX5vMdzc5A==
X-Received: by 2002:a05:6000:12c1:b0:2ef:a57e:bb9a with SMTP id l1-20020a05600012c100b002efa57ebb9amr3548275wrx.6.1681879693332;
        Tue, 18 Apr 2023 21:48:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6e92000000b002cea8e3bd54sm14597636wrz.53.2023.04.18.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:48:12 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:48:08 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Message-ID: <0e420e0e-001e-4d0f-a192-a2daa4e789c6@kili.mountain>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
 <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
 <14788dbc-c2a6-4d1d-8ae3-1be53b0daf17@kili.mountain>
 <837e9f5e-ca8d-4c93-9a89-d7bdb9bb0240@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837e9f5e-ca8d-4c93-9a89-d7bdb9bb0240@kili.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:39:43PM +0300, Dan Carpenter wrote:
> On Tue, Apr 18, 2023 at 10:30:01AM +0300, Dan Carpenter wrote:
> > I have some unpublished Smatch stuff which tries to track "variable x
> > is in terms of bit units or byte units etc."  I will try to make a
> > static checker rule for this.
> 
> Attached.  It prints a warning like this:
> 
> drivers/net/ethernet/broadcom/cnic.c:667 cnic_init_id_tbl() warn: allocating units of longs instead of bytes 'test_var'
> 
> I'll test it out tonight.

It didn't find any bugs.  (Which is hardly surprising because most would
be caught in testing).  No false postives either.  I imagine that people
will introduce bugs like this in the future and now we'll see it when
that happens.

regards,
dan carpenter

