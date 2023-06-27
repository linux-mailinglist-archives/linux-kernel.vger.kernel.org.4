Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8C74001E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjF0Pxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0Pxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2E19A4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D427611D6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61171C433C8;
        Tue, 27 Jun 2023 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687881214;
        bh=VFH04KQ3gvefUySLTDf8LtzRnAMEIEUyc0inlA7xpbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mI2EHfIeePjlJPuspRxyfSV9FsMA9HlLGkZd+HcdZ8vlvKxDr9MoWJKA8AsAqT8wd
         1djlje/vvpiXQhKC925sxIhVOHfBuLGyYyjyFlMwBl5pLHfh/MYxlp3NGnL4yzegCk
         KZqnQ757xoGvpJaSVeH8hDaGnocMW7uwHiTb9tIQmFhf2C29RTSQG1SJeINdPqfQKn
         je1v5uyAAy8pne/K0OoQwv0m1esdCnx8hGhNpc8JzYMrZii7xyEt8Fy6w3fwaH1ZOM
         8C1tUvcXeLzfOZ75STv4hhQzEc++98WCFIbnHrIsqQrgSl4BvZEdbCaX52uJ6MalrD
         mMXt/XLNELSVA==
Date:   Tue, 27 Jun 2023 08:53:33 -0700
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
Message-ID: <20230627085333.0968615d@kernel.org>
In-Reply-To: <20230627155147.atvr32v3vldnybrc@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
        <20230626154003.3153076-4-vladimir.oltean@nxp.com>
        <20230627151222.bn3vboqjutkqzxjs@skbuf>
        <20230627084651.055a228c@kernel.org>
        <20230627155147.atvr32v3vldnybrc@skbuf>
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

On Tue, 27 Jun 2023 18:51:47 +0300 Vladimir Oltean wrote:
> > pw-bot: changes-requested
> > 
> >  a) your email address is different and the bot doesn't understand
> >     aliases
> >  b) commands are hard to remember
> >  c) don't care about patchwork
> >  d) laziness
> >  e) other  
> 
> hmm, I'll tick e) unslept...

Ah, good, I was worried it was the aliases and I don't have a great
plan yet for how to deal with that :)
