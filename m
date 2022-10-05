Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317A65F5884
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJEQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJEQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:44:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CF356D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:44:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so36672011ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m45nq82Lfg1q6SNEw+KpGC7tj62Q9fUk4yU+5lXbo+o=;
        b=BDVZ2OiPMtg3p8vNbCwNKMoZwzFiI8iqqHYTG/Ma3vjDZNKqDlL6WyURzS7u3yFW0d
         JXjp3AskuTWetb7SNYos+u/fRVWDAT1H6e0bOm+xiCDoWVpifr4i/sQSxJSkh7V/XsCl
         9tKYmGNsotYqjf+XgrdIzHLwKZNs7XE3V9ZWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m45nq82Lfg1q6SNEw+KpGC7tj62Q9fUk4yU+5lXbo+o=;
        b=4mv/W61yRT6N4bBcSV3DK/vNKF1ZPqOBOyrXLzzuMESlQHlczbrWopZOTPhWc91t9M
         jphCHy0SAWYBcQHMaMQsYTMCwknJH+n8BtF2u1cOo2JwmidIzr9S6xBNrMwi8Vf5/yQJ
         nSIIUfYYmauWkYtDWC189IWl+lcFkLDywbuvefV3xZPLyQK3f5xOpmdBPlUjEnzhEZ9b
         BHuAk4cxNHhg2blyT+AQLH/iXy5JFwY3Mj41eG7o9XabwvQmDKCezXdPq4qLmr4sMcoF
         o64DdrGe3lwr6jnKnVSbO0TtfiBYgoXOxvXuejHr1QXEHTSFtxKxFqF+TjH770ffzYtK
         3RZA==
X-Gm-Message-State: ACrzQf33ND/MvOS6e+Mxe+X2L72aNEyQi4N6v3DwQnrprSRQfTPB4RJh
        bM5LWGOArZoHUxqBOrXIaCSc8NfNaUpkOvJn
X-Google-Smtp-Source: AMsMyM7vmZtvRW8pPwFEq7mMlqikk3TwFSkRhBk62FdovebRnWPJjWe3O8J0gTauR6d4RifH9PjfZQ==
X-Received: by 2002:a17:907:94c9:b0:78d:3544:ff0a with SMTP id dn9-20020a17090794c900b0078d3544ff0amr396704ejc.386.1664988246508;
        Wed, 05 Oct 2022 09:44:06 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id j14-20020a170906094e00b007417041fb2bsm8871773ejd.116.2022.10.05.09.44.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:44:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1377691wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:44:05 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr295066wmr.57.1664988245013; Wed, 05 Oct
 2022 09:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221003182637.v6.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
In-Reply-To: <20221003182637.v6.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Oct 2022 09:43:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vs5qjOkNS8zjqdJr+8o_h4nArA7s3XwoofrPaOsF6n4g@mail.gmail.com>
Message-ID: <CAD=FV=Vs5qjOkNS8zjqdJr+8o_h4nArA7s3XwoofrPaOsF6n4g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 3, 2022 at 3:28 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> evoker will have WIFI/LTE SKU, separate it for each different setting.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - new patch add touchpad and touchscreen for evoker
> - remove unnecessary whitespace
>
> Changes in v4:
> - fix typo in tittle and commit
> - remove change for trackpad and touchscreen

No need to spin for this purpose, but your version history is a bit
confusing here. You should be putting the version history in the patch
that changed. In this case the bindings patch (patch #1) didn't change
in v5 and the trackpad/touchscreen didn't change in v4. Those changes
were in patches #2 and #3.

-Doug
