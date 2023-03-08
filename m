Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF46B1374
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCHU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCHU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:59:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B659C7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678309120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK0tSbylSM3D4ZL5je7az/sG6hsOSuUnjSNP898pz7c=;
        b=DK7G21QWS3JTxz/sE6aHfmrbhlJ5podtuVoTb8xlX8noMpdQbNTxzFeHA0C8xvm8nmTHQL
        iQucgnf8fyJJgtkU+1OOHgXtjAmqqJKik53wJlqMx61BWedHYWDy5AOLgnzZ4rhuvg39gD
        y6IBinR8J91xlI5lUYOj/cYPGHBB2kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-IqUC3WCoMJKyKSIQdW4qbA-1; Wed, 08 Mar 2023 15:58:39 -0500
X-MC-Unique: IqUC3WCoMJKyKSIQdW4qbA-1
Received: by mail-wm1-f70.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so1420748wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK0tSbylSM3D4ZL5je7az/sG6hsOSuUnjSNP898pz7c=;
        b=s5DbDoo8CjauxACW46FrBvjmUbviuWbqdRqmxDBFVW04HNvOOrvhHMHotQ/QiGqPxR
         GmPHxmqFsvez702WH7YyigUpEP3Sn0bq8Awrh6O62G0tDZembqwhIOMo/0Z5UFdL7S1W
         oiJms+JnN56FGeqpojdSEaYv+w4hZEaAcEBWK42UaR8ikT88Owlx0G3fJc1LzLxPEUNE
         3E1j11gW3+C7CqHrrNnYmxoLrep+OuOQcZeewG83hGcfzE5oYJ35NBk79ozGjV8POjuq
         pTT/nvQSISD+reWEbnYSU09WmZRBHO9r4rQ9ToRd6pPt35/tFfX0jiHyyU8A/5NWkOKb
         qnDQ==
X-Gm-Message-State: AO0yUKUhPUM54fR09A7PkbkJXDXggeGhrp24uXSc4sOniktbNJnoi6Vy
        amAqe6B0CST78JgniBPh2yW8VFty5HX4d9Cp2nN1NXUuImMsi+Rg1+YZQ6qdqmYa34Kms5eG9E1
        seMZaFXj/SuYbFMN1GyZHBam7DFYwmQ7V
X-Received: by 2002:adf:df04:0:b0:2c7:169b:c56d with SMTP id y4-20020adfdf04000000b002c7169bc56dmr12867781wrl.17.1678309117535;
        Wed, 08 Mar 2023 12:58:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/qsQbqXpGs1BsSTQnZ83XeHRqUhK0bAYjCG5Ubgh4GHNnI59qU/QCeRnfK/U5SS6k2f9l5Lg==
X-Received: by 2002:adf:df04:0:b0:2c7:169b:c56d with SMTP id y4-20020adfdf04000000b002c7169bc56dmr12867772wrl.17.1678309117217;
        Wed, 08 Mar 2023 12:58:37 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600000cb00b002c3f03d8851sm15651366wrx.16.2023.03.08.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:58:36 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:58:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] container_of: add type safety
Message-ID: <20230308155524-mutt-send-email-mst@kernel.org>
References: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
 <ZAjMeVHI1r8jFW/X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAjMeVHI1r8jFW/X@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 06:57:13PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 08, 2023 at 12:35:03PM -0500, Michael S. Tsirkin wrote:
> > Using a wrong member in container_of will result in an error.
> > No so for container_of_const - it is just a cast so will
> > happily give you a wrong pointer.
> > 
> > Use logic from container_of to add safety.
> > 
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Link: https://lore.kernel.org/r/20221205121206.166576-1-gregkh@linuxfoundation.org
> 
> That's the wrong link, that's not this patch, that was an old patch.
> 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I did not sign off on this.  NEVER do that, you just made a legal
> statement in my name, why?
> 
> Why did you not sign off on it?
> 
> totally confused...

Ooops. I started with people who signed off on the original one
and replaced S.O.B with a CC. Forgot to replace it for yours
and then the script checking patches saw a signoff and was happy
so I didn't notice I forgot to sign it myself ...

However ...


> > ---
> >  include/linux/container_of.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > index 1d898f9158b4..5d87faf72e0a 100644
> > --- a/include/linux/container_of.h
> > +++ b/include/linux/container_of.h
> > @@ -29,10 +29,13 @@
> >   * @type:		the type of the container struct this is embedded in.
> >   * @member:		the name of the member within the struct.
> >   */
> > -#define container_of_const(ptr, type, member)				\
> > +#define container_of_const(ptr, type, member) ({			\
> > +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> > +		      __same_type(*(ptr), void),			\
> > +		      "pointer type mismatch in container_of()");	\
> 
> Why is this needed because:
> 
> 
> >  	_Generic(ptr,							\
> >  		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> >  		default: ((type *)container_of(ptr, type, member))	\
> 
> container_of() is used here, so shouldn't the assert trigger there if
> you get things wrong?
> 
> So why is this change needed at all?
> 
> thanks,
> 
> greg k-h


Hmm. I think I was confused. Error did not seem to trigger but
I tried again and it does. Ignore this please.

Sorry about the noise.

-- 
MST

