Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1F6BD184
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCPNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCPNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:53:50 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FEEB863B;
        Thu, 16 Mar 2023 06:53:45 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q6so816349iot.2;
        Thu, 16 Mar 2023 06:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974824;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3NLIIOkA38T8xNi8thzCJbEyjLbfAZFAf+qOplovd1I=;
        b=AgKBA1mmQ/nOAlYNUVi1QsYArvws0c7T7RBh/e8pEa+KhynPPpOqEo5E/mAAbzYO9/
         wMCHlU0lA2ZVtblAzyabGL//aEZHABOMKVlkMlnJ0oQdNePY2x/CkfaxQ//Q2RRxjhzn
         b88hoI5WNVUda3rH9BjTGSSmGRa3wUkTs8SfDG6jLER1KfKhrhkxnbF9mPC/G15W0T3i
         KXUsJqUvfwpoTQI/02OnSMGYkYFZv10nAOuoWzbebsU2eNaJ5PRUggHii47KG06SLwz5
         jdAgGoUsmzSUSW8YGnrsS/877kcLC5UziKEzC7GShNyDl5IiUGnL8UJhHVuoR0tZwhLF
         3Dpw==
X-Gm-Message-State: AO0yUKUVbmzu5lK5MS/WP3924qIglI34yCgxNDESDh8blX/WhYCjgBNw
        RXUbjjne3YfBjH3LLTRkiQ==
X-Google-Smtp-Source: AK7set8f/p7VDlt1VGn8Rrvxnn6ydrU6sfuFHCeMsWbwQmRzOITADPQaBi2wwy29Mr5G8EmDMLIVAA==
X-Received: by 2002:a5d:84cc:0:b0:74c:a9ab:ce68 with SMTP id z12-20020a5d84cc000000b0074ca9abce68mr28374793ior.12.1678974823861;
        Thu, 16 Mar 2023 06:53:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638119000b003a60da2bf58sm2521766jas.39.2023.03.16.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:53:43 -0700 (PDT)
Received: (nullmailer pid 2744946 invoked by uid 1000);
        Thu, 16 Mar 2023 13:53:34 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-doc@vger.kernel.org,
        Tao Zhang <quic_taozha@quicinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        coresight@lists.linaro.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
In-Reply-To: <20230316032005.6509-3-quic_hazha@quicinc.com>
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
 <20230316032005.6509-3-quic_hazha@quicinc.com>
Message-Id: <167897435275.2729718.16512739524975963906.robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: Add Coresight Dummy Trace
 YAML schema
Date:   Thu, 16 Mar 2023 08:53:34 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Mar 2023 11:20:04 +0800, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-dummy.yaml    | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml:91:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml: required:4: {'oneOf': ['qcom,dummy-sink', 'qcom,dummy-source']} is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml: ignoring, error in schema: required: 4
Documentation/devicetree/bindings/arm/qcom,coresight-dummy.example.dtb: /example-0/dummy_sink: failed to match any schema with compatible: ['qcom,dummy']
Documentation/devicetree/bindings/arm/qcom,coresight-dummy.example.dtb: /example-1/dummy_source: failed to match any schema with compatible: ['qcom,dummy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230316032005.6509-3-quic_hazha@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

