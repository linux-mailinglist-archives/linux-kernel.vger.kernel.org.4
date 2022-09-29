Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF35EF305
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiI2KH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiI2KHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:07:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F759147CDC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:07:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 126so937858ybw.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6P2cTknVyAGavRlD+4eMAUvWg3EU64xB/MzdvQ6eJEo=;
        b=Mr0hHY25uWS/mzDOzdRpAXl8R7VGuP4kg0xBwT4V/d9SnLCA0A5tHrk1adD7v3SnJ/
         s0zDwqEB0WKkZRrH6hMCHUMaJk9kpNyjChl9BeFHaBYweiCfARHmKqKA3QhBxeFX6OA+
         D/5yN1FzmTqzKM8bS68xBJ++Pzb0TcBAC7gI3mKmmwBJiYt9HZ1jnVPFqSs4GB5L0exU
         1W4M6NO6ERECu0iETHzedRPGyYirhLtBBBlbumILi3wkfYl3Eo6dL/+CbtkIjiK5JdY3
         ZZAiloIEalCuQJ7QFRyrT/ZacJzKHF6Pt68RK61ov017ULboqSJwwm2YiBhZ+lgF9vme
         kykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6P2cTknVyAGavRlD+4eMAUvWg3EU64xB/MzdvQ6eJEo=;
        b=d0xCdFe1y8uRIaam49Jzod+Ch2DJGEjVDQxINnBT44im+ciTic9r0C8AUbRQExUhbW
         DcCfVEaaSCmOXgTGNDz97vgyH/m8XmUYd7mKvTMi6nHjo3QpDDAoLyjCgYYpiKA2pOUN
         Wi9TmRAxwrjINHrsCVsY7K9TE0Q4/BcXbBjuPF5fle4HSzaEFKYGgMEWxLYjQFCqr7P9
         YPNt/ig8cOk/1to3Dvza/GYqaNW/oJjErzpCJq2me0ANxH1+bSx1sL40wb/FIYFXYr2t
         DBU7oPIDTCAZy2RFYE+iSsZBCD5+vFHO28da7dlpZm0Hs0+Fa21Dv3HLwh7/qoqznv/2
         JAgQ==
X-Gm-Message-State: ACrzQf3nIMsGutiE4TL37lf74MZNSxa30F4lWXSzTJBgxJnax/R8dChi
        68giHUSGh+3GdsE5rZibnAzQap7r3KflGvSZfAbp/Q==
X-Google-Smtp-Source: AMsMyM6D7SqrPmQfsbrIbYDPacs/gjDFTKXsYNUovfxlVQCoXY4xCWnklSmGugX8OW+YECAv0AUBs3whESatrlacJZY=
X-Received: by 2002:a25:a502:0:b0:6bc:2835:a88a with SMTP id
 h2-20020a25a502000000b006bc2835a88amr2355273ybi.15.1664446043618; Thu, 29 Sep
 2022 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220929092916.23068-1-johan+linaro@kernel.org> <20220929092916.23068-7-johan+linaro@kernel.org>
In-Reply-To: <20220929092916.23068-7-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Sep 2022 13:07:12 +0300
Message-ID: <CAA8EJppf5JkYYiCvjdZkPvKQLSP+F=fwEu93U8yD325ES8Mzcw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] phy: qcom-qmp-pcie-msm8996: clean up power-down handling
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 12:29, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> This driver uses v2 registers only so drop the unnecessary
> POWER_DOWN_CONTROL override.
>
> Note that this register is already hard-coded when powering on the PHY.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)


-- 
With best wishes
Dmitry
