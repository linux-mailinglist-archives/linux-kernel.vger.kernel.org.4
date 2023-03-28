Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E386CB2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC1ASJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC1ASH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:18:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D9510F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:18:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u38so6840749pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679962685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAT8YKWoRzsnW/D83k7oze0TqtTySta11nv0MrTObWM=;
        b=XPBm+9xksh5PxzAYsl8E2AlRmfp5jgrv9AuRc2x4dXApa3Kq+h8rESDLxoOEVNhg/+
         0PxFMH1ADI4OynnF8Aw62CSuC90wI/rUFShKEp06NyDRwuADSb5kzJF5IIZdhG9T85RU
         QzbJ/0i2LlYQCweBp+wP2uyZCby0ZsyuMziV2RaNGMx4ECDk8VgWJTI33ShhLu4BQ1wP
         bIpE6lcCispSViefdnCH3Xd50Z6G0SUG+EQPFu56pvsGLLfh/KrCsJL1b2VfzFlFSE5y
         5phRhyXvIJI4KIczbMnXtDsfKPoiGJpqPG0eKt4JdhNpmVtoeE1b/MYSxZP4AX+xRcMQ
         sxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679962685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAT8YKWoRzsnW/D83k7oze0TqtTySta11nv0MrTObWM=;
        b=m1MvFYdmXFbbStYtz5sclixkQKNF9cxFkFdJV001TiKhGmgk/s2wTGdWBuksPtkDHv
         wJ2FqtriXQuYfvQl2Iwo0q2odaQadHG44WbAOwJ6zNKuSINQBRPTkHb4lNSkqOhspjZ5
         v8sk+xXDtXxK3V+O04RRUU3OD1N+yzs2msCtxhIOy27PUeyOkpP/kPySL9WiyvycbF3w
         Aa5+Hev56TBbbyFjSgKiLpWHfGzjYP6I2XBeKtJK7sHJhmG8X1Jdya51F9O04FBPb05S
         xwJDmZ/wkeBjZA/MOKcwayZQiOIcbjB7Sp/CEzuFnoOebeZogCl94274JBjZ9RY+2ASi
         i7Iw==
X-Gm-Message-State: AAQBX9f9kb0htXKblLwxpp2SaV7ZRE+790MVwXF7F/fasv1afPcd1Xsy
        xerlMZLEf0wyXBR9Rvu84bMHQM8v3T2JnI9GU4rrlA==
X-Google-Smtp-Source: AKy350ZfVurdmDvbshJjR8lJnRWOqXeP2QfY8WKwM1OLga/HLMcolMzF6jCx6t5oZGgAAV3jHCML2DnLXVBFIwbDpRk=
X-Received: by 2002:a63:d157:0:b0:50c:2b1:7a8f with SMTP id
 c23-20020a63d157000000b0050c02b17a8fmr3720403pgj.6.1679962685061; Mon, 27 Mar
 2023 17:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
In-Reply-To: <20230327193829.3756640-1-abel.vesa@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Mar 2023 17:17:28 -0700
Message-ID: <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on sync state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:38=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> w=
rote:
>
> There have been already a couple of tries to make the genpd "disable
> unused" late initcall skip the powering off of domains that might be
> needed until later on (i.e. until some consumer probes). The conclusion
> was that the provider could return -EBUSY from the power_off callback
> until the provider's sync state has been reached. This patch series tries
> to provide a proof-of-concept that is working on Qualcomm platforms.

I'm giving my thoughts in the cover letter instead of spreading it
around all the patches so that there's context between the comments.

1) Why can't all the logic in this patch series be implemented at the
framework level? And then allow the drivers to opt into this behavior
by setting the sync_state() callback.

That way, you can land it only for QC drivers by setting up
sync_state() callback only for QC drivers, but actually have the same
code function correctly for non-QC drivers too. And then once we have
this functionality working properly for QC drivers for one kernel
version (or two), we'll just have the framework set the device's
driver's sync_state() if it doesn't have one already.

2) sync_state() is not just about power on/off. It's also about the
power domain level. Can you handle that too please?

3) In your GDSC drivers, it's not clear to me if you are preventing
power off until sync_state() only for GDSCs that were already on at
boot. So if an off-at-boot GDSC gets turned on, and then you attempt
to turn it off before all its consumers have probed, it'll fail to
power it off even though that wasn't necessary?

