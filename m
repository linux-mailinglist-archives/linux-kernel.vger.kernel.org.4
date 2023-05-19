Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5A70A2CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjESW2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjESW2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B97EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D498D616EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F6C433EF;
        Fri, 19 May 2023 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684535289;
        bh=kHtJttk0IvKNpeBTTCun9Kaxe9mpk0uKJbFMu4xbEBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjPLOWfLnh+YUZso0agkMdGAZir6v6nV/SrtAoiIwmSXhkhEz/FeEuTojZV5BbnPM
         xCIvyJdayyv8y4OHd1E2WJ46Z4RC9+FGstF2G124fSkQTJhZWetm0hjFjzRXF3V2gt
         2BRLX6+LhW1kwD1KTWzkeOxw2fRU1DTSyNRWM7wfV99ZalR8t0B4Cqz+5XOfzOmgfz
         NEXnwc7TwkiLmnpM5TIxiH0cgPylLpFcsTbogVuDBsPO73ySzLbgao2cnYIA8mzcvj
         a4+G4l6DjOJ6OwrSJ7RbWzd7XyYfgmqTdZQK2p8lRFod49RbJYyKwKIF2sLYn1Y17c
         JbJTzMI5Io2bg==
Date:   Fri, 19 May 2023 15:28:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macb: use correct __be32 and __be16 types
Message-ID: <20230519152807.57d3f4c8@kernel.org>
In-Reply-To: <20230519221942.53942-1-minhuadotchen@gmail.com>
References: <20230519221942.53942-1-minhuadotchen@gmail.com>
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

On Sat, 20 May 2023 06:19:39 +0800 Min-Hua Chen wrote:
> This patch fixes the following sparse warnings. No functional changes.
> 
> Use cpu_to_be16() and cpu_to_be32() to convert constants before comparing
> them with __be16 type of psrc/pdst and __be32 type of ip4src/ip4dst.
> Apply be16_to_cpu() in GEM_BFINS().

same story as with your stmmac patch, the warning is a false positive
