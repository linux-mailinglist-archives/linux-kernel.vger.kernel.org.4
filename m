Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22C626BD6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiKLVTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:19:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586872DFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:19:33 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z17so5318461qki.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7LJFqOyMImC8WuexexWgvCNPLHYfLpO1mzg+j0WKVE=;
        b=k8zH3XQS5nUlAJ7Qf8ugdM+28QhO5o1QQJlf/mRg5oV9ydzR8oxak/HxfipNGsEsMt
         d5DUqSU1OppLtFWP2ap/TdE70ZiRLRq9JcURS6XQMq3PIlEp7awRM0UbIiqYWjZhdH/2
         eBv5qi5M5TNoYmST0omw+ORZDeWMWNPbPNwaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7LJFqOyMImC8WuexexWgvCNPLHYfLpO1mzg+j0WKVE=;
        b=tENg/lxPmWuJxa9dkRXI2f8ZWDztaCsWDTdeVexh6VjokwPboOAKTX+gy7kG3Hyk37
         oO7o1QZlr8bfnk0U/IRNml1sWPT4b0SQr/rU26/8HwTX4zd8YphT6y5u4QwTdVFveaPW
         lxv4zhL6f11P6+pKA9xPHByyM7cDop8dO8X8ewNJED0iZRgF88HoOtF6vYWJQP1W+Y2Y
         A8jxKczg7YINiUGDL9e7sSCrWJ/mKxcuzvfnvCX16MzOk7Qd0vPYSJsehflJicIpzUHV
         rIODRKwFjRc/FySfvJmfKnUZsDbdlUrJHLdXT76eBptgsKplc2fKL7q33rNNaISwVZCM
         tj8Q==
X-Gm-Message-State: ANoB5pm92APtkUc5VOQjz9XfWRw1seL3JLzQqkff+1yQxRe9RrWbOXLK
        a9rDZ0FFZe+yszNJ70OJfSLXE2hyBZu/wcqtfO7/+Q==
X-Google-Smtp-Source: AA0mqf7fyCl7MgMyFSdWpZ3D8vMgXuKfyhDJRuN51J37UeA8YZ26KufNY39iN01RrkGow5bJ1cPEbNaKmNMJCualpUc=
X-Received: by 2002:a05:620a:1003:b0:6fa:23d4:aecc with SMTP id
 z3-20020a05620a100300b006fa23d4aeccmr6022174qkj.678.1668287972045; Sat, 12
 Nov 2022 13:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20221111112657.1521307-1-mitja@lxnav.com> <20221111112657.1521307-4-mitja@lxnav.com>
 <20221112173222.0ca56017@jic23-huawei>
In-Reply-To: <20221112173222.0ca56017@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Sat, 12 Nov 2022 22:19:07 +0100
Message-ID: <CACbQKWe5xGT80_ZcQmTYrGThtFyw6xKD_OmGLi8XGi0pvR1RBA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: mcp3422: add hardware gain attribute
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Nov 12, 2022 at 6:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> How are the separate?  We normally only use hardwaregain if
> changing it has no input on the scale that we need to apply in userspace
> to raw channels.  This normally happens for two reasons
> 1) There is a micro controller on the sensor that is doing a bunch of
>    maths so whilst changing the PGA value changes the range measurable it
>    doesn't affect the representation when we read from the device.
> 2) The hardware gain is controlling say the sensitivity of a light sensor
>    in a time of flight device - it affects if we can get a measurement, but
>    not the measurement itself.
>
> Any of that true here?
No. I see I misunderstood the hardwaregain attribute. For me this is a user
friendly way of setting the gain and subsequently scale.

What I don't understand is why set scale at all? It's a result of sampling
rate and gain settings. Using it as a setting, for which input value range also
changes depending on another attribute is quite cumbersome.
To use a sensor the program has to do this:
1. set the sampling rate
2. read available scales for this sampling rate
3. set the scale according to desired gain
or know the scales for each sampling rate in advance...which makes available
scales attribute quite useless.

Kind regards,
Mitja
