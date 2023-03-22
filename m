Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC66C5398
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCVSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:21:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0664B38
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:21:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l7so2082261qvh.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679509298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQxrNvV0gZz9GBG9UF+uE91SUr0DwwB7YS1OCSsuFvs=;
        b=bNAfFCJqMTkggLNKfUj1q0Zq+gK2p5Q+aazaYH3jwv8Y5uFEsXIl7gbwCQtaHQS93R
         Di+Eq8N8Z8L8sERhLRldvdy2TWuXa6g9YN8T++BzB9sA9lUEqQYw8ksTKQ9IGhxk8+6c
         daZsvBVl2XsxbOui2jr4yZ3rMoxcBNWJPRUXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQxrNvV0gZz9GBG9UF+uE91SUr0DwwB7YS1OCSsuFvs=;
        b=2nCn/U0b40Ehaz5e60VUZIrrjPgx5NvVydRaAHoVF+Fjfs08Q722o6iUsUt25akupk
         xqcs/XnXqKMhV91swoPDrSHEZ316efzjtuyf/ISVbLUD4tnnUW/OxMZtBmhisPVtzetT
         4TWwq7/Y7qf9rT9oaaiY8Y3FqT0l6wt0WiOhvaaZhOA5JxtJREe0hffUW2ujUr0OyVqg
         26klhC6x6Nmoyq0glF+IhtyauuBaP/HEch5/rRr+nVKMIHilXT6IenOi9kxOlohmbE+W
         SpJDuniIOYZXE5dwPmHnedGwKETzng5IbAWkwUgDWJPhP3nZNb7uWzKT5ZX0oEcsap34
         lWhw==
X-Gm-Message-State: AO0yUKUG+UW5psnMCbLJ8rFWCzMy0/Gvr7fjRuV/yvY+ge+UMpMI/Cva
        ZfBVytK0Dr1S3amoEonjeIm2gUhPFvDYkDq5qMM=
X-Google-Smtp-Source: AK7set9gClCfkM7GMAsosAPmVGjlFLfsV8+ddzx4H3UV/VuyqS84/iHtcuwH+7tNdMMQN7gBfseRNw==
X-Received: by 2002:a05:6214:1cc1:b0:5ab:7b00:9b6e with SMTP id g1-20020a0562141cc100b005ab7b009b6emr7249698qvd.0.1679509298685;
        Wed, 22 Mar 2023 11:21:38 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a025a00b00746a0672cf3sm2521902qkn.94.2023.03.22.11.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:21:38 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y5so22130060ybu.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:21:37 -0700 (PDT)
X-Received: by 2002:a05:6902:1081:b0:b21:a3b8:45cd with SMTP id
 v1-20020a056902108100b00b21a3b845cdmr549657ybu.0.1679509297542; Wed, 22 Mar
 2023 11:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org> <20230220095401.64196-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220095401.64196-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Mar 2023 11:21:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzU+TzHdsdruH_TaCVpwhsHBWPn9LMMTUORVPL08VyfA@mail.gmail.com>
Message-ID: <CAD=FV=XzU+TzHdsdruH_TaCVpwhsHBWPn9LMMTUORVPL08VyfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280-qcard: drop incorrect
 dai-cells from WCD938x SDW
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 1:54=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The WCD938x audio codec Soundwire interface part is not a DAI and does
> not allow sound-dai-cells:
>
>   sc7280-herobrine-crd.dtb: codec@0,4: '#sound-dai-cells' does not match =
any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Like with patch #1, I'm pretty soundwire ignorant but this looks right to m=
e.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Seems like folks who were involved in landing the patch that
originally added those properties should be CCed on this, though.
Adding them.

-Doug
