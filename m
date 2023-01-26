Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3F67CCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAZNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAZNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:50:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9F4B769
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:50:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 698CFB81BEA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9A1C433EF;
        Thu, 26 Jan 2023 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674741005;
        bh=hJnAv06Ctj8m84GdTXHU08N55+6Z6UhZb5afVPxfAI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njVesddcTFbXraQe46NyjJdxG2wdeVAFplYs7egIwh8AVxZXK1uD37AMpNQW29mBI
         VLd2bj7IuM/NJSUvDeIAriFOLW/lBUzcbESdBccP3XheHwTHfTe8z9tIY/6HDoJQUs
         nXKNPeTGKVgJ3Q/Bqn4JWi66J36AN5edOC9X/hBN8/3SxpG7+t4sGjjW9xmrXh0O9z
         mTcGlQLi088lqJ0zA7wd1t1lO7QoNSB3/l34RoKvlYzrSChtsDo6Dlxtkw5E67bXoa
         BNFsnEpfGFJ3XlH1dQBzpxIAyAGuxy6NbEVh1ALUFc4cqZfI+u7UlCbTpbfMqZpjiT
         4tuRA8/KID7Uw==
Date:   Thu, 26 Jan 2023 15:50:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9KFCC8XkCvduWDp@unreal>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:28:15PM +0000, Reshetova, Elena wrote:
> > On Thu, Jan 26, 2023 at 11:29:20AM +0000, Reshetova, Elena wrote:
> > > > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > > > Replying only to the not-so-far addressed points.
> > > > >
> > > > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > > > Hi Greg,
> > > >
> > > > <...>
> > > >
> > > > > > > 3) All the tools are open-source and everyone can start using them right
> > > > away
> > > > > > even
> > > > > > > without any special HW (readme has description of what is needed).
> > > > > > > Tools and documentation is here:
> > > > > > > https://github.com/intel/ccc-linux-guest-hardening
> > > > > >
> > > > > > Again, as our documentation states, when you submit patches based on
> > > > > > these tools, you HAVE TO document that.  Otherwise we think you all are
> > > > > > crazy and will get your patches rejected.  You all know this, why ignore
> > > > > > it?
> > > > >
> > > > > Sorry, I didn’t know that for every bug that is found in linux kernel when
> > > > > we are submitting a fix that we have to list the way how it has been found.
> > > > > We will fix this in the future submissions, but some bugs we have are found
> > by
> > > > > plain code audit, so 'human' is the tool.
> > > >
> > > > My problem with that statement is that by applying different threat
> > > > model you "invent" bugs which didn't exist in a first place.
> > > >
> > > > For example, in this [1] latest submission, authors labeled correct
> > > > behaviour as "bug".
> > > >
> > > > [1] https://lore.kernel.org/all/20230119170633.40944-1-
> > > > alexander.shishkin@linux.intel.com/
> > >
> > > Hm.. Does everyone think that when kernel dies with unhandled page fault
> > > (such as in that case) or detection of a KASAN out of bounds violation (as it is in
> > some
> > > other cases we already have fixes or investigating) it represents a correct
> > behavior even if
> > > you expect that all your pci HW devices are trusted?
> > 
> > This is exactly what I said. You presented me the cases which exist in
> > your invented world. Mentioned unhandled page fault doesn't exist in real
> > world. If PCI device doesn't work, it needs to be replaced/blocked and not
> > left to be operable and accessible from the kernel/user.
> 
> Can we really assure correct operation of *all* pci devices out there?

Why do we need to do it in 2022? These *all* pci devices work.

> How would such an audit be performed given a huge set of them available?

Compliance tests?
https://pcisig.com/developers/compliance-program

> Isnt it better instead to make a small fix in the kernel behavior that would guard
> us from such potentially not correctly operating devices? 

Like Greg already said, this is a small drop in a ocean which needs to be changed.

However even in mentioned by me case, you are not fixing but hiding real
problem of having broken device in my machine. It is worst possible solution
for the users. 

> 
> 
> > 
> > > What about an error in two consequent pci reads? What about just some
> > > failure that results in erroneous input?
> > 
> > Yes, some bugs need to be fixed, but they are not related to trust/not-trust
> > discussion and PCI spec violations.
> 
> Let's forget the trust angle here (it only applies to the Confidential Computing 
> threat model and you clearly implying the existing threat model instead) and stick just to
> the not-correctly operating device. What you are proposing is to fix *unknown* bugs
> in multitude of pci devices that (in case of this particular MSI bug) can
> lead to two different values being read from the config space and kernel incorrectly
> handing this situation. 

Let's don't call bug for something which is not.

Random crashes are much more tolerable then "working" device which sends
random results.

> Isn't it better to do the clear fix in one place to ensure such
> situation (two subsequent reads with different values) cannot even happen in theory?
> In security we have a saying that fixing a root cause of the problem is the most efficient
> way to mitigate the problem. The root cause here is a double-read with different values,
> so if it can be substituted with an easy and clear patch that probably even improves
> performance as we do one less pci read and use cached value instead, where is the
> problem in this particular case? If there are technical issues with the patch, of course we 
> need to discuss it/fix it, but it seems we are arguing here about whenever or not we want
> to be fixing kernel code when we notice such cases... 

Not really, we are arguing what is the right thing to do:
1. Fix a root cause - device
2. Hide the failure and pretend what everything is perfect despite
having problematic device.

Thanks

> 
> Best Regards,
> Elena
>  
>  
