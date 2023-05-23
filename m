Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD370E950
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbjEWWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEWWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730BC5;
        Tue, 23 May 2023 15:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D923462CE6;
        Tue, 23 May 2023 22:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A75C433D2;
        Tue, 23 May 2023 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684882504;
        bh=dS/YAPwYvnC+rAO3yycyAQlX67UojDPpvbvnHvURfM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhbaASO3SX6oEMdYloRMuQu+fO8z7EMT6Ht41KN3RvFMYNoPMsHWom9rwqMLPqYZ9
         //+ZB8v/Plyz8JALAqURXUge8kP3UmeQfQ6+S+LSpI4QQ1U4rXBt5vDQesaNq86tYv
         ZZRxtxg6MnPtnwE+3ANCP55NxE5DtcDRXShPtJYT+E8PBAv8g4w2WZZuPEHYQZFHs9
         9h2YAnK9oSGUbGB4YM/eGiCEkbB6FK5wiBpyqkwUuZ/aKT4ZUEkfdV5Vn9nZNUahxx
         5C1SU3M+wUNnpn1DpA/PiI0bgIde1/DZkqe9wNHBHhkwAzjWR3F0qxgmJKysAbmOby
         QPPia3CpkWBHQ==
Date:   Tue, 23 May 2023 23:54:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com, justinpopo6@gmail.com,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, opendmb@gmail.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, simon.horman@corigine.com,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v4 2/6] dt-bindings: net: Brcm ASP 2.0 Ethernet
 controller
Message-ID: <20230523-unfailing-twisting-9cb092b14f6f@spud>
References: <1684878827-40672-1-git-send-email-justin.chen@broadcom.com>
 <1684878827-40672-3-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684878827-40672-3-git-send-email-justin.chen@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Justin,

On Tue, May 23, 2023 at 02:53:43PM -0700, Justin Chen wrote:

> +  compatible:
> +    enum:
> +      - brcm,asp-v2.0
> +      - brcm,bcm72165-asp
> +      - brcm,asp-v2.1
> +      - brcm,bcm74165-asp

> +        compatible = "brcm,bcm72165-asp", "brcm,asp-v2.0";

You can't do this, as Rob's bot has pointed out. Please test the
bindings :( You need one of these type of constructs:

compatible:
  oneOf:
    - items:
        - const: brcm,bcm72165-asp
        - const: brcm,asp-v2.0
    - items:
        - const: brcm,bcm74165-asp
        - const: brcm,asp-v2.1

Although, given either you or Florian said there are likely to be
multiple parts, going for an enum, rather than const for the brcm,bcm..
entry will prevent some churn. Up to you.

Cheers,
Conor.
