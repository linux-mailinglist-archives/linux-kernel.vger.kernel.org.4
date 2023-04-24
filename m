Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46F06EB66F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 02:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjDVAV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 20:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjDVAVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:21:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B830F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:21:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b994571219fso459865276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682122875; x=1684714875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPWYGDJMhP7eV/jzWq1VIOUpeyeWw3B0wUE4YZZCmE=;
        b=p/bNplEChqCipEg965Y382pIyekStKKfzL2rZ+r7/98iZAysbEMBPiInYSpDkNsNrm
         hy5DEwvn4duWAUum10kTnlcAZ5P46IFyrAmd9ueWg4yx6XMxKgm7xCadl4M7tgzwLNxc
         BlVKJCZyoA368mMdWudGvnG5OpgrAv5vdCuP6Es4uWT1L2mOhjBilk2EluxX21EsgLR+
         5gLyt3c1/FuX45FtZIUzxj67Mu3ZGqWEOjyFqA9jUxrWHIAPPSw718PlU5P6fpzMUfYQ
         9/KHfk7pIzAOTQfcJrWaK20ufNMW8DSeZ9+jYP6WuMcXX+YjE4ECOYQcFw1EywSzs8ny
         N29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682122875; x=1684714875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYPWYGDJMhP7eV/jzWq1VIOUpeyeWw3B0wUE4YZZCmE=;
        b=dhXc/qBhxx9kTUepgdFkz+DMd5P6dbPD9EvcZsV3mypAkMMCflWKj43x71jA125Lj3
         tq5kgELIKvKI0ySvJrg6lld2VM2wjQwK16g/RbDLXHo3CTNQnmooceHLyHt90NF2zPQU
         qlIbMZy89mqvRLVsG871xzSqrIJRPM9sqc2L8IRj4x7BDNwUOs41ZOhRmmN5mzGKL+MK
         WgFgP5u4eZ9B/vuR55xSr8yl8apm8W42sydYuaNZuUvD2afz3cnC7cEuFYRiBrN6fj49
         GfZy37itmWnlxkuPD3oeq93jYcyD2msb/I/lbiN6HXf3w8T8DZKaE+ec7243+oXVjZay
         D/vg==
X-Gm-Message-State: AAQBX9fFGjhlUgLuxDNvGEyAgIhXh8LjLqnKv8epkLgXfqkymOa+/TbF
        oDacdtJVQfJGe/81YTyU3oP2XStkDVAgEHfule2XWQ==
X-Google-Smtp-Source: AKy350Y+lKJO2oSM2BWjg2A3ysf0G4U98qb2g2BmthOtZuVMrE/ho258xSHNWC2L91ksdI74UKOPiSBzxWADWpaq55U=
X-Received: by 2002:a25:e784:0:b0:b96:3fd4:52eb with SMTP id
 e126-20020a25e784000000b00b963fd452ebmr3497830ybh.39.1682122875007; Fri, 21
 Apr 2023 17:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com> <20230421124938.21974-3-quic_devipriy@quicinc.com>
In-Reply-To: <20230421124938.21974-3-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 22 Apr 2023 03:21:03 +0300
Message-ID: <CAA8EJpr-Xppn0RCOBH-12DJeY1nc5CCgB480FZsrdi4wAY7CxQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 15:50, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Add the PCIe pipe clocks needed for enabling PCIe in IPQ9574.
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
>         - Picked up the Acked-by tags
>
>  drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
