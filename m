Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78E68F6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBHScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE801F4B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675881092;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjIMNt6QbEWaBTMinb5F0Mjlorq11cP4pgDkqGZEChU=;
        b=JXkqZrfUQl8yzCBxAzoUoLRn7oONcMXMJUxsEK0rLNJVrqWxgWVRUvRoYRweDmVZW92LO/
        2LjxL9AdDfqXZ11NXcq3QM7Pne4m+oqhmnZhJkYq8fsrYS1yhtU/so8XKILeuHyU5jfvqe
        alnOsyVR50zhf9GiQx7hY9wXTXYt63s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-oSN_EdKnOdenzBNxrLCtZQ-1; Wed, 08 Feb 2023 13:31:27 -0500
X-MC-Unique: oSN_EdKnOdenzBNxrLCtZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6372C858F0E;
        Wed,  8 Feb 2023 18:31:26 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6B8BC15BA0;
        Wed,  8 Feb 2023 18:31:23 +0000 (UTC)
Date:   Wed, 8 Feb 2023 18:31:20 +0000
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
Message-ID: <Y+PqePFLgp5Lel4V@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208180835.234638-1-Jason@zx2c4.com>
 <20230208131125-mutt-send-email-mst@kernel.org>
 <CAHmME9rMnbGDZ+Rq8ao=gZd10kBp5ni=73HcPpFC58ChoKZObA@mail.gmail.com>
 <20230208131805-mutt-send-email-mst@kernel.org>
 <Y+PpPRvnlakC78Is@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+PpPRvnlakC78Is@zx2c4.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:26:05PM +0100, Jason A. Donenfeld wrote:
> On Wed, Feb 08, 2023 at 01:18:37PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 08, 2023 at 03:14:38PM -0300, Jason A. Donenfeld wrote:
> > > On Wed, Feb 8, 2023 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Feb 08, 2023 at 03:08:35PM -0300, Jason A. Donenfeld wrote:
> > > > > All attempts at providing setup_data have been made as an iteration on
> > > > > whatever was there before, stretching back to the original
> > > > > implementation used for DTBs that [mis]used the kernel image itself.
> > > > > We've now had a dozen rounds of bugs and hacks, and the result is
> > > > > turning into a pile of unmaintainable and increasingly brittle hacks.
> > > > >
> > > > > Let's just rip out all the madness and start over. We can re-architect
> > > > > this based on having a separate standalone setup_data file, which is how
> > > > > it should have been done in the first place. This is a larger project
> > > > > with a few things to coordinate, but we can't really begin thinking
> > > > > about that while trying to play whack-a-mole with the current buggy
> > > > > implementation.
> > > > >
> > > > > So this commit removes the setup_data setting from x86_load_linux(),
> > > > > while leaving intact the infrastructure we'll need in the future to try
> > > > > again.
> > > > >
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Dov Murik <dovmurik@linux.ibm.com>
> > > > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > >
> > > > I think I'll be happier if this is just a revert of
> > > > the relevant commits in reverse order to make life easier
> > > > for backporters.
> > > > Unless that's too much work as we made other changes around
> > > > this code?
> > > 
> > > I think that's going to be messy. And it won't handle the dtb stuff
> > > either straightforwardly.
> > 
> > List of Fixes tags so people can at least figure out whether they
> > have a version that needs this fix then?
> 
> 7.2 is when the functionality started causing problems for most people.
> But the buggy code goes back to 3cbeb524 in 2016.

We can't rip out the full setup_data support back to that point. That
is deleting significant features that would break -dtb IIUC. For that
we would need to have a deprecation period to announce the incompatibility.

I was thinking this would only revert the RNG seed pieces which have
negligible user impact.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

