Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F376601C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjAFODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjAFODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:03:46 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8FB7CC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:03:45 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198]) by mx-outbound47-78.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 06 Jan 2023 14:03:43 +0000
Received: by mail-lj1-f198.google.com with SMTP id c18-20020a2ebf12000000b00279a72705feso431558ljr.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlPsnIKkTLLU/5/VeY5zhomJN7U6Vw6q3Celpp1TfQc=;
        b=IoIZXfoj+B1KCYUbJd/lliIvSaBMPEL8dHNiLOkriA7ugn3v/sSiptRcR1OjX5yoxs
         jMDtTaElivSpdnLyTLLLQaqqezUjUerEKiSpvkGzXaGR+vE2bS3bD1Bl8ealorzrTfL5
         7kZnL1DrxbXckOVfWITmc3wOcn+3ahRGhqvzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlPsnIKkTLLU/5/VeY5zhomJN7U6Vw6q3Celpp1TfQc=;
        b=RDoP1NxuPvJlcW0xce9+7PiC7UucP3iGMEoiK3bfshRnKd6c8iEtiHOWXzThyQVoXo
         Yg+k9SpatVyHtzSx4T0763l0jJGwnjEww0QSeLqiizNRGxCMvzv2kfRCP1P28LyCkDhC
         AdUvb1cCBp9byDGhR1Othc5ILiWGztXA/VsY7wP4UxfDF/7sSp+7Xv3yBkJ/ntwHE+AW
         wMhJvICS8DzIAk6y0iWECnZNPQsnfeDCzlENUeFgXROE89LmzvlwCAMj0ND0W0Zimya1
         hhz6YcHmN9baP7JYA4u6wr+U1VnpwO+/mWLrymbM1d+3bwgE1hlI0IX3LAaeagJkXtK2
         10eQ==
X-Gm-Message-State: AFqh2kon6xR/QokjVEanm15bkYEqvLc7X3IsfYZrMyjGkh+on4FaC44y
        TbWug3fIvN2d8ikULrvJN7ltMAgMB1OsZCb4SBGWMko70f4T+PRPtTirV8KFsdtV+SERY31bLf2
        jd9aP/5i49wFIDyZjWnFR2vW7ffVg60oNu4Q2GTdvhF0k+yhLi79SgzU/WLzmAkwGOrmRB//TaY
        6/
X-Received: by 2002:a2e:a37b:0:b0:27f:c04f:aa1d with SMTP id i27-20020a2ea37b000000b0027fc04faa1dmr3333455ljn.40.1673013819378;
        Fri, 06 Jan 2023 06:03:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsZBHMAV+0xhkI48NiJp3toSY9OBwcF0jAmQgpmX8UjapPVIjNWiHsmKyfgJJJncErnsA0vcw+RmiLYvmI+vWs=
X-Received: by 2002:a2e:a37b:0:b0:27f:c04f:aa1d with SMTP id
 i27-20020a2ea37b000000b0027fc04faa1dmr3333449ljn.40.1673013818378; Fri, 06
 Jan 2023 06:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20230105151740.29436-1-sinthu.raja@ti.com> <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org> <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
 <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org> <CAEd-yTRzxUGNM6u0SMnVNjM=xrsX9g1JUEYvaUhqa--KcgYfeQ@mail.gmail.com>
 <20230106134102.twg6qzyeh5ivhe46@recopy>
In-Reply-To: <20230106134102.twg6qzyeh5ivhe46@recopy>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Fri, 6 Jan 2023 19:33:26 +0530
Message-ID: <CAEd-yTTSC6oFMAA+kH-GwMejPY0S0q8=L43_Sw62nyLrQiAT8Q@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1673013823-312110-5399-58627-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.198
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245288 [from 
        cloudscan22-5.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 7:11 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 18:47-20230106, Sinthu Raja M wrote:
> > On Fri, Jan 6, 2023 at 6:28 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 06/01/2023 13:53, Sinthu Raja M wrote:
> > > > On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 05/01/2023 16:17, Sinthu Raja wrote:
> > > >>> From: Sinthu Raja <sinthu.raja@ti.com>
> > > >>>
> > > >>> AM68 Starter Kit is a low cost, small form factor board designed for
> > > >>> TI's AM68 SoC which is optimized to provide best in class performance
> > > >>> for industrial applications and add binding for the same.
> > > >>>
> > > >>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > > >>
> > > >> What happened here?,
> > > > Krzysztof
> > > > Missed the merge window, so rebased to 6.2rc1 and reposted again.
> > >
> > > And what was here in v3?
> > Krzysztof,
> > Are you asking about this tag?
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> When you are re-posting OR updating the series, it is the patch sender's
> responsibility to pick up the acks. If you are explicitly not picking up
> reviews and acks, you should state in the diffstat why.
>
> Also see the b4 tricks[1]
>
> [1] https://www.youtube.com/watch?v=-Vld9aoFPwU
Nishanth,
Thanks for the information.

Krzysztof,
Sorry for the errors caused by my oversight. Kindly excuse me. Would
you want me to resend the V3 series with the correct subject?
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D



-- 
With Regards
Sinthu Raja
