Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514B705747
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjEPThA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297B902E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F9963927
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32594C4339B;
        Tue, 16 May 2023 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265796;
        bh=OuFy3VqAIPXlxy9jiJj4Z1KMk1POVJhyIATNgEp9BiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ebHfqCqajGW45iUzhEIDqRVSUeW5Q4Q+UyIGOYq+ywBIr6+8dJeOLg2jiHElX6GeA
         PTpD98AJAVJOLZQVEXLScQaV1HN6Lbm0MDqnYpShsiSPHN080dyrVNKMHk6EfIeepP
         gVRcpLNg0+ypamQdvttVkz6izNE95kr8fZAOzpOF5mWYwiFrad5gICIRMEEjcesbqT
         2SPT7intum6X8cxdXNHuYRzDOEUB6d332yxbRvREDcAPyUHid+ZG+PTqA2pYYqzOQC
         GRIaWGdZOyjKXjHYKryVT45Xm5X01vMrvtoOu6o7qDHhxPGr7lI5+RsZzi0A4zBCnB
         IuY99sY2QJy9Q==
Date:   Tue, 16 May 2023 12:36:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230516123635.58a20bb0@kernel.org>
In-Reply-To: <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
References: <20230413121525-mutt-send-email-mst@kernel.org>
        <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
        <20230414031947-mutt-send-email-mst@kernel.org>
        <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
        <20230510012951-mutt-send-email-mst@kernel.org>
        <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
        <20230515004422-mutt-send-email-mst@kernel.org>
        <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
        <20230515061455-mutt-send-email-mst@kernel.org>
        <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
        <20230516000829-mutt-send-email-mst@kernel.org>
        <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
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

On Tue, 16 May 2023 12:17:50 +0800 Jason Wang wrote:
> > It's not reliable for other drivers but has been reliable for virtio.
> > I worry some software relied on this.  
> 
> It's probably fine since some device like vhost doesn't support this
> at all and we manage to survive for several years.
> 
> > You are making good points though ... could we get some
> > maintainer's feedback on this?  
> 
> That would be helpful. Jakub, any input on this?

AFAIU the question is whether .ndo_set_rx_mode needs to be reliable 
and instantaneous?  I haven't heard any complaints for it not being
immediate, and most 10G+ NICs do the config via a workqueue.

I even have an "intern task" to implement a workqueue in the core,
for this to save the boilerplate code in the drivers.
