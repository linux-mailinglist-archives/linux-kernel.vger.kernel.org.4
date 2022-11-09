Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB71622122
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiKIBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKIBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98111C42A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667955867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZkmt97VpqvS5xcPVLVRJGY6/QQzPHRetf9QxFFBydg=;
        b=Pa3luBSim8/UXit+1asLJCnGsI4M73Z9n30Aa473AQ/pcGKAwILBujecjp+z0YMPcaV48P
        CH6IzDGodgGuyD1TeoxRA0/n8KkYRFLvXvsuFZpz/oAkNoR1XBYV0X2/sBPAZP9U2rTDHq
        drqNRpO9992/G+iwmrHKQ//SWuwRO48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-NK3vfayPPYianvDJCSSdgg-1; Tue, 08 Nov 2022 20:04:24 -0500
X-MC-Unique: NK3vfayPPYianvDJCSSdgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E209185A7AA;
        Wed,  9 Nov 2022 01:04:20 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAC114B3FC6;
        Wed,  9 Nov 2022 01:04:19 +0000 (UTC)
Date:   Wed, 9 Nov 2022 09:04:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-ID: <Y2r8kFZVZP1ou1qZ@MiWiFi-R3L-srv>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
 <20221108154846.11584119794413c7682280fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108154846.11584119794413c7682280fc@linux-foundation.org>
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

On 11/08/22 at 03:48pm, Andrew Morton wrote:
> On Thu, 27 Oct 2022 13:50:08 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> 
> > Though vmcoreinfo is intended to be small, at just one page, useful
> > information is still added to it, so we risk running out of space.
> > Currently there is no runtime check to see whether the vmcoreinfo buffer
> > has been exhausted. Add a warning for this case.
> > 
> > Currently, my static checking tool[1] indicates that a good upper bound
> > for vmcoreinfo size is currently 3415 bytes, but the best time to add
> > warnings is before the risk becomes too high.
> > 
> > ...
> >
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
> >  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
> >  
> >  	vmcoreinfo_size += r;
> > +
> > +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> > +		  "vmcoreinfo data exceeds allocated size, truncating");
> >  }
> 
> Seems that vmcoreinfo_append_str() will truncate (ie: corrupt) the
> final entry when limiting the overall data size to VMCOREINFO_BYTES. 
> And that final entry will be missing any terminating \n or \0.
> 
> Is all this desirable, or should we be checking for (and warning about)
> sufficient space _before_ appending this string?


Hmm, once we really reach that point, truncated vmcoreinfo should not be
useful for later vmcore dumping and analyzing. As we can see, the
arch_crash_save_vmcoreinfo() is called at the end of
crash_save_vmcoreinfo_init(). E.g on x86_64, the phys_base,
init_top_pgt, etc are very important for memory layout analyzing.
Fortunatly this insufficient vmcoreinfo page won't impact the normal
kernel running.

So, the current change looks good to me.

My further thinking is if we should print the truncated or first skipped
entry in the warning so that people know better what's happening, even
though whatever we will do is to increase one page for vmcoreinfo buffer.
Not strong opinion though.


diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..8ba4dd90694d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
 	vmcoreinfo_size += r;
+
+	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
+		  "vmcoreinfo data exceeds allocated size when adding: %s\n", buf);
 }
 
 /*

