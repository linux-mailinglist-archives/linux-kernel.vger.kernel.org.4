Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2374A8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGGCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGGCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182B19B7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C21FB6152B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C49C433C7;
        Fri,  7 Jul 2023 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696232;
        bh=JnxhhM1caNPNzvpuk3DMvL0aLRLKS2KlkCHyZiudBO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vqay8oFiTH0Ojp3oVDNTOMv6XuO+B8YQhtFb8ejQ+ry9IUyvIC2jhYPQ4RgnsEy/m
         mqlLbd5+27Z4Pw2GYhXqdTLOD4vZy8kTZgO1yn6AYqIezWM7I0XUVzzQK1k0HpR2XG
         DpJW6Rixb5aEaWd6MWvVaScd7BEz6DJRmG08SeZlcQD8sC/bqYhzhT3jr0p+pNTkZ5
         97ksk5nEk8YvKSX5pHM0PMi9nvQzkXYS8jsu8OXS4bhw5VYfqF4+FgighSbHNEavND
         KLkdEVqegiQltcw7YfqqcQb1q59LPSKSRxaYthDpdWpfG478QOCHwW7HPOk3e2zYFI
         jqvN0hUyCEDKg==
Date:   Thu, 6 Jul 2023 19:17:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
Message-ID: <20230706191710.5f071724@kernel.org>
In-Reply-To: <20230706172237.28341-1-ivan@cloudflare.com>
References: <20230706172237.28341-1-ivan@cloudflare.com>
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

On Thu,  6 Jul 2023 10:22:36 -0700 Ivan Babrou wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")

Doesn't build when IPv6=m, you need to export the tp?
-- 
pw-bot: cr
