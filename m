Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C263AE23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiK1QzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiK1QzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:55:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA251D0D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:55:14 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d123so8032346iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1d3sbSB153YFVx4HRjX3fuIz12BKVhol+9SQxjrH1A=;
        b=RBb2b8Ro6/aBOzwMx/C9FgHppT9WGFbhf7fR6teBrsO9J662xBpUMgZB86z+5RWKvA
         hVgWpdqNG4gx7nKpGeyAXSbQRMd2hTHx9SAW1thvcZ7el8Y+vW4OCbjMzVCCQu6FSdNc
         52ykCgZdmKvCbcxUtOEd77++vboUPczDscY3yo0oaL8Eo0MfKfgT4ASNaYQzNTPbRRJ3
         jsHer9WGkzn88B6Zk4QVD92AFQG4f9ZIshLSMjWtCPEAsY+ToAR0GwD/VmpMr/98Gb4V
         X4KwhIviEitLTxnjTjR7it+M64V+6NyxywlxccgL7CDPN570hponZpq93/z0QR1NysK5
         xNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1d3sbSB153YFVx4HRjX3fuIz12BKVhol+9SQxjrH1A=;
        b=K3Zgw9B8Uco0Uu0lxNiAl/sMUo0AopbhgNQAzTZHRKRfPKMBfNvkD6RPdOeN0neafq
         LobyPPasXZFu6ow9BacWAyy6+jXcshgdlimSG+wtYg+ibzkuXGMx2zOXO++Y5tmEpmKi
         68Vgx4SiNuyHyqhnXbOasMRdhmpYDM1jcNLvOKhOOvix40AIrVkZHMck/PQGmaON+107
         Ym01RqYoVQ1P2gTT3yIx0xORQDkW+/CAeMCgSgoCqhh1V3oppzYQniS/XXG3QAPt8aTJ
         abVj9f9F2x+l9FqtEk5pXFrwOSKBDE6Rp1oOEN4Yt5zNHv+py1paLfRLowgrxH4GCACO
         NYHg==
X-Gm-Message-State: ANoB5pmWnHD/knnwELdyziuZG/vnIp62srfl9LXQdNfGmoWikxv9PSZq
        +/L3AY7fgzBE7nFDJSnA8oUgxUgbufrDVQ==
X-Google-Smtp-Source: AA0mqf4ZCKVCscp3J6B+BpbGhbiFbw+Qjj3outsorwzAGzEs2ARb4sJEnrtlX/uWugqa2AlPvvAhgA==
X-Received: by 2002:a02:a68b:0:b0:374:98f7:2ad2 with SMTP id j11-20020a02a68b000000b0037498f72ad2mr23732347jam.0.1669654513940;
        Mon, 28 Nov 2022 08:55:13 -0800 (PST)
Received: from google.com (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with ESMTPSA id k29-20020a02335d000000b003495b85a3b9sm4382646jak.178.2022.11.28.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:55:13 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:55:10 +0000
From:   Matthias Kaehlcke <mka@google.com>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sc7280: Add DT for
 sc7280-herobrine-zombie
Message-ID: <Y4Tn7jemqoR2u2TZ@google.com>
References: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <20221125174415.v5.2.I5fa17e079100361ef6809efa0bba2bf32f829e15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125174415.v5.2.I5fa17e079100361ef6809efa0bba2bf32f829e15@changeid>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Owen,

On Fri, Nov 25, 2022 at 05:44:25PM +0800, Owen Yang wrote:
> Add DT for sc7280-herobrine-zombie
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>

> Changes in v5:
> - Overwrite pm8350c_pwm_backlight setting in sc7280-herobrine-zombie.dtsi for chrome zombie. v5.
> - Dropping the redundant 'DT binding for' as requested by Krzysztof. v4.
> - Adding an empty line here before "/dts-v1/;" in "sc7280-herobrine-zombie-lte.dts", "sc7280-herobrine-zombie.dts" as requested by Matthias. v4.
> - Deleteing "/dts-v1/;" in "sc7280-herobrine-zombie.dtsi" as requested by Matthias. v4.
> - Droping changing file path in description. v3. as requested by Matthias. v3.
> - Changing Patch order, binding patch first and dt file second, as requested by Douglas. v2.
> - Adding "arm64: dts: qcom: sc7280:" in dt patch ${SUBJECT}, as requested by Douglas. v2.
> - Adding "dt-bindings: arm: qcom:" in bind patch ${SUBJECT}, as requested by Douglas. v2.
> - Adding '#include "sc7280-herobrine-wifi-sku.dtsi"' in sc7280-herobrine-zombie.dts, as requested by Douglas. v2.
> - Adding "(newest rev)" for zombie entry description in qcom.yaml, as requested by Douglas. v2.
> - Adding "post-power-on-delay-ms = <100>;" for trackpad in "sc7280-herobrine-zombie.dtsi". v2
> - Changing "vcc-supply" to "vdd-supply" for trackpad in "sc7280-herobrine-zombie.dtsi", as requested by Douglas. v2.

For future patches please better organize the change log like this:

Changes in v5:
- Overwrite pm8350c_pwm_backlight setting in sc7280-herobrine-zombie.dtsi for chrome zombie

Changes in v4:
- Dropping the redundant 'DT binding for' as requested by Krzysztof
- Adding an empty line here before "/dts-v1/;" in "sc7280-herobrine-zombie-lte.dts", "sc7280-herobrine-zombie.dts" as requested by Matthias
- Deleteing "/dts-v1/;" in "sc7280-herobrine-zombie.dtsi" as requested by Matthias

...

If you are using patman you can keep the existing 'Commit-changes: vN' entries
from the previous versions and just add a new entry for the current version.

No need to re-spin the patches just for change log.

> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> new file mode 100644
> index 000000000000..d10362ecdafb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
>
> ...
>
> +&pm8350c_pwm_backlight{
> +	pwms = <&pm8350c_pwm 3 200000>;
> +};

Why is this change needed?
