Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB972339A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjFEXQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFEXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F7A6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60C962BA8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7039C433D2;
        Mon,  5 Jun 2023 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686007012;
        bh=N0okavvmW+hN+zvpU/6hPbUTjAPKTkWMzVLTCfODKj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxFFZGeRo8w3FyjbFp8iGddkfxEkSm6B7ROKwrdD+49820oQHrBDX8pULUmIFAJAW
         BnZ4XHz/+UUUv00BYv/XgrekfAscVRexvdC/jGjZ3AXdXdLqXsuGCdRJdqejPYNoUA
         +coVOUM0GUiTbFv0VbHcsO19NhI8HzXYCsYqTPN9/Wh/T0WeMv9WzauRRhAkrCPNB1
         7G6g4pE0SLuxuV8IbhPGSYNq3D4BTYISTw/UXwYtLMQSoh//yzHOVmmNO2cxARKvOh
         goVUi+tfdy0EBW0gpXZaRLvKfD1Z4PBFlmuGMfFmu5Hn4Osxm4u6KhVyC+Z+3CXFvw
         qfVbV/VNAWFQA==
Date:   Mon, 5 Jun 2023 16:16:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: lower "link become ready"'s level
 message
Message-ID: <20230605161650.4a844f42@kernel.org>
In-Reply-To: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
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

On Fri, 02 Jun 2023 11:36:07 +0200 Matthieu Baerts wrote:
> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
> 
>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
> 
> When netns are being extensively used -- e.g. by re-creating netns' with
> veth to discuss with each others for testing purposes like mptcp_join.sh
> selftest does -- it generates a lot of messages like that: more than 700
> when executing mptcp_join.sh with the latest version.
> 
> It looks like this message is not that helpful after all: maybe it can
> be used as a sign to know if there is something wrong, e.g. if a device
> is being regularly reconfigured by accident? But even then, there are
> better ways to monitor and diagnose such issues.
> 
> When looking at commit 3c21edbd1137 ("[IPV6]: Defer IPv6 device
> initialization until the link becomes ready.") which introduces this new
> message, it seems it had been added to verify that the new feature was
> working as expected. It could have then used a lower level than "info"
> from the beginning but it was fine like that back then: 17 years ago.
> 
> It seems then OK today to simply lower its level, similar to commit
> 7c62b8dd5ca8 ("net/ipv6: lower the level of "link is not ready" messages")
> and as suggested by Mat [1], Stephen and David [2].
> 
> Link: https://lore.kernel.org/mptcp/614e76ac-184e-c553-af72-084f792e60b0@kernel.org/T/ [1]
> Link: https://lore.kernel.org/netdev/68035bad-b53e-91cb-0e4a-007f27d62b05@tessares.net/T/ [2]
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

This appears to have been applied as commit f69de8aa4752 ("ipv6: lower
"link become ready"'s level message") in net-next, thank you!
