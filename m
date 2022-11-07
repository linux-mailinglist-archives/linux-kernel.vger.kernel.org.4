Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A961FA86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKGQvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiKGQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:51:12 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713CB22506
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:50:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y14so31748630ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyMhELtxZmy7LysjRxs5koPIPiBWXacQeXByz4XAWq8=;
        b=SB/go7ORYqxZZfdBrbyfG2GmTEbMOWGqLEqoNc+0uv6nh8+5+mS4V9HIuuT8AmOZjz
         x6Vm6fxOhVnjXIOZEW/ue9mKhxe1sdm5EbBux0/CaioMil4IxpsOJJHjSM5F1PSBv5iF
         CoufIDf0RF0y52GBQt1USA8W9XhrTAedwNAvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyMhELtxZmy7LysjRxs5koPIPiBWXacQeXByz4XAWq8=;
        b=vUH7asRjCMs2TQFM2cTIBfrfhW7x3YBazs40tDgpmEMp1H2qR1Vivj5BcaJiQnFQtg
         dmyZ309Qq+N9iNehtTixXsmyw++L7jb3Ac3D6HX3kGffbondm5EBcnuQ/ChPIMBxAm+k
         4j1cK3+p3OXtR+vUH2QSxzsTt0zlOVuD20VGm/kCYia4L/u+vXphRwhSCNZoq3YEjToD
         qtQ42rbBXAwqL5RrUKE8nEV3h7P0qF4sOalT3QfdFdgs/CwKL/cdVcPQVp9VILaxVV+x
         ZkLDPqWVKFypdLKAWQ1GGSxxdIj71RkO6n1iExFaMC6nJqVAvpmB1c+ar3Uu+IyELr+V
         90rg==
X-Gm-Message-State: ACrzQf2yhrxRutt9YjP+P0rrhFhXPTPlLlTqgxbxFjqD4EL/4OvBcUDo
        /lVDrSElM0fn6wDtq4sLlfIurmEYje/ITQ==
X-Google-Smtp-Source: AMsMyM48hJALYAyWpbG6XBjhVarfWOaNU8g/9bCzFMOKbpNVjO17V6Rb/1WW8crInK4klRyCnc6BUQ==
X-Received: by 2002:a17:906:dc93:b0:7ad:ca82:4cb9 with SMTP id cs19-20020a170906dc9300b007adca824cb9mr42076638ejc.521.1667839854075;
        Mon, 07 Nov 2022 08:50:54 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id fd25-20020a056402389900b0045b910b0542sm4458763edb.15.2022.11.07.08.50.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:50:53 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id a14so17141828wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 08:50:53 -0800 (PST)
X-Received: by 2002:adf:cd86:0:b0:236:6056:14d3 with SMTP id
 q6-20020adfcd86000000b00236605614d3mr33705613wrj.30.1667839852819; Mon, 07
 Nov 2022 08:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com> <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com> <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
In-Reply-To: <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Mon, 7 Nov 2022 08:50:41 -0800
X-Gmail-Original-Message-ID: <CAMfZQbxxD8oAAKES5c-=2Zw-id20ac7kg4T5=7xrih2WeYbKhQ@mail.gmail.com>
Message-ID: <CAMfZQbxxD8oAAKES5c-=2Zw-id20ac7kg4T5=7xrih2WeYbKhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Helen Koike <helen.koike@collabora.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@iki.fi, boris.brezillon@collabora.com,
        hiroh@chromium.org, nicolas@ndufresne.ca, Brian.Starkey@arm.com,
        kernel@collabora.com, narmstrong@baylibre.com,
        linux-kernel@vger.kernel.org, frkoenig@chromium.org,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 2:11 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 11/5/22 18:19, Hsia-Jun Li wrote:
> > Hello Helen
> >
> > I didn't see any updates from V6 and V7-WIP in your repo. That is what I
> > need to for our complex tile formats in our platform.
> >
> > Any future plane here?
> >
> > Besides I have some ideas on these patches.
>
> I was looking into updating this patchset few months ago and the biggest
> blocker was the absence of immediate upstream user for this new UAPI.
> What your platform is? Is the driver stack completely opensource?
>
ChromeOS had interest in this for enabling UBWC for the venus driver.
We have a workaround at the moment, but would be interested.  So not
immediate need, but would hopefully be a user at some point.

-Fritz
> --
> Best regards,
> Dmitry
>
