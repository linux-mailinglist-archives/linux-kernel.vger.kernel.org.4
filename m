Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC946DF9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDLP0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDLP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A55E4C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pl6/W8hCGdRrPSVdraI8ut0BaCLlf4yrRN6pHHW/94A=;
        b=aYSzuHfh3Am7qMD2z7lxm/YU5ZmwvCJ3j9Z7w1olbtd5nR5HAq08bmk3vdCzhs1X4LoX33
        9cYHXYGHkMhEtfBlJRTk4TdsejeE7G4RRDcAZWWYkMU4rXtULGE2QxNZFRqfHfQjwKRO8g
        lr5PE4/yMMvL5PD3pEQbRqSLoTNX65Q=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-StolHqkTMDS48q-CTMdz2A-1; Wed, 12 Apr 2023 11:25:23 -0400
X-MC-Unique: StolHqkTMDS48q-CTMdz2A-1
Received: by mail-yb1-f197.google.com with SMTP id 85-20020a250d58000000b00b8f380b2bccso2695064ybn.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl6/W8hCGdRrPSVdraI8ut0BaCLlf4yrRN6pHHW/94A=;
        b=Y3B9RJ0K5i/m0AtLfhWN7m2Q/vIX89/D0XhPx6Siq82ffgn5UUebMQdm9UOWp1KYd9
         gKNnVLTJngz6ruafHVWSwKWzEqW4Y6vJXs9weXkizzsZ26OqsEa+oZBxtHszGefZqRXL
         7BO7xFqgORe6SnmJMndbQpDpR3mfwuYV5camOpo0zQowV5Quq1FJe1k+l2l7yLVbVTU+
         wHNYvEcTyXT9YlmAWcBNG4sYAu1WThHz8/eM5cTmEXDeDhkfuX7DNPtO+/95c+p4N9r5
         qFOYHEadGuA//uy3G1KpAzr+N+cCNOTJTkSC9V2zpi1r5AiQUKZY1N3tq+1I2vKmf+DI
         sVrA==
X-Gm-Message-State: AAQBX9cLDmKtMgaH0K3Y4NVZ/V9etaCzpcd+w70Htz11vFUWBBou4j3k
        FhLy8XSReht533r9R/AyrjGF+1orWvHp3ft4G6H7o9Lh4pTi/PMqqEeN1h4U1mKcVQN9qBpU4xw
        ROxSk+3C1PrycPvzoc8PIKV8z
X-Received: by 2002:a25:ad94:0:b0:b62:d9a1:a606 with SMTP id z20-20020a25ad94000000b00b62d9a1a606mr14571416ybi.62.1681313123354;
        Wed, 12 Apr 2023 08:25:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350adNn8pbkwJ2Kq0277gghgwLXefMb+eA4EygwfbHqcH5RZ9YG9iTFp0U4fQIhM3iOy8sYtlRg==
X-Received: by 2002:a25:ad94:0:b0:b62:d9a1:a606 with SMTP id z20-20020a25ad94000000b00b62d9a1a606mr14571401ybi.62.1681313123021;
        Wed, 12 Apr 2023 08:25:23 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id e140-20020a811e92000000b0054f8a3f6281sm686495ywe.3.2023.04.12.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:25:22 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:25:18 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com
Subject: Re: [PATCH net-next v4 00/12] Add EMAC3 support for sa8540p-ride
Message-ID: <ZDbNXvHiyGuF2A49@x1>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
> Patches 1-3 are clean ups of the currently supported dt-bindings and
> IMO could be picked up as is independent of the rest of the series to
> improve the current codebase. They've all been reviewed in prior
> versions of the series.
> 
> Patches 5-7 are also clean ups of the driver and are worth picking up
> independently as well. They don't all have explicit reviews but should
> be good to go (trivial changes on non-reviewed bits).
> 
> The rest of the patches have new changes, lack review, or are specificly
> being made to support the new hardware, so they should wait until the
> series as a whole is deemed ready to go by the community.

Looks good to me!

Tested-by: Brian Masney <bmasney@redhat.com>

