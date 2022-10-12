Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE335FCAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJLSvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJLSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:50:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00060F4198
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:50:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so27536687wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQhlZRnJ0m4X2vc4+2LyXOMiawQABMxJ/mhVJlXpyFg=;
        b=xMNjvf+iP47KsXXvWRx0u3fSGwg+++0J4Fte26zqd3QXweAzJju6VUxhJ1ncoFer3c
         hdU6ZC2WmqVvyYCdZp+mOpqsallTsYpcTVbfTQFQOS/TboZ5uPi2kS6rhiUbtgYx8vB3
         MRJ1SpNH4IewAGwM8G/NifGm+kufLzutUHEFoRggbVmFdJGwROdqLdIV4L+1wbHlqj4R
         3wI/1RjABzR+HSCzU/xl3lwEm8xjPPsw5IPHLR2mZiZp05hLNVOi/tXnMf9guAVQyyIU
         MeIRe9HUG3bMm2JhRMXi2v1NL0mjlX39lbFS1iH469C4CQhF1vVfUe1s6z1qRbuKxn8i
         aRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQhlZRnJ0m4X2vc4+2LyXOMiawQABMxJ/mhVJlXpyFg=;
        b=g7P2CvZc75iz3IXJWVeO0rYRLI1wdsc3Y5nGf4eY78X/f2BfyJGwvDjfk3frS+/BHO
         8JrclqGG26Bhz3HWL2vzByDZoHDuO4Nq2ChXE+TnhwRQOicLwGSrLMgVfTIx+ocbb/Lj
         gd5PiQsv9z+/CUaoiCoCS4b/EbwdYJ1VitvIJ5ZhwxXBcPL5B0EAI/jw0+Y/3HNhq44k
         N9YhI544AIwyB3kEXUWr4nHF6pg6Q80jK37rjGZ+zXq9Ik7I4DfgLVNqkHTuDotjVBJa
         D6Obji7GrIdeSGlqzvVha6m/pSdvEx4l9UPHk8QQsMVajJTn3SjwNkIuRLzUstFR6QCH
         QoWw==
X-Gm-Message-State: ACrzQf1ZoiQmzvSVONED4gkcY6qe/vD4ABtCVBZZt2J7Ui3IsjDadoh5
        0tFCBIuh5NTjmrY5ORU6J623+CuGd3mMYoc9
X-Google-Smtp-Source: AMsMyM7kipgPbjIt6m4K8/GYYZTCjos7DxuGJh1RnAl0Ye38UQ60uXZy6uGh5XzIscj6pI9IK+JR6g==
X-Received: by 2002:a5d:6701:0:b0:22e:6545:995d with SMTP id o1-20020a5d6701000000b0022e6545995dmr18944278wru.301.1665600652184;
        Wed, 12 Oct 2022 11:50:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s14-20020adfecce000000b0022e653f5abbsm332083wro.69.2022.10.12.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:50:51 -0700 (PDT)
Date:   Wed, 12 Oct 2022 19:50:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/7] gpiolib: of: add a quirk for reset line for Marvell
 NFC controller
Message-ID: <Y0cMibfIomw3S5dc@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
 <Y0aW7vDxfNa/8bAk@maple.lan>
 <Y0cLLraNFVXtD2/k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cLLraNFVXtD2/k@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:45:02AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 12, 2022 at 11:29:02AM +0100, Daniel Thompson wrote:
> > On Tue, Oct 11, 2022 at 03:19:32PM -0700, Dmitry Torokhov wrote:
> > > The controller is using non-standard "reset-n-io" name for its reset
> > > gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
> > > so that gpiod API will still work on unmodified DTSes.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > How/when has/will the DT bindings documentation for this hardware be
> > updated to describe the new bindings?
> >
> > Delivering the quirks ahead of driver updates is great for avoiding
> > merge conflicts but it also conceals the rename from reviewers so
> > risks neglecting to update the bindings.
>
> I was planning on sending binding updates once driver patches land.

I'd have a (weak) preference for them being shared in the same patchset.
Maintainers can either ack or the changes can land seperately but
having them in the same patchset helps avoid having to quibble or check!


Daniel.
