Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77163C5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiK2Q4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiK2Q4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:56:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D2663C1;
        Tue, 29 Nov 2022 08:50:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB070B816AA;
        Tue, 29 Nov 2022 16:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C9C433D6;
        Tue, 29 Nov 2022 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669740655;
        bh=IdahP6huwuOhsZoNDIagIDmphdiN6quvNOXg01Cv/cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hpx8xwdEWqaVdWOJ8DwK5GqrwKyqe0pEZNF3ZGIGp5HZFg/v1O+Nh5BG4/hUCN+Sy
         dmvbPcDYnH2TBYv0ZaKF35sHry+e5JpnLZT/wr3hyy/3a53Fx0EfifbDuZxtizzOqR
         9Fp0F9xJz7+B1qKs0KczQFNV3PqzQ1C9DHDDQH2f3+MyENRzSfy2i5Yz0Wr62k1EA1
         bkwpf1MgcouUi1QEJaFqMU7p0CsN/VQoSiSxRmjGaQNR5mbqsyJmwiWR6zev4DaB7D
         jXxaCcZaR0LyriqoDq6RULZ7//uyMBAkzvNahTEtzcbwXXesSyUG+bP3TohU7zvTqc
         rHQjF6WONHZPw==
Date:   Tue, 29 Nov 2022 16:50:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, guoren@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Subject: Re: [RFC 0/2] Putting some basic order on isa extension stuff
Message-ID: <Y4Y4aZUEhCch1Sg+@spud>
References: <Y4XvnHIPw8ZuBZEk@wendy>
 <20221129144742.2935581-1-conor.dooley@microchip.com>
 <20221129154832.27or3ywsx7npuqzq@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129154832.27or3ywsx7npuqzq@kamzik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:48:32PM +0100, Andrew Jones wrote:
> On Tue, Nov 29, 2022 at 02:47:41PM +0000, Conor Dooley wrote:
> > RFC:
> > - I have not even tested this, I just did an allmodconfig
> > - I don't know if I re-ordered something that is sacrosanct
> > - I don't know if I changed all of the instances
> > - I didn't write a proper commit message for "patch" 2/2
> > 
> > With those caveats out of the way - all I did here was try to make
> > things consistent so that it'd be easier to point patch submitters at a
> > "do this order please".
> > 
> > I never know which of these can be moved without breaking stuff - but
> > they all seem to be internal use stuff since they're not in uapi?
> > 
> > @drew, I didn't touch the KVM ones - are they re-sortable too? My base
> > here is rc7 so if you did a reorder at any point there I'd not see it ;)
> 
> Right, we can't touch enum KVM_RISCV_ISA_EXT_ID as that's UAPI. All new
> extensions must be added at the bottom. We originally also had to keep
> kvm_isa_ext_arr[] in that order, but commit 1b5cbb8733f9 ("RISC-V: KVM:

Right, I knew that something had been changed in KVM land. It's probably
a good idea to say sort them all alphabetically apart from whichever
ones must be in other orders & explicitly note the reasons in-place.

> Make ISA ext mappings explicit") allows us to list its elements in any
> order, which means we could sort them in canonical order, if we wanted
> to. I think I'd rather have them in alphabetical order, though (they
> nearly are at the moment, except for the bottom two...) The only other
> place we have ISA extensions listed in KVM is in a switch statement,
> which of course doesn't matter, and it's currently in alphabetical order.

I did see the one in uAPI for KVM. Your idea in 2/2 of doing
alphabetical unless otherwise stated works for me as I just want
something concrete! If it works for the chief too, I'll resubmit and
drop the RFC...

