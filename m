Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E818974642A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGCUeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGCUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58708AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5D116102C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D274CC433CC;
        Mon,  3 Jul 2023 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416437;
        bh=qg8LE55Eb5eQTL/7iZUZZnwLSbL18eGO83l+uTl/wTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSt0gbtkjNVYR7WMHsuvkGTOLGmKAKUQk+paGFQsvXTryxi/NI6qMqVPxK2eh7LaW
         HpNBxIW04g1n2iyU+K4ndVDmafmQaXNLWChN/SiaQJYDDx4QhySMSoA7TtQ4xase1I
         fNd+0Gd919wHYzkyqmJAQTw+V5IDnoE/3E9ZOBY0Tzi7dzMojJScClKqfAa2yYrdbB
         DRIG+flWrfBdxykMNDhhrb1pOWUd6ofO5VF3KMlnr5IdK8cHyjzPLuaR7AndNw7+dw
         Z/p2v24gdYyoTvc43rY6sVemrq0u7qOf9HUwCDaZEghYAx40bCmA1qkpIDWPvkiQPk
         fnVLFu/gNEG1g==
Date:   Mon, 3 Jul 2023 13:33:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix mangled link-local MAC DAs with SJA1105 DSA
Message-ID: <20230703133355.479c6651@kernel.org>
In-Reply-To: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
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

On Thu, 29 Jun 2023 17:14:51 +0300 Vladimir Oltean wrote:
> The SJA1105 hardware tagging protocol is weird and will put DSA
> information (source port, switch ID) in the MAC DA of the packets sent
> to the CPU, and then send some additional (meta) packets which contain
> the original bytes from the previous packet's MAC DA.
> 
> The tagging protocol driver contains logic to handle this, but the meta
> frames are optional functionality, and there are configurations when
> they aren't received (no PTP RX timestamping). Thus, the MAC DA from
> packets sent to the stack is not correct in all cases.
> 
> Also, during testing it was found that the MAC DA patching procedure was
> incorrect.
> 
> The investigation comes as a result of this discussion with Paolo:
> https://lore.kernel.org/netdev/f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com/

This series got eaten by vger, I think. Could you repost?
