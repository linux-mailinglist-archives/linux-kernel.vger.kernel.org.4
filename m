Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C6705C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjEQBF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjEQBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:05:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488746BC;
        Tue, 16 May 2023 18:05:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so2971425ad.1;
        Tue, 16 May 2023 18:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684285547; x=1686877547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdJT/H8xGvY9gtvsfIysxPf/yPCjWQITLlyrUT61aco=;
        b=QYTxjI0U0atTLEgrOgeIl4hHlEqTKtSto9dlMW7Bb7eFmAcvVvnAm5xpa9D5afwd1P
         IVoVI1Z5H1XfMOcvR3ggDwnbmMnPkOWF5M77x4IXGPRnW/yCtJEr2feuoXwnzqO/KSzZ
         doci+IRTHw1PrihgbarOUKRppztgeikPMfMe4iZciwmySlWmWnM4C1rb0KnpgXvB2QUN
         3ucUudatzp+WtMjIhZxX+BMUo4cGOJjJfEjD3zjwaDifkNObLSuZ3OFN6d8pDNbiN2FB
         TS7O9N5DWUAuX5hGrTwMsVmXn3Y99J7O+J7YD8cgNFzRfDIZAwB62nPhv8GW9rZIRLAe
         9/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684285547; x=1686877547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdJT/H8xGvY9gtvsfIysxPf/yPCjWQITLlyrUT61aco=;
        b=Bbi0OHuaw+J2m3VHtwGN+mqx++Aycrc8jDgnAXJrZyXnNDG40N9gVLAJlLUA/HUPRt
         kluhNJbhgtrhQfR6YoNwj0LKDjzEjJspKavg1xWAXeHTsaPz101g7+2vGdvDNXfMvCmL
         C6YzzuKVgzVL6HNP2V883Em5hECyvyaAb8C6ZxwB9JkG2begz2uX0J3NoJzY5RSWPxli
         16YYL5wv3xiifK/BhzX0jAjxW3NDHdYpYCYpM/LzfFMFa8RauZUHzNVuY9U5wkQGmAdp
         O9R2LoaRKzeIh1S8LRT9i4HLChzjDvuGil/rLI5aQ8q+xa6ABQR6rK4YSEbknZDkPKGb
         d/aQ==
X-Gm-Message-State: AC+VfDwsFxlIHU0tNw7ksCKDKceWkYPKMM6kXktrUQt42WHyDeCC+Mwq
        6WSredVM6fkBjS/FETrLmCQ=
X-Google-Smtp-Source: ACHHUZ7KI41zcB0oQ+BjTW/TLDAHZb11VW/tWk4jjW1aQ4SKPPjF5n0cILRDs9QN7WxPC/lftoP6TQ==
X-Received: by 2002:a17:902:cec9:b0:19a:a9d8:e47f with SMTP id d9-20020a170902cec900b0019aa9d8e47fmr55604763plg.36.1684285546928;
        Tue, 16 May 2023 18:05:46 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001aaed524541sm16113183pli.227.2023.05.16.18.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 18:05:46 -0700 (PDT)
Date:   Wed, 17 May 2023 09:05:40 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGQoZKrEceqlSEtp@sol>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <ZGQkEdZ6DoJbgiFh@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGQkEdZ6DoJbgiFh@sol>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:47:13AM +0800, Kent Gibson wrote:
> On Tue, May 16, 2023 at 11:50:42PM +0000, Chris Packham wrote:
> > Hi Kent,
> > 
> > The second application is a userspace driver for a L3 network switch 
> > (actually two of them for different silicon vendors). Again this needs 
> > to deal with resets for PHYs connected to the switch that the kernel has 
> > no visibility of as well as the GPIOs for the SFP cages. Again we have a 
> > slightly less simple kernel module that grabs all these GPIOs and 
> > exports them with known names. This time there are considerably more of 
> > these GPIOs (our largest system currently has 96 SFP+ ports with 4 GPIOs 
> > per port) so we're much more reliant on being able to do things like 
> > `for x in port*tx-dis; do echo 1 >$x; done`
> > 
> 
> Given appropriate line names, that is already something you can do with
> the libgpiod v2 tools.  Something like:
> 
> `for x in gpiochip*; do gpioset -c x tx-dis=1; done`
> 

Of course that may only pulse the tx-dis line, depending on how your
driver behaves when the line is released.
(gpioset has options to control the pulse width, if that works for you)

If you need that to persist, independent of device driver behaviour,
then you need a some process holding the lines that your scripts can
communicate with.

Cheers,
Kent.
