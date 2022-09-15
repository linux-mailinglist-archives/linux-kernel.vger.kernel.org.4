Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739CC5BA27D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIOV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:56:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF38E0C2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:56:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 198so24749420ybc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JX9fTkq4tugLO6FL9ET8mX9f3rZGcI9uwJUlh9oT3XY=;
        b=Srf1ZQSyBr19coh7nj2aTvsXsaOIS/oIKx2DhWYMjU2NKDO7WQxtuGTyglZAyVrbnA
         Uj/QMJC9CSd/l8iFJ01p0tKtEQ2U3EQ1koMIPvAMFp+bkgD9LSk2v4N5YUW6f0QaOtV6
         wNOeA+4BkU6iyumZrZM3oEk9Yms7pfcFdJ7lv4GYqYCQBlPSjMBmN6poh4GpTuqPLFkC
         xxET9x6krRs2nQphspUHs/BSeGBOUacsRnu37Feuj4i2VWkopcNB2lmCowlOYbuR2oZg
         gQvY4ekhDQBXCFgg95GiWFo5hGHp0lFHQSZtNZWxf7ljc1wHsjtg9RZCCXOCFcGiMF5X
         ANqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JX9fTkq4tugLO6FL9ET8mX9f3rZGcI9uwJUlh9oT3XY=;
        b=qXdIp/CyWh6xkq3u3O17eaKjlOlsINEPi3dFMC47N0KBGnSgQyrSIf7Uqi5wRDSaFH
         lvxza0n3Znmy1TWqpPnYh/5mhVzkzFMoDZcCkI3hct7XekKDJ1JkJ7DRJAhmpCzsPw3Y
         O04nRpAOTncS9UCBJTb4EBgslxvpV769YmRpFONm/Qk1A+9/pYAoF6gTQXXRGCSL/Kcx
         zBOoTX48bQLrFRGH56oMiojz8Y4TXJOKwcVcuduYBYjSS4uk++qjmONMpjgp1wYfHfpP
         Sy17YxtwJ9YkF/HiP326/of9V5JyyxaZmAIPYIIE56ULeThdTwGmoPXP+Y/I8z64xZrL
         nhvQ==
X-Gm-Message-State: ACrzQf0I09686lOPiRPPveeyh3QsBIkfZqdua83y+IgUtOdptuvFqU09
        lQJGVmrArUxHjWUZb0/L1mov3BGjjWNts5XmVrb08iFeqPc=
X-Google-Smtp-Source: AMsMyM7v2nmvHmfbjX5rLUALCSTtuecAYdmFE+aJnXkmcOJa5iDWlDanh9g4UOjwuvBWDm4ZbJzoju1oeXo/moiWjjc=
X-Received: by 2002:a25:af13:0:b0:6ae:3166:1aee with SMTP id
 a19-20020a25af13000000b006ae31661aeemr1717295ybh.288.1663278995367; Thu, 15
 Sep 2022 14:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220915204844.3838-1-ansuelsmth@gmail.com>
In-Reply-To: <20220915204844.3838-1-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 16 Sep 2022 00:56:24 +0300
Message-ID: <CAA8EJprvxZrK2b1ctP5dtgK7eKFTj09K_H0=2tgA5--oVkR1ew@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom-adm: fix wrong sizeof config in slave_config
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 23:49, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Fix broken slave_config function that uncorrectly compare the
> peripheral_size with the size of the config pointer instead of the size
> of the config struct. This cause the crci value to be ignored and cause
> a kernel panic on any slave that use adm driver.
>
> To fix this, compare to the size of the struct and NOT the size of the
> pointer.
>
> Fixes: 03de6b273805 ("dmaengine: qcom-adm: stop abusing slave_id config")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Cc: stable@vger.kernel.org # v5.17+

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/dma/qcom/qcom_adm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


-- 
With best wishes
Dmitry
