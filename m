Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F85EE306
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiI1RZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiI1RZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:25:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2732063
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:25:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x29so15140084ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=LLveNPC/uBKK+oW5nMcZ4j8fgkAZZZSanakE2vr1K3U=;
        b=DF75UBCgCORqNvJeBnIRoGdgRm1Qf/DBY/8DUJQ0/nGYJZ4dblozIgLxYWmktMl+ni
         pMKyf2sRTaFelJzfkU0QOF/EQ+vmh+PhqJKcoIRCa6l4SAWOWOmFTzFhYM5bfV3HzRlX
         cBNe0H6cDPXLJT50YZFnyV2I0JwSUiM18P9I5Zw9FrBSp4nQqIL1YFnTUQL6tDnGKZ8R
         kk0fvuK8tg0h8lREj/seyMbkt9+IPY1+vO+tkgkY8J6NwLISeXsRo3ya2ZeqF3NEfKvE
         GyBh40dPXFN5YH6AlVPSxDbfoP2h4XcO4JbWwia4Aw0Ohhmz9OHmqs8iKig4FA0VAbSr
         XobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LLveNPC/uBKK+oW5nMcZ4j8fgkAZZZSanakE2vr1K3U=;
        b=U+18eVLrf1Gx0r41zAQXNOgKThP+TMxufnn+Bi1LuKbhMf1mmu4XbzfeEuLXYy7oLz
         OqWKJxxrZts4ag81iwVjx7QBtt/I6eTcVBMArMW38USl2D+Wh1yHgYviR2aG+JJabMs4
         ufksI6Bz+Y73Y7y0pcV5DalwP8mmpGJPr1hZhed9rKP+ArnwqZ23RtWz9Ra1itAuASQj
         O1kzotBvcSBd01fAlES83ffrxLxTfJDKGkFAdBtdGCiEpP5JJONS0TMAvrsHKZ6zkTka
         kfCZnNDRSatxQ86b17+Q5fjTdmOIIsAf3Nh4LlD3pavDrgTUmxDIOOrNzltVwKhQpbKE
         GrWA==
X-Gm-Message-State: ACrzQf0ASlirKX+J9bWoqLzS08XtJy3OyWR5oBNRMRxUO3YQu12LY7AP
        fny23oHbpN61uxN6KbCapgN/aQ==
X-Google-Smtp-Source: AMsMyM7RW774YN8ALEcVWSVPaktJMWCyv4As8SHHLXGQagPlqVLdtHEBDYK691kHI8HOg1NMASUeKw==
X-Received: by 2002:a05:651c:a08:b0:26c:539d:440a with SMTP id k8-20020a05651c0a0800b0026c539d440amr11804380ljq.264.1664385909038;
        Wed, 28 Sep 2022 10:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.4])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512202200b0049480c8e7bcsm526986lfs.176.2022.09.28.10.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:25:08 -0700 (PDT)
Date:   Wed, 28 Sep 2022 20:25:05 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] phy: qcom-qmp-combo: drop unused UFS reset
User-Agent: K-9 Mail for Android
In-Reply-To: <20220928152822.30687-3-johan+linaro@kernel.org>
References: <20220928152822.30687-1-johan+linaro@kernel.org> <20220928152822.30687-3-johan+linaro@kernel.org>
Message-ID: <EB4CF062-87D4-4FE6-ABCA-526E7C8F4F4A@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 September 2022 18:28:11 GMT+03:00, Johan Hovold <johan+linaro@kernel=
=2Eorg> wrote:
>Drop the unused UFS reset code which isn't used since the QMP driver
>split=2E
>
>Signed-off-by: Johan Hovold <johan+linaro@kernel=2Eorg>
>---
> drivers/phy/qualcomm/phy-qcom-qmp-combo=2Ec | 9 ---------
> 1 file changed, 9 deletions(-)
>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>=20

--=20
With best wishes
Dmitry
