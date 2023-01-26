Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D567D00E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAZPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjAZPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DEC20050
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674746534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiWnUSu55NG/fxtmWuYsdLF85NahVTAKDGkr6o00Vrw=;
        b=GAPS0MxACAzt40+AR+5rW8E5giq3TTwaA2Jj0Ud+DDFoPc3IrN/kQRggDwQ7kqAp+R0Q4a
        s9AN3QqJRnJqTfU85ZTtttPQCMtFUgxESRLknVnEuZJj+xSCEi+vP9yzBp9f+9l8NO2vsd
        mecEpg//R9ZLtLYsHWpDeEaml/OeM4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-Sq7lQR4tMYqZ22gXIHoA9A-1; Thu, 26 Jan 2023 10:22:13 -0500
X-MC-Unique: Sq7lQR4tMYqZ22gXIHoA9A-1
Received: by mail-wm1-f71.google.com with SMTP id k34-20020a05600c1ca200b003db30c3ed63so1194661wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiWnUSu55NG/fxtmWuYsdLF85NahVTAKDGkr6o00Vrw=;
        b=T1fhFBTBjUny50GhXITbq/BrigFJBLM8otpP9m7yjdWf++P+2j0dgqMVG0G5b2bUyO
         2Tp0+YmihFt4bVwBrKh1L3jvJFdAHs9n8+7RIGpWVZUUaQGNT26jhXe1stIA7KRT97PM
         Ia6sXUZCoVZ65SlL9FAivd7OlYKHEHWUykBQO92ZNDDEh1ROFYKPDy2DODqoJgewtkEj
         Kn8c1co6F5d7BwrC5dYwszSCw+i44Oqmy2AFT3pQ4EOAOSpa2xeEM7UF/O3yOegZSTWY
         UlwEMLfdiGOvLhhD3CrkP9etZgbeQTfyS/RvSHDabj7WV/jbfYqw/pp52RhVf84Jw+K8
         D/bw==
X-Gm-Message-State: AFqh2kr58LHP7a7fkPb5eLBPcJr+WzvCwwBUqeF+UglomSZU8xGmqQHk
        3CNCGCitlHwa41KfAQqUZUlaaAiHqd8d2qlolJ3rtzeIlAR0STDTCypVgUMb54+4NhQ+uslrGu8
        xs+E2A2vu6tC0IelsIk8ghe4C
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr32580417wro.48.1674746532275;
        Thu, 26 Jan 2023 07:22:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUoxvlfIjwabTI32l3InDigTpv5ZMbqGg+D9q3vmaeIBrib7FBQMUubpGP2ULG/rDQpSaxDw==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr32580394wro.48.1674746532076;
        Thu, 26 Jan 2023 07:22:12 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id c7-20020adfe707000000b002bfb0c5527esm1555390wrm.109.2023.01.26.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:22:11 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:22:09 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <Y9KaoZKjyKD8aokf@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
 <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
 <Y9KVHnHnig4jwNPx@work-vm>
 <CAFLxGvyMncqjkEXiOqenQu+rZW46RP7UorXs36+awmgnBxTGhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvyMncqjkEXiOqenQu+rZW46RP7UorXs36+awmgnBxTGhA@mail.gmail.com>
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

* Richard Weinberger (richard.weinberger@gmail.com) wrote:
> On Thu, Jan 26, 2023 at 3:58 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Richard Weinberger (richard.weinberger@gmail.com) wrote:
> > > On Wed, Jan 25, 2023 at 3:22 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > Any virtual device exposed to the guest that can transfer potentially
> > > > sensitive data needs to have some form of guest controlled encryption
> > > > applied. For disks this is easy with FDE like LUKS, for NICs this is
> > > > already best practice for services by using TLS. Other devices may not
> > > > have good existing options for applying encryption.
> > >
> > > I disagree wrt. LUKS. The cryptography behind LUKS protects persistent data
> > > but not transport. If an attacker can observe all IO you better
> > > consult a cryptographer.
> > > LUKS has no concept of session keys or such, so the same disk sector will
> > > always get encrypted with the very same key/iv.
> >
> > Are you aware of anything that you'd use instead?
> 
> Well, I'd think towards iSCSI over TLS to protect the IO transport.

Yeh, that's not entirely crazy for VMs which tend to come off some
remote storage system.

> > Are you happy with dm-verity for protection against modification?
> 
> Like LUKS (actually dm-crypt) the crypto behind is designed to protect
> persistent data not transport.
> My fear is that an attacker who is able to observe IOs can do bad things.

Hmm, OK,  I'd assumed dm-crypt was OK since it's more hashlike and
unchanging.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

