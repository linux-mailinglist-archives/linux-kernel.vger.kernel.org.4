Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF66E0F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDMOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDMOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F73A243
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6968663EEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0B2C433D2;
        Thu, 13 Apr 2023 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394649;
        bh=Ahx2IXPmgRvW3Kytgy7tTXDRUFlVeZwHebwdBqNN2CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H+CUkiL5VYYP3GYAQiplu72EifG+opq0EChsi7A90f9IDZur/fgTtuuKNDFVSWfnW
         PVPr1FbWbLNDPnr7NFsujmbf/2jDac9N7E6cv1MyiH0sz7GFBwOMxVSqcqDGBk39/y
         +txKnvP2rkegLrqYTT/wOgwuJw5YX6AXcGPu339MqLm0AjVWvG/wJqJGeEC455EmRO
         z38M/Wi1m/+ApQVwBLMS9rTG8BH80EV193nEL18ULLznXFUJ6GQg5LeaggFUpIKfuO
         SiVoQiHIIsyREnJRV9qbfX/CEEgjNwIGx0EdJKW72z8dUD/kTYCUOxGR2xe/Se6VE7
         UpLvVxCLRiEPQ==
Date:   Thu, 13 Apr 2023 07:04:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq
 command
Message-ID: <20230413070408.630fa731@kernel.org>
In-Reply-To: <20230413064027.13267-1-jasowang@redhat.com>
References: <20230413064027.13267-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 14:40:25 +0800 Jason Wang wrote:
> The code used to busy poll for cvq command which turns out to have
> several side effects:
> 
> 1) infinite poll for buggy devices
> 2) bad interaction with scheduler
> 
> So this series tries to use sleep instead of busy polling. In this
> version, I take a step back: the hardening part is not implemented and
> leave for future investigation. We use to aggree to use interruptible
> sleep but it doesn't work for a general workqueue.

CC: netdev missing?
