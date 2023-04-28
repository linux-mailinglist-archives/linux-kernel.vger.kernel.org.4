Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0F6F13FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjD1J0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjD1J0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCA30E8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682673928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuA0sp3kPLTAsZbFHqKe9UmjDCeX3uXbQzydlzfRVOE=;
        b=I3Pldj29w1nru67npb6LCjMeYj8IF0h4+MRLgj1ncA1NtDPej1Zg9FDELfxUfWcH15oud2
        YzS/5MqSeYapvnvNTjI+BoHoFEHOZmtR4aFVO5Q/q+gpolqlmXFegulNZbDxm6mDL8lo+y
        BAEaI84OeJeklwB3p5puZBbBac0L8bA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-uHpgIYk0MMua_cWE-cemCg-1; Fri, 28 Apr 2023 05:25:24 -0400
X-MC-Unique: uHpgIYk0MMua_cWE-cemCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A79BC185A79C;
        Fri, 28 Apr 2023 09:25:23 +0000 (UTC)
Received: from localhost (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99ABBC15BA0;
        Fri, 28 Apr 2023 09:25:22 +0000 (UTC)
Date:   Fri, 28 Apr 2023 17:25:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Message-ID: <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
 <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/23 at 10:26pm, Hari Bathini wrote:
> On 27/04/23 2:19 pm, Baoquan He wrote:
> > On 04/27/23 at 12:39pm, Hari Bathini wrote:
> > > Hi Eric,
> > > 
> > > On 04/04/23 11:33 pm, Eric DeVolder wrote:
> > > > When CPU or memory is hot un/plugged, or off/onlined, the crash
> > > > elfcorehdr, which describes the CPUs and memory in the system,
> > > > must also be updated.
> > > > 
> > > > The segment containing the elfcorehdr is identified at run-time
> > > > in crash_core:crash_handle_hotplug_event(), which works for both
> > > > the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
> > > > is generated from the available CPUs and memory into a buffer,
> > > > and then installed over the top of the existing elfcorehdr.
> > > > 
> > > > In the patch 'kexec: exclude elfcorehdr from the segment digest'
> > > > the need to update purgatory due to the change in elfcorehdr was
> > > > eliminated.  As a result, no changes to purgatory or boot_params
> > > > (as the elfcorehdr= kernel command line parameter pointer
> > > > remains unchanged and correct) are needed, just elfcorehdr.
> > > > 
> > > > To accommodate a growing number of resources via hotplug, the
> > > > elfcorehdr segment must be sufficiently large enough to accommodate
> > > > changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
> > > > only on the kexec_file_load() syscall; for kexec_load() userspace
> > > > will need to size the segment similarly.
> > > > 
> > > > To accommodate kexec_load() syscall in the absence of
> > > 
> > > Firstly, thanks! This series is a nice improvement to kdump support
> > > in hotplug environment.
> > > 
> > > One concern though is that this change assumes corresponding support
> > > in kexec-tools. Without that support kexec_load would fail to boot
> > > with digest verification failure, iiuc.
> > 
> > Eric has posted patchset to modify kexec_tools to support that, please
> > see the link Eric pasted in the cover letter.
> > 
> > http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
> 
> Right, Baoquan.
> 
> I did see that and if I read the code correctly, without that patchset
> kexec_load would fail. Not with an explicit error that hotplug support
> is missing or such but it would simply fail to boot into capture kernel
> with digest verification failure.
> 
> My suggestion was to avoid that userspace tool breakage for older
> kexec-tools version by introducing a new kexec flag that can tell
> kernel that kexec-tools is ready to use this in-kernel update support.
> So, if kexec_load happens without the flag, avoid doing an in-kernel
> update on hotplug. I hope that clears the confusion.

Yeah, sounds like a good idea. It may be extended in later patch.

