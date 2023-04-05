Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2C6D721E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjDEBnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDEBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:43:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701DF30EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:43:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 82so1400904iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680659016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwpFUC847/YFt/XfpeQoDJ4SxIEry2tnTeuETvaZGB8=;
        b=kxh9ZACpSPv9wiPQEq+Rau+iIjjh23SMvvzm/E89O97Lu0X8m0ZJUekQlfXg45YYiK
         Rcj1tmS/7d2NuAXOUQM1tAzt/Xt5Cfi9Fv8l7eqlYHG27QuDI++wznv/7hVQhFnxVVFd
         jAssVRAkytmfCRDzXjAFwmGufHKcj+tNyjBj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680659016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwpFUC847/YFt/XfpeQoDJ4SxIEry2tnTeuETvaZGB8=;
        b=WL9TE0L6Sz4L2IR19sjIO86K25nluFMdTGYPU1QJ1/v9omRjVdCXNWmF+wQpoQxFcL
         SLpi+9xDT8ZOTuwU5eX5hARmpnsenvpX3gYhGxwZ4X/Konr/2moxjbJ3ATlkhfkuxy+u
         rNpDNCTDYixirePkZUvnVyquy9kc9rS1wluVfgoRJrVmJJC7uA9X4piYFG3x32ACOhSd
         jIMpFE5DfR6oCuGQVZbqC9utfPecBMrtVcEXUJzsGTchwJu+HoCcwp0dZVu94ZSLZzch
         jRbvb8Nn9FTmrsxOK2S0GBIARezCxH0H7aoUYj/nu2iIxQ77KslFnMqghiMWy8SXFTnm
         KUTA==
X-Gm-Message-State: AAQBX9dYSR354Df5qTjByKhPw7qlYcBi1eJ8qfQiiftZ45aJeBzFdMOb
        RYNnUgdodCas7GxCMo5DtmrCVI5/djQFDd0NGAw=
X-Google-Smtp-Source: AKy350ayM7kMDpvXmQvI+GvYTSMV/h516BvQmgGaP/QtBwX5WMgXhS6N6mKN05pRcPWvyz1y78AZow==
X-Received: by 2002:a05:6602:2146:b0:74c:a5ac:7759 with SMTP id y6-20020a056602214600b0074ca5ac7759mr3945504ioy.5.1680659016477;
        Tue, 04 Apr 2023 18:43:36 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id n21-20020a056638211500b0040617a81e1asm3648728jaj.59.2023.04.04.18.43.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 18:43:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id q8so3435848ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:43:33 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d9a:b0:325:dd36:7451 with SMTP id
 h26-20020a056e021d9a00b00325dd367451mr2720800ila.1.1680659013319; Tue, 04 Apr
 2023 18:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com> <1680271114-1534-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1680271114-1534-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Apr 2023 18:43:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XV4yjUb2ufQZjOTYsgFXE0Ghnor3f8FCSdpV_pcZd1yg@mail.gmail.com>
Message-ID: <CAD=FV=XV4yjUb2ufQZjOTYsgFXE0Ghnor3f8FCSdpV_pcZd1yg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/msm/dpu: set dirty_fb flag while in self
 refresh mode
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        swboyd@chromium.org, quic_kalyant@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 31, 2023 at 6:59=E2=80=AFAM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> While in virtual terminal mode with PSR enabled, there will be
> no atomic commits triggered without dirty_fb being set. This
> will create a notion of no screen update. Allow atomic commit
> when dirty_fb ioctl is issued, so that it can trigger a PSR exit
> and shows update on the screen.
>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Link: https://lore.kernel.org/all/20230326162723.3lo6pnsfdwzsvbhj@ripper/
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)

I can confirm that this patch plus patch #2 fixes the typing problems
seen on VT2 on a Chromebook using PSR.

Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
