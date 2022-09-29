Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AE5EEADA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiI2BUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2BUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:20:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB60B2871
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:20:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j16so74160lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=PyA6JBZ/HLPJA0MSYRFOgBZKQs1v6t/7oG2AsVljbwA=;
        b=cnoIUXNM7y0Bx6E39zrU9pROCXP+TwDSRNusZ4S6UPUgk7lla7MB/QQzbc5dwyEX9P
         8fNXAUPeBK6so/28gYHdEMd4sVI5/q/0+poZEl+j+NGzdhZrT4Oh6Fn8OK1RvlrO3tRc
         faslcLLDDm6RV50iLLmFD/Kgz4ASmJmz2C1cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PyA6JBZ/HLPJA0MSYRFOgBZKQs1v6t/7oG2AsVljbwA=;
        b=EowXKjpYVBPr5judpAPOlVGV6VfMA2NS9an/vn7oZeGKHshSytEcgel7tpgNeL/5YB
         uXlyDvHL4HgS7C3ztCVzrDtPxi8gQAoq/t/R5aNUbKR9bhsjVuEGKZVveAEHAKKUzDml
         ugETH66QHPUt8psbD1B/0EwHTzDfia0ZVJQRB+Fp+9Oubgv99kv1FWWifAIGDQTtns/7
         RNhnTnnKuusGj6XvGLhSC3zt7hmi4VODO6N0+wV2VrfsSWQYDx2krDO4uUZGZYCJtXld
         MMTSNgQzRnt0+YDEhovXHCrc2N8r3WgfOo4azSeAYVBb18R5XckhdZcPxJpJdjSLiB4a
         Wi2w==
X-Gm-Message-State: ACrzQf1iR7OneDONsSQnrU8ZOwYLwXH/0xtvXeWW28wExElcvSo0EFuP
        M1LARuj+PB+8IJ94utRtsk7OxIR5yzzbq55ccEcc+A==
X-Google-Smtp-Source: AMsMyM6UGys+TKU82G78ADGDam7TNcOi0qQ36vJR4ZLCRet+LNaUHFDhfTG2aNNJ3/LcQS7hJhR1Mv+UkmcjDfeuFVw=
X-Received: by 2002:a05:6512:1151:b0:4a0:50f2:9509 with SMTP id
 m17-20020a056512115100b004a050f29509mr327722lfg.297.1664414432376; Wed, 28
 Sep 2022 18:20:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Sep 2022 21:20:31 -0400
MIME-Version: 1.0
In-Reply-To: <YzQf7hf15vvLeGse@google.com>
References: <Yr66ZZqEnBApHYMA@google.com> <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com> <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com> <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com> <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com> <YzQf7hf15vvLeGse@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 28 Sep 2022 21:20:31 -0400
Message-ID: <CAE-0n50cX5ky3By976RTecKkpeMoAjoBA4tYuWSZ150JfS9wiQ@mail.gmail.com>
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Lee Jones <lee@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2022-09-28 03:20:30)
> Wouldn't it make more sense to simply separate the instantiation of
> the 2 I2C devices?  Similar to what you suggested [0] in v9.  That way
> they can handle their own resources and we can avoid all of the I2C
> dummy / shared Regmap passing faff.
>
> [0] https://lore.kernel.org/all/CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com/
>

You can continue reading the thread[1]. My understanding is it's one
chip that responds on two i2c addresses, thus we don't describe that as
two i2c device nodes in DT. Instead we describe one node and use the
dummy API to make the second i2c device.

[1] https://lore.kernel.org/all/Yk3NkNK3e+fgj4eG@sirena.org.uk/
