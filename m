Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1972EC09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjFMTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFMTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:34:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2672199
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:34:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977d02931d1so859603966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684856; x=1689276856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLMJYRBorT4BFeTxoWUQlILrVOQXKFEtzQp+4QGPj4s=;
        b=cIcvMMxX34Ybq36qD0YDv9yvEekDBh38Er6kkTp3wTXSCTuw4lE9STuSaUaChqcXkm
         8z/uG5xIch5xemadR3GmPtlRxexsgrE7xGVND9Kpzk6cEIKfC6arOtzTdme1YD55o529
         kJbCdFjn3Zvg0VBcyS3ePZqslALm74mE9zvfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684856; x=1689276856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLMJYRBorT4BFeTxoWUQlILrVOQXKFEtzQp+4QGPj4s=;
        b=XpoxMbJKfY0U1gr+/0PORJvUrKCxJpzNGnU/9kdb3+/MeYLV/DHMACyzhyF9Y8WC5b
         SiYVN1dH1HICvM1k7VHTB9GjzR8foZibGZKiXwbBjG//V6Yg/WdJWahpNswNnLMV0TRh
         z071wmwn7kPhtJxWDqCxqk6ZBPZgT5aU5cu7AOXfidS1/Bwgxg79qckNTnpastZXRDlt
         2SUQPHsIEHIO9dDz56CAtnfFX+SE6yaL/90k6ycrU0HO6xJ4mN2QeL8LWrOJhcrWuc55
         GWcx0uBlp3hESD1RAwUwxGOvTQ5f8S9RrM1wHsSz9luRgapIJvJynyQf+i1M9jbtVvu2
         HYHA==
X-Gm-Message-State: AC+VfDywRM4bQVIeOOjcW0PpyZeXu0ipu7GFs2N2PtB3BxFxxBFVBB1S
        4J5GziUPDrJJtDkdtC4+fu2TVcfQR1+t0S9ZrYE8h9vO
X-Google-Smtp-Source: ACHHUZ7VRfiOV5UukhTmMT54vgtgVGT48224auUsaU5odWFzKm3Ge6Z076drd+Iq4/B52wt1ECuDow==
X-Received: by 2002:a17:906:4fd0:b0:96f:d556:b926 with SMTP id i16-20020a1709064fd000b0096fd556b926mr12233155ejw.77.1686684855809;
        Tue, 13 Jun 2023 12:34:15 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id jt5-20020a170906dfc500b0097462d8dc04sm7059148ejc.100.2023.06.13.12.34.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:34:13 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so2983a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:34:12 -0700 (PDT)
X-Received: by 2002:a50:bac8:0:b0:507:6632:bbbf with SMTP id
 x66-20020a50bac8000000b005076632bbbfmr11406ede.6.1686684852516; Tue, 13 Jun
 2023 12:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612220106.1884039-1-quic_bjorande@quicinc.com> <c31ee9e4-1878-c0ae-70e6-42af5fd838c7@linaro.org>
In-Reply-To: <c31ee9e4-1878-c0ae-70e6-42af5fd838c7@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jun 2023 12:33:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Whn3GDDMQiJGYbSK8LF-OO247m69Sqcf7dMw6HFthgqw@mail.gmail.com>
Message-ID: <CAD=FV=Whn3GDDMQiJGYbSK8LF-OO247m69Sqcf7dMw6HFthgqw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Drop aux devices together with DP controller
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 12, 2023 at 3:40=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 13/06/2023 01:01, Bjorn Andersson wrote:
> > Using devres to depopulate the aux bus made sure that upon a probe
> > deferral the EDP panel device would be destroyed and recreated upon nex=
t
> > attempt.
> >
> > But the struct device which the devres is tied to is the DPUs
> > (drm_dev->dev), which may be happen after the DP controller is torn
> > down.
> >
> > Indications of this can be seen in the commonly seen EDID-hexdump full
> > of zeros in the log, or the occasional/rare KASAN fault where the
> > panel's attempt to read the EDID information causes a use after free on
> > DP resources.
> >
> > It's tempting to move the devres to the DP controller's struct device,
> > but the resources used by the device(s) on the aux bus are explicitly
> > torn down in the error path.
>
> I hoped that proper usage of of_dp_aux_populate_bus(), with the callback
> function being non-NULL would have solved at least this part. But it
> seems I'll never see this patch.

Agreed. This has been pending for > 1 year now with no significant
progress. Abhinav: Is there anything that can be done about this? Not
following up on agreed-to cleanups in a timely manner doesn't set a
good precedent. Next time the Qualcomm display wants to land something
and promises to land a followup people will be less likely to believe
them...


> > The KASAN-reported use-after-free also
> > remains, as the DP aux "module" explicitly frees its devres-allocated
> > memory in this code path.
> >
> > As such, explicitly depopulate the aux bus in the error path, and in th=
e
> > component unbind path, to avoid these issues.
> >
> > Fixes: 2b57f726611e ("drm/msm/dp: fix aux-bus EP lifetime")
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
