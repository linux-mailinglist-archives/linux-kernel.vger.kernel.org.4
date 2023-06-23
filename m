Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129073B705
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFWMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:21:28 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5821BFA;
        Fri, 23 Jun 2023 05:21:27 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-341ff6251f2so2056965ab.0;
        Fri, 23 Jun 2023 05:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687522887; x=1690114887;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQSdFJAVTnk3qxJjfylhV8RKjwAoWiB8oCEQSQ64LXw=;
        b=XBDdiwJc+DcefDw4HrP2TtB9UfY7/Wdb6EqGuvfKi1HqwYvF8aM1cONX4jaS+Aa5MB
         MX0r3MwEiwgYTrHc827SEihECQ4t1e24t1GHV44e1wEZx/1h8bMTIru2MTmPgU+p5qt9
         XzaP9yW0iFChDM2KnJo4306E9KCESZMhK9dFNTFMUsOIOUfsFKA9Znr6ppHZucOJy9yK
         l2ChXlpU41tz2Edw3mH0t+PJuGi4dbc4u55tri9+MyHfnJJZRYHEX//IS++UDba8k8qp
         ith83KATfse3RJRN6cJFRoDMrkkH4S3z7miRuXctwki3VYQJQVIZmFiX1LBPNYEb8Qqa
         qzzA==
X-Gm-Message-State: AC+VfDzwKYi3gRuspGPNJDWsJB/eEsYDbe8IkdaT17heYbf3xPv7u/Dd
        3QlILtY4rVbTqaIASn4jpA==
X-Google-Smtp-Source: ACHHUZ6PvkiRbelDYtDOJYRBqil07WdG7hR4Lr/TlrWUoohyLS1Z2dU2OmjmbHVB8LqMKTR0Hg67nQ==
X-Received: by 2002:a92:c143:0:b0:33d:6988:bfea with SMTP id b3-20020a92c143000000b0033d6988bfeamr16680004ilh.21.1687522886662;
        Fri, 23 Jun 2023 05:21:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v2-20020a92d242000000b003443732257asm663017ilg.57.2023.06.23.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:21:25 -0700 (PDT)
Received: (nullmailer pid 27048 invoked by uid 1000);
        Fri, 23 Jun 2023 12:21:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230623113009.2512206-5-abel.vesa@linaro.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-5-abel.vesa@linaro.org>
Message-Id: <168752288418.27031.1090471926569361855.robh@kernel.org>
Subject: Re: [PATCH 4/5] scsi: dt-bindings: ufs: qcom: Fix sm8450 clocks
Date:   Fri, 23 Jun 2023 06:21:24 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 14:30:08 +0300, Abel Vesa wrote:
> The sm8450 has an ICE clock, so move the compatible to the proper
> clocks check.
> 
> Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clocks: [[4294967295, 151], [4294967295, 10], [4294967295, 150], [4294967295, 166], [4294967295, 0], [4294967295, 164], [4294967295, 160], [4294967295, 162]] is too short
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clock-names: ['core_clk', 'bus_aggr_clk', 'iface_clk', 'core_clk_unipro', 'ref_clk', 'tx_lane0_sync_clk', 'rx_lane0_sync_clk', 'rx_lane1_sync_clk'] is too short
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: reg: [[0, 30949376, 0, 12288]] is too short
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230623113009.2512206-5-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

