Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F268F794
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjBHS7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBHS7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0545528D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675882734;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ9ibrCR5RbDtCsjqILP7FESVL3t0DXajptKZqNboi0=;
        b=hGmyZ5M34VVflH5DfO5XT2w5NSLOsY7RZYseRjbppsTeM7pbz8oE9MCNCezs6Yg375PTJv
        77DK5sXE+yyhr6MKIKVgF21DZsNdbcxAUb3Z7wb2+0VGPzunen6CRXNkB2u5I8dVlkDO7Y
        1T5v8MMmTztkWEd3oy8aedpXm7lUrrA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-I0uVy-OfNX-hksdP0k93yw-1; Wed, 08 Feb 2023 13:58:50 -0500
X-MC-Unique: I0uVy-OfNX-hksdP0k93yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 196C5800050;
        Wed,  8 Feb 2023 18:58:50 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72A4D18EC2;
        Wed,  8 Feb 2023 18:58:47 +0000 (UTC)
Date:   Wed, 8 Feb 2023 18:58:45 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: temporarily remove all attempts to provide
 setup_data
Message-ID: <Y+Pw5St+8kBXSCFx@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208180835.234638-1-Jason@zx2c4.com>
 <20230208131125-mutt-send-email-mst@kernel.org>
 <CAHmME9rMnbGDZ+Rq8ao=gZd10kBp5ni=73HcPpFC58ChoKZObA@mail.gmail.com>
 <20230208131805-mutt-send-email-mst@kernel.org>
 <Y+PpPRvnlakC78Is@zx2c4.com>
 <Y+PqePFLgp5Lel4V@redhat.com>
 <Y+PrNmq5nuWKWfGw@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+PrNmq5nuWKWfGw@zx2c4.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:34:30PM +0100, Jason A. Donenfeld wrote:
> On Wed, Feb 08, 2023 at 06:31:20PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Feb 08, 2023 at 07:26:05PM +0100, Jason A. Donenfeld wrote:
> > > On Wed, Feb 08, 2023 at 01:18:37PM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Feb 08, 2023 at 03:14:38PM -0300, Jason A. Donenfeld wrote:
> > > > > On Wed, Feb 8, 2023 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 08, 2023 at 03:08:35PM -0300, Jason A. Donenfeld wrote:
> > > > > > > All attempts at providing setup_data have been made as an iteration on
> > > > > > > whatever was there before, stretching back to the original
> > > > > > > implementation used for DTBs that [mis]used the kernel image itself.
> > > > > > > We've now had a dozen rounds of bugs and hacks, and the result is
> > > > > > > turning into a pile of unmaintainable and increasingly brittle hacks.
> > > > > > >
> > > > > > > Let's just rip out all the madness and start over. We can re-architect
> > > > > > > this based on having a separate standalone setup_data file, which is how
> > > > > > > it should have been done in the first place. This is a larger project
> > > > > > > with a few things to coordinate, but we can't really begin thinking
> > > > > > > about that while trying to play whack-a-mole with the current buggy
> > > > > > > implementation.
> > > > > > >
> > > > > > > So this commit removes the setup_data setting from x86_load_linux(),
> > > > > > > while leaving intact the infrastructure we'll need in the future to try
> > > > > > > again.
> > > > > > >
> > > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Cc: Dov Murik <dovmurik@linux.ibm.com>
> > > > > > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > > > > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > > > > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > > > > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > > > > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > > >
> > > > > > I think I'll be happier if this is just a revert of
> > > > > > the relevant commits in reverse order to make life easier
> > > > > > for backporters.
> > > > > > Unless that's too much work as we made other changes around
> > > > > > this code?
> > > > > 
> > > > > I think that's going to be messy. And it won't handle the dtb stuff
> > > > > either straightforwardly.
> > > > 
> > > > List of Fixes tags so people can at least figure out whether they
> > > > have a version that needs this fix then?
> > > 
> > > 7.2 is when the functionality started causing problems for most people.
> > > But the buggy code goes back to 3cbeb524 in 2016.
> > 
> > We can't rip out the full setup_data support back to that point. That
> > is deleting significant features that would break -dtb IIUC. For that
> > we would need to have a deprecation period to announce the incompatibility.
> > 
> > I was thinking this would only revert the RNG seed pieces which have
> > negligible user impact.
> 
> I'm pretty sure -dtb is used by nobody...

Unless it can be demonstrated it is so broken it is technically
impossible to successfully use in any way, then QEMU policy is to
assume that there are users.

The QEMU deprecation policy exists to handle the scenario where we
want to remove a feature and need to alert potential users ahead
of time, so they have an opportunity to object to the breakage.
This is described here:

  https://www.qemu.org/docs/master/about/deprecated.html

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

