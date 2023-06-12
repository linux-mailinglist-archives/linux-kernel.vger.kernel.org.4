Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7747A72D461
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbjFLW3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFLW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:29:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BB170C;
        Mon, 12 Jun 2023 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=y+r3yDX0gpvop5JCvib9GEMK945+knWKoOtG6I/6PDo=; b=EjoOvBxawoJYWkc/fcKgriyiNV
        cIYEPdPC6Oxeq07YiRJx540EwIRgNHsCkUx76lklmGjvNHIO/4p06ZSiM4X8EXAgCJzmoEYj2DozZ
        mNGu7ih/QFL7HzaeMiZeX6P/DCi7+tCm2NPZ/0myxI8jJrhOJwB2uhh7Q2nPGystn5kM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8q1r-00FePO-QT; Tue, 13 Jun 2023 00:28:51 +0200
Date:   Tue, 13 Jun 2023 00:28:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Marco Bonelli <marco@mebeim.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: ioctl: account for sopass diff in
 set_wol
Message-ID: <9ec8eac3-6b2f-4455-89ef-2d5768b4cee9@lunn.ch>
References: <1686605822-34544-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686605822-34544-1-git-send-email-justin.chen@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:37:00PM -0700, Justin Chen wrote:
> sopass won't be set if wolopt doesn't change. This means the following
> will fail to set the correct sopass.
> ethtool -s eth0 wol s sopass 11:22:33:44:55:66
> ethtool -s eth0 wol s sopass 22:44:55:66:77:88
> 
> Make sure we call into the driver layer set_wol if sopass is different.
> 
> Fixes: 55b24334c0f2 ("ethtool: ioctl: improve error checking for set_wol")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
> 
> Note: Tagged "Fixes" patch has not hit rc yet.
> 
>  net/ethtool/ioctl.c | 3 ++-

Hi Justin

Does the netlink version get this correct?

And just for my own curiosity, why are you so interested in the ioctl
version, which is deprecated and not used by modern versions of
ethtool?

	Andrew
