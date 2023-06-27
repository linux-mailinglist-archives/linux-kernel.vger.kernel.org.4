Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47DE73FBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0MUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0MUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:20:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62731999;
        Tue, 27 Jun 2023 05:19:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso37085501fa.2;
        Tue, 27 Jun 2023 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868398; x=1690460398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZBRO+X3paThKk+MmzNq9+BGJ0hxRpP3TLZQHUudoOA=;
        b=rkWAm1ADq12z0SXn/Nh9CR+6SU/6HzEv8u8Lbh6hltITBw/8S6l//V3UDxzFMbw16r
         i1701QGXayvqF7ZHyboxKnmY9MWQ7XVuJ6+8BqRdP4UO/mrtDbh7AM0CPCsxAPEQttB7
         BQUk+cxmJI51j86nQUmbyrcsUYX7qyfKiul+OhFdZSfHjJ5tbWqrohcwHp27eGJLl798
         Ru8oFzmLKWq4NLeF+gp36mJ/9ZjfSZinNoAFtSFquMo0JDBAKaKux0fwV3emZTJOpgMn
         xDhtUaNYr16dU6ERQd1l6i8t4Eh4A96cBvAubnTlm4A3tr16a2srSN8Q2Mj8mFULTF+i
         SO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868398; x=1690460398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZBRO+X3paThKk+MmzNq9+BGJ0hxRpP3TLZQHUudoOA=;
        b=I1nE3jgdWl0wHxxQjNysySOEGYNBbSMJFIq79pxsD8GK95cU3E4C2Lgy6gy7MHp5Kf
         H4LIwUOcdWtHiUXrpjXauUvx60G1eIChC4xq+osZZG2InFR2jZV52u6dx4enRrd9qs+L
         PGaBs7j7YurzFtgonu9oTUZ+FbKm26pPoRtJ0u3t0nRh/hS1Rn5w4/X9jtu0RM/Bc/Sx
         +kNRItwFgtB/oIuCfiuwpvaArOyfQpNsJ8rbYaCYU0caBstHAV2BrQJy/Trs6ZewUbDd
         OE/8Nbw3hl9V6K2fINveUXmvaRIZh4R/1S37cKWt1U1cQbHsnogHEKPTVbN+3MNyWV5g
         xHkA==
X-Gm-Message-State: AC+VfDyGXFdxITi4cqJcKsfRkIGdoKijeryYaYaqre4A8wo8uRRt5ozJ
        BY2HyqiRH5b0r9XCMXgU5uw=
X-Google-Smtp-Source: ACHHUZ6ZdlfEPxn7Ed0+iaM3WCuxa27iQquL4Z5Cz/jXe2bpcFIDMotV/pP4MwZ8x94+hCXf864wkQ==
X-Received: by 2002:a2e:948b:0:b0:2b4:491d:8d53 with SMTP id c11-20020a2e948b000000b002b4491d8d53mr19561334ljh.45.1687868397832;
        Tue, 27 Jun 2023 05:19:57 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id i23-20020a50fc17000000b0051c7b5692easm3769981edr.7.2023.06.27.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:19:57 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:19:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     Ido Schimmel <idosch@nvidia.com>, kuba@kernel.org,
        Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, bigeasy@linutronix.de,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: Re: [PATCH v2 net-next] net: hsr: Disable promiscuous mode in
 offload mode
Message-ID: <20230627121955.4mhwwkc3i4knrsxg@skbuf>
References: <20230614114710.31400-1-r-gunasekaran@ti.com>
 <20230615223736.0577fb11@kernel.org>
 <ZJA4fIH6vm9cO2VG@shredder>
 <a93ff762-215b-fbc1-9e23-b186421cb176@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93ff762-215b-fbc1-9e23-b186421cb176@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:37:16PM +0530, Ravi Gunasekaran wrote:
> > It's not clear to me why you want to disable promiscuous mode. I'm not
> > familiar with HSR, but I assume you want the hardware to forward all the
> > packets between the two ports and not only specific DMACs.
> >
> > How does the underlying device implement "promiscuous mode" that you
> > benefit from disabling it?
>
> While creating an HSR interface using two slave nodes, the promiscuous mode
> is set via dev_set_promiscuity() in hsr_portdev_setup() for both the ports.
> And then in the HSR driver, a packet is forwarded to the other
> slave port (physical port) and also the HSR master if it is intended for it.
>
> Before forwarding, a check is done in
>
> static void hsr_forward_do(struct hsr_frame_info *frame)
> {
> ...
>
> if (hsr->proto_ops->drop_frame &&
>     hsr->proto_ops->drop_frame(frame, port))
>          continue;
>
> ...
> }
>
> And the drop_frame callback is as below
>
> bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
> {
>         if (port->dev->features & NETIF_F_HW_HSR_FWD)
>                 return prp_drop_frame(frame, port);
>
>         return false;
> }
>
>
> The driver drops these packets and does not forward to any port at all.
> But since promiscuous mode is enabled, CPU cycles are consumed. So benefit
> of disabling promiscuous mode is saving CPU cycles.
>
> So in this patch, I check for NETIF_F_HW_HSR_FWD and then take a
> call to enable/disable the promiscuous mode during HSR interface creation.

Can the hardware be configured to not send to the CPU packets that the
CPU is going to drop anyway? IFF_PROMISC is about receiving packets with
any MAC DA, not about sending all packets to the CPU. With offloading
drivers, there is a difference between the 2, because the RX path of a
port is not necessarily the same as the CPU receive path - the
destination of a packet can simply be another port.
