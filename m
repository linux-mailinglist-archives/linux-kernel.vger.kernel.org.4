Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB072E1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjFMLiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjFMLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:38:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC32F7;
        Tue, 13 Jun 2023 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686656290; x=1718192290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIZrY5TljSFD0HBXV6l1MOaL4rgBtNOPn6wu8/2Gd+Y=;
  b=F0KW/lCeplfkxSTqBYEdsFubzQcyAjqKP+W+WTTDU0msZYykyf75LALr
   hc3ACeoyfblPZp57RuoIyG4IFE8eQWQQ+zFUhiCoc1jVd8Hu/TfBYY9uR
   fK2E7mXFDQpL5hSgFjitIsthnW2i3bFi6tOtCOAgA/5UnLaGJ3W75dEc7
   V1hHDMPmaD22oi3At727lLfpU45Mf/KC6stbVvlnX3nwKoBd52rkaH8R7
   hXudNr/nlZc6eiGE9llniZvAgzHwc/urYUkYfAx6cB7SGYl2QtL6CJrPi
   aqz1A4dPNqb3Pa0G6kNuYcI1BNpi0rmlqprHlnljWrvKP0cMvkbSBEqBB
   w==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="156740761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 04:38:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 04:38:09 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 04:38:09 -0700
Date:   Tue, 13 Jun 2023 13:38:08 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: micrel: Change how to read TX
 timestamp
Message-ID: <20230613113808.mqasva7fuoxuurab@soft-dev3-1>
References: <20230613094526.69532-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230613094526.69532-1-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/13/2023 11:45, Horatiu Vultur wrote:

Argh... I forgot add Richard to this thread. Therefore CC him now.

> Change how to read the timestamp of the received frames. Currently it is
> required to read over the MDIO bus each of the timestamps but it is
> possible to change to receive the timestamp (the nanosecond part and the
> least significant two bits of the second) in the frame.
> The first patch makes this change, while the second patch optimized the
> read of second part. Because it is not required to read the second part
> of the timestmap for each received frame but it is OK to read the second
> part twice per second and then cache it.
> 
> v1->v2:
> - create a patch series instead of single patch
> - add optimization for reading the second part of the received timestamp,
>   read the second twice per second instead of for each frame
> 
> Horatiu Vultur (2):
>   net: micrel: Change to receive timestamp in the frame for lan8841
>   net: micrel: Schedule work to read seconds for lan8841
> 
>  drivers/net/phy/micrel.c | 272 ++++++++++++++++++++++++++-------------
>  1 file changed, 180 insertions(+), 92 deletions(-)
> 
> -- 
> 2.38.0
> 

-- 
/Horatiu
