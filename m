Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBE607D70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJURXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJURXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:23:36 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710324FED3;
        Fri, 21 Oct 2022 10:23:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1368940CDE;
        Fri, 21 Oct 2022 17:23:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2EF7940B7F;
        Fri, 21 Oct 2022 17:23:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666373010; a=rsa-sha256;
        cv=none;
        b=mhVsLICrbM/2uD8fKQLF4Any+/Zawom9skfLzz1aYcCDAWpVUaXXhJsxCe2YafWPuWKFzT
        IG5fc4aTw1hhmL3njGv5OOmjurN4r3K77NCNvgDr4LmIH7mYF6BonKLnFM72mYRJ9SJeO0
        AfDg1LGhCB4GlxUVjNeJXVeCYS5njaj3TPHzlmShVw3B2ARW3GqzcSWdy7GOKa/1LdrW14
        MP9atvcSFR6o36WzX/2vrDZwX6oNs9Kc+I4I74jVzTOa46GWLTdEpLvnWJ1E3elwiFrGSd
        j7v8Mj1wkd+zB+CQd38HE+ZbKFuLonaYgyqX6nc1MrBRF64uNo3o3JlFEtARjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666373010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vI+VPrep3qSC3kePNmUTtZOOYUuCF9olRxVhCYVNr+A=;
        b=IAVGkmNDXSqIeHt/6cCziLEqbmOXnlkCbwU2Xgrrw+MWI9Hgzwh1ks0GhTr6UuGSx9rsma
        gdh1j5KK0jnvlQ+JGDZFKdt3rnywHwO5qVNHDG3VPrcWP4LEswqkT6SAiWnFrKRM0biV/m
        /XtsMVNLKfk6eMmGCF0p7GOo6KwBiVgCRpMGo4xclMTS63Fzvn64JxsBR8bWQdur5Hx2DC
        1WXbZjTRblxae8eYsN3mg2Jx9W+GsO54VqiOa8j/aJGYB2LATiGqEyxJX3ET0WmIFbdG4x
        QjHIAlzMi0mK0nSY72ldip5DfiuVD9Q5RDi8aRmWZdbEc/725x5vKvir8XeZDA==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-vkcdq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Drop: 7d83b8cd61140078_1666373010635_3304474967
X-MC-Loop-Signature: 1666373010635:4041510918
X-MC-Ingress-Time: 1666373010635
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.183.105 (trex/6.7.1);
        Fri, 21 Oct 2022 17:23:30 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4MvBBm1v1Dz2d;
        Fri, 21 Oct 2022 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666373009;
        bh=vI+VPrep3qSC3kePNmUTtZOOYUuCF9olRxVhCYVNr+A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JoTs0WHeMSev4YpBj6Zp0eyrM30ArpEdcwK9B2FHaD52zUsHJU6i3T+oELX2WRwsD
         3IdI0sVInLoBeAGfay6hJPFBLjPt18E1mhgD+MPBThNXro8T8KOcr5JM73TCyL5Iym
         XF3KZ6x/naaerK0JuXuHfGPL2qCaTMLE8wkmK+sxKS1k7SqNFZiB/TAkMVtBuOiYMK
         kSYW3tazcIJ8wx6Fre0LByPVVPXKPxtg+7wWrqmuh6qP7PG2ZYOb/Ck55xwQcuWrWE
         6Tnxsr51GJCg0zGZumFsHy48d5eMaF2DmSGNDofFDOKoT6MbBT/ENbAfzaAq3lbcCD
         L2QgY9ZApy6bA==
Date:   Fri, 21 Oct 2022 10:23:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/mbox: Wire up irq support
Message-ID: <20221021172324.efg7vzrguvd7m44r@offworld>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-3-dave@stgolabs.net>
 <20221018103815.00003cb2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221018103815.00003cb2@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022, Jonathan Cameron wrote:

>Whilst I get the need for an example, I'd rather this didn't
>go in until we have that background handler in place.

One of the reasons why the bg stuff hasn't been re-posted is
because the only user currently is the sanitation work
(and hopefully maybe scan media soon), which in turn depends
on the cache-flushing thing to be picked up (unless someone
starts ranting again against wbinvd). And that is in Dave's
pmem security series which I'm hoping will be picked up for
v6.3 at some point.

So I guess we're a while away from the irq thing. I was mostly
suggesting sending an mbox-only just to layout the
pci_alloc_irq_vectors if we're not using the common table,
but per the above this might not be sooner than the pmu or
events stuff...

>Unused infrastructure tends to rot or not be quite what is
>needed.

No arguing there.

Thanks,
Davidlohr
