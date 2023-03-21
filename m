Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE86C324E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCUNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCUNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:08:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308B4D42C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:07:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5416698e889so279501437b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679404066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OMTf5Ga7cygQE1B9rsS6pN7RAXO/nEzZ4boh/y9Vt0=;
        b=cmJ8XIdSsNL/DkdwP6cioRpdQEMqyvRHRipv5kDKib1eCTK9r/TTQFkJ591EPAprgW
         kq+VOaFqG5IX5Y49IJLieVe4Yfzzh0D1CbApAa2dUuBDYA2BQKTHPzVhniNz4VD8TBmW
         4BquqEkEWXiF/o+8UKQ02d9YUbI2e0zJzXEUI4h6K9P1ZuDYQusqtbSPZ5a7NSUD26Cv
         ffegSH5qZRqhh+unOsVNC8HjiZJZe13TQR1kZOv7c/SgoL2Z/zOYub+eld/LVyB/ot02
         akzOY70zzgoeGMVkMtWSYvwHdpV3ThAm3o5tWKy9XvO4dfqJnRiN3+TAqeppxewF7dzE
         iXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OMTf5Ga7cygQE1B9rsS6pN7RAXO/nEzZ4boh/y9Vt0=;
        b=naS/XhJkoRMtP7SivMERhy/rX7NNNE2S3bdCcgZX/NoG3/PkQO2U2/cVJ5u/y3q7BT
         qQxw4AYbXieWsn5u1jbWZ968NM/RfHH6214E57itjOeMELJqlN67wWnZDGAv/d/azekw
         2+Z7TB6b6kwjO46kwlG+esn5zPAMc/L+q9ozNfwlJzFPG8AQnIAaMFsAoyzn/47KmOiG
         vS7aBVnAV9ocJAtXQfB00+Ju6BWlqx0gmWd712zF4BWN/7j4Ld2Au83uGlfjV1GlxVUS
         INALk1O1grZrDnYe3uTR9XsxTgkOJrMjT7rrKzGh07xg1XbuEgN0bSZx1wPUl/0yAppy
         UItQ==
X-Gm-Message-State: AAQBX9cqohId1k0f1U9TumDwrjA1VvDOKCNgShaEqj3+DcytT/gzjZ0t
        HTJSBFizNPZuJ3nnNbUN+X2pnNgHmg2CbxoK1y1mow==
X-Google-Smtp-Source: AKy350aj0PlWxbSVBeOrBC5vlMmi49wh+264w2jb98dmgSFBHyYGXdbEC1QiSslS+rFn7ARz91359uDeEapA874kEBA=
X-Received: by 2002:a81:4305:0:b0:52e:e095:d840 with SMTP id
 q5-20020a814305000000b0052ee095d840mr1020956ywa.0.1679404065610; Tue, 21 Mar
 2023 06:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320134217.1685781-1-abel.vesa@linaro.org>
In-Reply-To: <20230320134217.1685781-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Mar 2023 14:07:09 +0100
Message-ID: <CAPDyKFrhqOfiUPEcb724Qw0ZCUV6LYj8HL0OhnVbr-2vj+_6Wg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Allow genpd providers to power off domains on
 sync state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 at 14:42, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> There have been already a couple of tries to make the genpd "disable
> unused" late initcall skip the powering off of domains that might be
> needed until later on (i.e. until some consumer probes). The conclusion
> was that the provider could return -EBUSY from the power_off callback
> until the provider's sync state has been reached. This patch series tries
> to provide a proof-of-concept that is working on Qualcomm platforms.
>
> I've been doing extensive testing on SM8450, but I've also spinned this
> on my X13s (SC8280XP). Both patches that add the sync state callback to
> the SC8280XP and SM8450 are here to provide context. Once we agree on
> the form, I intend to add the sync state callback to all gdsc providers.
>
> Currently, some of the gdsc providers might not reach sync state due to
> list of consumers not probing yet (or at all). The sync state can be
> enforced by writing 1 to the state_synced sysfs attribute of the
> provider, thanks to Saravana's commit [1] which has been already merged.
>
> [1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.com
>
> V1 of this patchset was here:
> https://lore.kernel.org/all/20230315132330.450877-1-abel.vesa@linaro.org/
>
> Changes since v1:
>  * Added the qcom_cc sync state callback which calls in turn the gdsc one
>  * dropped extra semicolon from pm_domain.h
>
> Abel Vesa (5):
>   PM: domains: Allow power off queuing from providers
>   soc: qcom: rpmhpd: Do proper power off when state synced
>   clk: qcom: gdsc: Avoid actual power off until sync state
>   clk: qcom: Add sync state callback to all SC8280XP providers
>   clk: qcom: Add sync state callback to all SM8450 providers
>
>  drivers/base/power/domain.c        |  3 ++-
>  drivers/clk/qcom/camcc-sm8450.c    |  1 +
>  drivers/clk/qcom/common.c          | 19 +++++++++++++++++++
>  drivers/clk/qcom/common.h          |  2 ++
>  drivers/clk/qcom/dispcc-sc8280xp.c |  1 +
>  drivers/clk/qcom/dispcc-sm8450.c   |  1 +
>  drivers/clk/qcom/gcc-sc8280xp.c    |  1 +
>  drivers/clk/qcom/gcc-sm8450.c      |  1 +
>  drivers/clk/qcom/gdsc.c            | 26 ++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h            |  6 ++++++
>  drivers/clk/qcom/gpucc-sc8280xp.c  |  1 +
>  drivers/soc/qcom/rpmhpd.c          | 19 +++++++------------
>  include/linux/pm_domain.h          |  6 ++++++
>  13 files changed, 74 insertions(+), 13 deletions(-)
>

Besides the minor comments on patch1, this looks good to me! So, feel
free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
