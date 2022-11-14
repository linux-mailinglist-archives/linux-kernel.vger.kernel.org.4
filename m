Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021606279FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiKNKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiKNKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:05:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5AD11159;
        Mon, 14 Nov 2022 02:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CC3B80D6B;
        Mon, 14 Nov 2022 10:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC64C433D6;
        Mon, 14 Nov 2022 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668420228;
        bh=/cd/5SkT/YEm53XS+/Pd3GNWlwb6RdQ+QlBl3NrwxRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zbk0JuGFwiUfsDdnB1Qx5dMp61EYLsmgICY+oAsHbbLcb+wDcWaZnxbj8mjhGJ3/k
         p4Uyt9xCU/GVRkMkb86qx9gWeNBfbZKACbIR8C+VbhIMWkl7Nb0CTGlOdbAlffs/jT
         oqGi/WlK1kVscVQgOV4HT6PjibFA6bczU3Vng9kxeGjt4GryapPHazS+8690NTqpiC
         jlHzwGe3d79mlmwLmVVMnL5oKOL1zPlA6Xiz4m/TSyxI0+g53m5/hec6fPQq1sD/Jx
         WnQesfvzkDMN6qn6+EyDE3JrQkv9gulv9/oUaNMYSlLgsKGwLrKzVbvcey/EcVSKy5
         OdHOUFsXyI6lQ==
Date:   Mon, 14 Nov 2022 10:03:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y3ISftAta+/R711T@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
 <Y1/sUfeVy1a6EKZQ@google.com>
 <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
 <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
 <Y2jKRQ8VyauSfXmH@google.com>
 <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
 <AM7PR04MB70467B746B6CA03CD2FB0982983E9@AM7PR04MB7046.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM7PR04MB70467B746B6CA03CD2FB0982983E9@AM7PR04MB7046.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2022, Ying Liu wrote:
> > Yeah, I tried to not to introduce a new driver for the CSR module, but
> > it seems that it is needed.
> 
> After more experiments, I think it's appropriate to take the CSR module as a
> simple-pm-bus device instead of a simple-mfd device.  This requires to change
> the existing DT bindings for the CSR module and it's child devices.  I'll send the
> change out once it is ready.  Thanks for Lee's review and comments.

Excellent, well done.

No problem, you're very welcome.

-- 
Lee Jones [李琼斯]
