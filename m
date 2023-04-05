Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E06D7224
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjDEBoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjDEBoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:44:01 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B563599
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:43:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o12so13047798ilh.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680659035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8kHzkX9SzRAkXXCj8yo/EKVJUuQ4P1xn/63qVUInQs=;
        b=i9T1CFuEPq6knTYwkWxspjaVaE3oVJ+xHE8V/HWUGqp4KihyT8cD6A4jXo195Hs1TB
         3Nlj3keIDe/Kc4XP1YSA+dsQ2AryZqABe6/cdtCGUVwcFnd38a2uBOc5h6ZKIQs6ymfg
         Ig39Rfj5g4tTuBH3zm/mD0w2GEXNkgrRaaCVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680659035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8kHzkX9SzRAkXXCj8yo/EKVJUuQ4P1xn/63qVUInQs=;
        b=r8D67JuNBSHxbdDiJLXD4mDgkT/P8OOSr/bk8feXyLOe0NIRaFIp1lpIxQIPwJray4
         ZaJam3Q/7pu46qDEyE8QCrRW7Yf/1LdZk4XWZnxT0iHh2YmHJKsOan0jAzCS859yhDpv
         09MpmR2goWR/qDE21GpXLJblxrO5z3j0sW1Tz0j1cY/LLprm3L23EwTjVuQB6oFc+nln
         ByS0WcSNqmu7lwBgOA1AngYm0Nc0DE3G7h64aG5q1CkAnFmGUNremvnefuV+3EIwreK2
         gQhl1osOmoqtaBuV78EpRi3oZCipq8UsXiw04cs1dB6knVylWzkVH8L9JxsQLadAc6wM
         Hy+Q==
X-Gm-Message-State: AAQBX9eHSMXslWOV/qIcLwdp5ipPr7sKyT6HwbGkiUPu+2XwPf5ins9J
        ewbcridHfP+ocxsOcw47QoHsEyyRjIz6WbICWPc=
X-Google-Smtp-Source: AKy350bqOLjEUA071uG6tsaOQdvf3WDnFv7O+d5+VC72YctJ1i7cctCSg2TojS0ByOOVzjM5HzxFWQ==
X-Received: by 2002:a92:c949:0:b0:316:e39f:1212 with SMTP id i9-20020a92c949000000b00316e39f1212mr3279855ilq.4.1680659035504;
        Tue, 04 Apr 2023 18:43:55 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id bs22-20020a056638451600b004063510ba0esm3760187jab.142.2023.04.04.18.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 18:43:54 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id 82so1401120iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:43:54 -0700 (PDT)
X-Received: by 2002:a6b:d010:0:b0:752:ed8d:d015 with SMTP id
 x16-20020a6bd010000000b00752ed8dd015mr675791ioa.1.1680659034009; Tue, 04 Apr
 2023 18:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com> <1680271114-1534-3-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1680271114-1534-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Apr 2023 18:43:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSHmQPtsQfWjviEZeErms-VEOTmfozejASUC9zsMjAbA@mail.gmail.com>
Message-ID: <CAD=FV=VSHmQPtsQfWjviEZeErms-VEOTmfozejASUC9zsMjAbA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] msm/disp/dpu: allow atomic_check in PSR usecase
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
> Certain flags like dirty_fb will be updated into the plane state
> during crtc atomic_check. Allow those updates during PSR commit.
>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Link: https://lore.kernel.org/all/20230326162723.3lo6pnsfdwzsvbhj@ripper/
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can confirm that this patch plus patch #1 fixes the typing problems
seen on VT2 on a Chromebook using PSR.

Tested-by: Douglas Anderson <dianders@chromium.org>
