Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1739763A8AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiK1MpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiK1Mo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:44:58 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8876562
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:44:57 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c140so13091535ybf.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5L92L6sWI/+mEWBmBL3DtHPyW1jrzK/QlQTZzSwQBI=;
        b=Mygr6yQSUM5fS8H6tqebwAnMYYMV5asAEjAdIHLZWUuRsaaJh47JXIwLyq6w7kU9fH
         Dx8VY3uEtrRnPXOExf0PqEUZygw09IAuWk1vo9KEXrTEPkE5I5jNBlzcGOz7e3m6Z/TB
         qSIphXTQSA6T0gWAZoPOKVkMyaxj+QZlVMiznxElGNykjYLe00WkX3JDBxOTJ/F4KUGr
         E0dF2hVqVTZohzaqRjaqdFfnRS8fJMzUlFdSoTuNnxPetqNtaXGqJ8k2VRz2+dOmDJn2
         VDHTKCXrC9KdovNkpJnr9YnumkZBZfiF+dV2zXvMYXkpqffwCCVErvSgl+vi6F+Mluor
         W7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5L92L6sWI/+mEWBmBL3DtHPyW1jrzK/QlQTZzSwQBI=;
        b=j/IgSENCCwp1d9krk21YianK0mn3dQuElNG0klMLtwojAuNwGswugoheuq2qw9aP8G
         caf6XxE/54KyI7KMHXqX+/n2kXyEcNS8bIcMuk6+mwyQ0grhYBTFTKS/KPfAxoalligf
         j8/1B74m5XeQntBnSq0FX7ry8vuWFqYnN8k284c1Z0sQFGGOgi+dFD+lzgxTwWNRUV/7
         cT5ab8LAJHER/bjYjM/sQCe8akqJRAwSR+35qk8AQcom4i1Z2FnTDM34K9XdxuDVk6uh
         vMcT0G0FtztarI/Jy/gCsGDjYAox7pFEB4n1yHEDWx0W1jFF4N4IDfX0q0+UaLfHMgp3
         KGjw==
X-Gm-Message-State: ANoB5plxZlxtNA/78OWHned0vruBe2A2Q+n//5K7baDFccqqTus1dbmV
        THlYgybZXoX2Q1cj3+rGuQb9pbrU9wBHaZD4HqX13g==
X-Google-Smtp-Source: AA0mqf5Sn4jHKFKdQcFa691WYR9rNCynIRXa9CGR9ccLIcawSxkCvfobdAo43wTafqOGnZNywSN2TTxO5daqjB41s2s=
X-Received: by 2002:a25:910c:0:b0:6dd:ac4a:65e1 with SMTP id
 v12-20020a25910c000000b006ddac4a65e1mr48492491ybl.288.1669639496489; Mon, 28
 Nov 2022 04:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20221127181835.806410-1-luca@z3ntu.xyz> <CAA8EJpoe09FZcfVXuknmFWO5qg-iYDOBVN3=qr=DeJjvHw56Mw@mail.gmail.com>
 <f0a15b01-81b6-5c73-6c35-ce3a8c71b4ad@linaro.org> <CAA8EJppEXpv-wVAAXhZ6NiPzDGzP+evnKrT=an5esOx610D+dw@mail.gmail.com>
 <f6bb5759-453b-fa05-c6e1-f1d57abeaffa@linaro.org>
In-Reply-To: <f6bb5759-453b-fa05-c6e1-f1d57abeaffa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 28 Nov 2022 14:44:45 +0200
Message-ID: <CAA8EJpofyGs=OEvDB5vx_odJBYHMCsry09PnjgH86bfsyo63jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 at 10:34, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/11/2022 22:43, Dmitry Baryshkov wrote:
> > On Sun, 27 Nov 2022 at 23:30, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/11/2022 22:25, Dmitry Baryshkov wrote:
> >>> On Sun, 27 Nov 2022 at 20:19, Luca Weiss <luca@z3ntu.xyz> wrote:
> >>>>
> >>>> Document the OnePlus One ("bacon") which is a smartphone based on the
> >>>> Snapdragon 801 SoC.
> >>>>
> >>>> Also allow msm8974 devices to use qcom,msm-id and qcom,board-id.
> >>>
> >>> The patch itself is good. However it raised a broader question for me.
> >>> Up to now all msm8974pro devices use qcom,msm8974 as a top-level
> >>> compatibility string. Should it be changed to use pro-specific one
> >>> (e.g. qcom,msm8974pro)?
> >>
> >> Yes, makes sense.
> >
> > Would you make the patch?
>
> I do not plan to. I don't know which ones are Pro which aren't.

Ack, I'll do it then.

-- 
With best wishes
Dmitry
