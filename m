Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6F73FFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjF0Pq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0Pq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13514FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698E0611D1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F171C433C8;
        Tue, 27 Jun 2023 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687880812;
        bh=citRCY1nXVM5YZjWqN+A8/dMciHAof7pxHR25ffEWQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=THP1uOpqKpG4iNLYRsx15JbN7wHnC/BFSxc51Tx28ToHIYQD+Ad49doHsw9tUHnwk
         TdWUv+bKLJqn9cs7xRX+/Yx+yB5NPVsjwJNwcIXUwc1ir55zTeP8JNN7kOuVcrqfWy
         lrZ89+2lIEc7lXcCrgNzobFDd8UFRm9SS5icb/M1Rnv0kgbz4tTq56PiaoFgW+S88+
         wCmNmxDBCTYCQwWWRYo+Pg9B8MtPCTMEeBUMgM3BDOoqCIjeI+ZPGadV7fmgQtYE0Z
         Ke+JYr/pQ9Jj3VbHYWkAmaHS1tx5mJXMo/kA6QkG0wLvSD0dDk7tMR41jbq16m2g5p
         wk197WmcbQQdg==
Date:   Tue, 27 Jun 2023 08:46:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627084651.055a228c@kernel.org>
In-Reply-To: <20230627151222.bn3vboqjutkqzxjs@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
        <20230626154003.3153076-4-vladimir.oltean@nxp.com>
        <20230627151222.bn3vboqjutkqzxjs@skbuf>
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

On Tue, 27 Jun 2023 18:12:22 +0300 Vladimir Oltean wrote:
> This is still not as good as I had wanted it, because simply checking
> for HWTSTAMP_FILTER_NONE does not distinguish between L2 and L4
> timestamping filters, and a port configured just with L2 traps will
> still drop L4 PTP packets.

Out of curiosity - quick survey on why your reply does not contain:

pw-bot: changes-requested

 a) your email address is different and the bot doesn't understand
    aliases
 b) commands are hard to remember
 c) don't care about patchwork
 d) laziness
 e) other
