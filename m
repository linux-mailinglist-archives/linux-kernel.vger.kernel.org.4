Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0667D377
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjAZRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAZRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A71814C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674755119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSskgd+GsWzZv2ddPzXtajpOXPCHYl8he11PS9zfEkM=;
        b=MjDLuHpVQhhmQ546RbRfqPVo2f7dF9NAEoqwcDxHvZ6VtUs9BKKEGnMk0HWiqJta02oU+o
        tWzU5BA1gxkXVLBfHw/0Kq4/6NCnsQQ1+cCtMGa4x4Sps09rjLukN0+/UTHj4ri23M18Rn
        pspaUkP6bbvYCoxvDoNfn3fJStkXwpI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-yFBFxI08MMiGJ0xy5nzkxA-1; Thu, 26 Jan 2023 12:45:17 -0500
X-MC-Unique: yFBFxI08MMiGJ0xy5nzkxA-1
Received: by mail-io1-f72.google.com with SMTP id y21-20020a5ec815000000b00707f2611335so1329991iol.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSskgd+GsWzZv2ddPzXtajpOXPCHYl8he11PS9zfEkM=;
        b=kjQdy1jorPi4Yh3nzzWb+EAYIvy4cDqQ8FxDbJJRM1DACCZErLzS0ZBV3LT+EnNvLH
         IhpRtscIRWWsWHqBkDDppuYSw22mabwp70EJ/bmoieR8FSVk443NIFapkulo9c/ezTyl
         XpaL0SyXKMoQX6XE29QZxTYKqIYxqLNxkXIiJsS66q3foFTK3l7cSa27NhjRiQXFbNid
         Nd1NwombMuK/ge1bf/RDF8BORXgaJH62nU6neT9ubx5H8l3QTZfNd6W43lMygGfQLaY6
         H+B74kCxpKLcjWpx4qnXuA6xbRb+fzBoRNy5/CdhgztUzEL+rlHAo+Q3o/CU0+8AerSX
         WQUQ==
X-Gm-Message-State: AO0yUKXER4R3/I5HuCWSvgvx7pMSw933tU6UrkYP0rnhSzctGOJhzS+h
        IqYZHcB09hgXytzWRYwISaXkUO8GvjAsiq4mS4PykIPpj9hrlbJNiHUpHulTAiBsjVxSip2urtD
        ioaK3x0wScxr5hXOVLZJsnE5d
X-Received: by 2002:a92:cd86:0:b0:310:b003:1495 with SMTP id r6-20020a92cd86000000b00310b0031495mr4198213ilb.30.1674755117131;
        Thu, 26 Jan 2023 09:45:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8pxzVfaSnYFk5ftxwc90HJUbrmuoH4f2VuN21CzLzQVMCitdN+sNCb50knQ3teiBU/DLTvNg==
X-Received: by 2002:a92:cd86:0:b0:310:b003:1495 with SMTP id r6-20020a92cd86000000b00310b0031495mr4198181ilb.30.1674755116851;
        Thu, 26 Jan 2023 09:45:16 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z13-20020a92d6cd000000b0030da09e3bd0sm498125ilp.50.2023.01.26.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:45:16 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:45:15 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Finn Behrens <me@kloenk.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230126104515.3fcb3abf.alex.williamson@redhat.com>
In-Reply-To: <20230126174044.GA15999@lst.de>
References: <20230126163719.3585002-1-arnd@kernel.org>
        <20230126103811.56d71351.alex.williamson@redhat.com>
        <20230126174044.GA15999@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 18:40:44 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jan 26, 2023 at 10:38:11AM -0700, Alex Williamson wrote:
> > Seems like it wouldn't just be the sample drivers with this issue,
> > don't VFIO_CCW, VFIO_AP, and DRM_I915_GVT_KVMGT all have this problem?
> > Thanks,  
> 
> Yes, they all need to depend on VFIO.
> 
> Should I resend the series with that fixed?

The culprit is already in my next branch, we just need a fix that
includes all the cases.  A respin of Arnd's patch would be preferable
to keep the fixes in one place.  Thanks,

Alex

