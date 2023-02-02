Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D336879B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBBKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjBBKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:03:04 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EC3A8E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:02:58 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-51ba4b1b9feso19073567b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yJzW53IuloyduIjuDpeyHuvtPwbWveSeqDHuN025brk=;
        b=Vks3Bu67QVtaZjqKEf8VZXwCPQADEPehhWMW7nERW8os1q6BoKGZqlPJTx8hfSzRHU
         y0+pubSYKycw87QukXP7xxV3m88miJ+fYEibbpDN3Vg0bLUXcujLTkdtrGQ6YNAvjZQT
         xkyC+CxEm06wtkfExPFUMuDANE7A/M319en6ITK7iKrCjXwmihiwEuQ/pkczMIZlXDfc
         OT/DgiPuX7DqtAKIIiS9u6BG2mkeR0xpX3AQtoxXXY7/KL3y/nREt3Ld9Zu0x/crL+oY
         nCEmF9wduI3ahiUvWj/WVIvQ1/7Hv3IbGemo65x5RGQZ1WI9C7feMGLG1RmDpFOn0BN9
         /zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJzW53IuloyduIjuDpeyHuvtPwbWveSeqDHuN025brk=;
        b=Ft9D4vJH9nBCLpWavQMQr9qQRKEuh8RyvnMPn9iYmPWPWbZpMXy5hhdhTFMQha6lhl
         n4yzK7FLI5mdxRw93K7d/HA3o7LrkqXPRcvT2WjsmprF4fp/t7O4EDUxsL6JlsEakxNR
         QqHXNeJ1IyVZJ3HMq1m7Nrpw1Hx3PwFhyzGInIWrsHkgVyqEbtHwjMerZ4nRFjoowU4N
         2Z9sD/9Pm0Pft1mPZQ0xbuZ1Nfxoyua/1jt//XpcXvkZQIGct3ojJAdw80lxghoTEDRG
         nPN1NSp2P0Sgr3kiC6iJvX2TQztic8XQ2jAVuNOZqyqgcV2JtlsQvktvBlclkbOkj57J
         D5mg==
X-Gm-Message-State: AO0yUKWGz0mVTWAiUiEon1NTlFj7ruuTNco/MF7SL+Fis8/8jQbgxVq6
        Nu3/ldp/Z6+awmCxqcS5kOEBdMEFgWTEAKuZN16xQw==
X-Google-Smtp-Source: AK7set+gzkLWtXfxrJHJOEXhQHzI1CPd49w2oBTe+ZpCeOcmyFbqbUKwWlFvdxMCpYWpRAY0ZDPw6WpQPDBhtxPbgI8=
X-Received: by 2002:a0d:dfd6:0:b0:51b:1df9:ebac with SMTP id
 i205-20020a0ddfd6000000b0051b1df9ebacmr661975ywe.138.1675332177717; Thu, 02
 Feb 2023 02:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20221115121237.28361-2-quic_vboma@quicinc.com> <20230202064712.5804-1-quic_vboma@quicinc.com>
In-Reply-To: <20230202064712.5804-1-quic_vboma@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Feb 2023 12:02:46 +0200
Message-ID: <CAA8EJpomzsY+mgjVzpTG3tn+UGtUufEesM1QJcJS4ZK6thQkCQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/1] Fix for VP9 DRC and Decoder STOP issue.
To:     quic_vboma@quicinc.com
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 2 Feb 2023 at 08:47, <quic_vboma@quicinc.com> wrote:
>
> From: Viswanath Boma <quic_vboma@quicinc.com>
>
> Tested the changes on v5.15 and v5.4 kernels .

Please test your patches properly. It is 6.2-rc already.

> For testing Chrome Utilities were used .
>
> Viswanath Boma (1):
>   venus: Enable sufficient sequence change support for sc7180 and fix
>     for Decoder STOP command issue.
>
>  drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>  5 files changed, 41 insertions(+), 3 deletions(-)



-- 
With best wishes
Dmitry
