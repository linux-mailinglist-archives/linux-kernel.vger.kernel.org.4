Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4A712E85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEZUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEZUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:53:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462B18D;
        Fri, 26 May 2023 13:53:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so1061638a12.2;
        Fri, 26 May 2023 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134432; x=1687726432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3oCCAl/V4UknHRsyhXqj01s93x9w7LClBL1JwZ0dwkU=;
        b=db5lbVToJusbCCNTqlOyV5mdv1kXs5c/1AkgnBfW/gIv3Oib7xuJscxTCduwxfYMee
         u37Y4I2HYKrbod8/r67vpOr4m9NKGVVm4OKh52FOPj4rI/XQOxxYzqN8YFoMLd4PgB3v
         t5gsMZ9KgrwxyVDGH14+q7i8yfZE/EcK/eFz7166XyQWXV5uoH5OiGg/yqSOeqh6754x
         eKz0sRJfqIe7CWytVeXxTekRLyjOzFLiFdV8WcAH9dZXhbA3EWqTo6Lv/PID3BIl3Ky/
         hj3phFg6T761Ylp/CLP/xmRS1tE6huO/K5fwWVAOYXMazBZOm/xRR2OLxENrbR8SeAKA
         UIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134432; x=1687726432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oCCAl/V4UknHRsyhXqj01s93x9w7LClBL1JwZ0dwkU=;
        b=QF+BvS06eVksyPnf9P/ni6ZcNSpnih3NcXO9j/oW5dqIWs22Gx+rN9IEoGJcO9XPF1
         MF+zBp8F432TBO61BG2xfx9WHe5h4SGGSj1j0PvGJtg6dACfdU1o/YCZOC9/AWuGPBpj
         40e/xSHJUGAepFeQ5MbpMWqErJjvoxGdAieoIFLV/857rKydO4peE53CiRN972x2Th9g
         zs/RC6swm7lIX7UKi57wAXnkCOKEfb/lBwlrU8dF6xK0wPKYXygjVwaNYgYln+D1yxhl
         zt/cls7DJ314MPmC3LKCpu3jV47Ek+xO7U/g6UVWUL2YDTUp7sMEYSn3rC7cPJX1QPNw
         cPpw==
X-Gm-Message-State: AC+VfDyieVsrr7h259JJVnOjl9vYCvxheVhzopxODUXz5B5kl8Mg41F2
        PoHNMZvcm66lar0kFsmmJC1Iss6aj5pQcTuHut0=
X-Google-Smtp-Source: ACHHUZ7LbtE+hljdKXBjuqngT/pzKTlTGC2llOglkcZxIt9eN6lz798aE2e9rcjtIql4nuDBvHSNzUkrp6Xv58/X4s0=
X-Received: by 2002:a17:902:7084:b0:1a5:2760:74ef with SMTP id
 z4-20020a170902708400b001a5276074efmr3444552plk.25.1685134431793; Fri, 26 May
 2023 13:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230526190855.2941291-1-robimarko@gmail.com> <20230526190855.2941291-2-robimarko@gmail.com>
 <5833388f-51c6-ad42-f8c2-2ad37cecc31f@linaro.org>
In-Reply-To: <5833388f-51c6-ad42-f8c2-2ad37cecc31f@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 26 May 2023 22:53:40 +0200
Message-ID: <CAOX2RU7bXm_xry1c0byzkzXw4VNL71d4YrFwUB2xvFWSJLSkLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: qcom: ipq6018: fix networking resets
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 at 22:52, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 26.05.2023 21:08, Robert Marko wrote:
> > Networking resets in IPQ6018 all use bitmask as they require multiple
> > bits to be set and cleared instead of a single bit.
> >
> > So, current networking resets have the same register and bit 0 set which
> > is clearly incorrect.
> >
> > Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq6018.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> > index abd97b939850f..b8310f29a8ff4 100644
> > --- a/drivers/clk/qcom/gcc-ipq6018.c
> > +++ b/drivers/clk/qcom/gcc-ipq6018.c
> > @@ -4520,24 +4520,24 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
> >       [GCC_PCIE0_AHB_ARES] = { 0x75040, 5 },
> >       [GCC_PCIE0_AXI_MASTER_STICKY_ARES] = { 0x75040, 6 },
> >       [GCC_PCIE0_AXI_SLAVE_STICKY_ARES] = { 0x75040, 7 },
> > -     [GCC_PPE_FULL_RESET] = { 0x68014, 0 },
> > -     [GCC_UNIPHY0_SOFT_RESET] = { 0x56004, 0 },
> > +     [GCC_PPE_FULL_RESET] = { .reg = 0x68014, .bitmask = 0xf0000 },
> GENMASK / GENMASK|GENMASK / GENMASK|BIT?

