Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DF631504
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKTPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:47:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C1F21;
        Sun, 20 Nov 2022 07:47:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d1so4385351wrs.12;
        Sun, 20 Nov 2022 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phxWAWN6RFOZILWUELs+CtSL4mhtXipbV6LGQCU4x9A=;
        b=Zk/hEWohRKl7NoWnQIqZa6QSrvfeaOITUdtB2WBO/h9tt/JjVWHH+dXSsIlHPujtWJ
         7bR60K9/aYLtgsFdsxpra004l8GRUpsqlWK+nWEWWUFsU41bkjrx2Flxr+7VnY3TQJhf
         c4m9fynDD6V4oblVuKDivJIFBwN3SW/BoTxfdtJcTC75r1hmuuRbNAW80J5AnI4T78sV
         LBmAodvRoEuXAtkih0nlfIWaiv5OXEspQWUzbCF+ifqla9XTKJ5SImNXJnqJrwwmTgzu
         f19i653b/g0Ks/BNn6Mg5K+VXBVe5XK8VMruWgpf487Vs5k8OWbfZ5lBvh8QLuZNH+8g
         zb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phxWAWN6RFOZILWUELs+CtSL4mhtXipbV6LGQCU4x9A=;
        b=HxKbgLh5IAS51w14Xu+TIQ2uHJxgA+0VKw50PneCdj046vLxthGvv/Wxt3AvQlCpd1
         gxCAp5Ww3dHury5SzUjHYTNYkXI8NTiE9UsDJtKZZ+9lHdaTX9tdU8QRJpRIXhp5ImaH
         fhrtJmMyiHMKhTg2PjiR9ATbKfkN+/EtEb7cjVt+zhYR4OAHhUOqz115F5dH4ANzR1Ke
         Lipo3VQqn9ylzlNTd1Ycd6GUIYIwiQkUwS93WWpNTofaETbtQmDq+f3EWG2vbePmVRIs
         rn3uXCX0w1yVIj2eTtdFiQRjBMSH8PH6pjqSCnh7oROEmqlPNeanMSUiyna5t9sR4muZ
         F0bw==
X-Gm-Message-State: ANoB5pnKS9cmS3I0imBLSB7kvC2wfSgsW3CDjzmmk/ckgjyiibhWH9lU
        cI42GH5kCqbqKpBzTmnBiVid5+gE07g=
X-Google-Smtp-Source: AA0mqf6xnkqQnQfUHctZhRxImHLViJZZuZz2Od3ef/eFyMFibOUIOsiLnK2/7A3TVpH1AhbmXGnw3A==
X-Received: by 2002:adf:ff83:0:b0:236:6824:c227 with SMTP id j3-20020adfff83000000b002366824c227mr9131970wrr.510.1668959245848;
        Sun, 20 Nov 2022 07:47:25 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b0022da3977ec5sm8974094wrj.113.2022.11.20.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:47:25 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for Qualcomm SMBCHG
Date:   Sun, 20 Nov 2022 18:46:26 +0300
Message-Id: <20221120154625.57095-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <dfaf7a35-25bb-8201-42bc-73ca280fcb69@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 11:42:34 +0300, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 08/08/2022 10:34, Yassine Oudjana wrote:
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> > 
> > Add DT schema for the switch-mode battery charger found on Qualcomm
> > PMICs such as PMI8994. Due to lack of documentation, some interrupt
> > descriptions might be inaccurate.
> > 
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > ---
> >  .../bindings/power/supply/qcom,smbchg.yaml    | 205 ++++++++++++++++++
> >  MAINTAINERS                                   |   8 +
> >  2 files changed, 213 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> > new file mode 100644
> > index 000000000000..d825a9c10b3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> > @@ -0,0 +1,205 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/qcom,smbchg.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm PMIC Switch-Mode Battery Charger
> > +
> > +maintainers:
> > +  - Yassine Oudjana <y.oudjana@protonmail.com>
> > +  - Alejandro Tafalla <atafalla@dnyon.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,pmi8994-smbchg
> > +      - qcom,pmi8996-smbchg
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  monitored-battery:
> > +    description: |
> > +      phandle of battery characteristics node.
> > +      The charger uses the following properties:
> > +      - charge-term-current-microamp
> > +      - constant-charge-current-max-microamp
> > +      - voltage-max-design-microvolt
> > +      The constant-charge-current-max-microamp and voltage-max-design-microvolt
> > +      properties must be set.
> > +      See Documentation/devicetree/bindings/power/supply/battery.yaml
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Charger error
> > +      - description: Charger inhibited
> > +      - description: Charger precharge safety timer timeout
> > +      - description: Charger charge safety timer timeout
> > +      - description: Charger pre to fast charging switch threshold reached
> > +      - description: Charger recharge threshold reached
> > +      - description: Charger taper threshold reached
> > +      - description: Charger charge termination threshold reached
> > +      - description: Battery hot
> > +      - description: Battery warm
> > +      - description: Battery cold
> > +      - description: Battery cool
> > +      - description: Battery overvoltage
> > +      - description: Battery low
> > +      - description: Battery missing
> > +      - description: Battery thermistor missing # unconfirmed
> > +      - description: USB input undervolt
> > +      - description: USB input overvolt
> > +      - description: USB input source detected
> > +      - description: OTG regulator failure
> > +      - description: OTG regulator overcurrent
> > +      - description: Automatic input current limiting done
> > +      - description: USB ID pin changed
> > +      - description: DC input undervolt
> > +      - description: DC input overvolt
> > +      - description: Power OK
> > +      - description: Temperature shutdown
> > +      - description: Watchdog timeout
> > +      - description: Flash failure
> > +      - description: OTST2 # unknown
> > +      - description: OTST3 # unknown
> 
> It seems you listed register interrupts, not physical pins. This should
> be interrupt lines.

I'm not sure what I'm supposed to do here. I couldn't find an interrupt-lines
property used anywhere so that's not what you meant, right?

