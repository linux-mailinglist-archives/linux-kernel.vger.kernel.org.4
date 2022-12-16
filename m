Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8C64F20C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiLPT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLPT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727C9FCC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671220596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yT5WMStb6RpixjYKqDqsORdwrjmO9fsi3vyA4Yz5900=;
        b=Z8HNRt2qIb3mPpPyxWydDxNiMQWqPEd8Wzx/CkpdvS1jIG8PZGX+thbUinn8kka56C472I
        0WLm6x3yVxan13rW4o2aMeWZLYF2/v4TwctUp0Pi5ury8p8voHmc2GvcD2qD7grGXbjTRg
        qtehgZDzZGnyzz9nDR1oDflLqTzcATI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-GRkJkZuUMieEQSMlVz6pTg-1; Fri, 16 Dec 2022 14:56:34 -0500
X-MC-Unique: GRkJkZuUMieEQSMlVz6pTg-1
Received: by mail-qk1-f197.google.com with SMTP id br6-20020a05620a460600b007021e1a5c48so2564959qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT5WMStb6RpixjYKqDqsORdwrjmO9fsi3vyA4Yz5900=;
        b=lxv9yjcsKRMgXi69sUXfFgBjReJATj+q2qsM67HwqbVovbPdQKqCnbdTO3dcEqakTe
         L7oIOrGLDod9/zZPAsW9tVNKtBOXkfXrsYFjx6FI9eHUiU6jCh5tyNeZajctf3FTMJUt
         VigBy94QgITFG5nv5Qd/iNZBxIcxHKalFi8/GjD9WpXO6n8P+ndYQ/vU9VNwsdLV/2xP
         0m1J3AMSkp1YRCVX03MDWOVx8qB5B5g8emKyZlq+MtbHhqgwjpALpgo+lrL/T5GKZqke
         Xqr+9iCGfZHBhFY/0uPAbJtAEcEuCG9ahyEkN5SJlINjVpsujbtKE75KX30/epwMazS6
         09MQ==
X-Gm-Message-State: ANoB5pmJ0pUE4MY4voiTd3u1HlXiqcp7aTRroLtVwD+cjD+6gnslEP37
        1ZDrCn6k3FOIfJUBXQvZDbvW+II4zjhRdvs1tjOzlvpGXvMeIEAVODALaDdMcsyHBX+9In5v3C1
        VLzrhwpfV3QHTnb60mf4JKqsQ
X-Received: by 2002:a0c:9043:0:b0:4c7:7f0d:5ff with SMTP id o61-20020a0c9043000000b004c77f0d05ffmr52617392qvo.28.1671220594221;
        Fri, 16 Dec 2022 11:56:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58vdEWVOATW0nNkHgiDWVtF1qXLQ+uvel5zgdChW1seR8UKu6CT/BvYquMe74N90ISkTsLOA==
X-Received: by 2002:a0c:9043:0:b0:4c7:7f0d:5ff with SMTP id o61-20020a0c9043000000b004c77f0d05ffmr52617370qvo.28.1671220594026;
        Fri, 16 Dec 2022 11:56:34 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a24c700b006fc9fe67e34sm2199346qkn.81.2022.12.16.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:56:33 -0800 (PST)
Date:   Fri, 16 Dec 2022 14:56:32 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p-adp: use pm8450a dtsi
Message-ID: <20221216195632.2wu5h4opfr46n7s4@echanude>
References: <20221214210908.1788284-1-echanude@redhat.com>
 <20221214210908.1788284-2-echanude@redhat.com>
 <5ed623d6-3ca2-a1c4-9277-6768df5a63fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed623d6-3ca2-a1c4-9277-6768df5a63fe@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 02:01:09PM +0100, Konrad Dybcio wrote:
> On 14.12.2022 22:09, Eric Chanudet wrote:
> > Include the dtsi to use a single pmic descriptions.
> > Both sa8295p-adp and sa8540p-adp have the same spmi pmic apparently.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 79 +-----------------------
> >  1 file changed, 1 insertion(+), 78 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index 84cb6f3eeb56..889259df3287 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/spmi/spmi.h>
> >  
> >  #include "sa8540p.dtsi"
> > +#include "pm8450a.dtsi"
> I feel like naming it  sa8540p-pmics.dtsi (like sc8280xp-pmics.dtsi)
> would be more representative of what's really going on (unless it's
> a single chip providing 4 virtual PMICs on different SIDs).

I can make a v3 renaming this. The initial commit from Parikshit
mentions it is to be re-used on sa8540 based boards.

Side note: A quick look also shows pm8450.dtsi[1] is not included by
any of its intended targets (sm8350 and sm8450 IIUC). Was this lost?

Thanks,

[1] https://lore.kernel.org/r/20220226205035.1826360-8-dmitry.baryshkov@linaro.org

-- 
Eric Chanudet