4) The returning -EBUSY when a power off is attempted seems to be
quite wasteful. The framework will go through the whole sequence of
trying to power down, send the notifications and then fail and then
send the undo notifications. Combined with point (2) I think this can
be handled better at the aggregation level in the framework to avoid
even going that far into the power off sequence.

-Saravana

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
> [1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.co=
m
>
> V2 (RFC) of this patchset was here:
> https://lore.kernel.org/all/20230320134217.1685781-1-abel.vesa@linaro.org=
/
>
> Changes since v2:
>  * renamed genpd_queue_power_off_work to pm_genpd_queue_power_off and add=
ed
>    comment about its purpose w.r.t. it being exported.
>  * added the qcom_cc generic sync state callback to all providers that
>    register GDSCs, instead of SM8450 and SC8280XP
>
> Changes since v1:
>  * Added the qcom_cc sync state callback which calls in turn the gdsc one
>  * dropped extra semicolon from pm_domain.h
>
> Abel Vesa (4):
>   PM: domains: Allow power off queuing from providers
>   soc: qcom: rpmhpd: Do proper power off when state synced
>   clk: qcom: gdsc: Avoid actual power off until sync state
>   clk: qcom: Add sync state callback to all providers
>
>  drivers/base/power/domain.c            | 18 ++++++++++--------
>  drivers/clk/qcom/apss-ipq6018.c        |  1 +
>  drivers/clk/qcom/camcc-sc7180.c        |  1 +
>  drivers/clk/qcom/camcc-sc7280.c        |  1 +
>  drivers/clk/qcom/camcc-sdm845.c        |  1 +
>  drivers/clk/qcom/camcc-sm6350.c        |  1 +
>  drivers/clk/qcom/camcc-sm8250.c        |  1 +
>  drivers/clk/qcom/camcc-sm8450.c        |  1 +
>  drivers/clk/qcom/common.c              | 19 +++++++++++++++++++
>  drivers/clk/qcom/common.h              |  2 ++
>  drivers/clk/qcom/dispcc-qcm2290.c      |  1 +
>  drivers/clk/qcom/dispcc-sc7180.c       |  1 +
>  drivers/clk/qcom/dispcc-sc7280.c       |  1 +
>  drivers/clk/qcom/dispcc-sc8280xp.c     |  1 +
>  drivers/clk/qcom/dispcc-sdm845.c       |  1 +
>  drivers/clk/qcom/dispcc-sm6115.c       |  1 +
>  drivers/clk/qcom/dispcc-sm6125.c       |  1 +
>  drivers/clk/qcom/dispcc-sm6350.c       |  1 +
>  drivers/clk/qcom/dispcc-sm6375.c       |  1 +
>  drivers/clk/qcom/dispcc-sm8250.c       |  1 +
>  drivers/clk/qcom/dispcc-sm8450.c       |  1 +
>  drivers/clk/qcom/dispcc-sm8550.c       |  1 +
>  drivers/clk/qcom/gcc-apq8084.c         |  1 +
>  drivers/clk/qcom/gcc-ipq806x.c         |  1 +
>  drivers/clk/qcom/gcc-ipq8074.c         |  1 +
>  drivers/clk/qcom/gcc-mdm9615.c         |  1 +
>  drivers/clk/qcom/gcc-msm8660.c         |  1 +
>  drivers/clk/qcom/gcc-msm8909.c         |  1 +
>  drivers/clk/qcom/gcc-msm8916.c         |  1 +
>  drivers/clk/qcom/gcc-msm8939.c         |  1 +
>  drivers/clk/qcom/gcc-msm8953.c         |  1 +
>  drivers/clk/qcom/gcc-msm8960.c         |  1 +
>  drivers/clk/qcom/gcc-msm8974.c         |  1 +
>  drivers/clk/qcom/gcc-msm8976.c         |  1 +
>  drivers/clk/qcom/gcc-msm8994.c         |  1 +
>  drivers/clk/qcom/gcc-msm8996.c         |  1 +
>  drivers/clk/qcom/gcc-msm8998.c         |  1 +
>  drivers/clk/qcom/gcc-qcm2290.c         |  1 +
>  drivers/clk/qcom/gcc-qcs404.c          |  1 +
>  drivers/clk/qcom/gcc-qdu1000.c         |  1 +
>  drivers/clk/qcom/gcc-sa8775p.c         |  1 +
>  drivers/clk/qcom/gcc-sc7180.c          |  1 +
>  drivers/clk/qcom/gcc-sc7280.c          |  1 +
>  drivers/clk/qcom/gcc-sc8180x.c         |  1 +
>  drivers/clk/qcom/gcc-sc8280xp.c        |  1 +
>  drivers/clk/qcom/gcc-sdm660.c          |  1 +
>  drivers/clk/qcom/gcc-sdm845.c          |  1 +
>  drivers/clk/qcom/gcc-sdx55.c           |  1 +
>  drivers/clk/qcom/gcc-sdx65.c           |  1 +
>  drivers/clk/qcom/gcc-sm6115.c          |  1 +
>  drivers/clk/qcom/gcc-sm6125.c          |  1 +
>  drivers/clk/qcom/gcc-sm6350.c          |  1 +
>  drivers/clk/qcom/gcc-sm6375.c          |  1 +
>  drivers/clk/qcom/gcc-sm7150.c          |  1 +
>  drivers/clk/qcom/gcc-sm8150.c          |  1 +
>  drivers/clk/qcom/gcc-sm8250.c          |  1 +
>  drivers/clk/qcom/gcc-sm8350.c          |  1 +
>  drivers/clk/qcom/gcc-sm8450.c          |  1 +
>  drivers/clk/qcom/gcc-sm8550.c          |  1 +
>  drivers/clk/qcom/gdsc.c                | 26 ++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h                |  6 ++++++
>  drivers/clk/qcom/gpucc-msm8998.c       |  1 +
>  drivers/clk/qcom/gpucc-sc7180.c        |  1 +
>  drivers/clk/qcom/gpucc-sc7280.c        |  1 +
>  drivers/clk/qcom/gpucc-sc8280xp.c      |  1 +
>  drivers/clk/qcom/gpucc-sdm660.c        |  1 +
>  drivers/clk/qcom/gpucc-sdm845.c        |  1 +
>  drivers/clk/qcom/gpucc-sm6115.c        |  1 +
>  drivers/clk/qcom/gpucc-sm6125.c        |  1 +
>  drivers/clk/qcom/gpucc-sm6350.c        |  1 +
>  drivers/clk/qcom/gpucc-sm6375.c        |  1 +
>  drivers/clk/qcom/gpucc-sm8150.c        |  1 +
>  drivers/clk/qcom/gpucc-sm8250.c        |  1 +
>  drivers/clk/qcom/gpucc-sm8350.c        |  1 +
>  drivers/clk/qcom/lcc-ipq806x.c         |  1 +
>  drivers/clk/qcom/lpassaudiocc-sc7280.c |  1 +
>  drivers/clk/qcom/lpasscc-sc7280.c      |  1 +
>  drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 ++
>  drivers/clk/qcom/lpasscorecc-sc7280.c  |  2 ++
>  drivers/clk/qcom/mmcc-apq8084.c        |  1 +
>  drivers/clk/qcom/mmcc-msm8974.c        |  1 +
>  drivers/clk/qcom/mmcc-msm8994.c        |  1 +
>  drivers/clk/qcom/mmcc-msm8996.c        |  1 +
>  drivers/clk/qcom/mmcc-msm8998.c        |  1 +
>  drivers/clk/qcom/mmcc-sdm660.c         |  1 +
>  drivers/clk/qcom/videocc-sc7180.c      |  1 +
>  drivers/clk/qcom/videocc-sc7280.c      |  1 +
>  drivers/clk/qcom/videocc-sdm845.c      |  1 +
>  drivers/clk/qcom/videocc-sm8150.c      |  1 +
>  drivers/clk/qcom/videocc-sm8250.c      |  1 +
>  drivers/soc/qcom/rpmhpd.c              | 19 +++++++------------
>  include/linux/pm_domain.h              |  4 ++++
>  92 files changed, 161 insertions(+), 20 deletions(-)
>
> --
> 2.34.1
>
