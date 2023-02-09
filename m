Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AC69118E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjBITs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBITs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A323671
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675972093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLB/j3TkDxPe2Ifjg9f2yoKGkddHFcQGKgP3GFg7Ob0=;
        b=iQIrJAPEFSzAlu1GTgOmGl6QyfTiKXhyr/nwXx+5LzAXgsIUJWnC6Pl1lxE8kI2bmBRZCU
        c6UkEu1SiJb0ZVUPq3DRorkxfNORmPSB4BAZJXlXNR3wDEc0o49qdM3M9icg4z2LCL1U8z
        nD0I6zkyO4116xnCMxwk4OBq2hhnCys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-h5gsowieNomj9nDUIJz0kA-1; Thu, 09 Feb 2023 14:48:12 -0500
X-MC-Unique: h5gsowieNomj9nDUIJz0kA-1
Received: by mail-wr1-f70.google.com with SMTP id v5-20020adf8b45000000b002bde0366b11so807302wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLB/j3TkDxPe2Ifjg9f2yoKGkddHFcQGKgP3GFg7Ob0=;
        b=vvYZ/Sl8seLID8nIbnq118k2eZnYLua9wFpoeqCXizOetphnrmlAdHLet3CLhQpynG
         hjqsdVFMEHSzUYZ/qqEsC/zWwN8JO6RcvTa0xP0WscUhEHs0HSuko09xFL0UkH9uLum9
         Z0MhFjnF4SV98I7x0ESlL3moidNJRDdUZ9tM9hKxegSYL9GMJ8NfX0gPyF1hELFg190E
         UAQ2BP73o9HXtvqtkSPosJjIZxTe8XbguvhaHaQzhDZNtdChW8TFyzuEXasjxOm68fiV
         9RKukS0Dl74Y9KxMoNDsw7fB4v91blL11gj9PtQKYag4SS/Aq3WoThla3mS6TtK10094
         nevQ==
X-Gm-Message-State: AO0yUKXtCGv5WhFk0ZTYOLpr7mbw1wFY1ijHJsApr80f7mquz4s+Xg0f
        sh11lS+xwN+kXtYTwXJlx4cgHbCk4VYBRmHgtdtcMupG1+beHLR81ECqBx373ji0Ve0K3EcC6wj
        WdyiKZHkxbm2eB3p5gAIH+YS+
X-Received: by 2002:a5d:67c6:0:b0:2c5:3fcb:6830 with SMTP id n6-20020a5d67c6000000b002c53fcb6830mr1864369wrw.47.1675972091368;
        Thu, 09 Feb 2023 11:48:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+aKA0QFjwLg+f0HQfDEKr3EdsNsL3InfWZ+QlzyoWSFZjoaZBLuxj82eEY7MzaXa5mi/1g3Q==
X-Received: by 2002:a5d:67c6:0:b0:2c5:3fcb:6830 with SMTP id n6-20020a5d67c6000000b002c53fcb6830mr1864345wrw.47.1675972091202;
        Thu, 09 Feb 2023 11:48:11 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b002c3f280bdc7sm1988622wrz.96.2023.02.09.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:48:10 -0800 (PST)
Date:   Thu, 9 Feb 2023 19:48:08 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y+VN+DnL4XQhGKhv@work-vm>
References: <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y+OAZTljX1I6ZvR/@kroah.com>
 <m2edr03xh4.fsf@redhat.com>
 <Y+Pb4Ood56Wxn4sj@kroah.com>
 <Y+Pjv8CeDiLRxqP/@work-vm>
 <87bkm42dcs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkm42dcs.ffs@tglx>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner (tglx@linutronix.de) wrote:
> On Wed, Feb 08 2023 at 18:02, David Alan Gilbert wrote:
> > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> >> Anyway, you all are just spinning in circles now.  I'll just mute this
> >> thread until I see an actual code change as it seems to be full of
> >> people not actually sending anything we can actually do anything with.
> 
> There have been random patchs posted which finally caused this
> discussion to start. Wrong order obviously :)
> 
> > I think the challenge will be to come up with non-intrusive, minimal
> > changes;  obviously you don't want stuff shutgunned everywhere.
> 
> That has been tried by doing random surgery, e.g. caching some
> particular PCI config value. While that might not look intrusive on the
> first glance, these kind of punctual changes are the begin of a whack a
> mole game and will end up in an uncoordinated maze of tiny mitigations
> which make the code harder to maintain.
> 
> The real challenge is to come up with threat classes and mechanisms
> which squash the whole class. Done right, e.g. caching a range of config
> space values (or all of it) might give a benefit even for the bare metal
> or general virtualization case.

Yeh, reasonable.

> That's quite some work, but its much more palatable than a trickle of
> "fixes" when yet another source of trouble has been detected by a tool
> or human inspection.
> 
> It's also more future proof because with the current approach of
> scratching the itch of the day the probability that the just "mitigated"
> issue comes back due to unrelated changes is very close to 100%.
> 
> It's not any different than any other threat class problem.

I wonder if  trying to group/categorise the output of Intel's
tool would allow common problematic patterns to be found to then
try and come up with more concrete fixes for whole classes of issues.

Dave

> Thanks,
> 
>         tglx
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

