Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173B6F4D87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEBXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEBXS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:18:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78952128;
        Tue,  2 May 2023 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2l5Uv2F7D/BM238Fz1afWDTU9gd8SlLHR7GBsDFXHNE=; b=ua8uarLFqpT95yGaNxhsDrN2JU
        QFWtZOol6DrBowgnIS3dd8eKz7LG4JvB1lhRFBmTqffhCcvDpiMcpsuqawuIRJnDd5/s0LQgIB//a
        plFw9s8e8QFQl2QGajvptVWH8abV36oJwIyjecgR4M8SUas4JkWogD8w1SK6NVO1qnJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ptzGY-00Blwb-VN; Wed, 03 May 2023 01:18:38 +0200
Date:   Wed, 3 May 2023 01:18:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH v2 net 2/2] net: fec: restructuring the functions to
 avoid forward declarations
Message-ID: <6dff0a5b-c74b-4516-8461-26fcd5d615f3@lunn.ch>
References: <20230502220818.691444-1-shenwei.wang@nxp.com>
 <20230502220818.691444-2-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502220818.691444-2-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 05:08:18PM -0500, Shenwei Wang wrote:
> The patch reorganizes functions related to XDP frame transmission, moving
> them above the fec_enet_run_xdp implementation. This eliminates the need
> for forward declarations of these functions.

I'm confused. Are these two patches in the wrong order?

The reason that i asked you to fix the forward declaration in net-next
is that it makes your fix two patches. Sometimes that is not obvious
to people back porting patches, and one gets lost, causing build
problems. So it is better to have a single patch which is maybe not
100% best practice merged to stable, and then a cleanup patch merged
to the head of development.

   Andrew
