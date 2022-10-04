Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477E55F4A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJDUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJDUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:35:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6CA25C73
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:35:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so14036540pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9fXt++4LgE9mXdKKs8Gz37yN6oaUTd7sRbjLloeTITA=;
        b=EM/izpDhzVgjLPP4z1Be56ZjebluoeNmZOVtYAdYVA1P7id/xrgZ5bH/0xCvP5yEXy
         YB1nt9x5W7qVukkUhpaPSrEWoT/LE22oe4vCOdiovkhSqOpSSsP2/uh5oEYZ8Gb4L/Pb
         HYHkRzOMDocHXsTt4SRcr+EIbR7w3s4wj/NXLz5eXf9+uBxpHwplErA+kioTVvOEsOSK
         VCgefRXa5wKvoS2YTSO+aqCnJVPw8aj4nOHCj9sRHwq2/MVZZkrlBGUh4s1j7l5GFakQ
         y4D/grX3MgEpeWY6wWwuW193whiyo/b3v1SFVqGuBhGQNIxZveMvPVk8caFMSDMYNg6x
         VXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9fXt++4LgE9mXdKKs8Gz37yN6oaUTd7sRbjLloeTITA=;
        b=I+L9kWvwuIPUaBAomVBuBhIRf80QhKvAIOGAOw2LPpcBrh5lBb9P4oh5MvTFlYSRJc
         2OP+mkvg48vxVV+JIGn5G4+BJgLSe1yn7sC7PP35Dxm25upAXRt6tneRqekz1XnYR29g
         4FJiotEymM0s0J5PhUekN4bz42ts0rjKcPl/GFq4PSGgv6tHjx/jp0nE0HqH6KEBH1dq
         xMsRLMm10qz4nlJivuakn497BhEHT4RyYdKYhowF1hoLZAlNHqU2HsP5CEQPYOjB+OQF
         8bIlrFtHB/Ad16gDEbnP2oEnveaaGgEnCQsRmWfb8Dfjkl4N1UtEXeRbbv5WX4pLh2tn
         wzew==
X-Gm-Message-State: ACrzQf0QPZ9GjmWA4/ZqIg66OYyxlQOlA9i6TPtZcljU7i4f7kR+F3lX
        uodCFFObALJ8Q/x3Jiwp3g4=
X-Google-Smtp-Source: AMsMyM5UzOCqqtVVf0Pssp93TeW8vr3ihVhmaabDx/b+rVCItuV0nYKbvscpLLcx1nfd34nR6aZ4dA==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr27263792ple.21.1664915753290;
        Tue, 04 Oct 2022 13:35:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:978:a034:8ff4:b4b5])
        by smtp.gmail.com with ESMTPSA id 63-20020a620442000000b00540d03f3792sm9704838pfe.81.2022.10.04.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 13:35:52 -0700 (PDT)
Date:   Tue, 4 Oct 2022 13:35:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
Message-ID: <YzyZJSwy9xsy69WL@google.com>
References: <YzN6A9Y20Ea1LdEz@google.com>
 <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan>
 <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:50:25PM +0200, Linus Walleij wrote:
> On Tue, Oct 4, 2022 at 2:54 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> 
> > > We need to know if i.MX is shipping device trees stored in flash,
> > > or if they bundle it with the kernel.
> >
> > This part is frequently found in add-on boards so it's not purely an
> > i.MX-only question.
> 
> Oh
> 
> > IMHO for not-in-the-soc devices like this the presence of in-kernel DTs
> > isn't enough to make a decision. What is needed is a degree of
> > due-diligence to show that there are no obvious out-of-kernel users.
> 
> OK I think this is a good case to use a special quirk in this case.
> I actually envisioned keeping piling them up, and that they would
> not be innumerable.
> 
> Dmitry, could you fix this? Just patch away in gpiolib-of.c.

Sure, I'll add a few quirks. I wonder what is the best way to merge
this? I can create a bunch of IBs to be pulled, or I can send quirks to
you/Bartosz and once they land send the patches to drivers...

Thanks.

-- 
Dmitry
