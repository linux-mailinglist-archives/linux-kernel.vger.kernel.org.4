Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A9704656
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjEPH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjEPH1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:27:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE111C;
        Tue, 16 May 2023 00:27:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64395e741fcso14245429b3a.2;
        Tue, 16 May 2023 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684222061; x=1686814061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMkkuioWkC+udXRloS+HK40vtfIEidS3uoOdvaB5NUg=;
        b=WiDWT2zI2xlQvDkBOyqZDLIiQ+/FbhgU3cgCIgCAKHDrRdhRg3kGM02F3deXcEbHXo
         yjnzuyxgn4H5yyy4sDf9sfL1wWfh7wWLV1evTmc7L01WpgYzRmbZO9mnRkUzWXeOKXQf
         4bIqpkaiNA3uSn35cxCG+YRzMVbjDzbU5M27v4wdqho+lp+aTla4Z+7xiKOxrrfyrurd
         EP5Y8u5KaaOHgiVjpNvPx+XQG5zYl0JprYnafva1fV+xwhS0D0kJlBz92iO/Goj+NCAl
         s3a5onKS+8xBItoWEOMzbeu7zkXk5piLEdcH11iSuijIv5pJzFA/b0P7aRxGpm+figaR
         n/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222061; x=1686814061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMkkuioWkC+udXRloS+HK40vtfIEidS3uoOdvaB5NUg=;
        b=UHN+NLe5fNDRC/2KNLTd88LIikKeYZvMB4HJkdhOB6KxvUvN7AVSlI4AsvC6KPpWXO
         6pAHa0M2u4CfMY85geT5gGP0ECagSTWiWdWePD55togzHkSbhdTUNm0UzFXYX0Uz0bKe
         owV74usILk7W3+0wu0vt2iK/v+YMoQZO4fh8GbUC+zH4bgkYHPd7fbThDWprwUbJKbPt
         pjdWdMKZoFrPo4jkmT8Tbwc6Hu4pIpZftyz71YNRjMkBkf5kUOaZG8DcldRIDV4ldupL
         Pihjj2jc9TzJI0XI51rUP9eMFbEoGeNNdyAMZW0NSw4NvVMWkb/eBmaIBGu7+BbrLMoW
         L5tw==
X-Gm-Message-State: AC+VfDzKJkkR5bwbAi/a3F+77O9k+//x3ytcvCzuSNVfqrALX8q2ZEE0
        T/Y9zXaVzMIyZiTXCcuVFOA=
X-Google-Smtp-Source: ACHHUZ74rnoX13f+ip9crIOWfq+6SjW8iqq3ldmHjj2wBSe350Z+Ops2E1y7tLdOMQ+xPt34CGZlcg==
X-Received: by 2002:a05:6a00:14ce:b0:640:f313:efba with SMTP id w14-20020a056a0014ce00b00640f313efbamr49839859pfu.19.1684222060775;
        Tue, 16 May 2023 00:27:40 -0700 (PDT)
Received: from Gentoo (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm12689091pfr.112.2023.05.16.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:27:40 -0700 (PDT)
Date:   Tue, 16 May 2023 15:27:34 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RESEND,PATCH 3/3] arm64: dts: qcom: sm8250-xiaomi-elish: remove
 redundant empty line
Message-ID: <ZGMwZiPI3eCGdoS8@Gentoo>
References: <20230516062657.28616-1-lujianhua000@gmail.com>
 <20230516062657.28616-3-lujianhua000@gmail.com>
 <95f257ae-0b9d-a002-7074-a476fbc5bc98@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f257ae-0b9d-a002-7074-a476fbc5bc98@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:11:28AM +0200, Krzysztof Kozlowski wrote:
> On 16/05/2023 08:26, Jianhua Lu wrote:
> > Remove a redundant empty line introduced by
> >   commit 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
> 
> So you resent my patches just to add a comment? Not even as a dependency
> of something? Please, no.

Acked, I will split this patch to new series.
> 
> > 
> > Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
> 
> It's not a bug. Drop fixes tag.

Acked
> 
> 
> Best regards,
> Krzysztof
> 
