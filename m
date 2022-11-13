Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21143626D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMBVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKMBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:21:20 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52013E08
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:21:18 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 089086407E8;
        Sun, 13 Nov 2022 01:21:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 77A2464067D;
        Sun, 13 Nov 2022 01:21:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668302477; a=rsa-sha256;
        cv=none;
        b=Ije2RFkY9SOY19ZGXg87U/DL3motmOst3st9QxfkcmvbFz/Fgs2ujCelcHu5j3mBwFeA5s
        r9U4L/zGFve/fnNj0P/jbPRIiVezm5+xgVmirN1Z5tV0DmMYOJdhbgZ0uhrd/EoBqcojAR
        SDvFzCpXe3LhLk6Qq1oZTD+sNf8viLmOi5re3uaeTk6ymp8CidvE8GpwKkQJe6ZI11drqx
        OAgtxU42r7QlIs6VlIqmnnjmz+7M/+qaKlHtdPvdYZsqLUFy/da7dIVQPLWdJpFNsURR01
        OF3lAPveoavc+Y5Vut5mZGOL6Gk2q3NotgkZEWsDnLq3o3vyJ1YB2skm9v1oCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668302477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jrFeBNF4kEmipaWAEowojy7sdhw3j4DUICVDJ7CjWpw=;
        b=naBIpE+DV+xRL83tgLLWEOZUDJ/4dc+YooCaTr3uGPSd/MUGkYbPKN14AH0lE5CX8a5rKl
        D7/X52npIelPDhyRQFLJ7R/tA6qLtWri5NEVqGqUmu1dBj8WhoTcMDqFFhDcbXvAIBSZ+x
        YUxNbCjRZbR6HSw1Sxj9JXNGR+5MW8AZoKtfINI2mXkvnxgyKDn0lpM8WnSxCVZug+LV8F
        A/47jLgBILgxe3+rpsylEPy4YByXS28Klxv0RzjkKDq0j8Cq+Ed+6gptYxhO+0Si1GzjAE
        TcU+a1Jsb74x9oHYu2WXQrp8tTFCRrYBcMq+to30ZX0rnmN52HJZPH58esPn2A==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-8mdh8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Irritate: 77fe86300b02c00a_1668302477815_1001803127
X-MC-Loop-Signature: 1668302477815:10762536
X-MC-Ingress-Time: 1668302477815
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.12 (trex/6.7.1);
        Sun, 13 Nov 2022 01:21:17 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4N8vlw1vp6z4h;
        Sat, 12 Nov 2022 17:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668302477;
        bh=jrFeBNF4kEmipaWAEowojy7sdhw3j4DUICVDJ7CjWpw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qhd3kRt8kGU979D7+MNWmf+zjmALavGlhVclFkSzOw/g0QXVDUZVKNWmw+DkxyoXQ
         Et35NQi6dp8ozkIW6xNfTxXvNfRcOTX50Gy9dOklTi9XJY/3zxumnTWO6HIfiBVxLR
         qHorVDexnz7YYEayDCZVWiJoqFYorQKfdxDYClI1G9nu/GjDddVo1dnkuD3LQhfGyb
         l1UpnBVyyIoDixkfqcHtAlA4r48PfjCD+KIVO2vn441WquUA0Zzqx9J29lYpnks4tu
         2edKrRfGevelXF0jQPhegOVnjwmzT7wdJnjHvRgaeQ+SlCPrPNXNaxcbJYyIcFw6dV
         S0ImdqNBz7Srg==
Date:   Sat, 12 Nov 2022 20:21:14 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Message-ID: <Y3BGimp2LmRqV9oy@rhino>
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
 <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
 <Y3A9waTkehESUyn+@rhino>
 <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 05:11:27PM -0800, Randy Dunlap wrote:
> 
> 
> On 11/12/22 16:43, Ian Cowan wrote:
> > On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
> >>
> >>
> >> On 11/12/22 13:59, Ian Cowan wrote:
> >>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
> >>>> Hi--
> >>>>
> >>>> On 11/12/22 08:37, Ian Cowan wrote:
> >>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> >>>>> the following modpost error for both `kmalloc_trace` and
> >>>>> `kmalloc_node_trace` on the staging/staging-next branch:
> >>>>>
> >>
> >> Ian, what do you mean by "on the staging/staging-next branch"?
> >>
> >> What kernel version are you trying to build?
> >>
> >> The .config that you sent is for v6.1.0-rc1.
> > 
> > I am building from the staging repository (gregkh/staging) and my
> > working branch when building is staging-next. So I am trying to build
> > from staging and not a particular version. I have also run `make modules_prepare`
> > and updated the .config per that script. However, when I do build
> > v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
> 
> Have you built the entire kernel already and then you are trying to build
> only drivers/pci/hotplug?
Yes, I did build the entire kernel already and then I'm just trying to
rebuild that module.

In `include/linux/slab.h` if I remove the lines between `#ifdef
CONFIG_TRACING` and `#else` (lines 473-480) and then the corresponding
`#endif` and leave lines 481-499, I'm able to compile that module
without issue.
