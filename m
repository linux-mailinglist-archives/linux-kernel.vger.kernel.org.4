Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29DB7252EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFGEf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjFGEfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0DFC;
        Tue,  6 Jun 2023 21:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D0163A7A;
        Wed,  7 Jun 2023 04:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7DEC433EF;
        Wed,  7 Jun 2023 04:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686112544;
        bh=P18xwHSQkIlN8lIUXoCRzo1fXi4iUk52n4ZPjP2Ek0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YP/ToqnJo2qSg2iIeGUY9YSgzegUrbZCLLs+xLllqyMHFQ2+ouHNIfJb5b6113fWf
         wrVKYV/FnfZ7U9pDQcFmWwstM4QF4Iuijuqz0wtpFMgbV+dlo4NcH7Cn5IQVddLIW5
         aok2jR/Wm5+Kn+4YlBxaooxrvZgtgEwnSSDGTlmDEbAJ56FIq8uxNwwVEa8rDumn0Q
         9Dvy8n1jr/IBoU6ng8X99B4rWb1oLokOLpTGNChIQqsvFtTX93LfG3DuUuag8zYFs2
         TQyaTYmblC1wqFTTFV5pVkH2itK5O0YrMxgzBrzGdsayWkgVA2qbIS36bL+ZY39viO
         Ja7pwVrEWGYZw==
Date:   Tue, 6 Jun 2023 21:35:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        simon.horman@corigine.com
Subject: Re: [PATCH net-next v6 3/6] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230606213542.3913d3b8@kernel.org>
In-Reply-To: <fd0f87b9-a822-c83a-4880-9ed1ac34794e@broadcom.com>
References: <1685657551-38291-1-git-send-email-justin.chen@broadcom.com>
        <1685657551-38291-4-git-send-email-justin.chen@broadcom.com>
        <20230602235859.79042ff0@kernel.org>
        <956dc20f-386c-f4fe-b827-1a749ee8af02@broadcom.com>
        <20230606171605.3c20ae79@kernel.org>
        <8601be87-4bcb-8e6b-5124-1c63150c7c40@broadcom.com>
        <20230606185453.582d3831@kernel.org>
        <024a6733-f552-c538-2b59-26058c750d66@broadcom.com>
        <20230606204500.04083bd8@kernel.org>
        <fd0f87b9-a822-c83a-4880-9ed1ac34794e@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 21:22:45 -0700 Justin Chen wrote:
> >> Through filters that can be programmed by the Host cpu or co-processor.  
> > 
> > How are the filter programmed by the host (in terms of user API)?  
> 
> You are stumbling upon my next objective here. This patch set does not 
> support this because it wasn't clear how to do it. The plan was to get 
> the base driver merged first then introduce a way to specify an offload 
> channel.

Alright.

> If you must know, I introduced a rxnfc flow_spec ring cookie to specify 
> an offload filter. Not sure if this is the right way to do it or not, 
> but figured this would be a future discussion.

We clean leave it for later indeed, but in case you're wondering -
that's unlikely to fly. My preference will be to expose the accelerator
port as a switch port, with a netdev and forward using TC flower etc.
With the netdev in place you'll have a place to report stats and all the
necessary diagnostics, which otherwise get crammed into random places.
I believe Florian asked about this in the past, I hope I'm being
consistent with my answer here :P
