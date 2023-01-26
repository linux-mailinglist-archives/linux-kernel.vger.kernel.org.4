Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395467D68B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjAZUhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjAZUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348C4E530
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674765382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4KxlWv6KpVe3egxVDGwOgJo4CmF2S3SgyJLNLgqiQ=;
        b=Zs36ARyMBIiHxQ3jIhPDpW5de11195qdyazOTJpPZ1ZIXc23p0YiuKAkeTaqL2lqRjL+LE
        PbdV6XlSoRbGqM2OjQ/eWSrELvr75qq/D5yxg3ZNgQAA5xwd1Xmkje01lpW/1Byw/O5TFh
        fdFrLPtYOkdBWLfZTsnWs6xYpxtsQpE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-asq64vrMOnC3JmYOrKPzQA-1; Thu, 26 Jan 2023 15:36:20 -0500
X-MC-Unique: asq64vrMOnC3JmYOrKPzQA-1
Received: by mail-qk1-f200.google.com with SMTP id c18-20020a05620a269200b0070d0f35e15eso1756430qkp.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw4KxlWv6KpVe3egxVDGwOgJo4CmF2S3SgyJLNLgqiQ=;
        b=Fpp7YsPaf/iW1DbrP9PAMr/PhDlGMultwg085mWJfQ86L5lzFuUPWgPxurroXW2qG6
         SHadqlvUP0EP8Jdq+isbH1BS0etBgz3QCLVmhdh6zrfxD1cONNVxBCZXy7+xP/aKLgqZ
         4psKfEoItZ7zn35I9o8uHDcwiqzO+tCezIoKOJIctn1lxHJWjB88iF14JdrQdeYUxCdm
         OK6ROPsd2D/e8YkMribH0Lw/N9RXSRK7jyK89knZ0pYVeXrQkLyRfN5xyBDvCD+P6fbR
         jBBW/wtdvy7IyJTYFWc76TiPjbWpKgPhnJp5guDo1Hj0ABhiBOqPfuFQMhRfuViLBByK
         PZVA==
X-Gm-Message-State: AFqh2kp8SYkDsf6j3AHGF9iz63PBAemew9s8P74g2iocw8309McrJCSI
        45nRsGVZqkf/4sb7aeQ8jyDY2CV0HCWcQRruiqapO9CnPzzweAy1FdGEjgAhdrsMfjXov7tfGep
        K2PC52vFyzxGkE8Ib1Dh3EhRv
X-Received: by 2002:a05:6214:5e04:b0:531:e1dd:c4d0 with SMTP id li4-20020a0562145e0400b00531e1ddc4d0mr54232899qvb.37.1674765379843;
        Thu, 26 Jan 2023 12:36:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvwOFBTT+t6+IREbUQb6eiBYg2AMk1i+IREHkHQzlfvLVMlpLpWNUZpAG89LRG9LhLj1H0Jxw==
X-Received: by 2002:a05:6214:5e04:b0:531:e1dd:c4d0 with SMTP id li4-20020a0562145e0400b00531e1ddc4d0mr54232878qvb.37.1674765379636;
        Thu, 26 Jan 2023 12:36:19 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c2-20020a37e102000000b006fec1c0754csm1526771qkm.87.2023.01.26.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:36:19 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:18 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: document the
 interconnects for sa8775p
Message-ID: <20230126203618.nbqwppaddncq7on7@echanude>
References: <20230118140825.242544-1-brgl@bgdev.pl>
 <20230118140825.242544-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118140825.242544-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:08:24PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a DT binding document for the RPMh interconnects on Qualcomm sa8775p
> platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       |  50 ++++
>  .../interconnect/qcom,sa8775p-rpmh.h          | 231 ++++++++++++++++++
>  2 files changed, 281 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sa8775p-rpmh.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> new file mode 100644
> index 000000000000..672c7aaa8ed7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sa8775p-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SA8875P

s/SA8875P/SA8775P/

-- 
Eric Chanudet

