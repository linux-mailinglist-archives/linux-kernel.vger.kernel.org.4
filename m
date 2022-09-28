Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063495ED2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiI1B1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI1B1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:27:52 -0400
Received: from mail-vk1-xa63.google.com (mail-vk1-xa63.google.com [IPv6:2607:f8b0:4864:20::a63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1851DCC75
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:27:51 -0700 (PDT)
Received: by mail-vk1-xa63.google.com with SMTP id b81so5780299vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:message-id:subject:cc:to:from:date
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date;
        bh=Qz5cZ1dKHpFe+uznEPT4rkoMBo9Ge3E30XeFeUWy5mE=;
        b=W93jpcRr4vtZVYKX9kczoBDKZmJyaU4fi2hssmieVuPLQLKMIiTBfeA3q9a/e5YpD7
         Jm5rPaCZNEXRGPtUjkful3Q4NjJgWFltCDMbDzpKeopVBy0kBeupJxWLzns94E7GXkdt
         +5+6XgFVPQyhxAF8i1uyzAc/DanTlMExsXgzysesNlmDGqJJoRUtm5D+aYNmucdWciHX
         2Nf9DQUZt4N/gg2eiltIXsBoloC36rnZoXRB4eDzd3siKnE8Rxadp82kVcTBAsGp052W
         eafuryRI9Z3Tav8qec50ELDSLqS9kUWba/Luk60PWaRaamslKwzzzBHYDjb6rnV5jngy
         pCYg==
X-Gm-Message-State: ACrzQf0ToXs1/xeTLv1SKEv1tF0tSz887+smB0C3nfRtANSbQkWbuE6a
        H7iut8d4d0dtOWjw6eVeMCGyitCGl/hx+/Upv/ADozCkqMFU
X-Google-Smtp-Source: AMsMyM67kpBezgFODbSEU45KeVvN4UIgvuZwRllusRhb56QOMtF8EaFCaLlbwLW/2jMzUhV/hUQOSnVAFf3O
X-Received: by 2002:a05:6122:91e:b0:3a2:e497:2484 with SMTP id j30-20020a056122091e00b003a2e4972484mr12793883vka.41.1664328471019;
        Tue, 27 Sep 2022 18:27:51 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [52.0.43.43])
        by smtp-relay.gmail.com with ESMTPS id j189-20020a1fd2c6000000b003a4a4c7dc91sm320320vkg.9.2022.09.27.18.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 18:27:51 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.71.70])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 465A430000AD;
        Tue, 27 Sep 2022 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-B; t=1664328469;
        bh=Qz5cZ1dKHpFe+uznEPT4rkoMBo9Ge3E30XeFeUWy5mE=;
        h=Date:From:To:Cc:Subject:From;
        b=E16SIa4lYOPZo3XnRkH0LzvPn3MnnOt1gbxBIZFiC8tRowFKa75tR/WZqeuIpnCSQ
         dlRwL4ziIBBOeCqTHx79NOAVVL4SmpO6L18IAx+sqz+EC1SETjSPPWoUTSRQXtE7X7
         dc8mrs/W8NbfwT18dHxHCFw26wQmH/8/5gz8N6Do=
Received: from kevmitch by chmeee with local (Exim 4.96)
        (envelope-from <kevmitch@arista.com>)
        id 1odLrX-000QfB-1L;
        Tue, 27 Sep 2022 18:27:47 -0700
Date:   Tue, 27 Sep 2022 18:27:46 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Antoine Tenart <atenart@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: new warning caused by ("net-sysfs: update the queue counts in the
 unregistration path")
Message-ID: <YzOjEqBMtF+Ib72v@chmeee>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the inclusion of d7dac083414e ("net-sysfs: update the queue counts in the
unregistration path"), we have started see the following message during one of
our stress tests that brings an interface up and down while continuously
trying to send out packets on it:

et3_11_1 selects TX queue 0, but real number of TX queues is 0

It seems that this is a result of a race between remove_queue_kobjects() and
netdev_cap_txqueue() for the last packets before setting dev->flags &= ~IFF_UP
in __dev_close_many(). When this message is displayed, netdev_cap_txqueue()
selects queue 0 anyway (the noop queue at this point). As it did before the
above commit, that queue (which I guess is still around due to reference
counting) proceeds to drop the packet and return NET_XMIT_CN. So there doesn't
appear to be a functional change. However, the warning message seems to be
spurious if not slightly confusing.

I'm not exactly sure what the fix for this should be or if there should be
one. In the meantime, we have ignored this message for this test, but was
wondering if there weren't any ideas for a better solution.

Thanks,
Kevin
