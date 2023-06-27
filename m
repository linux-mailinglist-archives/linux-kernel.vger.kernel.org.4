Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34B73FB81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjF0L5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjF0L5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:57:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B2E69;
        Tue, 27 Jun 2023 04:57:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39e86b3da59so3994694b6e.3;
        Tue, 27 Jun 2023 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687867070; x=1690459070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fDgEXlhTD4u8fEfAv0rtldp2XRqOyVB/WnpGR/b7zuY=;
        b=FDNmeXnHd+jw7p8jw+HL89Z2tgcnVnU2TeHJA+En7NebFcfeLWwBwC7W4gGnqWuWL2
         EDnwOFhdIZRlxIhITOhdSWKZq0lIRNNPsfLANcWwVCY4A+n9Ig54yZIG7XnOUAiaFrch
         KvbZwdu2Gc22uqoix+94OU7wgCLq+Boq3qhU89Z3OUKgvj3BvmHGo2wOKjavSy7g+5y9
         /1gCeBNYqAvsCAYOcxLOQOhcaHFuYE2D9hMdpDoZO6sGv9S/FIXAYPpisdoczKDITULq
         LXvKeTHR2wba1RcMNidfKDLBJfVTpBFaPyeTS45zXPyLDYcUmJmjfIu2fKg0kdN0OH9X
         rCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687867070; x=1690459070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDgEXlhTD4u8fEfAv0rtldp2XRqOyVB/WnpGR/b7zuY=;
        b=QYdRlzpXRf6JZ/QrUFNji5XTAj0YRy46dXIuh/XYuJsiTUrLmS1EcHVfscq3fA1hh8
         Yh1hQC7zHb88yDCfM9fjZFeGZIx7FhIpx44h/RFNrRjHD8MojCZHIubosuPDoebTS6/j
         jacR9wQuph3mEf4VrWYZVsgc1MDysPGHoTSuygZHPzV98/w54fInsxxU0W2wgc4D2AY8
         zcB0i8wv2n/h5fd1DgXU9Kq8R9lbeluA8kOJx0EvT0lG0toNggb/ficcA1OIjJI1JT1f
         5wmWhnawWSRO6es6GPMiNiS2fKSQ0ioEo1DNWyDvg3EoVG0MSfsPrp6F6oz3O14qHn7H
         xVrw==
X-Gm-Message-State: AC+VfDz75oTCswEoXmUVAQjv5CDjYTo1mUbhQNV4Gq3WovFWQnOZnbay
        b3PStjWuWWxGoWVsdPz/RJu8JyIxG3Q=
X-Google-Smtp-Source: ACHHUZ5BpG4SyD+0rzxN1TBdD7Q3ffvV21SE8bflOFkxl91kiSLDLPfJT5UuYbZHc0r+aOsVY2D/XA==
X-Received: by 2002:a05:6808:2027:b0:3a1:c233:5552 with SMTP id q39-20020a056808202700b003a1c2335552mr12592457oiw.34.1687867069854;
        Tue, 27 Jun 2023 04:57:49 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id y124-20020a636482000000b0053423447a12sm5734553pgb.73.2023.06.27.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:57:49 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:57:44 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Message-ID: <ZJrOuLXmnxuRlbLL@sol>
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJk87rWsDj7pWJIP@sol>
 <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
 <ZJo+wBMsyHvu/7Mj@sol>
 <CAMRc=MeyEuZpDXsZHVGdrivZbYjHr1YDiYAbu4A0--Xy9rKVUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeyEuZpDXsZHVGdrivZbYjHr1YDiYAbu4A0--Xy9rKVUw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:47:16PM +0200, Bartosz Golaszewski wrote:
> On Tue, Jun 27, 2023 at 3:43 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Mon, Jun 26, 2023 at 05:50:47PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Jun 26, 2023 at 9:23 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > >
> >
> > While we are on the subject of spin_locks, why does
> > gpio_desc_to_lineinfo() use spin_lock_irqsave()?
> > I assume the _irq is necessary as the desc could be updated at interrupt
> > level, but AFAICT gpio_desc_to_lineinfo() is only ever called from process
> > context, so why not just spin_lock_irq()?
> >
> > Cheers,
> > Kent.
> 
> Didn't we use an atomic notifier before for some reason? Then it got
> changed to blocking but the lock stayed like this? It does look like
> spin_lock_irq() would be fine here. On the other hand - if something
> isn't broken... :)
> 

Yeah, it was atomic before blocking, but that doesn't explain the need
for the save - interrupts are always enabled in that function.
Not a big difference either way, and irqsave is always safe, so no
problem with leaving it as is - I just thought it odd when I noticed it,
while spin locks and context were front of mind.

Cheers,
Kent.

