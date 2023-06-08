Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F172849E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjFHQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjFHQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:09:31 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3451BDF;
        Thu,  8 Jun 2023 09:09:30 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-777b4560ae8so26807539f.2;
        Thu, 08 Jun 2023 09:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240569; x=1688832569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8MAtXZkrsYG/HkNDt42uWE09jxVB49iJ0UFdWUAyow=;
        b=OLR6Eeudy+WLujveKYM9mYpLYDnTgYNOJUDLDJkDceejtMkZnN0aZxEIDHgZacF2UM
         OFPeDcYjc5Db/W9ywpFDAPuDLlrc9KYg0lJSIj8eADJMzDePFixJ/7RM3W6/M/n7PX3y
         I2QUxJGB5ZqVvi8RY4r3iRqpkr/FLGbpwBeDPJOYiC4JvvEljnDw8pIlD+SvQbtx0kxd
         8zBRH7wAIYwWEyUu6u+hixE1IdQOHeMlxvf10K2okPiT5kiyEYBSKR6lFzbNtfTNBorp
         AnZcpPqM6WkLIzLGeDmzmvfIg4oAq7NfmOo8nbq26/0BS0UjS1wXza79oOq0hd0Vkxs+
         HKYQ==
X-Gm-Message-State: AC+VfDxRj1KeaCO718ivoQfVZb/bgjknpasfFCMyxvAbNSS7/Uoku9Ez
        BHIOPDZkYdVmcZFE9Mowbg==
X-Google-Smtp-Source: ACHHUZ64aKy+sH0t8A7IOQ7qgaq0gx7MJX7wPrx+Ud/5T6iVeFYfh1Oqmiu/A65L7jv4nbkZXhpRKw==
X-Received: by 2002:a5e:834d:0:b0:778:82d1:39a3 with SMTP id y13-20020a5e834d000000b0077882d139a3mr10262471iom.13.1686240569183;
        Thu, 08 Jun 2023 09:09:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y14-20020a02a38e000000b004090c67f155sm358129jak.91.2023.06.08.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:09:28 -0700 (PDT)
Received: (nullmailer pid 2787707 invoked by uid 1000);
        Thu, 08 Jun 2023 16:09:25 -0000
Date:   Thu, 8 Jun 2023 10:09:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: Add Coresight Dummy Trace
Message-ID: <20230608160925.GA2780221-robh@kernel.org>
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-3-quic_hazha@quicinc.com>
 <99343862-6b6a-30ba-40e5-7f984434b1dc@linaro.org>
 <44524ce9-b24e-7e2d-819c-232149e29f0e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44524ce9-b24e-7e2d-819c-232149e29f0e@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:52:41PM +0800, Hao Zhang wrote:
> 
> 
> On 5/7/2023 4:04 PM, Krzysztof Kozlowski wrote:
> > On 05/05/2023 11:24, Hao Zhang wrote:
> > > Add new coresight-dummy.yaml file describing the bindings required
> > > to define coresight dummy trace in the device trees.
> > > 
> > > Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> > > ---
> > >   .../bindings/arm/arm,coresight-dummy.yaml     | 102 ++++++++++++++++++
> > >   1 file changed, 102 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> > > new file mode 100644
> > > index 000000000000..126518863eea
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> > > @@ -0,0 +1,102 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ARM Coresight Dummy component
> > > +
> > > +description: |
> > > +  Coresight Dummy Trace Module is for the specific devices that kernel
> > > +  don't have permission to access or configure, e.g., CoreSight TPDMs
> > > +  on Qualcomm platforms. So there need driver to register dummy devices
> > > +  as Coresight devices. It may also be used to define components that
> > > +  may not have any programming interfaces (e.g, static links), so that
> > > +  paths can be established in the driver. Provide Coresight API for
> > > +  dummy device operations, such as enabling and disabling dummy devices.
> > > +  Build the Coresight path for dummy sink or dummy source for debugging.
> > > +
> > > +  The primary use case of the coresight dummy is to build path in kernel
> > > +  side for dummy sink and dummy source.
> > > +
> > > +maintainers:
> > > +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> > > +  - Tao Zhang <quic_taozha@quicinc.com>
> > > +  - Hao Zhang <quic_hazha@quicinc.com>
> > > +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > 
> > You were asked to drop oneOf, not to replace with items. Drop items.
> > Drop oneOf. It's just enum.
> > 
> 
> Hi Krzysztof,
> 
> I will drop items and update it in the next version.
> 
> Thanks,
> Hao
> 
> > > +      - enum:
> > > +          - arm,coresight-dummy-sink
> > > +          - arm,coresight-dummy-source
> > > +
> > > +  out-ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port:
> > > +        description: Output connection from the source to Coresight
> > > +          Trace bus.
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +
> > > +  in-ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port:
> > > +        description: Input connection from the Coresight Trace bus to
> > > +          dummy sink, such as Embedded USB debugger(EUD).
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +if:
> > > +  # If the compatible contains the below value
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: arm,coresight-dummy-sink
> > > +
> > > +then:
> > > +  required:
> > > +    - in-ports
> > > +
> > > +else:
> > > +  required:
> > > +    - out-ports
> > 
> > No improvements. Implement Rob's comments.
> > 
> 
> Hi Krzysztof, Rob,
> 
> There are two comments from Rob:
> 1) I could imagine the OS wanting to know more information than just
> 'dummy'. Is data from an unknown source useful? Likewise, don't you want
> to know where you are sending data too?
> 2) This still allows the nodes when they don't make sense. I think this
> needs to be 2 schema files. The only common part is 'compatible' and
> that's not even shared.
> 
> 
> 1. The necessary information for coresight is connection(ports) between
> different components. However, this information is not very intuitive. There
> would be a generic change to support coresight name in the further. You can
> refer to the below link, this solution is still under discussion, I think
> it's also helpful for our query.
> https://lore.kernel.org/linux-arm-kernel/b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com/T/

I don't really have more input. I'm looking for input from coresight 
folks on this.

Design the binding so it is future proof. If you need to go back and add 
more data to the binding in the future you've lost. It is perfectly fine 
to have specific bindings with generic drivers (e.g. simple panel). Then 
if you need more capabilities than a generic driver, then you can add a 
specific driver in the future with no DT change.

> 2. Dummy driver is very simple, the only goal of it is to build a path in
> kernel for subsystem, so we want to handle dummy source and sink in one
> generic driver. For one same driver, shall we split the schema file?

schemas and drivers are not 1:1. So yes, split the schema.

Rob
