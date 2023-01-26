Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5017867C91D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjAZKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9662790
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674730136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eiMNk9k1N4YdRqn/UAZCbRr/7MVZcTlwG/ktRA0Tof8=;
        b=Pm1D/mvP+ioOuo5pj/F3R6OKJpVQ7L6T+6GYu1b5Fh0Y9pwXaDPa/IUMYVOwuaIubEVFrf
        Ai9UP3SNPHK+6iq1nez5pglwa9829w+BGAQ45BjxEWFB/ol66j9KyyNwd32MPMYAKmwZdZ
        s0HVsyJNY7+R1McSJGM5ezymfe3g5vY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-h_btVADlN4OoZ0P440XCAQ-1; Thu, 26 Jan 2023 05:48:55 -0500
X-MC-Unique: h_btVADlN4OoZ0P440XCAQ-1
Received: by mail-wr1-f72.google.com with SMTP id h17-20020a5d5491000000b002bfb1375c4eso212621wrv.17
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiMNk9k1N4YdRqn/UAZCbRr/7MVZcTlwG/ktRA0Tof8=;
        b=XnyRhOOciQSCrowhI5o9QiVNj8WVbHPMGJZy0B7GcGiWQV4r9jNedXhDty8map+JhN
         KYRiciFKy94pN2ICJ9JJTrUGZQ5gJybElkpH0JDBB7+uuTFi8CqINiaRHY6vg8Ax+p5+
         D5nmFW21Oi4mTX+duKkmHFWRg6KwLkTEggbtHOnhY0WEg8Jr15aHMTOypaCrcNSkCemF
         gEayjG8Nn9wsbUji/ZnD9vSpYDWF7IA1nwcI/rkslfmM2hwpGyGcxevx62HdANXWGo75
         TxVQHvMabv08wPcvlmAfPvBRM3oyDeowPetmZQjW6uP1yQhuIf3RG2nlN9kFlLoAnLdv
         zTuw==
X-Gm-Message-State: AFqh2koZdvVUpWKIM0EFEpazxSVETZWu2MeV+Hz6BqEm6JMRNCP8Fyio
        CYuPzkB1HzonzC1eUYfU9ZvCgsURSRpnhBOitRyJlFZeABg0GKAkr0g2p8bsvZfmnX+V0PM/zyL
        Du6D/EI1ANWw+M7gaOS6kkUBZ
X-Received: by 2002:a05:600c:4f45:b0:3cf:68d3:3047 with SMTP id m5-20020a05600c4f4500b003cf68d33047mr35060545wmq.41.1674730133840;
        Thu, 26 Jan 2023 02:48:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtf8Lf9xM1JYsHez9AX5rRzGIxFUUdD0MkWNZ3BH56Iis9kY3O8+Z7Z8QktN/BOvRVvUUIvIg==
X-Received: by 2002:a05:600c:4f45:b0:3cf:68d3:3047 with SMTP id m5-20020a05600c4f4500b003cf68d33047mr35060518wmq.41.1674730133632;
        Thu, 26 Jan 2023 02:48:53 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b003d9de0c39fasm5167009wmr.36.2023.01.26.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:48:53 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:48:50 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9Jakvab14K61b2t@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125215333.GA18160@wunner.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Wunner (lukas@wunner.de) wrote:
> [cc += Jonathan Cameron, linux-pci]
> 
> On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:
> > Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > Great, so why not have hardware attestation also for your devices you
> > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > worry about anything in the guest.
> > 
> > There were some talks at Plumbers where PCIe is working on adding that;
> > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > SPDM.   I don't know much of the detail of those, just that they're far
> > enough off that people aren't depending on them yet.
> 
> CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
>
> https://github.com/l1k/linux/commits/doe

Thanks for the pointer - I'll go and hunt down that spec.

> It will allow for authentication of PCIe devices.  Goal is to submit
> this quarter (Q1).  Afterwards we'll look into retrieving measurements
> via CMA/SPDM and bringing up IDE encryption.
> 
> It's a kernel-native implementation which uses the existing crypto and
> keys infrastructure and is wired into the appropriate places in the
> PCI core to authenticate devices on enumeration and reauthenticate
> when CMA/SPDM state is lost (after resume from D3cold, after a
> Secondary Bus Reset and after a DPC-induced Hot Reset).
> 
> The device authentication service afforded here is generic.
> It is up to users and vendors to decide how to employ it,
> be it for "confidential computing" or something else.

As Samuel asks about who is doing the challenge; but I guess there are
also things like what happens when the host controls intermediate
switches and BAR access and when only VFs are passed to guests.

> Trusted root certificates to validate device certificates can be
> installed into a kernel keyring using the familiar keyctl(1) utility,
> but platform-specific roots of trust (such as a HSM) could be
> supported as well.
> 
> I would like to stress that this particular effort is a collaboration
> of multiple vendors.  It is decidedly not a single vendor trying to
> shoehorn something into upstream, so the criticism that has been
> leveled upthread against other things does not apply here.
> 
> The Plumbers BoF you're referring to was co-authored by Jonathan Cameron
> and me and its purpose was precisely to have an open discussion and
> align on an approach that works for everyone:
> 
> https://lpc.events/event/16/contributions/1304/
> 
> 
> >    a) there's no good way to authenticate a PCI device yet
> >      - any nasty device can claim to have a given PCI ID.
> 
> CMA/SPDM prescribes that the Subject Alternative Name of the device
> certificate contains the Vendor ID, Device ID, Subsystem Vendor ID,
> Subsystem ID, Class Code, Revision and Serial Number (PCIe r6.0
> sec 6.31.3).
> 
> Thus a forged Device ID in the Configuration Space Header will result
> in authentication failure.

Good!  It'll be nice when people figure out the CoCo integration for
that; I'm still guessing it's a little way off until we get hardware
for that.

Dave

> Thanks,
> 
> Lukas
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

