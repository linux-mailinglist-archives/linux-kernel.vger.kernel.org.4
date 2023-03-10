Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B90D6B38BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCJIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCJIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:32:08 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74AE8CCA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:31:58 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bbe5f888so84032557b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEnDDQC7GhZEI1kmJpTuNmo6i9voSvFWeItpPldUIYU=;
        b=cD7vD9Z1570thbPMT0MfQRnKjBSUb9CqZPM0xYCHqCuvP1TriRXZTLOaJQg3e0j0xv
         vF4UXxoWFEUhYG+S6iyTO/cS8Zk14IaLq7ewYCEX1hASo2mZFUmguU9VaPAQCB875cwn
         CyB9mXKtHUvw5UtoA0m/qoUAJpmelkAV865sn4UcYuqFYQEvX1W69b48IhZurvoINQ+7
         Jl1Tgz4+nJyiGVY32DVZ8n4lWyvH/+trpIXJ8pPS+2Fi4tNU+Y7zJsEV8Tbb2f860jte
         YaMWuNzBgBxa9SlIjIAxc3jCX29lk9eJsoS3YfRLlMzHClXKezdNcy6Nmw0MoKukiirW
         /w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEnDDQC7GhZEI1kmJpTuNmo6i9voSvFWeItpPldUIYU=;
        b=OJSlUEkq+g/O+TncmdUhbJjtLCKWspVi5t7L0WYKdf+aWgG3fr31ldaTIjBHuVGxyW
         1cTfLYFnDL2cMWf1x/6kEDUMDBDp1nEZgyjL+hMbGPB1cjEuPhcqgnSvu1DNeGB5HifH
         //l9Tzmn+MmKaLCv923nQtId/Rh1gHPqPpSQLmFQzV+y5pIXes8RVqOodHixj5/rKzya
         9ZD/btGdjCBHdQdsgeCRMJq+g06B9fgAUJhidt8jqRK/FY+sewqYlqbgCvPsyLJar/qN
         4GFpiwSD7XAD1DhWGesF5GOjJzLIy6T7u9nO9/Ore6cKcuKEMdXyjpaxuzkaiwUfycYY
         Zvlg==
X-Gm-Message-State: AO0yUKUACJMEvx9TxfZPQclS70JoSbSRaG0d2IYOQ/nXHwGRW5bxN+GM
        RJ1Qvje988DYVJtL1BaCtwaaX3hDuMQTv0RjoXutfQ==
X-Google-Smtp-Source: AK7set/dzMiqf5mSy0pANYi5bUztGCql2W6gCMXtz6HB1aFjDIVxaXeUN9JRSGvg7YJ9h8wxNHPwjjTrVbv03zrk03Y=
X-Received: by 2002:a81:b705:0:b0:535:fe26:acc with SMTP id
 v5-20020a81b705000000b00535fe260accmr16173406ywh.10.1678437118046; Fri, 10
 Mar 2023 00:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-10-sre@kernel.org>
In-Reply-To: <20230309225041.477440-10-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:31:46 +0100
Message-ID: <CACRpkdY5kzCm5fQgoXQBV_mAGYQP2rvjgc9cdLQwfFhO7LKdYw@mail.gmail.com>
Subject: Re: [PATCHv1 09/11] power: supply: generic-adc-battery: simplify
 read_channel logic
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Drop mostly useless gab_prop_to_chan() function by directly
> supplying the correct enum value to read_channel().
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Looks correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
