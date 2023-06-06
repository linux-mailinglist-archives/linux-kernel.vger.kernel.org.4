Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD27238D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjFFHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjFFHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:20:37 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3BC118
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:20:25 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-45c6c5ea666so1265556e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686036024; x=1688628024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aznv3oFTVvxn0OuZbUQcyVpvGCRIQmh+X3GwU5kUzcI=;
        b=pqCnRJRCwqhZlMoMMHMibVJA/xuevTSeutUDFwF61VwL8ko3pMujyGCyCSRM03bNMG
         9APZmZJ7/BQKGYe6TmoJcceN0HImz62Nb0KcRrZrpii6MSpie9veyWq9j5rcqmNQwbFK
         3OKktcRQEDsJM8Mk0z2zsIU+0IA6VP0KawfyhzlaVuqQnE48r2cnCmMcwhhcIQ2iWp9b
         +lCBsJGng/U4AlbJFP9Finf6omnSqSrzyynY+TaMN+TBC6Xmc4zdehjhizMoGZL9claE
         rrnnCmQn8wuvjaxz8/FWh3GHzE1DmE7gmGajaXXkLewaiWiiBmJoyoDo44kChVjVJt8C
         T/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036024; x=1688628024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aznv3oFTVvxn0OuZbUQcyVpvGCRIQmh+X3GwU5kUzcI=;
        b=XsJViocDHjPlFuNd1YKaCsHh2b7/4mSLTcjWyvP9MHIc4OPKF7nSYqK6CmYt23U986
         fjecyDlciI+Gjjvl/qHr+rihp/+wTyMx8aAfezYf/GBam4bq4lS2zpsNqa18NIcjN+Bd
         34pU5F4/QJyERrnonhjqu4SFPZMroZmI7IxrdfqQqcdmFS805SugSXPH5O99UIqMMLf0
         kRK5xTgXx5ntGflgNfqDQBJkFJIns9luOePPCJt5szSNyiOT2MBOND55QemgCauVzpjk
         2M94nPsNCdKJK8/QN6nmYEcRbcnJeJ/1lwm0d8WyxVVuDdi72V8Bx83F7kgF7+srBM9o
         sTfA==
X-Gm-Message-State: AC+VfDwePMqixcSxj3q9+g/gzBQbCbcRUwrK5R1utAKkW64ShcYyGRhZ
        CGqEV/u5KwBO4CEMhMNdyuYh/Z3eeADOsWYQznTd7g==
X-Google-Smtp-Source: ACHHUZ611b6fh0JRo/6OzBszVFi42muiyHcQzpD7oR3k3oIsTKXQ7ahb8V/9G7hauPfbKNUFBwLbN7riniMmmKT0bHw=
X-Received: by 2002:a1f:dd02:0:b0:45f:ed55:4cca with SMTP id
 u2-20020a1fdd02000000b0045fed554ccamr353486vkg.6.1686036024433; Tue, 06 Jun
 2023 00:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230530144931.188900-1-brgl@bgdev.pl> <20230605153928.GB21796@willie-the-truck>
In-Reply-To: <20230605153928.GB21796@willie-the-truck>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 6 Jun 2023 09:20:13 +0200
Message-ID: <CAMRc=MeNrgcV_mCM-1-OgJvRGygAAEVQpvS1W2+26CHVpeHhNg@mail.gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 5:39=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 30, 2023 at 04:49:31PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The GPU SMMU will require the clocks property to be set so put the
> > relevant compatible into the adreno if-then block.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Resending with all IOMMU maintainers in CC.
>
> I've picked up the earlier version (which is the same patch). There was
> a trivial conflict with a similar change allowing clocks for the
> 'qcom,sc8280xp-smmu-500' device, so please check when I push out the
> updated branch.
>

Looks good, thanks!

Bart
