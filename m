Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87673FDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjF0OV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0OVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1A270F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8943C611B9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7783EC433C8;
        Tue, 27 Jun 2023 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687875710;
        bh=Rjb5KzOvEcNBlqAldIGXkJCYs3UeaI83KJEb4omLbqI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Yd52Vi9wTQRfvLzc71xv6C1LtVQs9bTGLIY0pzXRZuDEde0vAbr0hzSvYY//u3DGl
         AQ6re97HPS6VK2XoYTCO2cG5sa1GWhAVrd1j1glWdt9ChbjMQIUSZZOqH3wK9cfYi0
         P4kKpaK1/QjezOknCPlHyp/NSvRAyxzmCEV0hSsoadYA2PB4KoVn7srxZuY7p2T3ad
         Og+AX2Nz6BAPc5LE6GNV62YX8kBkANZtwLiibjL0oco8/mnroSyxjPkCBR5bsARRXZ
         k/106BUiYQEwg1hrfn3hfTSwNVTeHj7dv0JQ4td3j151K/S33HwefGY1s7R0O0SPgS
         VyzKYW5434Wkg==
Message-ID: <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
Date:   Tue, 27 Jun 2023 08:21:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Content-Language: en-US
To:     Gal Pressman <gal@nvidia.com>,
        Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 2:55 AM, Gal Pressman wrote:
> I believe this commit broke gro over udp tunnels.
> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
> is pretty much zero.
> 

Could you add a test script to tools/testing/selftests/net? It will help
catch future regressions.

