Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD4675EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjATUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjATUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:33:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6509085E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:33:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn6so6697550ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6a1CsEt8CudzRfvBnwyGdGse2R0fVkuKsLbjSK3W3ZU=;
        b=BV4fyxZgFNPW/IkcBFL26ouEsyGDHeRDZG+9LaXTS9UmerEGGQKt8zSbntQy6f70Ee
         DLFKPt4Ecx2aFtqeP66leWda/QaPgnyvwyvs0F2PEME9O2F7dU425QOhtLUktr9DHz45
         mJoISy2zum6vUbvBGLxP65OznjqVzj4BrHB+hXTfxQudiviaVX7OodTaOtNk12l463Eh
         34aLCeGzHfmm35Z2aO+do5+1C2o0wxgnoiSRZwXLYXZgIyu+Zgc/zypkoYvaEHMtFoZy
         1PudTMMcf+ygD/aB3VrnDYcwDR6zNmtKRCxKjjkxBCL+nHWswnVnaPa1EDCarbaySvWD
         McDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6a1CsEt8CudzRfvBnwyGdGse2R0fVkuKsLbjSK3W3ZU=;
        b=xYaVU19kduBo5n1+u3Eqp0wMHLTYgY2ttP2Olgdkl8A84t0HdRCzRdNW9YDWKEb0i+
         wYQGDQveCXmh8zT0Y3lWYPZfxwkNaP+R2PlqIrTWKohSMRC6LTTZrExHW2YcHkUn/jn6
         Olop7SsicbjvZGJwJgaVE0zdI9b+ze2M1NjyyEDu1T81tm/4Zu3X9C3HtneOEF9kTOs0
         khd5tyoj//05BpGpJnTFHkVrqLTUlHwSxWECjl+gWsLBG1duv0pAigdAP5HjTs/iFdLC
         yCNRyhA30mKzZxtgBhR8+zltpgo65Wr6ljAqQsJwrS6GYaCoqRbBZWtmjnkcJthArNcW
         mqWQ==
X-Gm-Message-State: AFqh2kr6/G9MgFzRH/yUjo+yXLK8NztAO9XHppPxJ+D3qq6aryIDdPwr
        cd1kYxnFdKQj9nXLO3QGPpbssA==
X-Google-Smtp-Source: AMrXdXseY041EcoBVjr8I7TjlaoEgXg0O09aGRO1387zhmObbC/gygm6bg9SKzzA3KsLfgKlsqBVYg==
X-Received: by 2002:a2e:9ecb:0:b0:283:ce76:415b with SMTP id h11-20020a2e9ecb000000b00283ce76415bmr4760051ljk.29.1674246829689;
        Fri, 20 Jan 2023 12:33:49 -0800 (PST)
Received: from [127.0.0.1] ([188.162.65.44])
        by smtp.gmail.com with ESMTPSA id k6-20020a05651c10a600b00287d9d49939sm3518968ljn.81.2023.01.20.12.33.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2023 12:33:49 -0800 (PST)