That would explain why I did not send it before, its been on the TODO
list to reverse
the QCA magic values like I did for IPQ8074.

Will do it for v2, thanks.

Regards,
Robert
>
> Konrad
> > +     [GCC_UNIPHY0_SOFT_RESET] = { .reg = 0x56004, .bitmask = 0x3ff2 },
> >       [GCC_UNIPHY0_XPCS_RESET] = { 0x56004, 2 },
> > -     [GCC_UNIPHY1_SOFT_RESET] = { 0x56104, 0 },
> > +     [GCC_UNIPHY1_SOFT_RESET] = { .reg = 0x56104, .bitmask = 0x32 },
> >       [GCC_UNIPHY1_XPCS_RESET] = { 0x56104, 2 },
> > -     [GCC_EDMA_HW_RESET] = { 0x68014, 0 },
> > -     [GCC_NSSPORT1_RESET] = { 0x68014, 0 },
> > -     [GCC_NSSPORT2_RESET] = { 0x68014, 0 },
> > -     [GCC_NSSPORT3_RESET] = { 0x68014, 0 },
> > -     [GCC_NSSPORT4_RESET] = { 0x68014, 0 },
> > -     [GCC_NSSPORT5_RESET] = { 0x68014, 0 },
> > -     [GCC_UNIPHY0_PORT1_ARES] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT2_ARES] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT3_ARES] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT4_ARES] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT5_ARES] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT_4_5_RESET] = { 0x56004, 0 },
> > -     [GCC_UNIPHY0_PORT_4_RESET] = { 0x56004, 0 },
> > +     [GCC_EDMA_HW_RESET] = { .reg = 0x68014, .bitmask = 0x300000 },
> > +     [GCC_NSSPORT1_RESET] = { .reg = 0x68014, .bitmask = 0x1000003 },
> > +     [GCC_NSSPORT2_RESET] = { .reg = 0x68014, .bitmask = 0x200000c },
> > +     [GCC_NSSPORT3_RESET] = { .reg = 0x68014, .bitmask = 0x4000030 },
> > +     [GCC_NSSPORT4_RESET] = { .reg = 0x68014, .bitmask = 0x8000300 },
> > +     [GCC_NSSPORT5_RESET] = { .reg = 0x68014, .bitmask = 0x10000c00 },
> > +     [GCC_UNIPHY0_PORT1_ARES] = { .reg = 0x56004, .bitmask = 0x30 },
> > +     [GCC_UNIPHY0_PORT2_ARES] = { .reg = 0x56004, .bitmask = 0xc0 },
> > +     [GCC_UNIPHY0_PORT3_ARES] = { .reg = 0x56004, .bitmask = 0x300 },
> > +     [GCC_UNIPHY0_PORT4_ARES] = { .reg = 0x56004, .bitmask = 0xc00 },
> > +     [GCC_UNIPHY0_PORT5_ARES] = { .reg = 0x56004, .bitmask = 0x3000 },
> > +     [GCC_UNIPHY0_PORT_4_5_RESET] = { .reg = 0x56004, .bitmask = 0x3c02 },
> > +     [GCC_UNIPHY0_PORT_4_RESET] = { .reg = 0x56004, .bitmask = 0xc02 },
> >       [GCC_LPASS_BCR] = {0x1F000, 0},
> >       [GCC_UBI32_TBU_BCR] = {0x65000, 0},
> >       [GCC_LPASS_TBU_BCR] = {0x6C000, 0},
