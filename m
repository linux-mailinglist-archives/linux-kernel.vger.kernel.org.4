Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9E731464
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbjFOJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbjFOJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA541FDB;
        Thu, 15 Jun 2023 02:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 222DC62D0F;
        Thu, 15 Jun 2023 09:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1046BC433C0;
        Thu, 15 Jun 2023 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686822468;
        bh=dq78Mpvl25tYI9hMZp9HS6PZVswp2rMHbFOPamCyiDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/LosNBtIuUZHTTGv6QPPVczkMmlTJ6O2pB1K6x6sqqG7xEDBamku+iQU5wLuRzPs
         CTDmPkpZUxzwkBKR0ziMgoQ4Xg9BWFnENd23M+GG5056lh7lve20ZNKCLo3XTptvov
         HO7QJbEWXHH2gitPjei+I6keyXRFuyGOGrsZFYnk=
Date:   Thu, 15 Jun 2023 11:47:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
Message-ID: <2023061514-wager-iphone-cf71@gregkh>
References: <20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org>
 <20230601-topic-sm8x50-upstream-redriver-v3-2-988c560e2195@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v3-2-988c560e2195@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:50:08PM +0200, neil.armstrong@linaro.org wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
> and DisplayPort ALT Mode Linear Redriver chip found on some devices
> with a Type-C port.
> 
> The redriver compensates ultra High-Speeed DisplayPort and USB
> Super Speed signal integrity losses mainly due to PCB & transmission
> cables.
> 
> The redriver doesn't support SuperSpeed lines swapping, but
> can support Type-C SBU lines swapping.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/typec/mux/Kconfig      |   8 +
>  drivers/usb/typec/mux/Makefile     |   1 +
>  drivers/usb/typec/mux/nb7vpq904m.c | 529 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 538 insertions(+)

I get the following build error on my system with this applied:

  CC [M]  drivers/usb/typec/mux/nb7vpq904m.o
drivers/usb/typec/mux/nb7vpq904m.c: In function ‘nb7vpq904m_register_bridge’:
drivers/usb/typec/mux/nb7vpq904m.c:327:20: error: ‘struct drm_bridge’ has no member named ‘of_node’
  327 |         nb7->bridge.of_node = nb7->client->dev.of_node;
      |                    ^


What went wrong?

thanks,

greg k-h
