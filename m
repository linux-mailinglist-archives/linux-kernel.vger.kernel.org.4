Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E063D8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK3PCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiK3PBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C94199F;
        Wed, 30 Nov 2022 07:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1C061A21;
        Wed, 30 Nov 2022 15:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8268AC433D6;
        Wed, 30 Nov 2022 15:01:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YA6wSyss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669820505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BND7rRc9XPDDo7YYi8oruVq6wiGyRDWqN2FS4XKYKhw=;
        b=YA6wSyss1bZc377olT6x0it7sfwcRYCrtSf2acOgow8kFBZZo2AsBtZkiCkyeTSD2mEE7A
        Bs64/ew8tY5MzLdjstsh5TnhibrlnpkObbG1UILpDHUUuzD7wm8WDbT51AVtbC23l2N0gf
        yYFj4mxZzKIEm00fjDdkZ0KwQLsPe9s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 28efa6da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 15:01:44 +0000 (UTC)
Date:   Wed, 30 Nov 2022 15:59:27 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y4dvz4d0dpFzJZ9L@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-4-Jason@zx2c4.com>
 <878rjs7mcx.fsf@oldenburg.str.redhat.com>
 <Y4dt1dLZMmogRlKa@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4dt1dLZMmogRlKa@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:51:01PM +0100, Jason A. Donenfeld wrote:
> Hi Florian,
> 
> On Wed, Nov 30, 2022 at 11:44:30AM +0100, Florian Weimer wrote:
> > * Jason A. Donenfeld:
> > 
> > > diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> > > index 73eb622e7663..9ae4d76b36c7 100644
> > > --- a/include/vdso/datapage.h
> > > +++ b/include/vdso/datapage.h
> > > @@ -109,6 +109,16 @@ struct vdso_data {
> > >  	struct arch_vdso_data	arch_data;
> > >  };
> > >  
> > > +/**
> > > + * struct vdso_rng_data - vdso RNG state information
> > > + * @generation:	a counter representing the number of RNG reseeds
> > > + * @is_ready:	whether the RNG is initialized
> > > + */
> > > +struct vdso_rng_data {
> > > +	unsigned long	generation;
> > > +	bool		is_ready;
> > > +};
> > > +
> > 
> > I don't think you can use a type like long here.  The header says this:
> > 
> >  * vdso_data will be accessed by 64 bit and compat code at the same time
> >  * so we should be careful before modifying this structure.
> > 
> > So the ABI must be same for 32-bit and 64-bit mode, and long isn't.
> 
> Excellent point. The size of the type needs to be explicit. Will fix.

I'll do something like this:

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 80e25cdcdb1c..218bbeac5613 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,19 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>

+/**
+ * type vdso_kernel_ulong - unsigned long type that matches kernel's unsigned long
+ *
+ * The structs in this file must operate the same way in both 64-bit code and
+ * in 32-bit compat code, over the same potentially 64-bit kernel. So, this
+ * type represents the size of an unsigned long as used by kernel-space code.
+ */
+#ifdef CONFIG_64BIT
+typedef u64 vdso_kernel_ulong;
+#else
+typedef u32 vdso_kernel_ulong;
+#endif
+
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -115,8 +128,8 @@ struct vdso_data {
  * @is_ready:	signals whether the RNG is initialized
  */
 struct vdso_rng_data {
-	unsigned long	generation;
-	bool		is_ready;
+	vdso_kernel_ulong	generation;
+	bool			is_ready;
 };

 /*

