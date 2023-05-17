Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81A7063A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjEQJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjEQJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:10:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7270B3C30;
        Wed, 17 May 2023 02:10:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so11684194b3a.0;
        Wed, 17 May 2023 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684314609; x=1686906609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQVT9+5iZHDvM+4sOdIDONXV8SnNYUsj9FcqBhfBcQM=;
        b=Ye/P+cS2GAnNadzY9LXw7I08PBeU8OnA8LX2MToAi+8E42GvOH9SkWX0pni5H7unOo
         XVNWhkT21bNL690o5tJVj2GJOvlhJo0JTUzs+Ci49JkwwVJY803BdYpghfKWF+313gHQ
         2/JIHXYIaJvzOTSRV4ImRH1IrUx3UHqgjyS3iYo/hpvEYcnmKKRiLjEMEoG/T6wfzY7F
         +TS9WbfiXhZ3fX059qQqWnCm4JmqeEf+nBSJihWuZluROEw2T84X1HxVJKTRmbra2Gvh
         cj27IbdjZBV97N6tov4Y+9Wv7sX8USxlbLI55hxYOQvGsKWpFW099w7kNRehD7YZWMwr
         dmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314609; x=1686906609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQVT9+5iZHDvM+4sOdIDONXV8SnNYUsj9FcqBhfBcQM=;
        b=JyhRCgabwH73G9UvWADDj9+I3/Cn0LNX3vNenWveN9FRCt/ft+565om8IEhuTE8Zfs
         fIQ4HfcgcCavpD6abwvw89TeeQGpxldfpt6Nl2/u6tbEBRFfc61VEwNY3cz7pGQOJ0Gi
         bFh0m1M2i4twEnWVbqL4BdXmsYrVaLRD4q3t0KDHi9qhoHULvCOFA7xj7P5GjGgA3ISU
         TssHHGGsCkpqPmYfNVlr5veKiI+xn3Ui72siXzrCTo6aiISPfwXa6ICT2HEoVh9qsh2l
         yp6+ZT9oKP6+lT/V6SswgOsM2qfM9JPrLH6ICVzLMqNDbYgJF4QPmPlylYeOZu3vNae5
         qmTw==
X-Gm-Message-State: AC+VfDzB12Zxtx3aH7Y9pozti5VpK71lhwXZqv2FacE+EzTOF2Vnf8Vi
        q+cFDsWfQgRJeiLwWM2SL+8=
X-Google-Smtp-Source: ACHHUZ4wb3371ocMUlMVj604rXwLPf+/s0QTiboeqtWQYeFphiwt0hlCI7sFqQCGTRE5NT0OWfJO/w==
X-Received: by 2002:a17:90a:ee4a:b0:250:69de:7157 with SMTP id bu10-20020a17090aee4a00b0025069de7157mr1990983pjb.2.1684314608821;
        Wed, 17 May 2023 02:10:08 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090aad0500b00247150f2091sm1070766pjq.8.2023.05.17.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 02:10:08 -0700 (PDT)
Date:   Wed, 17 May 2023 17:10:02 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGSZ6mK17ywSzjtz@sol>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:54:58AM +0300, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 2:50 AM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 17/05/23 10:47, Kent Gibson wrote:
> 
> ...
> 
> > I'm sure both of these applications could be re-written around libgpiod
> > but that would incur a significant amount of regression testing on
> > existing platforms. And I still consider dealing with GPIO chips an
> > extra headache that the applications don't need (particularly with the
> > sheer number of them the SFP case).
> 
> It seems to me that having no in-kernel driver for your stuff is the
> main point of all headache here. But I might be mistaken.
> 

Yeah, that is probably a fair call.
I tend to have GPIO blinkers on and try to solve things from userspace,
but this application is probably moving outside the bounds that the uAPI
(or the much accursed sysfs) is intended for - if you want industrial
grade reliability go in-kernel.

Cheers,
Kent.
ps Sorry if I jumped in on this thread uninvited, but with the TZ
differences involved I thought it useful.