Date:   Fri, 20 Jan 2023 23:33:40 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sean Paul <sean@poorly.run>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 01/10] drm/hdcp: Add drm_hdcp_atomic_check()
User-Agent: K-9 Mail for Android
In-Reply-To: <Y8q0H7SiDkdfmyXP@art_vandelay>
References: <20230118193015.911074-1-markyacoub@google.com> <20230118193015.911074-2-markyacoub@google.com> <67170ce0-8622-8b35-e73a-7d873b7a3b8b@linaro.org> <Y8q0H7SiDkdfmyXP@art_vandelay>
Message-ID: <A0271342-FB1E-4F7C-BD94-7506F4FACE6E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 January 2023 18:32:47 GMT+03:00, Sean Paul <sean@poorly=2Erun> wrote=
:
>On Thu, Jan 19, 2023 at 11:37:52AM +0100, Krzysztof Kozlowski wrote:
>> On 18/01/2023 20:30, Mark Yacoub wrote:
>> > From: Sean Paul <seanpaul@chromium=2Eorg>
>> >=20
>> > This patch moves the hdcp atomic check from i915 to drm_hdcp so other
>> > drivers can use it=2E No functional changes, just cleaned up some of =
the
>> > code when moving it over=2E
>> >=20
>> > Acked-by: Jani Nikula <jani=2Enikula@intel=2Ecom>
>> > Acked-by: Jani Nikula <jani=2Enikula@intel=2Ecom>
>> > Reviewed-by: Rodrigo Vivi <rodrigo=2Evivi@intel=2Ecom>
>> > Reviewed-by: Abhinav Kumar <abhinavk@codeaurora=2Eorg>
>> > Signed-off-by: Sean Paul <seanpaul@chromium=2Eorg>
>> > Signed-off-by: Mark Yacoub <markyacoub@chromium=2Eorg>
>> > Link: https://patchwork=2Efreedesktop=2Eorg/patch/msgid/2021091317574=
7=2E47456-2-sean@poorly=2Erun #v1
>> > Link: https://patchwork=2Efreedesktop=2Eorg/patch/msgid/2021091520383=
4=2E1439-2-sean@poorly=2Erun #v2
>> > Link: https://patchwork=2Efreedesktop=2Eorg/patch/msgid/2021100115114=
5=2E55916-2-sean@poorly=2Erun #v3
>> > Link: https://patchwork=2Efreedesktop=2Eorg/patch/msgid/2021110503043=
4=2E2828845-2-sean@poorly=2Erun #v4
>> > Link: https://patchwork=2Efreedesktop=2Eorg/patch/msgid/2022041120474=
1=2E1074308-2-sean@poorly=2Erun #v5
>>=20
>> It seems all your previous versions were sent not to correct people and
>> lists=2E Therefore we see it for the first time even though it is v6!=
=20
>
>Hi Krzysztof,
>Thanks for your review comments=2E
>
>Here are the addresses the last version was sent to, who is missing?
>
>To: dri-devel@lists=2Efreedesktop=2Eorg,=20
>    jani=2Enikula@intel=2Ecom,
>    intel-gfx@lists=2Efreedesktop=2Eorg,
>    freedreno@lists=2Efreedesktop=2Eorg,
>    rodrigo=2Evivi@intel=2Ecom
>Cc: bjorn=2Eandersson@linaro=2Eorg,=20
>    swboyd@chromium=2Eorg,
>    abhinavk@codeaurora=2Eorg,
>    markyacoub@chromium=2Eorg,
>    Sean Paul <seanpaul@chromium=2Eorg>,
>    Maarten Lankhorst <maarten=2Elankhorst@linux=2Eintel=2Ecom>,
>    Maxime Ripard <mripard@kernel=2Eorg>,
>    Thomas Zimmermann <tzimmermann@suse=2Ede>,
>    David Airlie <airlied@linux=2Eie>,
>    Daniel Vetter <daniel@ffwll=2Ech>,
>    Jani Nikula <jani=2Enikula@linux=2Eintel=2Ecom>,
>    Joonas Lahtinen <joonas=2Elahtinen@linux=2Eintel=2Ecom>,
>    Tvrtko Ursulin <tvrtko=2Eursulin@linux=2Eintel=2Ecom>
>
>> It's
>> not the first such weird CC list in chromium, so maybe your
>> organisational process could be improved? Not only for you but for
>> colleagues as well, so you all start using get_maintainers=2Epl on newe=
st
>> kernel (not something ancient)?
>
>I can't really speak for others, but I use MAINTAINERS from drm-tip=2E Th=
e=20
>previous patch sets were sent before 24df12013853 ("MAINTAINERS: Add=20
>Dmitry as MSM DRM driver co-maintainer"), which might explain why you thi=
nk
>there are absences?

Current iteration of the patchset got at least three addresses wrong=2E Th=
ey have been changed for various reasons=2E Thus I also can suppose that th=
e list is incomplete and/or incorrect=2E

>
>Thanks again,
>
>Sean
>
>>=20
>> Best regards,
>> Krzysztof
>>=20
>

--=20
With best wishes
Dmitry
