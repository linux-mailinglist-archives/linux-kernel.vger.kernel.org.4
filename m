Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FA6D2AEC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjCaWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjCaWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431942222B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680300379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4U8Z/tCC6KI1ZHcEPqkuT5mdoVjDaEr2xngNPO60lM=;
        b=IlEqMEPojEaikvMp5LySoJ751uXtc1NLG4FFP/JG1WTCopoqbb2qa9cDfQheQNX+6+XvZm
        lzJ2Y1DeXnHnw0GFlAHvCadgUa+7Urm24NMPXMS5df0vsUTn2nLmF6Etu3YVx+rrDHsznw
        44Y5APrQ66U/sU5tTp1y44xe1F2raLo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-A6dwCGj6OoSf5kVHcP-mIA-1; Fri, 31 Mar 2023 18:06:18 -0400
X-MC-Unique: A6dwCGj6OoSf5kVHcP-mIA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17714741d9dso11895494fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680300377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4U8Z/tCC6KI1ZHcEPqkuT5mdoVjDaEr2xngNPO60lM=;
        b=h6z2prU+fAo62X0ktJwrE4Lrlertjfl8T04K2eST/ktd/F0iiu/zgseFfsRYCp0Ufw
         2D6f7gGzwFTDUvFq+O5rfGcjSz5YLJwlIx/86dmdoyD12ZZDeBQpWbPRH2XfumUhtllB
         T8VgC2Hj7ZaA18Ai1jZccF3tnudKCm2mXIioYmzEUmJZ0iLWfTQGOqMv30F1i6Dm9fMC
         fEs5OFywTbhgbQ9ovVqB3TshyApBp7TQpCU9IFkuSKp5ixp9nqOkGhMntgW5x7G1r7tb
         LHygkH6uiOEsrGs0ZnRrvpChSL/2lacRJBv4Gcct1VNLahC14T7Jv4+TvZm327TmG2rX
         y8kg==
X-Gm-Message-State: AAQBX9dSlgjah6vU9Yu58dO+Rh6inNT9CmrTQAqDG8knpV1egXiTpmgc
        d6iWUfuIu5xF0bQFKuddrT5b0goL5QJ2L0Kv8rXg9WvFSSbCk3hynfyy6cc046CuOxN69bF+D/s
        htvQffNl0poNRPRlKXYL0lZCQdXEftKJ/3tfx6Soz0ZBRcQJEiP/z9uBsVQ6WQgKVk/MmvAhaFl
        ya9u+1n4f1Vp8=
X-Received: by 2002:a05:6871:282:b0:172:80fd:8482 with SMTP id i2-20020a056871028200b0017280fd8482mr19329679oae.5.1680300376920;
        Fri, 31 Mar 2023 15:06:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350bGGsF2laKAGdPP0P41FMsK9S+A2djDpOUWZkU3NZ+9W7d4GHZmrs+i2VfMoBvGhIEn0N/dew==
X-Received: by 2002:a05:6871:282:b0:172:80fd:8482 with SMTP id i2-20020a056871028200b0017280fd8482mr19329633oae.5.1680300376680;
        Fri, 31 Mar 2023 15:06:16 -0700 (PDT)
Received: from halaney-x13s (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id h11-20020a9d798b000000b0069f74706056sm641395otm.9.2023.03.31.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 15:06:16 -0700 (PDT)
Date:   Fri, 31 Mar 2023 17:06:13 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com
Subject: Re: [PATCH net-next v3 00/12] Add EMAC3 support for sa8540p-ride
Message-ID: <20230331220613.2cr2r5mcf2wwse4j@halaney-x13s>
References: <20230331214549.756660-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331214549.756660-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 04:45:37PM -0500, Andrew Halaney wrote:
> This is a forward port / upstream refactor of code delivered
> downstream by Qualcomm over at [0] to enable the DWMAC5 based
> implementation called EMAC3 on the sa8540p-ride dev board.
> 
> From what I can tell with the board schematic in hand,
> as well as the code delivered, the main changes needed are:
> 
>     1. A new address space layout for /dwmac5/EMAC3 MTL/DMA regs
>     2. A new programming sequence required for the EMAC3 base platforms
> 
> This series makes the change for 1 above as well as other housekeeping items
> such as converting dt-bindings to yaml, etc.
> 
> As requested[1], it has been split up by compile time / maintainer tree.
> I will post a link to the associated devicetree changes that together
> with this series get the hardware functioning.

As promised: https://lore.kernel.org/netdev/20230331215804.783439-1-ahalaney@redhat.com/T/#t

Thanks in advance for any reviews!
- Andrew

