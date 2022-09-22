Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89545E6880
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIVQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIVQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:34:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491993DF36
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:34:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r18so22230027eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Im4t9lnX5R8DyS/Oqe89/5RcWfGnhyqZe+p62UWe9Qo=;
        b=Xh7fkD8mev4MAGIdOZHvcOICVshIyRbeR0HigP2a9U/aMnCKzZ5Uctq7lQBfqZSZOf
         7obnHbGc8GXP7p+qEAJ2MZsfGsSP3qD2wR4Ud70TzcdKV3Lu1z+VwryD+FscawLJsm2R
         0n8MmSvs111TR+ULATFWpPn6MLHtWVGxNSD4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Im4t9lnX5R8DyS/Oqe89/5RcWfGnhyqZe+p62UWe9Qo=;
        b=rRF6YcMhkYf0D+syPuHQxvjR+xStzoVXfYx3iatbwAxOs7IkQ/cEGmID0jWQpCytcR
         OUP0oWwvczGtJGGhK0uurF7QNnRLiCTT3hJWrDjpF30FDMS+NpnVkcGPfiSPnTCuBT/w
         nWXefWLx5xahGLECXoxHSQjf4h8MggfuCVah17GbjyQknVOWzeE7mblZsw1rE/s0mv2t
         R/0p+hD6Fa3YKWUhalkQzKYSyF4Zlhr12CsPCBHomGmqvGFaDlju6HGhw++sYZgIvpNM
         yAqIV4b3p4+24KjsW+8rMssgt4FPo2pfJ/TauHbtx/ZdMo4vS3kYSbU4kbQBuyF2WV9W
         lAWw==
X-Gm-Message-State: ACrzQf2bIfEKYFNrfn1knYAHF4BHf+5qMJcefU6qlIH7690O+ksvUJyl
        Ysww1M61b+O4tXk7q+zwJl6xELfF5GNaDdf/
X-Google-Smtp-Source: AMsMyM6pKTxpjDByu2dlEonXZkjQliPMO1kJFIeVx9qwXL6TgQuM/OO0B8X+mp4XA0K5c5dYGRc9+g==
X-Received: by 2002:a17:907:7e9d:b0:782:3601:7d01 with SMTP id qb29-20020a1709077e9d00b0078236017d01mr3480447ejc.361.1663864459585;
        Thu, 22 Sep 2022 09:34:19 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402034e00b004478be33bddsm4002520edw.15.2022.09.22.09.34.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:34:18 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id ay36so7179408wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:34:18 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr2841969wmr.57.1663864457846; Thu, 22
 Sep 2022 09:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220922101813.v4.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid>
In-Reply-To: <20220922101813.v4.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 09:34:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XiGJ27sGaAPafQW2B3yJe_dSPp55nA-+YFHZ29BPwPgQ@mail.gmail.com>
Message-ID: <CAD=FV=XiGJ27sGaAPafQW2B3yJe_dSPp55nA-+YFHZ29BPwPgQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: Add sc7180-pazquel360
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 3:22 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> Create first version device tree for pazquel360
> pazquel360 is convertible and the pazquel it is based on is clamshell.
> sku 20 for lte & wifi
> sku 21 for wifi only
> sku 22 for lte w/o esim & wifi
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v4:
>  1. Adjust the 'Signed-off-by'.
>  2. Add touchscreen setting in dtsi.

Just to be clear, I've looked at the differences in v4 and I'm still
fine with my Reviewed-by as was carried by Yunlong.

Also note that this should be the last patch in the series. The
"ekth3915" bindings are relevant to it and bindings should be earlier
in the series.


-Doug
