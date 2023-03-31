Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157C6D22E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjCaOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjCaOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:46:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A672060A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:46:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p203so27617576ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680273972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrHq3nvdZgYqWKc7TXYHf/S8IML0/6fKVdabRYk6kRs=;
        b=FSshoQjBEuyysNCAr4gfKkkGjn4WnfdI+qOqlOkmRGkMNcnt/lTDYQWC74sG1SCNSr
         yA//YZ5ueiDN+mks0OSAOUFD/ujtg6ET1DLreUtSgU2q+etoIHNRF5G933Ped6CgeRI0
         QL92NvVIMFSNYUE9bbc+c64MKwS4aI45gJ4usYlHz/B9dxSZDWGpJNnepadvvprJ3kWU
         SKpZLhDKTfmBr40947S5E077bALebDfpjQNAUSNpdXB1O3cKgF35WnBhuNFcnqVd7wUt
         A6CjUPwCzxd3uRMQakcZWQUV83AYiGZuKUHKAi4faRjl4QKYjuM1EDYKaRJyy4uYt+ir
         Oukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrHq3nvdZgYqWKc7TXYHf/S8IML0/6fKVdabRYk6kRs=;
        b=InGhqauc/JnIGcc9IVgDlJmDWRxfkpNe4ruCpZcwPgp5ZJeRewPDH9gxpFbrDbNYyR
         3d+UXgvK4TSGdT4XVWBV5KtpY4WFzrWZh+WPLqeXWzp2izeQqdj9nqlN5xbX45h8JuMG
         /00mWopnB89xR44hYCKmQlBwv1ZjBg/Wf87h+QIrCpo/EjZdn2ejiSqr/Qq0eXJjxmIK
         3/DsyjnPR4EGSurmqwlQElPaCs3NxJ972SlfBArVLjJHFSje/c1BFwXLHwSWLCBw7tL7
         HYkAMY/uDMtAQG39bnwtUJTgyiKyZMmQaj+LURNqNmDKEiw9OKyPyL4CrRc4Xap9R9xe
         jQPw==
X-Gm-Message-State: AAQBX9fBdNC3WHFwp3gfseVrGp6W2Qi+TThJFWtVjSBQQqCQzzWeCaGe
        mMu6UgQFDhvsN/y75suPw5ORFx0Zo5TGzpaawZjH7g==
X-Google-Smtp-Source: AKy350bPOqn4cx7f84281++qJEmUbQ+CCAD8rP4eVc4hTLCXDTlkGh1wbgDJB5qJk6X6yqA4dryEiDQ+tlglpoAIfVU=
X-Received: by 2002:a05:6902:1501:b0:b4c:9333:2a2 with SMTP id
 q1-20020a056902150100b00b4c933302a2mr14740974ybu.9.1680273972110; Fri, 31 Mar
 2023 07:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com> <1680271114-1534-3-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1680271114-1534-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 31 Mar 2023 17:46:01 +0300
Message-ID: <CAA8EJprG5g2jzfkez1V0HHO0X_8WDfA9cVfaY3K3cUByW58A1g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] msm/disp/dpu: allow atomic_check in PSR usecase
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 at 16:59, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> Certain flags like dirty_fb will be updated into the plane state
> during crtc atomic_check. Allow those updates during PSR commit.
>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Link: https://lore.kernel.org/all/20230326162723.3lo6pnsfdwzsvbhj@ripper/
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
