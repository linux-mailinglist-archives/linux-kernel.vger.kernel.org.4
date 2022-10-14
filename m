Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA65FF3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJNSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJNSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:41:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23C1C116B;
        Fri, 14 Oct 2022 11:41:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g27so7986832edf.11;
        Fri, 14 Oct 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8juC6hMPMU2N03LaFSLm2HtS0qIXfus5Qh81eVapbo=;
        b=RtNba/Q15Dwtjw+/9AybnS/nkRDKtk46OAbyJKFRQs5MVZRUawxrNeIhiEVXtkxc5G
         lbVgu0N4fL6sTHjthSXG/WvdTP672n7pgaKRoETtGl7VnsEuF6hdG9wAfe2yQWCtvGYl
         B3zChh2OixTvT7VsdmdQ4dvaVUx2s6oxa87FghJWdcUddeYAvAsg4Er9BICMgN+XVPsW
         mRLmOZ6ePhX/ZDigreEhIdmjF0EGNEZgQeH4L6q62woIgX5KJe31PhCFNF6z2nPqoT42
         pPIpl20rhzV+zdtcqxG77x/IFcJ7qNhqw7BH5U427mEURl0SxA03A46aAoLvlrVWjyAb
         Y1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8juC6hMPMU2N03LaFSLm2HtS0qIXfus5Qh81eVapbo=;
        b=Nen52ch4vDD7SSribFg0kStrfsNTVYz697sNcIL0BxtQwgdmq80otw8hQ9C0aHVsFu
         rzUjr0znW6XYMi1YKqrJG4mx72u2pV8kErleUFpDdPIgVm+yykhzaDx6hmhb56LWMrXQ
         7co42pFuHzAVTUjvnu30MSLwXnSsLb26CjaZdwwRKl/ZuzMFtvGhNhw898coELA1sDxT
         8Q1mF6Xzvh/aSOq417cFQK/wlC9uoECjZwwHz8lK9Di9Nmah1E9WHb+p4OCnDxFsYyX2
         UAN1rNIWSFrzUzpAl4ZlmtXodDfITPEB+fIAauIO03L+AeKKCWpKlqpRJWHdIAptndv7
         uxyQ==
X-Gm-Message-State: ACrzQf2rqgrjsmqTDYJqhZFr5QQnJt/MTugPd3PvJLTCA2z0i9YKwMMs
        ffLi7qoDNX6P2YqiiFf13Ia8yAxWEk5DqETkr5A=
X-Google-Smtp-Source: AMsMyM7gGbl8alPUyCtiMtgGvzBv11vh19S7U55cAsqsI5VCbyej6jfc5cwLQkFaH4IGmeWQ5U72JYiN8gSoJYoe7CU=
X-Received: by 2002:a05:6402:26cf:b0:45d:48d7:928e with SMTP id
 x15-20020a05640226cf00b0045d48d7928emr2432edd.275.1665772865109; Fri, 14 Oct
 2022 11:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 14 Oct 2022 19:40:37 +0100
Message-ID: <CA+V-a8szP16n90tkwVaqdbC-e7sEs8pA6GKCY5EzAfU630RGyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] media: i2c: ov5645 driver enhancements
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Oct 14, 2022 at 7:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> The main aim of this series is to add PM support to the sensor driver.
>
> I had two more patches [0] and [1] which were for ov5645, so instead
> sending them separately I have clubbed them as series.
>
> v1-> v2
> - patch #1 is infact a v3 [1] no changes
> - patch #2 fixed review comments pointed by Sakari
> - patch #3 [0] no changes
> - patches #4 and #5 are new
>
> [0] https://patchwork.linuxtv.org/project/linux-media/patch/20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1] https://patchwork.linuxtv.org/project/linux-media/patch/20220919153540.178732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (5):
>   media: dt-bindings: ov5645: Convert OV5645 binding to a schema
>   media: i2c: ov5645: Use runtime PM
>   media: i2c: ov5645: Drop empty comment
>   media: i2c: ov5645: Return zero for s_stream(0)
>   media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
>     the subdev
>
After sending this series I realized I had an additional patch [0] for
ov5645 which I should have tagged along with the series. Can you
please pick [0] while reviewing this series.

[0] https://patchwork.kernel.org/project/linux-media/patch/20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
