Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2C67C9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjAZLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjAZLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:20:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFB6592
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 314BE61799
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACC5C433D2;
        Thu, 26 Jan 2023 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674731999;
        bh=HLNfnERh9yqih9lmJtSKLabo136R/CglFwL3l5Rj5Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1P0qk7I1ISxzTc2mfP78KRR9qkhlKvXLycdAcYIJgTq7Z4z+GIN6nmkB9rm6iZcK
         Nu9Wcfup5flrAI+Aw6onJbejHOwFimvel5O7/Z6+LnfBt/c1k1AF4hEp076Sy/mMgs
         0Q1UKpiOY7Wqm2lafw0WKMG3Jy0ROLgsHe0cwPJyfY38tFxTQBKNhWhdl+fV7olHVD
         +FqUZICP/kQVIHUTCgwiVcB1qs4tsrj61CN6QDbM6qnKZ03QCKYezwF1/TxNzLZ0kX
         0yn1a8OdrPdl4ohdn1rN6XzpFq8KZTRyOU/IBGnp3MSCMbAjQPjeoRW2pdJAOPVSd2
         Xh2nWWqQM0jSg==
Date:   Thu, 26 Jan 2023 13:19:55 +0200
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
Message-ID: <Y9Jh2x9XJE1KEUg6@unreal>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> Replying only to the not-so-far addressed points. 
> 
> > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > Hi Greg,

<...>

> > > 3) All the tools are open-source and everyone can start using them right away
> > even
> > > without any special HW (readme has description of what is needed).
> > > Tools and documentation is here:
> > > https://github.com/intel/ccc-linux-guest-hardening
> > 
> > Again, as our documentation states, when you submit patches based on
> > these tools, you HAVE TO document that.  Otherwise we think you all are
> > crazy and will get your patches rejected.  You all know this, why ignore
> > it?
> 
> Sorry, I didn’t know that for every bug that is found in linux kernel when
> we are submitting a fix that we have to list the way how it has been found.
> We will fix this in the future submissions, but some bugs we have are found by
> plain code audit, so 'human' is the tool. 

My problem with that statement is that by applying different threat
model you "invent" bugs which didn't exist in a first place.

For example, in this [1] latest submission, authors labeled correct
behaviour as "bug".

[1] https://lore.kernel.org/all/20230119170633.40944-1-alexander.shishkin@linux.intel.com/

Thanks
