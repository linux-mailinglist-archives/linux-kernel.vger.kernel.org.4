Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3D675955
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjATPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjATPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:55:39 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC66DA117
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:55:12 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a25so4417923qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIZBov414cRAviPU8wwR8NqtPTpO7JU2x/UOZjpaEK8=;
        b=I+/367Wr7qAl4QZ19Xa8tMaf6OqBl6nT+owiFtMqLB3/Pk1nuu/DhyGmoEK7Lb+cBd
         //6UGaGGTvOGvzJ/mWDIIYHpM5WkOc2aTbH28Z5mpomge2PFcZWk0jPPE8ng1P9KJICw
         kYEMN9hgS7OBMWqEVVXpEj+uPpGaVXdsBHwT1L5aA7FsjQPf0Z3TStJ+iaepVd5A72HF
         wvf5b52cvYfFrjB5l0ouephNq/+wZXsmyY1xI7jEACR3zpiFVnJGl1fUMjGlE8xgQr2+
         9GwZy1WuKMfqeSoyDSpeMrCnVUYV9UONb7Y8Ru7Xa3AMfHs1LyJSouAVHeWITYRdqKw5
         NHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIZBov414cRAviPU8wwR8NqtPTpO7JU2x/UOZjpaEK8=;
        b=yJqqUyvWDFMsV1jbQg1u+eas8c9oh5URFxqb1k4Y4GOOXDB24ezMvAxpj7nH7rBQ/o
         5xHOd5uOuNJiLF4s7h+KklJqMVQusD9kJslVf7Q5CMTyHq8FTanW/pWvOCxk23k7Wa+G
         RtsEVL/Gf9eGGkycl+1WlOeepwHC3B+TMMc0nLAwq8BUr6tbnwjw/ialWJJiuiw/+PMC
         FGc4WBkgCw20nPVYkpEi2ddzxXGyislCEdLuu+Qi3Skj5uskdT/sRci2VtGJ1bnrJMMq
         oZ47b7uEhybSc2jwc6sHIgPDB+8VZrpTGrgqxwPgu/VSmMoCAUeWFRFJUKqYZ0PGdDx8
         Y2Rg==
X-Gm-Message-State: AFqh2krZ3CCVBZBXLxMqslD4KvGOGioB/SOf3EYA+0cBsTNaMXZez0Aw
        Ro2R3fnoaUQ1xcWEUNLPJRo0HA==
X-Google-Smtp-Source: AMrXdXsjEvmwrWcwoIJKQJn80PQaEbBtBLRSxwKE/E0XlC2LInWRVyvOb56cD5VovaJaFNuBUXq/4w==
X-Received: by 2002:ac8:7ed1:0:b0:3ab:5a62:453b with SMTP id x17-20020ac87ed1000000b003ab5a62453bmr21415426qtj.53.1674230099206;
        Fri, 20 Jan 2023 07:54:59 -0800 (PST)
Received: from localhost (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a40d300b006cec8001bf4sm26567015qko.26.2023.01.20.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:54:58 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:54:57 +0000
From:   Sean Paul <sean@poorly.run>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
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
        abhinavk@codeaurora.org, seanpaul@chromium.org
Subject: Re: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Message-ID: <Y8q5UfpIg0+qnAuG@art_vandelay>
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-10-markyacoub@google.com>
 <aee03688-54b6-ed9f-e32c-b46e31d72198@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee03688-54b6-ed9f-e32c-b46e31d72198@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:35:32AM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2023 20:30, Mark Yacoub wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > This patch adds the register ranges required for HDCP key injection and
> 
> Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> This applies to all your patches. Fix it everywhere.

My goodness, this is peak bikeshedding. Surely we have better things to do with
our time?

> 
> > HDCP TrustZone interaction as described in the dt-bindings for the
> > sc7180 dp controller. Now that these are supported, change the
> > compatible string to "dp-hdcp".
> 
> What does it mean? Where do you do it?
> 
> > 
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-15-sean@poorly.run #v1
> > Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-14-sean@poorly.run #v2
> > Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-14-sean@poorly.run #v3
> > Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-14-sean@poorly.run #v4
> > Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-10-sean@poorly.run #v5
> 
> Drop the links.

Why? I've always done this, it seems helpful to me?

> 
> > 
> > Changes in v3:
> > -Split off into a new patch containing just the dts change (Stephen)
> > -Add hdcp compatible string (Stephen)
> > Changes in v4:
> > -Rebase on Bjorn's multi-dp patchset
> > Changes in v5:
> > -Put the tz register offsets in trogdor dtsi (Rob C)
> > Changes in v6:
> > -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
> > 
> > ---
> 
> Changelog after --- .

It's common practice in drm subsystem to include this in the commit message.

Sean


> 
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> 
> Best regards,
> Krzysztof
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
