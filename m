Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4B6287C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiKNSCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiKNSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:01:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C32CDCE;
        Mon, 14 Nov 2022 10:00:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA36AB810F3;
        Mon, 14 Nov 2022 18:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89592C433D6;
        Mon, 14 Nov 2022 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668448843;
        bh=NsWh9tC3u+LrZ7KM/VCH67ErhMDNadIOAI4DLlEPjm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opuhEyZWZOlVWK14qSuxfOOL4suXKkOF3YlvfYfIT7ygPylXUSbnk6yNl/O/4pCFq
         CpQFWnObH2oKm1fukMmp+zFYl7jquehRnFSgITOZEBmhyzZMSj7nPGkOjHfExsm/Qe
         w+nm2kyplTChDxBu4LaupYXtCBGvUFl5Gipy/rVFSyOqmNRceXSFOGO2ZMNS9l+zPA
         5htVZlPy0R3cA4hYIWdu+X0pZS7Yy2Udw6izruhbL84srM4qPYsPD3ynbHpaV7OvgN
         Jwl4UHFwQfppNQU5RhVeNTWr4mB4gmQjWr5CQImPWNaxulKvR1DiSMr8nWma29v44c
         ZHG+Y1I1QCusQ==
Date:   Mon, 14 Nov 2022 18:00:37 +0000
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        corbet@lwn.net, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Enable FPDT on arm64
Message-ID: <20221114180036.GA31476@willie-the-truck>
References: <20221109174720.203723-1-jeremy.linton@arm.com>
 <20221114161206.5sspq25v57ddco4o@bogus>
 <CAJZ5v0jHk9eEj0EnH-hWnRsabAs+E3LiudTPE+KFhcsZARaw5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jHk9eEj0EnH-hWnRsabAs+E3LiudTPE+KFhcsZARaw5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:16:59PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 14, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Nov 09, 2022 at 11:47:20AM -0600, Jeremy Linton wrote:
> > > FPDT provides some boot timing records useful for analyzing
> > > parts of the UEFI boot stack. Given the existing code works
> > > on arm64, and allows reading the values without utilizing
> > > /dev/mem it seems like a good idea to turn it on.
> > >
> >
> > FWIW, this looks good to me.
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Hi Rafael,
> >
> > Just saw this marked as "Handled Elsewhere", do you prefer to be merged
> > via arm64 or other tree ? This doesn't have any arm64 changes, just Kconfig
> > and doc changes. Let us know.
> 
> There is arm64 in the subject, though, so I think it belongs there.

Okey doke, I'll grab 'em.

Cheers!

Will
