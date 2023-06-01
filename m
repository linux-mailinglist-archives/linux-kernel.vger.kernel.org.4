Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C9719F78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjFAOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjFAOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:14:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CBFC;
        Thu,  1 Jun 2023 07:14:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f50470d77cso1170216e87.0;
        Thu, 01 Jun 2023 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685628892; x=1688220892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeEt3ZtY/qgPpIG3Juy6jxgig7CNozbybAWZDbKu/2U=;
        b=EA6QMh0SF1z/MTpMCRKX9Wem4Jbt9wiCcnjreK854AVtiORKI2PsSN79zxKO/ZRuvH
         he7xl4p/EgXNjbb0tGcGODweznwFnioHPqiX1EZuVwCn8HNL+2VENunXXh0TUIRIgtoO
         SNWIsXG1pOToRqQL8NGZ5TVMAwYkgYUkjnecI1TL2VCAy99EVn5bWCW+fJILMGZfWEYP
         SK2W9Irhygls/2htBENC8xH8KNvPZ4SV11mlGK86spve9XhKwz6YVDsvkPbc3Aaan//D
         RilNeQcQojDJ1HsnPi2lZSFpdQoO6QjsfaZeSqevXWkx8yZAWqTKJM6VQPqC5BmSMLE6
         khNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628892; x=1688220892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeEt3ZtY/qgPpIG3Juy6jxgig7CNozbybAWZDbKu/2U=;
        b=gzDGDOM8sHpEbLTuDsQyvKVQGhfhYHosEKAyBnJXe6OLBhOTQ25NHgBtNlszSiQnGt
         KyVdYJZ08RNw/ahBHeC/Yp8+RABSAcJZ/bcWW8Z7QRydCTohhx+9VEayzXoLtRm64Ct5
         J/qrZSovYhhzV93zllwxDyiY3XOCuqNd81aTriaF+0LSV1fdmhMqh0DQ5Q/8ld3EF+kd
         1CarRccA3nyVU0pk/c1GHBUbAIUou7EfvavZNCqcqfAn9PZ9W4/EPHyjpBVURHTet59i
         DdONXBSgBLscBmFkZmM0WsNT2+M0MO5ew0ozrx10UrwFb4NGczDEkG/gIYJ1q+7spKnx
         ytEg==
X-Gm-Message-State: AC+VfDxEyoQuQPNKIJH+d9AsbrYsGjqD5HDWC5IU0dlHcU39Klg0Ijr2
        XiaK+WMqHKyl5PgfEe3Y6jKOMROpuOmA+kCYAQQ=
X-Google-Smtp-Source: ACHHUZ5aZbU8uqtUstqjsROwRBmYjoZddv/BBhfDrYD2/3YDUKKqXKbBGkdUqIRDFOIon0Wjh3OmpR/FjZOPjI6eNUU=
X-Received: by 2002:ac2:4c2b:0:b0:4f4:b41c:a8c1 with SMTP id
 u11-20020ac24c2b000000b004f4b41ca8c1mr171lfq.69.1685628892019; Thu, 01 Jun
 2023 07:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org> <20230531-topic-8998_mmssclk-v1-4-2b5a8fc90991@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v1-4-2b5a8fc90991@linaro.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 1 Jun 2023 08:14:41 -0600
Message-ID: <CAOCk7Nogy3+5rvyzPEgsyJe7xE_17MXVs-=mniJJj=ELsCqzNQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:01=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
> HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
> it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
> votable.
>
> Fix all of these issues.
>
> Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller =
(MMCC) driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Was this tested on a system where the bootloader has enabled the
display and it is active during Linux boot?

I seem to recall that in that scenario, Linux would boot up, see that
the GDSC is on, not see any clients for it (still initializing), turn
it off, and kill the display which then results in either a mess of
errors or a bus lockup.

-Jeff
