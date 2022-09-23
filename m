Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9195E7D21
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiIWOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiIWOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:32:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0369140F07
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:32:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r18so1041512eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xTwLqO8cX8Smr2zI4HvNer2tshPwVR5NDDlLtozuMKc=;
        b=fs4tS8nrQy9RSirOwgPb0QfF27CzJpSViwhpvYaErPMIWgpPRd4uS6Pl/XjGckP9+O
         ho/sFqVTR1zzMjus5zbzBoYapH5NCh9Fkuw3z69leEZXIoqR7JwmZik/01NIKOKIbsmU
         FIUSMbQiEtwlGypah9AqwPODH0jl95FGJx3BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xTwLqO8cX8Smr2zI4HvNer2tshPwVR5NDDlLtozuMKc=;
        b=YT87utlBBX44tIVz6AGkP9u3FNbizRqNvZzvhDlgO3qisE24c5YggDRfM0CY7WkhB8
         w0dKlFMBsPDb9voL9jNc58K875tgCFisgCoBS3dP+Ni5+KvWW7PZD7DlGykznWimvs00
         CBX9hE+YIrIjqlkqaqSgMaHo0miw6n2WUFQ7azumJfjXN6IJVFT3YBPy7ogpTHGVqdXJ
         nohGssVaBWwL8MimErVCgHWLj+KgoDKTutdlU92wzybJaOek7nJilaplGYj7RFDvrtch
         ftj0XHIK/crFwtX42wla+Y81EZ921Vo7k9FRvrM4BULNuqNZ5C+TpW1Dbb96aHRtQKal
         2MmA==
X-Gm-Message-State: ACrzQf3a4/oL6CXgm1uH3jpmxNqfHJRmySaEY0IY6QUkV0SD1/aYo2tt
        PIavWZ1/tSEjeWuSaoXYcqBxiCrwhCmOtv4v
X-Google-Smtp-Source: AMsMyM7B5Nf95ypkuZerzscZKtXUsFDdTtPtIm4520hsvQ78RaWsy8kNQF4/Mv0G8mM4kcEjuioeiA==
X-Received: by 2002:a17:906:9b83:b0:730:b3ae:343 with SMTP id dd3-20020a1709069b8300b00730b3ae0343mr7599699ejc.670.1663943562155;
        Fri, 23 Sep 2022 07:32:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id gc35-20020a1709072b2300b0077ab3ca93efsm4018653ejc.223.2022.09.23.07.32.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:32:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t7so255828wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:32:41 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr5622908wra.617.1663943561341; Fri, 23
 Sep 2022 07:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220923053729.301626-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220923053729.301626-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:32:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VA+YPgyLn+0EzWbJjUBfbQE2fbNT7PmAhah_B_T_B5TA@mail.gmail.com>
Message-ID: <CAD=FV=VA+YPgyLn+0EzWbJjUBfbQE2fbNT7PmAhah_B_T_B5TA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add INX N116BCN-EA1
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Sep 22, 2022 at 10:37 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the INX - N116BCN-EA1 (HW: C4) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

As with previous trivial patches that just add an entry to this
structure, there's no reason to wait before applying. Pushed to
drm-misc-next:

9f4a57148120 drm/panel-edp: Add INX N116BCN-EA1
