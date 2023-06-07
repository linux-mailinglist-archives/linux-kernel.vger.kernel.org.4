Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245FA725115
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbjFGAQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjFGAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947461988;
        Tue,  6 Jun 2023 17:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2502263942;
        Wed,  7 Jun 2023 00:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86E9C433EF;
        Wed,  7 Jun 2023 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686096967;
        bh=CWFasZaJOed9oYdPj/iRxWloXiVd+HoiWc32ZvjGn6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJ6o6XBP1+rKTs0mr+FNRRl9AfnoHx2AQ6hfFsukq6JktBEkaeeUZusc93iTSG5/E
         9X6nho+NYjfMMm4MXXUktFhM3DjojpG230V5REgbnYqzSTe6WKznZDJVy9Se6Xo9bx
         7m6kWQaNMFVnBPvMnGc3ZKTxZmmzUmwPhhKNyZycVtSSpSkmbgkfkiWgedZPPj3Vjl
         7XNtKYxhjZsP79OcL0uRfJORRPs5EQDCh7P8IVoWFRTQYThZx0L271g/UF/NvCmLRM
         9t+PsjoPAXGeqPZnXF2+ETihM+O4FcsQ6fzWTqUZKVqjQ2yjuzvwrc03WjYvbH764j
         2Rq0f8pfS86vg==
Date:   Tue, 6 Jun 2023 17:16:05 -0700
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
Message-ID: <20230606171605.3c20ae79@kernel.org>
In-Reply-To: <956dc20f-386c-f4fe-b827-1a749ee8af02@broadcom.com>
References: <1685657551-38291-1-git-send-email-justin.chen@broadcom.com>
        <1685657551-38291-4-git-send-email-justin.chen@broadcom.com>
        <20230602235859.79042ff0@kernel.org>
        <956dc20f-386c-f4fe-b827-1a749ee8af02@broadcom.com>
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

On Tue, 6 Jun 2023 15:58:21 -0700 Justin Chen wrote:
> On 6/2/23 11:58 PM, Jakub Kicinski wrote:
> > On Thu,  1 Jun 2023 15:12:28 -0700 Justin Chen wrote:  
> >> +	/* general stats */
> >> +	STAT_NETDEV(rx_packets),
> >> +	STAT_NETDEV(tx_packets),
> >> +	STAT_NETDEV(rx_bytes),
> >> +	STAT_NETDEV(tx_bytes),
> >> +	STAT_NETDEV(rx_errors),
> >> +	STAT_NETDEV(tx_errors),
> >> +	STAT_NETDEV(rx_dropped),
> >> +	STAT_NETDEV(tx_dropped),
> >> +	STAT_NETDEV(multicast),  
> > 
> > please don't report standard interface stats in ethtool -S
> >   
> 
> These are not netdev statistics but MAC block counters. Guess it is not 
> clear with the naming here, will fix this. We have a use case where the 
> MAC traffic may be redirected from the associated net dev, so the 
> counters may not be the same.

You seem to be dumping straight from the stats member of struct
net_device:

+		if (s->type == BCMASP_STAT_NETDEV)
+			p = (char *)&dev->stats;

No?

Also - can you describe how you can have multiple netdevs for 
the same MAC?
