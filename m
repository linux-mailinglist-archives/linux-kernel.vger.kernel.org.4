Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D595EF313
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiI2KKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiI2KKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:10:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C25E563
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:09:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 4so954820ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jeUTM7DFBoz7PLwWwa1BeBsJ9kV5jVLDyMertW/d5ig=;
        b=L26P3SIm2tTN+4cZIEP7GWktPtbGxaDqPIOtWOnPexIMm1BzN7s2ww4bKoklpELEt5
         PRACvw5LeLKzuv1qpmH8eohoe0p1cyYOaENVN4oWAodjV56aMndZKZ6N4fQpySMItlnn
         YPf40QjO4wSU967BIT+Gkqes/LUNwNqakoDkR+n2MR8iify0sQSQuJW1UztwLmRSkuKv
         wCglpgfleEFP/mi5p322f+kPlyhonQQMZ4W2FdBNTywCFUIDBPoD0k4r9xHnXq7zZKdy
         bezkD774RY9+iHR2uikw7sASBiv/kTBR+ojBiZuSRKy1Ch8qFyeb+asHpUEuwBD1nD2r
         /GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jeUTM7DFBoz7PLwWwa1BeBsJ9kV5jVLDyMertW/d5ig=;
        b=DqjfNTepm3in91l/uzYmUJ8WZXwqzAeNSmgPkpFctvMhcqbcEpRYl4LkwGQDrU5MVt
         QMVP69NK6ymB1eHNMATm1WnxMTIJJaOuR6HuIX0VmwTxdqLxi34i5TgNgVWJ0akUUyGC
         J73h/sEr6jAHynxUfe0nUeHzNfdsFHeLhHMVadWET5kvX/xGwKH3+yJtNUNYessiKpLO
         kfTkW2RS6xWKi/AAMnHHoyUzoZHfD4UgVApEifnXZl2/Ujtei9VV7DiuqUCLYshMVhSI
         NJ3T13OBLoEELg89xHPQyMs6qJpQt8oUGrO/eXBSKp+pfV3oC/+G4D0gxhDsSq1/YVwa
         C7Eg==
X-Gm-Message-State: ACrzQf2NrnWG24JJNIX0C99LdIj9USZNsm0sZMpgGxM0+t1qSnttmMNB
        NLpQC8S/9yjwpUtJFIT5vtG+Qg8GWr99I7Yp149H4A==
X-Google-Smtp-Source: AMsMyM7bGcje56QfT0SiahpE0KKI3Eo9XTeAq2kxH8gsm/VHDTd9kGNI7Sw9FFyYjfuxfH4/EiUYyV+VRFb0PjHoRFk=
X-Received: by 2002:a25:2e4e:0:b0:6bc:ac92:a4df with SMTP id
 b14-20020a252e4e000000b006bcac92a4dfmr2385840ybn.153.1664446197322; Thu, 29
 Sep 2022 03:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220929092916.23068-1-johan+linaro@kernel.org> <20220929092916.23068-5-johan+linaro@kernel.org>
In-Reply-To: <20220929092916.23068-5-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Sep 2022 13:09:46 +0300
Message-ID: <CAA8EJpo9U-vYU1tJ5FGw1gM9kE3tb==nno+N+QaAqEQyWX9Ozw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] phy: qcom-qmp-pcie: clean up power-down handling
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
> Always define the POWER_DOWN_CONTROL register instead of falling back to
> the v2 offset during power on and power off.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
