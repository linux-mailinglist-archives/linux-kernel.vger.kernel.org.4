Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB262E695
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiKQVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiKQVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:14:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3A7A36A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id i10so8291684ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/DuA3/Pzsx3au4LPnKseak3gciQYTCxB9OFJeaSfOo=;
        b=AYvUNnIKTWnfmr6P3d3C+p6IzwACHao5za/pAs9MP8aieYoKmyHi+PBxS93Wp4jVUt
         CgXxgr2fCJCcnrnPa7FCwKMzEbot8+2S3iBr48lamoFuvFt5hKKrjo5w0lkTnnttOQUX
         7NH5WgXKirab3uUHAmboue15BxwxoP32qrCo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/DuA3/Pzsx3au4LPnKseak3gciQYTCxB9OFJeaSfOo=;
        b=TEPvmBpQIUz8PmdkddBhIKFkRxWbBgAD1ilAOD3xIiTmBqQEsnRuksE05I3AgBfFc4
         weW0Y3M3VmYST+1xe+IUXs3i52XKTsoOkaGhUNlypldUCKFTgpjLy+rBPf8ZddaQGXHi
         /2jl9j7655ucGQDQKj907iqkiHe7RtdEOVDA5Q05ijRse9FbCiW4Mxyvk7SyW0ojQnqQ
         iqxyoAuGY57OVMne5EJIBNgSo1pfA/diKZdzKH/Jt0GtjBPt0mm/ZU9fW0js2k6lX88P
         hD5Qhsrq7OoCxRQDGMQVpCdrv9UMMLA6cVX22GVLz/lDJtfOWZASiqXrBcXIXfMa+7Qc
         tDRw==
X-Gm-Message-State: ANoB5pnB8OFuL3r/wBi5hFRVxGw+UrO/qb1g83nriHCJE8e8x+BSuCPh
        Y6w+SJtdLTiRZkxLv46JIvng/TME0CSDrwdN
X-Google-Smtp-Source: AA0mqf59E8zLGmCs4rr+YSfK34uVTIdxLXkwvdBGfZiNasL88YFS8PMGkVbAtXMYV6PTFcKhwJknFw==
X-Received: by 2002:a17:907:75f3:b0:78d:b046:aaae with SMTP id jz19-20020a17090775f300b0078db046aaaemr3504916ejc.218.1668719688506;
        Thu, 17 Nov 2022 13:14:48 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c2c7000000b00467c3cbab6fsm991245edp.77.2022.11.17.13.14.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:14:45 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so2472541wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:45 -0800 (PST)
X-Received: by 2002:a05:600c:3109:b0:3cf:5731:53db with SMTP id
 g9-20020a05600c310900b003cf573153dbmr6680730wmo.85.1668719684774; Thu, 17 Nov
 2022 13:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
In-Reply-To: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:14:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XFsSoUqkk8zhta1V-oT2AGGvUz=0qFWAcXiJ7m+nnATA@mail.gmail.com>
Message-ID: <CAD=FV=XFsSoUqkk8zhta1V-oT2AGGvUz=0qFWAcXiJ7m+nnATA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/panel-edp: Use ktime_get_boottime for delays
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
>
> ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
> suspend, the time that the panel was powerd off is recorded with
> ktime_get, and on resume this time is compared to the current ktime_get
> time to determine if the driver should wait for the panel to power down
> completely before re-enabling it.
>
> Because we're using ktime_get, this delay doesn't account for the time
> that the device is suspended, during which the power down delay may have
> already elapsed.
>
> Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
> which does not stop when suspended. This ensures that the resume path
> will not be delayed if the power off delay has already been met while
> the device is suspended.
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
