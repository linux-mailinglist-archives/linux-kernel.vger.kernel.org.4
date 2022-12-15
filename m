Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727DE64E227
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLOUKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLOUKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:10:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39F1EEDA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:10:11 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so127024ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIS0EaGXTjCRXER8GI+dNLF12wjq2q+2o8WGX76WmuM=;
        b=AZZq5PUnZFfrNHwv7HNiSHWCLeR7RR8le4981nYRfDcS/ru+GZCfjF9myTcDec3B82
         mQ2GZURB0mLaYbyVBtGJ1NFHjPo+S8Ar/iMl/x6SnWZIdiR5UPHYRSs5fzuQuqgP3aaO
         fSc/9GAnzacM7M1X/ZpuSegZbsPHV8l1Y5Xms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIS0EaGXTjCRXER8GI+dNLF12wjq2q+2o8WGX76WmuM=;
        b=EyfNnXTMXlOjuSmyFJJSU5bmCnmwdmijRCAyQTh8Hh/Ay/KhQOb8e5aFvvHXzZ3nga
         4cnowftsXan/JLfw7AitRqVNJNxD80VAblQXOoF8hb1GBiZHFzb5nO6v0r6xN0IpNlQI
         hs8os8QrOdKgipHtTI7VBMxDtOYLek/6aVwz04uuEfW1RkLI81/DuKlu4b6nhsL3Z44t
         Kk7pAiZ8beW9OK844gs77cA1P54FbxBRfKZyQ4hH2+klbhdigaPx63yoHozd3JKG0S7r
         UnVeFNZ2H3zg11w+vO8C91G+IN+hO+cUXtSAccZtzAqAevxpp+7G2oHjZSgdB5RGAvUW
         fX9A==
X-Gm-Message-State: ANoB5pn8Q5EQegU9fzO/aTc3sod87B72mqQAv/YiiH82on/YORoVlV0Z
        0AtmUnGAaN8ZkGgcU7gzqUbogTkE48lVDEuNHSg5Pg==
X-Google-Smtp-Source: AA0mqf4Tx6gctjKCY4dC7SXXC0K/mpFF/gMRMqZIcP3KQUC32WpR7lr/tv9LCeuvBxDdF2/qWtwf4i+PNBpUR6inRKk=
X-Received: by 2002:a05:651c:221e:b0:277:6231:5a7 with SMTP id
 y30-20020a05651c221e00b00277623105a7mr23597850ljq.300.1671135009730; Thu, 15
 Dec 2022 12:10:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Dec 2022 15:10:09 -0500
MIME-Version: 1.0
In-Reply-To: <ca15a54b-8040-5e4f-a78e-12b7f8a554e1@linaro.org>
References: <1671129159-31105-1-git-send-email-quic_khsieh@quicinc.com> <ca15a54b-8040-5e4f-a78e-12b7f8a554e1@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 15 Dec 2022 15:10:09 -0500
Message-ID: <CAE-0n53bREwEMV4aP=ySPuPP8mMbDr=Unbjw_bW0MNN7hTsWRw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if
 irq is not for aux transfer
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        dianders@chromium.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-12-15 10:46:42)
> On 15/12/2022 20:32, Kuogee Hsieh wrote:
> >       if (!aux->cmd_busy)
> >               return;
> >
> >       if (aux->native)
> > -             dp_aux_native_handler(aux, isr);
> > +             ret = dp_aux_native_handler(aux, isr);
> >       else
> > -             dp_aux_i2c_handler(aux, isr);
> > +             ret = dp_aux_i2c_handler(aux, isr);
> >
> > -     complete(&aux->comp);
> > +     if (ret == IRQ_HANDLED)
> > +             complete(&aux->comp);
>
> Can you just move the complete() into the individual handling functions?
> Then you won't have to return the error code from dp_aux_*_handler() at
> all. You can check `isr' in that function and call complete if there was
> any error.

I'd prefer we apply my patch and pass the irqreturn_t variable to the
caller of this function so spurious irqs are shutdown. Should I send it
as a proper patch?
