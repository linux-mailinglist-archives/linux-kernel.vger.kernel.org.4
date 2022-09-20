Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBED5BE8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiITOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiITOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:24:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D8DF00
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:24:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so6634277ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=RB9jao1RvJqD7q146MWauhEs/XPA1hJe/ii/bB71eYk=;
        b=bY4rQNJblhGCXlfTf0ljqyrS0bwAA7s1qk+DVA7MaGpfDN9urU4dwOrG0PRT67r4b+
         KVuu1GBzHozmiZ/R0O0a/yT2PdhZdhoZ+B4TnPXKExKhxtnl0PBPHrTtg8LmOZPQafmH
         S1yod32L2LUvVwdoULLd4/ejBhoyCy09wHLoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RB9jao1RvJqD7q146MWauhEs/XPA1hJe/ii/bB71eYk=;
        b=8LrjQrmMB0/gxYd8F15PhySjGi9nHGZvhvyIXdvy/yfA2rTwhCMQLh3UqdByf5qgfe
         8QNoxJlpnVqMeEOxlTHmefYqP4VaIZ1qdwB3kOZJtDSCMAICYHBgEY44k0898cNTR6FI
         aID+VDau8S+d9pTNJjTAR65YkZQyFDC0qW9okG9jVIQV9OV9IpZgIjvFRim4XF6rM8f5
         LpP6yc/iiZiXeqAmVjQgd5GJ8ZcahnCHeyl/JXsjUp1PbAQJVINR1H5pJpqzEaf7c49l
         t3+VPNtcCiGL/wFOcmSOja/WMTj4UKgTqb9K6s8MFrhSL2vm8dVCFyPpFv1+qQIA1bu/
         dqeQ==
X-Gm-Message-State: ACrzQf3bogW14+takuvTSsGr3tejXdbo96acEITkJAZfYD/aiYMKxIJy
        0MJ6qjTDK9J3eJ30F7xudOZ5+xA8m8jlNncX
X-Google-Smtp-Source: AMsMyM6YlDkAbSjflVmcPMakutYqAAUSHvQm5DB8LlmFEhpWkbE5yPP7OFErbYMmxeCIemodqFuvJQ==
X-Received: by 2002:a17:907:6d11:b0:780:2737:755a with SMTP id sa17-20020a1709076d1100b007802737755amr17353459ejc.30.1663683872464;
        Tue, 20 Sep 2022 07:24:32 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0076ff600bf2csm961228ejg.63.2022.09.20.07.24.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:24:30 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id n10so4503862wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:24:30 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr14212984wrr.583.1663683870079; Tue, 20
 Sep 2022 07:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
 <20220909102720.v3.2.I22ae48d8ee064456073a828393704809360c4368@changeid>
 <Yyk/b29aG2ivpkf5@google.com> <CAFvdKjuBFoKXmU9zN8vQ65LT3=MMX-_3vhay16uhN3Z05QN6eA@mail.gmail.com>
In-Reply-To: <CAFvdKjuBFoKXmU9zN8vQ65LT3=MMX-_3vhay16uhN3Z05QN6eA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Sep 2022 07:24:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6zAabNPCB2aER7FL9Hwt=m71PTviOFcUbbZf7SmAA0A@mail.gmail.com>
Message-ID: <CAD=FV=U6zAabNPCB2aER7FL9Hwt=m71PTviOFcUbbZf7SmAA0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] input: touchscreen: elants_i2c: Add eth3915n
 touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 20, 2022 at 1:38 AM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> Dear Dmitry=EF=BC=9A
>
> Thanks for your reminding.
> After double checked with Elan, we finally decided to cancel this timing =
delay submission, due to touch panel module has HW modification..

Just to confirm that I understand this. I believe that you're saying
that in the end you decided that you _don't_ need the extra delays for
"ekth3915" and you can just use the normal ones. You only needed the
extra delays because of something that was different on your local
setup. Thus we should consider ${SUBJECT} patch abandoned.

If that's not true then please yell.

-Doug
