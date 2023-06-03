Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD9720E35
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjFCGxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFCGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7180197;
        Fri,  2 Jun 2023 23:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39149601D9;
        Sat,  3 Jun 2023 06:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7248C433D2;
        Sat,  3 Jun 2023 06:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685775176;
        bh=Dtp7yfw3yIgpqLiDkFokEpEEdCuCwpELzyb1JLQqmrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TE06WsU3DCFbMrsqZlqF429AXurYRJfP/0Zv2ohSLs8375orVlB58ve3KTVMOKmbS
         PiSGZynui9JnJg3B0/YZWpIZNRBhfGEOFp5rVJeK0fJRGDREg6nyecUN+4NutKmEQn
         tWlwAcdAaynyHoVkcXLssxpGSI5ieYElOSfvkBonjBHaFxvZbisr8nwO2ZFMk+7oMs
         IfxML+cV2NVqDTx8M9FPI+0b+YW1dc3EemFN7SKx7Npi+s7qViK6ohzl9PT3FJneS4
         JB5fK5J42HHHgWuz4xmEC9Rh2kZXRiWuUndyPJqFmZ9i9kDnfl54QUS0S+KfKmOB+d
         eVh/BEjikHwZA==
Date:   Fri, 2 Jun 2023 23:52:54 -0700
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
Message-ID: <20230602235254.61798d80@kernel.org>
In-Reply-To: <1685657551-38291-4-git-send-email-justin.chen@broadcom.com>
References: <1685657551-38291-1-git-send-email-justin.chen@broadcom.com>
        <1685657551-38291-4-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 15:12:28 -0700 Justin Chen wrote:
> +	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
> +	if (!ports_node) {
> +		dev_warn(dev, "No ports found\n");
> +		return 0;
> +	}
> +
> +	for_each_available_child_of_node(ports_node, intf_node) {
> +		of_property_read_u32(intf_node, "reg", &port);
> +		if (!bcmasp_is_port_valid(priv, port)) {
> +			dev_warn(dev, "%pOF: %d is an invalid port\n",
> +				 intf_node, port);
> +			continue;
> +		}
> +
> +		priv->intf_count++;
> +	}

I think that you're leaking ports_node,

/**
 * of_find_node_by_name - Find a node by its "name" property
 * @from:	The node to start searching from or NULL; the node
 *		you pass will not be searched, only the next one
 *		will. Typically, you pass what the previous call
 *		returned. of_node_put() will be called on @from.
 * @name:	The name string to match against
 *
 * Return: A node pointer with refcount incremented, use
 * of_node_put() on it when done.
 */

-- 
pw-bot: cr
