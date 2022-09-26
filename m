Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0845EB047
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIZSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIZSl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:41:29 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FDC371BE;
        Mon, 26 Sep 2022 11:40:33 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278624b7c4so10406280fac.5;
        Mon, 26 Sep 2022 11:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jOftl44zGA/j7b6jC5BfWvHZRnHvotAovSxfOgGEkoo=;
        b=g24guHzggQs3myammUxgM38C6N3mcGYIIFr+sLHEVvEw2Uhuh7+yFcusIpAKJRcucO
         7sKIJSAjRbBPuorViobHHm9Sg2RfTaTPHOSxN5Ln6m2Bsh3Mo2asr0NVklv2qgiyFaRC
         N/G6Vo0BLw/+xeg967KtR20tcWVW3xrpeNcdwFL9cxk9Ce6X8Fr7Wug/C+eVSc6tcdkw
         Idt3T86pi/jw9kTVS0RvizvD9iVU5hZLxdCXx7MhxtYltgehZlA0b+FPA/CpcNAe+gNw
         Uu06Cy1vmj6Nq07qH/5ftzruAVH+AkgZUMfJYZnwm1STc5vEBfFU/FXwFjZCV6OoMBnC
         coDw==
X-Gm-Message-State: ACrzQf2ieqQmYYuFpPJ/qH7DZZKL5GiUg5qQKtQVrCffqBS4OBriGtz/
        SKWfRrqAdi+T27B9Wcx9OQ==
X-Google-Smtp-Source: AMsMyM6CJ/qhJwuMc45cCjEUUDZtxi2hbfOF0apEHjAHZOF15YxgXO5YHOoCtO/8OFgsZ1yuZ+HEBg==
X-Received: by 2002:a05:6870:c22a:b0:127:cba8:6b19 with SMTP id z42-20020a056870c22a00b00127cba86b19mr51044oae.151.1664217597994;
        Mon, 26 Sep 2022 11:39:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l19-20020a4ae2d3000000b0044884c40c8asm6934334oot.30.2022.09.26.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:39:57 -0700 (PDT)
Received: (nullmailer pid 2547832 invoked by uid 1000);
        Mon, 26 Sep 2022 18:39:57 -0000
Date:   Mon, 26 Sep 2022 13:39:57 -0500
From:   robh@kernel.org
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3] dt-bindings: virtio: Convert virtio,pci-iommu to DT
 schema
Message-ID: <20220926183957.GA2547766-robh@kernel.org>
References: <20220923074435.420531-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923074435.420531-1-jean-philippe@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 08:44:38 +0100, Jean-Philippe Brucker wrote:
> Convert the binding that describes the virtio-pci based IOMMU to DT
> schema. Change the compatible string to "pci<vendor>,<device>", which is
> defined by the PCI Bus Binding, but keep "virtio,pci-iommu" as an option
> for backward compatibility.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v3: Renamed file and type to pci-iommu
> v2: https://lore.kernel.org/linux-devicetree/20220922161644.372181-1-jean-philippe@linaro.org/
> ---
>  .../devicetree/bindings/virtio/iommu.txt      |  66 ------------
>  .../devicetree/bindings/virtio/pci-iommu.yaml | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/virtio/pci-iommu.yaml
> 

Applied, thanks!
