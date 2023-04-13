Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADE96E13FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDMSWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60664680;
        Thu, 13 Apr 2023 11:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68387640B2;
        Thu, 13 Apr 2023 18:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A2C433EF;
        Thu, 13 Apr 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681410137;
        bh=Hd8IcoblSRP4QvKpc1PPwu3BTSDjkQ2bWVKjm6hZBm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fr5pupMj7IiONRvpaQeU1jNbceEGxtjzHL8SUM3oXDDXV+76SrmSVxyLmms1eUbop
         9MY+KsqEbnMAiQGkZTJQhFU3rVs1feiVwoCGcThSvuV4C1k8uM/nUPRYDuBqJO2y3c
         Th6fu034Y2iZ0MfIqoYomL2m3Ot8VSsUHSXKCQps=
Date:   Thu, 13 Apr 2023 20:22:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <2023041322-stopwatch-ungraded-a08b@gregkh>
References: <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
 <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
 <2023041209-armed-overlaid-3d3d@gregkh>
 <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
 <2023041216-antitoxic-finch-dd14@gregkh>
 <dc2f4e9d-2e7e-a4af-5513-1d25eaba40a8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2f4e9d-2e7e-a4af-5513-1d25eaba40a8@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:07:23AM -0700, John Moon wrote:
> On 4/12/2023 9:43 AM, Greg Kroah-Hartman wrote:
> > On Wed, Apr 12, 2023 at 09:37:16AM -0700, John Moon wrote:
> > > On 4/11/2023 11:14 PM, Greg Kroah-Hartman wrote:
> > > > > Would you find the tool more useful if it simply filtered out all instances
> > > > > where the size of the type did not change? This would filter out the
> > > > > following which the tool currently flags:
> > > > > 
> > > > > - enum expansions
> > > > > - reserved field expansions
> > > > > - expansions of a struct with a flex array at the end
> > > > > - type changes
> > > > > - re-ordering of existing members
> > > > > - ...others?
> > > > 
> > > > Obviously not, as some of those are real breakages, and some are not at
> > > > all.
> > > > 
> > > > Please understand what is an abi breakage.  Adding new enums is not.
> > > > Using a reserved field is not.  Reording existing members IS.
> > > > 
> > > 
> > > Yes, understood that method would miss certain classes of breakages. I was
> > > suggesting it as a way to improve the signal-to-noise ratio of the tool
> > > since we don't currently have an algorithm for determining breakages with
> > > 100% accuracy.
> > 
> > Why not?  You know the different types of things here based on the
> > differences between the dwarf data, and they fall into different
> > categories, and those different categories mean different things.
> > 
> > If you have questions as to which type of change is allowed and which is
> > not, just ask us, the rules are not complex, nor impossible to describe,
> > otherwise we wouldn't have a stable api at all, right?
> > 
> 
> Right, it's currently a limitation of parsing the abidiff output.
> 
> Even in trivial situations like an enum expansion, the tool knows that a
> variant was added and another variant had its offset changed. There's not a
> good way to say for sure that the variant whose offset changed is a "*_MAX"
> variant. So if we simply ignored enum expansion, we'd miss breakages like
> this:
> 
> enum foo {
> 	FLAG_A,
> +       FLAG_B,
> 	FLAG_C,
> 	FLAG_MAX
> }
> 
> Maybe we can ignore an enum expansion if only the last variant's offset
> changed, but then we'd miss cases where enums don't have a MAX variant.
> Maybe we could limit the check to last variant's offset whose name contains
> string "MAX", but what if someone calls it "LAST" instead? It gets fragile.

That's what the regexes are for, you can make them on a per-file basis,
right?

> Or situations like expanding into reserved fields. How can we detect the
> difference between this:
> 
> struct foo {
> 	__u32 x;
> 	__u32 y;
> +       __u32 z;
> +       __u8  padding[12];
> -	__u8  padding[16];
> }
> 
> And this:
> 
> struct foo {
> 	__u32 x;
> 	__u32 y;
> +       __u32 z;
> +       char  codename[4]; /* Takes "NAME" */
> -	char  codename[8]; /* Takes "CODENAME" */
> }
> 
> Maybe we grep for "pad" or "reserved", but again... fragile.

Again, regexes.

But if this is too fragile, then yes, it's going to be useless as those
are obviously allowed changes and you are giving us a tool that would
say they are forbidden.

> Another idea is to add some sort of in-line comment to give the checker a
> hint that the field is intentionally unstable. It could be implicit for
> "*_MAX" enum variants or "*padding" at the end of structs, but if you wanted
> to have something like "end[]" (like in the rseq change), you could add /*
> ABI-unstable */ next to it and the script would ignore it.

The abi isn't "unstable", it's "extensible".  Those are two very
different things.

> Beyond those issues, we have non-trivial situations like when it's safe to
> add members to a struct. We know the kernel will zero-extend mismatches
> between kernel and userspace, but how do we know the driver properly handles
> the case of an old userspace passing an old struct?

Then flag it to make sure as the "driver" is the "kernel".

> So far, we've erred on the side of flagging it if it _could_ be a break and
> relied on the reviewer to make the final determination.

But don't give us loads of "this could be broken" if it really isn't
please.

You have decades of code history to run the tool on to get these things
worked out.  Please do so before expecting us to use it and complain
about things it flags that are not actual breakages.

In it's current form, would you use this tool if you were the maintainer
of a subsystem?

thanks,

greg k-h
