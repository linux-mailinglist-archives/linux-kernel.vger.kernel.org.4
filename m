Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3586FFE35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjELBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjELBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EBCE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E63C6108A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4773C433EF;
        Fri, 12 May 2023 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683853210;
        bh=7FidZPL6/JjR3aTG0/yt8Rh22XZmVz74jmu+VOu18Y8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bjf5oJYI8oN3E17VPraPX2agydE7OjsCS3FUzf65OoQ5iXw2Cm4PcTV9Y9/e+uqet
         Q+t0DzA5XTqAJD2zLFzWthP2Swto6kSV2zdkywDU+XTiYr70v5jnAq5yFzn8XduN0E
         KD0caRgfYN/zIj4UQkUJauhosv1gtGdLPKVBqPt8qilVNDXxSSUSjHPu+Bv8xzgkA/
         qMoan7ub0mpsIVWgZy1yfX1L1ZKVcwvMRRO/GIsdx/aEH7qdrQLAHTFHM/icwrUz6D
         K3dn2+9VLe/01/EjfQElNp9YcnjZfBa0CpvFiMhWgOHnyenYfeZdICIP1SvDT44tby
         w2pLvpsTTnO0Q==
Date:   Thu, 11 May 2023 18:00:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next] net: fec: using the standard return codes
 when xdp xmit errors
Message-ID: <20230511180008.0a216e0b@kernel.org>
In-Reply-To: <20230511152115.1355010-1-shenwei.wang@nxp.com>
References: <20230511152115.1355010-1-shenwei.wang@nxp.com>
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

On Thu, 11 May 2023 10:21:15 -0500 Shenwei Wang wrote:
> This patch standardizes the inconsistent return values for unsuccessful
> XDP transmits by using standardized error codes (-EBUSY or -ENOMEM).

Let's split the return code cleanup from the double free fix.
Please post a v4 patch with just the xdp_return_frame() removed,
and none of the other changes. For net (rather than net-next),
with the Fixes tag back.

