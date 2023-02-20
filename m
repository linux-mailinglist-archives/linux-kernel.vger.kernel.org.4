Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC769C8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBTKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjBTKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141CBB84
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676890147;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+IrwP2BnQ+t/YdFo+t5fvXd2ZtYLj+C5Gx+3ACfu0I=;
        b=WVtANXQBnKoYj5O3wO7h1H4GbrsMANk3o/JWczOw3lhDg/fGxm7nwGNHKZI/UR9nkGq0bO
        aboOqxn+vV545ykBWFKLqIZfpz+JpG+y7MNyO7P4QUiPdUkFivV4+7tjXU4VP2I/iUCvHK
        JYw3deokzsVD7Qfs2cMlFGP8LCoBAfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-jasF8v-gPQ2iNFprKINAtw-1; Mon, 20 Feb 2023 05:49:03 -0500
X-MC-Unique: jasF8v-gPQ2iNFprKINAtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C675585A5A3;
        Mon, 20 Feb 2023 10:49:02 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0E9C15BA0;
        Mon, 20 Feb 2023 10:49:00 +0000 (UTC)
Date:   Mon, 20 Feb 2023 10:48:57 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH RFC 0/7] revert RNG seed mess
Message-ID: <Y/NQGfiH322iZuhX@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
 <Y+YratFIX/WHWbFy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+YratFIX/WHWbFy@redhat.com>
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

On Fri, Feb 10, 2023 at 11:32:58AM +0000, Daniel P. Berrangé wrote:
> On Wed, Feb 08, 2023 at 04:12:23PM -0500, Michael S. Tsirkin wrote:
> > All attempts to fix up passing RNG seed via setup_data entry failed.
> > Let's just rip out all of it.  We'll start over.
> > 
> > 
> > Warning: all I did was git revert the relevant patches and resolve the
> > (trivial) conflicts. Not even compiled - it's almost midnight here.
> > 
> > Jason this is the kind of approach I'd like to see, not yet another
> > pointer math rich patch I need to spend time reviewing. Just get us back
> > to where we started. We can redo "x86: use typedef for SetupData struct"
> > later if we want, it's benign.
> 
> This approach looks suitable for applying to the 7.2 tree too,
> which will be good for fixing the regressions in stable.

Since no further alternative has been proposed, can you consider sending
a pull request for this series. This has been broken for too long and
many users & vendors are looking for an official fix to be applied to
master before they backport to 7.2

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

