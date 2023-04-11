Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11D6DE603
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDKUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDKUuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192F40E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681246203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnJ89Jr7frkhLpQ5e8FVQom59cKoMcGSZpquVEiks/w=;
        b=cT6zhbtygNaO7Fa41W/yHNmH6M7R8ArCmeMdN/TxraDTE7bcqBUfa8mVvTK633gu6+4NkY
        WdqbVwOO/vHxrqDoxQqeP1FVvICP7ANp2QH+8Pcs8ZGdATYKsQ1DBq4XmjA1hTC2G9IGud
        xGWqbz08KE5EG0ZQiFgXH+VXo+gEAP4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-sk4HfPKkOQ2R5mVL1Du5_g-1; Tue, 11 Apr 2023 16:50:02 -0400
X-MC-Unique: sk4HfPKkOQ2R5mVL1Du5_g-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1842ab38ebcso5476200fac.19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681246201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnJ89Jr7frkhLpQ5e8FVQom59cKoMcGSZpquVEiks/w=;
        b=hxHJDbtdGt1t0EurPaCya/jr3dDa68SIcQCluxIqxPDglMxTceQLA4pCE4rtFWBIt9
         3W1WOTbY4XQj4LZ70vvRUFUvuPULwtQoQH4i6HL+c9qhfZRgPUj8ax2rYloeo4V8Wjab
         BrdeWCvPwaRpc8RqHdgJfIikkXBclvniu9lw00J/7f0gtN5TKE1ZgERQ1WWj5IY9FdMx
         5aVvVaVShj+Wq7Xev4RWx4EdSpYfKd6h70akzt6r9ZbqaXjcgLAeYKMKEK6ZviXexh1H
         mfne74Ie5Prrkk/54Gwo1zhyMcNhcB3LUmYjeimKm+9IMrdKxpyMqYAyyRmH6cSZ37PJ
         aAag==
X-Gm-Message-State: AAQBX9ecKft19pSU7CqAZaMowte/885li/DqdKIGgrGpSxn+hfCXXkk+
        1OXIPOurxBBTCb1kEpsLThieIyrHrXdF/tr5P0isZniPo+8Ru9BiHDm4Y/d1EMic/PXETs7eqnx
        8lZ6RzEOtoL7as8i633cDRnKhpnyvHTwGum6R8bikZ5mdOcY2aWLBlCcboF9NFz3FcuLXvS5pZs
        o9t2tfjTjdyuc=
X-Received: by 2002:a05:6870:32c9:b0:17f:6909:1618 with SMTP id r9-20020a05687032c900b0017f69091618mr8385071oac.5.1681246201378;
        Tue, 11 Apr 2023 13:50:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350a/jKcTh3Dg+IN29kMyFBcT98jFq7QbmEt+C4YJeNTF6M0ET6Rq1bJC/j+OEgYr3vcjHqKpaA==
X-Received: by 2002:a05:6870:32c9:b0:17f:6909:1618 with SMTP id r9-20020a05687032c900b0017f69091618mr8385021oac.5.1681246200922;
        Tue, 11 Apr 2023 13:50:00 -0700 (PDT)
Received: from halaney-x13s (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id s21-20020a056830149500b006a3e377f0d7sm499957otq.4.2023.04.11.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:50:00 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:49:57 -0500
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
Subject: Re: [PATCH net-next v4 00/12] Add EMAC3 support for sa8540p-ride
Message-ID: <20230411204957.kt5o4oraoxi7szts@halaney-x13s>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:03:57PM -0500, Andrew Halaney wrote:
> This is a forward port / upstream refactor of code delivered
> downstream by Qualcomm over at [0] to enable the DWMAC5 based
> implementation called EMAC3 on the sa8540p-ride dev board.
> 
> From what I can tell with the board schematic in hand,
> as well as the code delivered, the main changes needed are:
> 
>     1. A new address space layout for dwmac5/EMAC3 MTL/DMA regs
>     2. A new programming sequence required for the EMAC3 based platforms
> 
> This series makes the changes above as well as other housekeeping items
> such as converting dt-bindings to yaml, etc.
> 
> As requested[1], it has been split up by compilation deps / maintainer tree.
> I will post a link to the associated devicetree changes that together
> with this series get the hardware functioning.
> 

Link to the devicetree bits: https://lore.kernel.org/netdev/20230411202009.460650-1-ahalaney@redhat.com/T/#t

Thanks,
Andrew

