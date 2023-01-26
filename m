Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAB67D0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjAZP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769124FAF4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674748541;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUfz5FqW5DjFue06WiRhV7K91biiIYjl4iTlBUVfvFM=;
        b=itoZpfI6CAv3MX+5k4Up1GSDXfk958vgDtTXE0eCHreTtBeOIAgKh0o8aV66yNDUblq7cO
        hkIVViott+xKE9EPNs66efok7hqwepuNl4cA1Pi/eipAE0WVKg3HrO7k8LySulGRqc6T96
        tzbbUaVB+kM32lCdcnYGE4f9PzjJX4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-QlWNrDv2PaGd9D8a0A1pJw-1; Thu, 26 Jan 2023 10:55:38 -0500
X-MC-Unique: QlWNrDv2PaGd9D8a0A1pJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91B4C3C10696;
        Thu, 26 Jan 2023 15:55:37 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62D16492C14;
        Thu, 26 Jan 2023 15:55:34 +0000 (UTC)
Date:   Thu, 26 Jan 2023 15:55:32 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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
Message-ID: <Y9KidD7bT8QJbG+Q@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
 <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
 <Y9KVHnHnig4jwNPx@work-vm>
 <CAFLxGvyMncqjkEXiOqenQu+rZW46RP7UorXs36+awmgnBxTGhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvyMncqjkEXiOqenQu+rZW46RP7UorXs36+awmgnBxTGhA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:13:11PM +0100, Richard Weinberger wrote:
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

That just moves the problem elsewhere though surely. The remote iSCSI
server still has to persist the VMs' data, and the cloud sevice provider
can observe any I/O before it hits the final hardware storage. So the
remote iSCSI server needs to apply a FDE like encryption scheme for
the exported iSCSI block device, and using a key only accessible to the
tenant that owns the VM. It still needs to solve the same problem of
having some kind of "generation ID" that can tweak the IV for each virtual
disk sector, to protect against time based analysis.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

