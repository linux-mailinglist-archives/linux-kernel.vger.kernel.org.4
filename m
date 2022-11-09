Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492A623391
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKITcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKITcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:32:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4F27B33;
        Wed,  9 Nov 2022 11:32:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 130so17633429pfu.8;
        Wed, 09 Nov 2022 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0uFv26oxfQOpv2Agiwe2bOMKx2UCxtBDVgweGAJ2bo=;
        b=URppbdoi1ufzNJuJSoYALHk4wC7j81GtZTVN8KmWuo8mNeJQBFEQNn0uNhx3mscpLz
         E1/dz+P8Rn0jiv6AqOLDhn3diJ3kI282AIt+bjgjExcnJobdJlM9Y25BykrV7gsqZDWI
         rVBRdI1EWskLHY+US35BXZGm5kgCDfaDqE1VQi8qARfl3DF8HIEw8W+tent44w3g5yef
         UBN0GfzZ4QKAX4mLr68N5OCPNZEBtm/zF4qomyPqcxhVcWmj3sYpfbeBtEp10MSGH5Dm
         DD+XN66VE+gjxidhpEJak1KcCI9DCfzBrh4FUoiea9UkA7x1fa2j4LwCWJ42owMT1Epq
         9hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0uFv26oxfQOpv2Agiwe2bOMKx2UCxtBDVgweGAJ2bo=;
        b=jmCYNuOaWQlRR1yBHa6IpZMRIYjd1x/7SHWp96VdZ3BUoGEvTd6SWCvmTQrW7hAtYR
         HQsBl/w7ZJ+oxnc+LyuSykWZqbl1gC1bcpkTMq9p+/McitDWrRBOZLs06VeLHCWbROH9
         QfgiRXvzV/s0geD94Qmflp+zBR0kPIr40NFciDdc5QSLfEha7HFu3lEcN6bY6HlAj36u
         g7WMdps23Sb1qLfXEy/qy8J6itm3Icg8tWv8926vZcJf177n2FTL24QzcpRx/NPw8uPt
         yhOxRim4R4pUGBAurSNLaezDT4pWEW7SWKq9yvBMsrZpyzsYH9sC84vJmlTXW+t6lTAJ
         RWbQ==
X-Gm-Message-State: ACrzQf30igk5xJIK65ChNnlCofqid1PPijjJhCD6HyjcuC37uT9trQMH
        amXEtTq9pImcaFzUUn8K6Qo=
X-Google-Smtp-Source: AMsMyM6vHLnM1U40oZTzQ8QqDYIgjUK+yy2wRERF5rEmuSlaVo7Yt7Cnu+gZ8fhbWs2pccBaZtFodA==
X-Received: by 2002:a63:1e0f:0:b0:44b:796c:bc14 with SMTP id e15-20020a631e0f000000b0044b796cbc14mr51855118pge.563.1668022355278;
        Wed, 09 Nov 2022 11:32:35 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001769206a766sm9388618plr.307.2022.11.09.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:32:34 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:32:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for software nodes to gpiolib
Message-ID: <Y2wAT3LOytr9AfZt@google.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <Y2uPJfkYpuI/uHeQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2uPJfkYpuI/uHeQ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:29:41PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 08, 2022 at 04:26:45PM -0800, Dmitry Torokhov wrote:
> > This series attempts to add support for software nodes to gpiolib, using
> > software node references. This allows us to convert more drivers to the
> > generic device properties and drop support for custom platform data.
> > 
> > To describe a GPIO via software nodes we can create the following data
> > items:
> > 
> > /* Node representing the GPIO controller/GPIO bank */
> > static const struct software_node gpio_bank_b_node = {
> >         .name = "B",
> > };
> > 
> > /*
> >  * Properties that will be assigned to a software node assigned to
> >  * the device that used platform data.
> >  */
> > static const struct property_entry simone_key_enter_props[] = {
> >         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> >         PROPERTY_ENTRY_STRING("label", "enter"),
> >         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> >         { }
> > };
> > 
> > The code in gpiolib handling software nodes uses the name in the
> > software node representing GPIO controller to locate the actual instance
> > of GPIO controller.
> 
> Thank for an update!
> 
> I have almost nothing serious except two nit-picks I think we can address:
> - dropping const qualifier for no (?) reason
> - having a superfluous check and extra dev_dbg()
> 
> If you are are going to address them, feel free to add my Rb tag to
> the patches 5 & 6.

Thank you for the reviews. I addressed most of your comments, but
because I still left the check you were concerned about in I'd like an
explicit reviewed-by on the v3 if you OK giving it.

Thank you.

-- 
Dmitry
