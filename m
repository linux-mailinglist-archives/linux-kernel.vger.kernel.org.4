Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC96B97E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCNOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCNOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119CA9DCE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678803785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rV/CKa5wadgKLok3eourywXXQnzSqpZ7XBoZDYaJi8=;
        b=IHDZN1prlKUzzxqFG9SBC9CmHB0GxJJF1hWnuRZt+CDYzRHSLxHuXD4ccBU5XUnMkgsgGd
        VLvkjzyyvMeRRXbcaSW5TvsZEBRICkBq3QAM1NhUPyA6g3IGFlVBrCm5YpVHihbQQo7kpk
        EE2/TANA/lqNSe//8Mqt0459yi0YE0w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-9Lh6L2NCPKWmtI7AoNP3mQ-1; Tue, 14 Mar 2023 10:23:00 -0400
X-MC-Unique: 9Lh6L2NCPKWmtI7AoNP3mQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B9DF2800489;
        Tue, 14 Mar 2023 14:22:59 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B3A202701E;
        Tue, 14 Mar 2023 14:22:57 +0000 (UTC)
Date:   Tue, 14 Mar 2023 22:22:54 +0800
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
Message-ID: <ZBCDPuTdjMY+7VrG@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
 <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/23 at 08:28am, Eric DeVolder wrote:
......
> > > +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> > > +{
> > > +	switch (val) {
> > > +	case MEM_ONLINE:
> > > +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> > > +			KEXEC_CRASH_HP_INVALID_CPU);
> > > +		break;
> > > +
> > > +	case MEM_OFFLINE:
> > > +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> > > +			KEXEC_CRASH_HP_INVALID_CPU);
> > > +		break;
> > > +	}
> > > +	return NOTIFY_OK;
> > > +}
> > > +
> > > +static struct notifier_block crash_memhp_nb = {
> > > +	.notifier_call = crash_memhp_notifier,
> > > +	.priority = 0
> > > +};
> > > +
> > 
> > Because for_each_possible_cpu() is taken in
> > crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
> > hotplug or doesn't do anything with this patchset. This cpu part in
> > infrastructure is only for the later powerpc usage, right?
> 
> That is true, yes.

Given this patchset is aimed at crash hotplug on x86, while obviously it
does't need to have the cpu hotplug support on x86 since the
for_each_possible_cpu() adjustment. People looking into this may be
confused if they don't follow the discussion thread of v18. Do we need
to mention this in cover letter or somewhere else? I could miss that
though it is has been told, please ignore this if yes.

