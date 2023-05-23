Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50570E9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjEWXej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEWXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:34:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B481B6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:34:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2533d74895bso243860a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684884850; x=1687476850;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNA57LFsEAjv0YnO7XAE11SZw6Ds4IrSm19nvlVJk98=;
        b=wF+aug1ydohk/cr8Rfez98IIlwqb13f0RxZ6y479XbKidTrvL03zg77sxMin+zGFGx
         l5eXByrl4nPZWQWmqQncYvX9EBJ2jhKSQOmxQvgaHwbuXn34nx47cTnpfrrrJzj+8zQw
         4pNfP+xtaTEDb3tmNzMbZ9lq1FvB1h3Y/9o0b9L7TTlVcKFXDAGLKRDd9xXEgp7O259E
         JEOObHH4XNk6aUQOdhlo/FfoEEjn3MqFmkmu5jjMJ2GV+T7Gsu/kuTOHMZ3neHBb56qU
         VtYRMrOu288bwsGXUhDF1P0SpaYg4k2ai2BHS88fM94NGHU7+411tXSKeuvtY4mY+E9V
         VdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684884850; x=1687476850;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNA57LFsEAjv0YnO7XAE11SZw6Ds4IrSm19nvlVJk98=;
        b=bxARNg48OPz672jb36p0LuFiZop5MOWgSkPMm2y3sTWU/Igchto3hj10PgbhXbxMe/
         hF53oQMhoUteumjIKZIpRZiJdPqiLkwyWn0+pT2bmNwF5PHBeyhdyx3l3CrTzKsZiMir
         Bd4iTa/K93xWRJ4TqWmfRJN1Lhb/vCh8rpRP7B0sc0U3+jSV9+N38tH1ANeipBGi7KOQ
         Rtc+6wzg5HzHcTh6h7cf5Rcq4FIgP8BkGRgC/3/BOEr8EgNs9pn0yXhehsGuBpWZWYls
         8Ft37TpJRHLHEwdWNVgG8GMb2cP4WgCajo5Z4dBT8xLzXEsAxLkheKJ0zG6hDrNkboKo
         yRvw==
X-Gm-Message-State: AC+VfDypMSSe/HCcc61WFpXLFZwWhV5O6rdxouUMZ/HuAI9lvRD0fYRQ
        2CMbmhDxwjCezEs+DsIaPiR3fg==
X-Google-Smtp-Source: ACHHUZ4/S/KRgTtfzWmFTkvHxw3NShbPiyY6ElSBnhSbSlY2KYV0gjG/Ka+9HzWGVYgXMdo2hQhd0g==
X-Received: by 2002:a17:90b:a45:b0:253:947f:af51 with SMTP id gw5-20020a17090b0a4500b00253947faf51mr13745197pjb.5.1684884849781;
        Tue, 23 May 2023 16:34:09 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id gl21-20020a17090b121500b00253305f36c4sm100944pjb.18.2023.05.23.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:34:09 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org, bero@baylibre.com,
        jstephan@baylibre.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        linaro-mm-sig@lists.linaro.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, nbelin@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 0/7] Add a DRM driver to support AI Processing Unit (APU)
In-Reply-To: <d0807fe4-dba2-8244-f655-d04e80973572@quicinc.com>
References: <20230517145237.295461-1-abailon@baylibre.com>
 <d0807fe4-dba2-8244-f655-d04e80973572@quicinc.com>
Date:   Tue, 23 May 2023 16:34:08 -0700
Message-ID: <7ha5xud3m7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> On 5/17/2023 8:52 AM, Alexandre Bailon wrote:
>> This adds a DRM driver that implements communication between the CPU and an
>> APU. The driver target embedded device that usually run inference using some
>> prebuilt models. The goal is to provide common infrastructure that could be
>> re-used to support many accelerators. Both kernel, userspace and firmware tries
>> to use standard and existing to leverage the development and maintenance effort.
>> The series implements two platform drivers, one for simulation and another one for
>> the mt8183 (compatible with mt8365).
>
> This looks like the 3 existing Accel drivers.  Why is this in DRM?

Yes, this belongs in accel.  I think Alex had some issues around the
infra in accel with device nodes not appearing/opening properly, but
I'll let him comment there.  But either way, the right approach should
be to fix any issues in accel and move it there.

[...]

>>   .../devicetree/bindings/gpu/mtk,apu-drm.yaml  |  38 ++
>>   drivers/gpu/drm/Kconfig                       |   2 +
>>   drivers/gpu/drm/Makefile                      |   1 +
>>   drivers/gpu/drm/apu/Kconfig                   |  22 +
>>   drivers/gpu/drm/apu/Makefile                  |  10 +
>>   drivers/gpu/drm/apu/apu_drv.c                 | 282 +++++++++
>>   drivers/gpu/drm/apu/apu_gem.c                 | 230 +++++++
>>   drivers/gpu/drm/apu/apu_internal.h            | 205 ++++++
>>   drivers/gpu/drm/apu/apu_sched.c               | 592 ++++++++++++++++++
>>   drivers/gpu/drm/apu/simu_apu.c                | 313 +++++++++
>>   include/uapi/drm/apu_drm.h                    |  81 +++
>
> "apu" seems too generic.  We already have 3 "AI processing units" over 
> in drivers/accel already...

Indeed, it is generic, but that's kind of the point for this driver
since it's targetted at generalizing the interface with "AI processing
units" on a growing number of embedded SoCs (ARM, RISC-V, etc.)  In
addition, the generic naming is intentional because the goal is bigger
than the kernel and is working towards a generic, shared "libAPU"
userspace[1], but also common firmware for DSP-style inference engines
(e.g. analgous Sound Open Firmware for audio DSPs.)

As usual, the various SoC vendors use different names (APU, NPU, NN
unit, etc.)  but we'd like a generic name for the class of devices
targetted by this driver.  And unfortunately, it looks like the equally
generic "Versatile processing unit" is already taken Intel's
drivers/accel/ivpu. :)

Maybe since this is more about generalizing the interface between the
CPU running linux and the APU, what about the name apu_if?  But I guess
that applies to the other 3 drivers in drivers/accell also.  Hmmm...

Naming things is hard[2], so we're definitly open to other ideas.  Any
suggestions?

Kevin

[1] https://gitlab.baylibre.com/baylibre/libapu/libapu

[2]
"There are 2 hard problems in computer science: cache invalidation,
 naming things and off-by-1 errors."
 -- https://twitter.com/secretGeek/status/7269997868

