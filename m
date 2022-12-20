Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196D65229B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLTObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiLTOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:30:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7419293;
        Tue, 20 Dec 2022 06:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91121B815C2;
        Tue, 20 Dec 2022 14:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB6AC433EF;
        Tue, 20 Dec 2022 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671546625;
        bh=70XXttVOGVIVhY0cgtn/nOiywONR5LfAWdNk1kH9ePA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYhMcKJV+ufvydMktI3+ZAaFKxmd3n6769WXov0wiyNSeG1tahVuEe9f+adUbjxBa
         Hn45Tfuf/sQcPrOlssz1QEcwKfWiPGN7uuAGvk5UB5GGFQgtT4DBTKlaJgFqkLmQjv
         MG9iDymZYT60yOL8U/eFlbS1Vmv74td1FruZTgjo=
Date:   Tue, 20 Dec 2022 15:30:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <Y6HG/vz4MWRwcEhj@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <YyHq9OOKBLP2GEcc@kroah.com>
 <5d1485d4-08d4-1e26-f597-b5fa6cc65ce6@nxp.com>
 <Y4cF2pX4Lohefm4f@kroah.com>
 <bbfd859e-b8fb-d69f-887b-4a3d82bb0437@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfd859e-b8fb-d69f-887b-4a3d82bb0437@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:39:52PM +0530, Manjunatha Venkatesh wrote:
> On 11/30/2022 12:57 PM, Greg KH wrote:
> > Caution: EXT Email
> > 
> > On Wed, Nov 30, 2022 at 09:10:08AM +0530, Manjunatha Venkatesh wrote:
> > > On 9/14/2022 8:23 PM, Greg KH wrote:
> > Note, originally you all were "rushed" to get this accepted, and now
> > this took 2 1/2 months to respond back to a code review?  Something is
> > wrong here, when responding so late, almost all context is lost :(
> 
> Sorry for the delayed response,further we will make sure address the review
> comments ASAP.
> 
> > 
> > > > Caution: EXT Email
> > > > 
> > > > On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
> > > > > +++ b/drivers/misc/nxp-sr1xx.c
> > > > > @@ -0,0 +1,794 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > > > Please no.  If you really want to dual-license your Linux kernel code,
> > > > that's fine, but I will insist that you get a signed-off-by from your
> > > > corporate lawyer so that I know that they agree with this and are
> > > > willing to handle all of the complex issues that this entails as it will
> > > > require work on their side over time.
> > > > 
> > > > If that's not worth bothering your lawyers over, please just stick with
> > > > GPL as the only license.
> > > Dual-license is signed-off by NXP corporate lawyer.
> > We need a signed-off-by on the patch itself.
> As part of Version6 patch submission signed-off by NXP corporate lawyer
> updated
> > > Though, we would like to understand what complex issues which require
> > > work over the time?
> > I am not a lawyer and can not advise you of this, please work with yours
> > to set into place the requirements you will have to keep this working
> > properly.  Note, it is not trivial, and will require work on your end.
> > 
> > I will push back again, and ask "Why?"  Why do you want this dual
> > licensed?  What is driving that requirement and what will having it
> > licensed like this enable you to do that having it just under GPL-2.0
> > will not?
> 
> Our corporate lawyer suggested to use this dual license for NXP UWB product.

And I need a tangable _reason_ why a dual license is needed here.
Remember, dual licensing takes from the community and does not give
back, so justifications for why this is required is essencial if you
wish for people to at the very least, review your code...

> 
> > > > > +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> > > > > +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> > > > You can't stick ioctl command definitions in a .c file that userspace
> > > > never sees.  How are your userspace tools supposed to know what the
> > > > ioctl is and how it is defined?
> > > We will move ioctl command definitions into user space header file as part
> > > of our next patch submission.
> > > > How was this ever tested and where is your userspace code that interacts
> > > > with this code?
> > > We will share the corresponding user space code soon,meanwhile can you
> > > please suggest how to share this user space code?
> > You all have ways of posting code publicly :)
> 
> NXP UWB user space code available at below shared path.
> 
> https://github.com/NXP/uwb-driver-testapp

And the code there shows that you did not write the kernel side
correctly :(

Please fix it all up for your next submission.

thanks,

greg k-h
