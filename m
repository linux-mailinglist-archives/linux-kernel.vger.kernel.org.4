Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711B663A52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjAJIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjAJH7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:59:20 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CF373B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:59:02 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197]) by mx-outbound43-210.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 10 Jan 2023 07:59:00 +0000
Received: by mail-lj1-f197.google.com with SMTP id a11-20020a05651c210b00b0027fc4f018a1so2505505ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fouvbSbhOedB3R0y60hD4igAfBtj8dKG632MnzlVrgI=;
        b=CtE+LrsM4lZJWgoogDCeG2uvJbRJvbERB7xqMuQf+p9f2fx5r53mFHEZ8xE+wFG34x
         n4MqPw6ZcskTmS9ZqzKkaGxfQAwMaxB6PqDDt90WNOfdEX+8peEy9i/rkrNpqKcYj+0X
         4S5I36cziWvcIu8jPw8AZ2LVUEmKlC55Ae360=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fouvbSbhOedB3R0y60hD4igAfBtj8dKG632MnzlVrgI=;
        b=MSWWRyAONfMWuPcF7JOrurO9K3tk9L2XSL/mHg6a0+Th15pRZTnheQOosq3tqMCufU
         ENLFqcJbG5jJQl/3q2y04typ0Q4J/3xG41e8M4XE0waOWC9bdji0johHBHNvJD7hMm7x
         wN0KMMIUq0xnqW2RNC+gbG0D65A2CRjPNOv+Ug89k/3/gFW8onuR0mvS4aZPfn9Ql+Ft
         YiNox6dTDboCqoBQTtNtXv8/d+3P2LoAZ7jFDH0hJCesN1ZFypIVXDBXLkCQH3d6e28p
         Yykx5w0JiiDXBCPkYLD/+gQAHIob918zX3fCV7NPH23SNTATZG59kgIZW6XXJsCe+bZW
         Ky5g==
X-Gm-Message-State: AFqh2krhzMevF+to+nCCHuwa9Fih2CdvfSGsZz6QydheByaNVPv8Ry7d
        mvw1wGsuuBwqVFmuYYrHJuxZwW09scuzs4/9ysx8bMpvc66p8z2LEsULDupEtCiQZ2evHjnXvIa
        eBdx+wP5MbMhgWVWCFv5HwkqGKaZ/b9i0qmr2QZxg6N4cMRDDSD12+iNVY2/FmDjY+/OltaQTJV
        1s
X-Received: by 2002:a05:6512:2287:b0:4b5:5ec2:8787 with SMTP id f7-20020a056512228700b004b55ec28787mr2833245lfu.625.1673337538350;
        Mon, 09 Jan 2023 23:58:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvP6TKGTgKwa/6boR1h6KfoxvSqnDvxqdJApJqZHcJUZsACSZfFL+mVKqoQVXl5x533E/mB+rYE1cOEMsEyrd4=
X-Received: by 2002:a05:6512:2287:b0:4b5:5ec2:8787 with SMTP id
 f7-20020a056512228700b004b55ec28787mr2833237lfu.625.1673337538058; Mon, 09
 Jan 2023 23:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20230105151740.29436-1-sinthu.raja@ti.com> <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org> <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
 <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org> <CAEd-yTRzxUGNM6u0SMnVNjM=xrsX9g1JUEYvaUhqa--KcgYfeQ@mail.gmail.com>
 <20230106134102.twg6qzyeh5ivhe46@recopy> <CAEd-yTTSC6oFMAA+kH-GwMejPY0S0q8=L43_Sw62nyLrQiAT8Q@mail.gmail.com>
In-Reply-To: <CAEd-yTTSC6oFMAA+kH-GwMejPY0S0q8=L43_Sw62nyLrQiAT8Q@mail.gmail.com>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Tue, 10 Jan 2023 13:28:46 +0530
Message-ID: <CAEd-yTQEM42mJ80Vab8MQkFPiNwesyqTw5YktGCRuEeh_RqSyA@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1673337540-311218-5385-2287-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245369 [from 
        cloudscan10-60.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 7:33 PM Sinthu Raja M
<sinthu.raja@mistralsolutions.com> wrote:
>
> On Fri, Jan 6, 2023 at 7:11 PM Nishanth Menon <nm@ti.com> wrote:
> >
> > On 18:47-20230106, Sinthu Raja M wrote:
> > > On Fri, Jan 6, 2023 at 6:28 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 06/01/2023 13:53, Sinthu Raja M wrote:
> > > > > On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >>
> > > > >> On 05/01/2023 16:17, Sinthu Raja wrote:
> > > > >>> From: Sinthu Raja <sinthu.raja@ti.com>
> > > > >>>
> > > > >>> AM68 Starter Kit is a low cost, small form factor board designed for
> > > > >>> TI's AM68 SoC which is optimized to provide best in class performance
> > > > >>> for industrial applications and add binding for the same.
> > > > >>>
> > > > >>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > > > >>
> > > > >> What happened here?,
> > > > > Krzysztof
> > > > > Missed the merge window, so rebased to 6.2rc1 and reposted again.
> > > >
> > > > And what was here in v3?
> > > Krzysztof,
> > > Are you asking about this tag?
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > When you are re-posting OR updating the series, it is the patch sender's
> > responsibility to pick up the acks. If you are explicitly not picking up
> > reviews and acks, you should state in the diffstat why.
> >
> > Also see the b4 tricks[1]
> >
> > [1] https://www.youtube.com/watch?v=-Vld9aoFPwU
> Nishanth,
> Thanks for the information.
>
> Krzysztof,
> Sorry for the errors caused by my oversight. Kindly excuse me. Would
> you want me to resend the V3 series with the correct subject?
> >
Hi Krzysztof,
Could you please let me know if further action is required from my end?
> > --
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
>
>
>
> --
> With Regards
> Sinthu Raja



-- 
With Regards
Sinthu Raja
