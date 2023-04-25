Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004ED6EE7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjDYSrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjDYSq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:46:58 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966965A9;
        Tue, 25 Apr 2023 11:46:57 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-187b70ab997so32750024fac.0;
        Tue, 25 Apr 2023 11:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448416; x=1685040416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUQiQ/cycrAa4n9iZRt3Zgr4LfG6yW1fRE0hcsRmUfQ=;
        b=WoQcwEWCWwJYkurfoN5o3Hr75SbTZikgSbisRbGrm70/l/sIK4lGpbj9xrdw2DUTft
         rFsLrHMiFNH2/nkwj2EDvF17aLNO6Hq9d9x29YSgR73onUKmD8QuyBn4FbjMkdLGPHvV
         oLsywOWk7tOB5VidrGR+C0KVzDQemLrQY4RkkFQejrUb6EIdML+t1tVcMIWjXmvGtfH+
         8VdoJpWzdjy1AmU7Mf6ZvcFh80/b4wUEsglAEeLvNtiHa0VsNePUyb79ukjwiWU1gBkj
         lNacryLIGFRgw7WcHPp0jX3uNcJ+Sfcee/FIzu/8wP5hRS4EC52iMXWkhIrODzfZ82ZL
         3A1Q==
X-Gm-Message-State: AAQBX9eLADV8c+aw1Twg35kXb6OUbKnirkxX4N9ll2zsxN3Gvwhv0wdG
        Rhbj7CWzE5S7sMHqVUvtcA==
X-Google-Smtp-Source: AKy350a9gR40wr81MPVCWEPH2D/7sm+9b9p11s31OwD5EHu62Pt7kbhb85SbKjjVrnX0z5MDz6Fg4A==
X-Received: by 2002:a05:6830:130e:b0:6a1:2c80:5a3f with SMTP id p14-20020a056830130e00b006a12c805a3fmr9233595otq.19.1682448416562;
        Tue, 25 Apr 2023 11:46:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p26-20020a9d695a000000b006a13dd5c8a2sm5991901oto.5.2023.04.25.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:46:56 -0700 (PDT)
Received: (nullmailer pid 2070614 invoked by uid 1000);
        Tue, 25 Apr 2023 18:46:54 -0000
Date:   Tue, 25 Apr 2023 13:46:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: Add Coresight Dummy Trace
Message-ID: <20230425184654.GA2063541-robh@kernel.org>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
 <20230422073714.38844-3-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422073714.38844-3-quic_hazha@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 03:37:13PM +0800, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../bindings/arm/arm,coresight-dummy.yaml     | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> new file mode 100644
> index 000000000000..48d864aefaaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Coresight Dummy component
> +
> +description: |
> +  Coresight Dummy Trace Module is for the specific devices that kernel
> +  don't have permission to access or configure, e.g., CoreSight TPDMs
> +  on Qualcomm platforms. So there need driver to register dummy devices
> +  as Coresight devices. It may also be used to define components that
> +  may not have any programming interfaces (e.g, static links), so that
> +  paths can be established in the driver. Provide Coresight API for
> +  dummy device operations, such as enabling and disabling dummy devices.
> +  Build the Coresight path for dummy sink or dummy source for debugging.
> +
> +  The primary use case of the coresight dummy is to build path in kernel
> +  side for dummy sink and dummy source.

I could imagine the OS wanting to know more information than just 
'dummy'. Is data from an unknown source useful? Likewise, don't you want 
to know where you are sending data too?

> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:

Don't need oneOf as there is only one entry.

> +          - arm,coresight-dummy-sink
> +          - arm,coresight-dummy-source
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the source to Coresight
> +          Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +          dummy sink, such as Embedded USB debugger(EUD).
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +
> +if:
> +  # If the compatible contains the below value
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,coresight-dummy-sink
> +
> +then:
> +  required:
> +    - in-ports
> +
> +else:
> +  required:
> +    - out-ports

This still allows the nodes when they don't make sense. I think this 
needs to be 2 schema files. The only common part is 'compatible' and 
that's not even shared.

Rob
