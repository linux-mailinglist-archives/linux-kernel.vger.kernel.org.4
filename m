Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6276472C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLHPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLHPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:21:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1370B81;
        Thu,  8 Dec 2022 07:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E96E61F7B;
        Thu,  8 Dec 2022 15:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54264C433C1;
        Thu,  8 Dec 2022 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670512860;
        bh=V4PGwpQHcRdaTj7RQB6+cCZjNiTp0CjtX/YahKcx2cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvJRraG+p2Y89wgqvueBx/Hwwieb06weDeQZsJjClXTuDt2c0hFVpxFdocmOreu5y
         0KvQkzmvoYbdlBCPAW2JJf9QAH8ng7wTz5z+372P4f/ZleBaxJhpOQ/JjGXL28AmV9
         cXCMhLD1KAJEO/CZ7uIRjtdoiUaVgJvkMTu7oesA=
Date:   Thu, 8 Dec 2022 16:20:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, lucas.de.marchi@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] modules: add modalias file to sysfs for modules.
Message-ID: <Y5IA2NYE5IaAzNby@kroah.com>
References: <CAJzde06+FXNpyBzT+NfS2GCfqEERMkGDpdsmHQj=v1foLJW4Cw@mail.gmail.com>
 <20221129224313.455862-1-allenwebb@google.com>
 <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
 <CAJzde06ACctpK-5ht_Ow9dMuisOwTM5CKE_SK+bW5eWTmwCUxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJzde06ACctpK-5ht_Ow9dMuisOwTM5CKE_SK+bW5eWTmwCUxg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:22:56AM -0600, Allen Webb wrote:
> On Wed, Dec 7, 2022 at 8:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Nov 29, 2022 at 04:43:13PM -0600, Allen Webb wrote:
> > > This information is readily available for external modules in
> > > modules.alias. However, builtin kernel modules are not covered.
> >
> > Why add this into the kernel instead of just a modules.builtin.alias
> > or something like that?
> >
> >   Luis
> 
> I am fine with that approach and already have a PoC for it. Here are
> some considerations:
> * This would add a new file to the kernel packaging requirements.

That's easy, you add it to the build process and the tools that pick up
kernels to package them, grab everything that the build process creates.

> * It is easier for separate files to get out of sync with the runtime
> state (this isn't really a big deal because we already have to deal
> with it for modules.alias)

How can it get out of sync if it came directly from the kernel image
itself?

I think this really is the best solution, as it should be much simpler
overall and not require every bus to add special code for it, right?

thanks,

greg k-h
