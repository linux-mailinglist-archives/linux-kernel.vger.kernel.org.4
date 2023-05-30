Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E86715EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjE3MPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjE3MOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:14:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E07C7;
        Tue, 30 May 2023 05:14:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256712d65ceso1475227a91.1;
        Tue, 30 May 2023 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685448890; x=1688040890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+MgT1FKi8QRhIXurt+ra0ok8EMIh+YKcmCY8v006bc=;
        b=QNHsOWlWjDdyhqOnCh8Df1YFdzajIzb4plEq2WamdbG9YAWyExSoK8u6WOUPwnLdrn
         ol7pgcUYuagYleQWlM94u7fwBEs2jfLE1973x7UFia957K3Q9tIJDpj4TGMHNxiElz75
         n2qSv1ephMKxNvNVMGnVrW4zEWbisKE0plihgeppsGC3/ovCkusgmetRzlluRTUltvF0
         cvWfo/Y+seVJlYFaCa6hm3Wjkiezr2qETO1tnDrFY6diZ4QCZBzlCHyewwVJJA/3PgpS
         SuwXpop5KDrVI9zpaiatrPtQEPwEN95rFEIq+Z9XRSEXHQDm/9yFVMWE+PJk5CUSpW1p
         lVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685448890; x=1688040890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+MgT1FKi8QRhIXurt+ra0ok8EMIh+YKcmCY8v006bc=;
        b=HyBhYOQVc9w0ny8qysbCZBpM9RlnEY5oXAtQZG7xM71LWiB1M6eySy0rN6WoJswq8y
         DiAVCvFnW3U6u0UISeffVQtP1vhujxlwFVw7st1BBITokts5Rya5YZSMYVlki9PGUeFf
         DciFDXvCqS7j1iKfbvzc7KZwRuYdktH/1hiN2D6eXHRy1a/r8WBme/I0O7uZlIFsCrCn
         P9As5xUVdpmDQnVVIk8zkaJbNDTfVu3xzdXU3b03ZJ99ulrWp8qsjsEVPPMdDMiqzVIp
         01nsVnqxczpCi+t2WdVGxv/UMAFq87DTghgo45vBcfDyJDMN+aX/HGjzGRHpdLH45BKZ
         O+qA==
X-Gm-Message-State: AC+VfDwaJVbWuJ0CwQXaGX93ATbVs6plOhdnLIJ5A6h47VQvcQ+Bma67
        atTmdbzt+pSB+MsEZecHVy0=
X-Google-Smtp-Source: ACHHUZ4v6lgc/nGjmXES7OKszOYkk7o41YtPwiA3ELfz6KEeYZEIINq2lv5oXgUS3DFCHibjz+IAmw==
X-Received: by 2002:a17:90b:350e:b0:246:af1f:62ef with SMTP id ls14-20020a17090b350e00b00246af1f62efmr2687689pjb.5.1685448889630;
        Tue, 30 May 2023 05:14:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a632b06000000b0053f2037d639sm8693033pgr.81.2023.05.30.05.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:14:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 May 2023 05:14:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V4 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog
Message-ID: <fab945af-f42a-463d-95bb-89dc5509cae4@roeck-us.net>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
 <20230420104231.2243079-3-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420104231.2243079-3-srinivas.neeli@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 04:12:29PM +0530, Srinivas Neeli wrote:
> Versal watchdog IP uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and
> a period that is not too late.
> 
> Add devicetree bindings for versal window watchdog device.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V4:
> - Updated commit subject(removed redundant "bindings").
> - Updated commit descriptioni(removed "this patch").
> - Updated watchdog.yaml reference to local.
> Changes in V3:
> - Removed  xlnx,close_percent property.
> Changes in V2:
> - Added watchdog ref
> - Removed timeout-sec property
> - Used 4 spaces for example indentation.
> ---
>  .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> new file mode 100644
> index 000000000000..14b069599740
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/xlnx,versal-wwdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal window watchdog timer controller
> +
> +maintainers:
> +  - Neeli Srinivas <srinivas.neeli@amd.com>
> +
> +description:
> +  Versal watchdog intellectual property uses window watchdog mode.
> +  Window watchdog timer(WWDT) contains closed(first) and open(second)
> +  window with 32 bit width. Write to the watchdog timer within
> +  predefined window periods of time. This means a period that is not
> +  too soon and a period that is not too late. The WWDT has to be
> +  restarted within the open window time. If software tries to restart
> +  WWDT outside of the open window time period, it generates a reset.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,versal-wwdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@fd4d0000 {
> +        compatible = "xlnx,versal-wwdt";
> +        reg = <0xfd4d0000 0x10000>;
> +        clocks = <&clock25>;
> +        timeout-sec = <30>;
> +    };
> +...
> -- 
> 2.25.1
> 
