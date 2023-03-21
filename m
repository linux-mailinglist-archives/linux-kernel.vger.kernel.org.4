Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0A6C2832
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCUCb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCUCbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A42E0E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679365828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8Jw9Nr2e+wCPq9TDRMSOjtClj7zVlNFMHhVGtvKL/k=;
        b=id12wdtoERtShKqsctUnrDV6xHf8eihHOjwbiT0X5F1e8hBudeKTHJCxYsKAbGbIxqq6l3
        DHiZ2lgjc+d27QL40D8uatHOfouNwdZif76XYVG+1G5fjUD8Hjc70TlS6dQo/QaDMzCeiX
        OQAP79aJ09W+7pOvsa0/V2jI1iZgplc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-PCJeYWObP0CHigoWpsJiTA-1; Mon, 20 Mar 2023 22:30:25 -0400
X-MC-Unique: PCJeYWObP0CHigoWpsJiTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0308299E746;
        Tue, 21 Mar 2023 02:30:24 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B6F18EC2;
        Tue, 21 Mar 2023 02:30:23 +0000 (UTC)
Date:   Tue, 21 Mar 2023 10:30:17 +0800
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
Subject: Re: [PATCH v20 2/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBkWub0rTMp2+kxd@MiWiFi-R3L-srv>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
 <20230317212128.21424-3-eric.devolder@oracle.com>
 <ZBgVjjZdiEA5YxQX@MiWiFi-R3L-srv>
 <12fa9836-4ddd-2961-7d32-4754506c84ae@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12fa9836-4ddd-2961-7d32-4754506c84ae@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/23 at 10:06am, Eric DeVolder wrote:
> 
> 
> On 3/20/23 03:13, Baoquan He wrote:
> > On 03/17/23 at 05:21pm, Eric DeVolder wrote:
> > ......
> > > @@ -697,3 +700,137 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >   }
> > >   subsys_initcall(crash_save_vmcoreinfo_init);
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) "crash hp: " fmt
> > > +/*
> > > + * To accurately reflect hot un/plug changes of cpu and memory resources
> > > + * (including onling and offlining of those resources), the elfcorehdr
> > > + * (which is passed to the crash kernel via the elfcorehdr= parameter)
> > > + * must be updated with the new list of CPUs and memories.
> > > + *
> > > + * In order to make changes to elfcorehdr, two conditions are needed:
> > > + * First, the segment containing the elfcorehdr must be large enough
> > > + * to permit a growing number of resources; the elfcorehdr memory size
> > > + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> > > + * Second, purgatory must explicitly exclude the elfcorehdr from the
> > > + * list of segments it checks (since the elfcorehdr changes and thus
> > > + * would require an update to purgatory itself to update the digest).
> > > + */
> > > +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> > > +{
> > > +	/* Obtain lock while changing crash information */
> > > +	if (!kexec_trylock())
> > > +		return;
> > > +
> > > +	/* Check kdump is loaded */
> > > +	if (kexec_crash_image) {
> > 
> > Here, what I mean is:
> > 
> > 	/* Obtain lock while changing crash information */
> > 	if (!kexec_trylock())
> > 		return;
> > 
> > 	/*If kdump is not loaded*/
> > 	if (!kexec_crash_image)
> > 		goto out;	
> > 
> > Then we reduce one tab of indentation for the following code block, e.g
> > the for loop block will have smaller pressure on breaking the 80 chars
> > limitation.
> > 
> 
> Ah, yes, ok. I'll make that change. Do you prefer I post that soon, or give this v20 some more time?

Yeah, giving v20 a while for reviewing sounds great. After all this
is only programming style issue. Other than this, the overall looks good
to me, let's wait and see what other people's concern, esp x86
maintainer's opinion.

