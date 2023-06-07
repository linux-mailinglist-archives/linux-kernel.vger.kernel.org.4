Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD73A72529E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjFGDz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjFGDym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3964019B9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80646393B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54CC433EF;
        Wed,  7 Jun 2023 03:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686110079;
        bh=lipBdfsrWW5U0xjBpTPT3ABPpxcdQFIPfd2IFiOUgNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCV6XLflw/NJOGtOegGp36oA4bQY0p+0RGE1AEmJjv5H22cdKjzlh/chTPZSCqo7d
         o4sUJdtoHGCBdw1euRdxLQB5HqDooBMdFj6eA4JnDP9gkY5j3epfFaobL4/4I7BQUq
         j+nbKWAwIWKBpwLxea+zZPyAzAE6Sx6/QtsHM9gUPSJ9H+5+b5MBMX4wqIjBIrocGA
         EoEdbZu11I60omxq/SZtoACfjxvGwvHFUH/xXfjzSxTy9XliOdyojXgk0ADcnjcRGM
         OUrbNPCOazk3O6FKI7uVjlbMjTz3QIPDoo8z9LsFvWfTclJIiHwfHW86jvz88yys82
         jIew+n89qRt3Q==
Date:   Tue, 6 Jun 2023 20:54:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, simon.horman@corigine.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Marco Bonelli <marco@mebeim.net>,
        Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
        Sean Anderson <sean.anderson@seco.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] ethtool: ioctl: improve error checking for
 set_wol
Message-ID: <20230606205437.49378d25@kernel.org>
In-Reply-To: <1685990778-34039-1-git-send-email-justin.chen@broadcom.com>
References: <1685990778-34039-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jun 2023 11:46:16 -0700 Justin Chen wrote:
> +	if (wol.wolopts & ~cur_wol.supported)
> +		return -EOPNOTSUPP;

One small comment - I think we should return -EINVAL here.
That's what netlink return and we seem to mostly return -EOPNOTSUPP
if the operation is completely not supported.
-- 
pw-bot: cr
