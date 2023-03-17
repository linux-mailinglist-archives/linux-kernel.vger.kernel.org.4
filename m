Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058526BE5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCQJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575DCC33F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679045432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YPCtklsU3EN6/UK6raeMaHzWYyPWwijivGCe480384=;
        b=EHTjEcSOuJb/iIo1u01oeMIA/D8jWUU/grIMiVqZ4aDV8/6r+XvxRqz+YbB+TIUC/lFsiM
        YS3AMhYtDIlWqLbDrFlx+JyCbDyC5J67XcItJ4n+3shTNPrjadBjfj9BvLdMArrFfjsS8P
        GYK389DsvnFtozFnQ1Ah0cf6GjJ/8s8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-0wcKsR7COJuusFPRlOWVug-1; Fri, 17 Mar 2023 05:30:27 -0400
X-MC-Unique: 0wcKsR7COJuusFPRlOWVug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 011DA811E7B;
        Fri, 17 Mar 2023 09:30:27 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AB0140E960;
        Fri, 17 Mar 2023 09:30:25 +0000 (UTC)
Date:   Fri, 17 Mar 2023 17:30:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBQzLxpLPcyhrDoF@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
 <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
 <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/23 at 10:47am, Eric DeVolder wrote:
> 
> 
> On 3/16/23 09:44, Eric DeVolder wrote:
> > 
> > 
> > On 3/16/23 05:11, Baoquan He wrote:
> > > On 03/06/23 at 11:22am, Eric DeVolder wrote:
> > > ......
> > > > +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> > > > +{
> > > > +    /* Obtain lock while changing crash information */
> > > > +    if (kexec_trylock()) {
> > > > +
> > > > +        /* Check kdump is loaded */
> > > > +        if (kexec_crash_image) {
> > > > +            struct kimage *image = kexec_crash_image;
> > > > +
> > > > +            if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> > > > +                hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> > > > +                pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> > > > +            else
> > > > +                pr_debug("hp_action %u\n", hp_action);
> > > > +
> > > > +            /*
> > > > +             * When the struct kimage is allocated, the elfcorehdr_index
> > > > +             * is set to -1. Find the segment containing the elfcorehdr,
> > > > +             * if not already found. This works for both the kexec_load
> > > > +             * and kexec_file_load paths.
> > > > +             */
> > > > +            if (image->elfcorehdr_index < 0) {
> > > > +                unsigned long mem;
> > > > +                unsigned char *ptr;
> > > > +                unsigned int n;
> > > > +
> > > > +                for (n = 0; n < image->nr_segments; n++) {
> > > > +                    mem = image->segment[n].mem;
> > > > +                    ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> > > > +                    if (ptr) {
> > > > +                        /* The segment containing elfcorehdr */
> > > > +                        if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> > > > +                            image->elfcorehdr_index = (int)n;
> > > > +                        }
> > > > +                        kunmap_local(ptr);
> > > > +                    }
> > > > +                }
> > > > +            }
> > > > +
> > > > +            if (image->elfcorehdr_index < 0) {
> > > > +                pr_err("unable to locate elfcorehdr segment");
> > > > +                goto out;
> > > > +            }
> > > > +
> > > > +            /* Needed in order for the segments to be updated */
> > > > +            arch_kexec_unprotect_crashkres();
> > > > +
> > > > +            /* Differentiate between normal load and hotplug update */
> > > > +            image->hp_action = hp_action;
> > > > +
> > > > +            /* Now invoke arch-specific update handler */
> > > > +            arch_crash_handle_hotplug_event(image);
> > > > +
> > > > +            /* No longer handling a hotplug event */
> > > > +            image->hp_action = KEXEC_CRASH_HP_NONE;
> > > > +            image->elfcorehdr_updated = true;
> > > 
> > > It's good to initialize the image->hp_action here, however where do
> > > you check it? Do you plan to add some check somewhere?
> > 
> > Hi Baoquan,
> > The hp_action member is initialized to 0 in do_image_alloc_init(). I've
> > mapped KEXEC_CRASH_HP_NONE onto 0 on purpose.
> > 
> > But the use of image->hp_action = KEXEC_CRASH_HP_NONE is to actually
> > delineate that a hotplug event handling has completed. You can see
> > imae->hp_action set to hp_action to capture what the triggering event
> > was, as passed into this function.
> > 
> > I will go ahead and set image->hp_action = KEXEC_CRASH_HP_NONE; explicitly
> > in do_kimage_alloc_init(), as that is done for the other crash hotplug members.
> > 
> > Thanks!
> > eric
> 
> Baoquan, as you are currently working through v19, please let me know when I
> should put out v20 with this and Sourabh's feedback.
> Thanks,
> eric

The overall serial looks good to me other than the nitpicks.

