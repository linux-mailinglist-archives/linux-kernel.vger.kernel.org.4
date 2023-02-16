Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3E6998F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBPPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBPPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0158420D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeQYQxyJSAMsBVRXT+gaV/xgFEd8Rxkvo3bIKZXtNYs=;
        b=XSasYzT7XDMjLvFw0txKY6Rij+kdjh1O5A79ZTFiR/s2wCXsh9U3t6FeKz9SGAk8GlUXPf
        OF7fHWXOggaWfjLxn3IYnGrmkoXCaN0/m96a8hU8rqJPgHRkqPuRwVHJ6sSNLotoS/8QRd
        +FhzdmWZ+rLiEGrkDkz17k+FUvjrqQU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-RM_hQxpeOEeQOE9MbmAuFQ-1; Thu, 16 Feb 2023 10:33:54 -0500
X-MC-Unique: RM_hQxpeOEeQOE9MbmAuFQ-1
Received: by mail-il1-f200.google.com with SMTP id k13-20020a92c24d000000b003127853ef5dso1483009ilo.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeQYQxyJSAMsBVRXT+gaV/xgFEd8Rxkvo3bIKZXtNYs=;
        b=XQRltur2BS7oGUahTCXmIRhga0edovMcpE4iWpm/Ca2tJd5brfLV/QyLCUCXqrFpdV
         frZ4MUy6E/aDZXmoftESGvTpjm9xQ99uSlqibRtRFfMnlkYoS2MWqI72KKxCDRGOO7ze
         XPFx2ruUNXsnp74gaawuQVyl+CPlqSbIYvcyUFO9RfuZzn1mAFuQ8A80+sRow/DGNHSt
         fVAV9h1rUA0+hrdcn6ASfNOTaE1Gd9prPulUAVxr3wO5nrka+GJKkmKUQjTMGXIhQbog
         tNKwF3aTJOIzootGLj2eQcYtsrjh+m6CGgf23dfv7w6CxMGi2rhnPM1VhNuWGt1HTlYZ
         vjsw==
X-Gm-Message-State: AO0yUKWpj3bIjLFvLMfvjzovVsTc+uF1EAYz8jyDSXN+Jh8BFPFoOm4Q
        +XcW4Pnsb+Hr80t9u3FSp/kgDU1Fs28xQqq/Sa7T2YxvJwaUIhrLDnYVe3QQkFgo0QOJ3MiX/Mi
        J31wgDd+31K7ByMJ5GXkYTdGvVY8j0g==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3727048iox.0.1676561632907;
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+h4rAfOjfEETcRvGoeKLhBvNlkJkZqTyazjzNPwMYB/1qXXAYupXsUtXuE7aklEhW9g2jibA==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3727038iox.0.1676561632677;
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id w5-20020a6bd605000000b007407ea5d07csm559095ioa.51.2023.02.16.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:33:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Message-ID: <Y+5M3qezT2t0wPx+@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
 <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
 <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
 <Y+z4XlhDzokAMTI1@x1n>
 <CADyTPEzcJxgFgQAwopsHz3b-e+hmHJqidpjzDhow8KkkAyyo8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyTPEzcJxgFgQAwopsHz3b-e+hmHJqidpjzDhow8KkkAyyo8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:32:54AM -0500, Nick Bowler wrote:
> On 2023-02-15, Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Feb 15, 2023 at 03:49:56PM +0100, Linux regression tracking
> > (Thorsten Leemhuis) wrote:
> >> On 31.01.23 02:46, Nick Bowler wrote:
> >> > I'll keep running this for a while to see if any other problems come
> >> > up.
> >>
> >> Nick, I assume no other problems showed up?
> >>
> >> In that case Peter could send the patch in for merging. Or did you do
> >> that already?
> >
> > Thanks for raising this again.  Nop, I'm just waiting for a final ack from
> > Nick to make sure that nothing went wrong after the longer run.
> 
> Oh, yes, it wasn't so much a "run" as just continuing to use the
> computer normally.
> 
> Everything seems stable enough.

Thanks Nick.

I've just posted a formal patch with you copied.  There's a slight tweak
due to rebasing to the latest akpm tree, but I still attached your
tested-by for appreciations on the help, and I assume it should have the
same functional change.

-- 
Peter Xu

