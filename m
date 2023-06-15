Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB37A7322AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjFOWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjFOWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:23:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA87294C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977d7bdde43so35450566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686867815; x=1689459815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXs/FAzfDAPWyI4Y95NmlLp9vPjbZFgrVl2RswLT5Fo=;
        b=NhFSL8sGrc9NXuNgtdiy8tyD3fyf6SbX/zbB4U2dFZwBi4YDyrfdd2Fw6VtJ892o2p
         4WZpjxBWUhTFkQxmZ02mXlx0NEMYY8vGR1G2zPOaT2egCTktNmd92D0G9Zwlm5/qdnHc
         HumzS8TkWejVwFFg7xzXzFwa2GSvclV+Zw5Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686867815; x=1689459815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXs/FAzfDAPWyI4Y95NmlLp9vPjbZFgrVl2RswLT5Fo=;
        b=fHyrjO6vei2qHCOda5JE+bbO5M9ssSOEZscV9TCcujpxYAdfTPCVOUdEaeyKm6RkxV
         kYF9B7WBPaQrqKASYoKMiNxbycClMOxMR4N+9e2EzwM7JpfpaNOzMBM+LtBFQPzK9Gq1
         QrF9SH0yzvm7+M4ePGLOCpDjhlEu+FOQCEY1UlnPBzGQx2mTgmZPNYDI35KI0OsGNdIG
         KWuQiuc36XkZgWcHy1vMgyhGKbd8AGAnMGwFQRncn3NVne6u8S2ntLbzIuBGHqohOwqX
         f+hPgoJfJFx6OVYFbf/vWagpdxzwDT663gy8lIdxTECQUm3X8bFMQGOywIH1ozjoYsKd
         Q/UQ==
X-Gm-Message-State: AC+VfDznef/4XKiSriAN/flY2YWlM4LyfACjkZuBFUCao2V9bavfUZbZ
        saZpb+4JCAR+mTPhoMj7Vsf8tbkyRpx/DogJ3HWllrNg
X-Google-Smtp-Source: ACHHUZ5jCmqj51ahvnuamTtYNQgqbuNKXPwokwoC9XfTlmcKVtZ3SJP2CAVRr2vZlPlMv/XETf3XFA==
X-Received: by 2002:a17:906:4fd1:b0:97e:17cc:cc95 with SMTP id i17-20020a1709064fd100b0097e17cccc95mr87279ejw.36.1686867814766;
        Thu, 15 Jun 2023 15:23:34 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906b19700b009746394662asm9900355ejy.53.2023.06.15.15.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 15:23:34 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1669a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:33 -0700 (PDT)
X-Received: by 2002:a50:999d:0:b0:516:6453:1b76 with SMTP id
 m29-20020a50999d000000b0051664531b76mr164183edb.5.1686867813115; Thu, 15 Jun
 2023 15:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
In-Reply-To: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 15:23:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcWqFyz9_76s5uXfQQpxLMsivWZtTDqAa+2wOpUzHsLg@mail.gmail.com>
Message-ID: <CAD=FV=WcWqFyz9_76s5uXfQQpxLMsivWZtTDqAa+2wOpUzHsLg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
To:     andersson@kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, sumit.semwal@linaro.org,
        Will Deacon <will@kernel.org>, amit.pundir@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 15, 2023 at 2:59=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
> normal TZ. On TF-A we end up mapping memory as cachable. Specifically,
> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE. Apparently
> Qualcomm's normal TZ implementation maps the memory as non-cachable.
>
> Let's add the "dma-coherent" attribute to the SCM for trogdor.
>
> Adding "dma-coherent" like this fixes WiFi on sc7180-trogdor
> devices. WiFi was broken as of commit 7bd6680b47fa ("Revert "Revert
> "arm64: dma: Drop cache invalidation from
> arch_dma_prep_coherent()"""). Specifically at bootup we'd get:
>
>  qcom_scm firmware:scm: Assign memory protection call failed -22
>  qcom_rmtfs_mem 94600000.memory: assign memory failed
>  qcom_rmtfs_mem: probe of 94600000.memory failed with error -22
>
> From discussion on the mailing lists [2] and over IRC [3], it was
> determined that we should always have been tagging the SCM as
> dma-coherent on trogdor but that the old "invalidate" happened to make
> things work most of the time. Tagging it properly like this is a much
> more robust solution.
>
> [1] https://chromium.googlesource.com/chromiumos/third_party/arm-trusted-=
firmware/+/refs/heads/firmware-trogdor-13577.B/plat/qti/common/src/qti_sysc=
all.c
> [2] https://lore.kernel.org/r/20230614165904.1.I279773c37e2c1ed8fbb622ca6=
d1397aea0023526@changeid
> [3] https://oftc.irclog.whitequark.org/linux-msm/2023-06-15
>
> Fixes: 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache invalidation=
 from arch_dma_prep_coherent()""")
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Shoot. I just realized I probably need a bindings update too. If this
looks good other than that, I'll post a v2 tomorrow.

-Doug
