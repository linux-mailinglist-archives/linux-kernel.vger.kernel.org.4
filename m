Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9976BCC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCPKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCPKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AF3B78B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678961497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85fsDNz+lL7FHNJ1iBNzrAf34oVvetUItgQ6w01KkXg=;
        b=CFuZBAiqcmFiQPbH10yxQEHkhAt0jkDW0vRJP6sF1MPfJOTV49iB6XJ0kVFhXSEO2mm3XZ
        2eOAec3ljGUY7fsCALOVqXhekXfNgsn/p0AQ6Ei7t7OwurE/4zTg1Yu8qJBzLnpsX5DrIg
        qbh8kdteHMTSWOzcEeERIuaMmqdn5LI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-6DMdYaQDM0Kz1urE3t7CmQ-1; Thu, 16 Mar 2023 06:11:33 -0400
X-MC-Unique: 6DMdYaQDM0Kz1urE3t7CmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE3B800B23;
        Thu, 16 Mar 2023 10:11:31 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E59B32A68;
        Thu, 16 Mar 2023 10:11:29 +0000 (UTC)
Date:   Thu, 16 Mar 2023 18:11:26 +0800
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
Message-ID: <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306162228.8277-3-eric.devolder@oracle.com>
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

On 03/06/23 at 11:22am, Eric DeVolder wrote:
......
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (kexec_trylock()) {
> +
> +		/* Check kdump is loaded */
> +		if (kexec_crash_image) {
> +			struct kimage *image = kexec_crash_image;
> +
> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +			else
> +				pr_debug("hp_action %u\n", hp_action);
> +
> +			/*
> +			 * When the struct kimage is allocated, the elfcorehdr_index
> +			 * is set to -1. Find the segment containing the elfcorehdr,
> +			 * if not already found. This works for both the kexec_load
> +			 * and kexec_file_load paths.
> +			 */
> +			if (image->elfcorehdr_index < 0) {
> +				unsigned long mem;
> +				unsigned char *ptr;
> +				unsigned int n;
> +
> +				for (n = 0; n < image->nr_segments; n++) {
> +					mem = image->segment[n].mem;
> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +					if (ptr) {
> +						/* The segment containing elfcorehdr */
> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +							image->elfcorehdr_index = (int)n;
> +						}
> +						kunmap_local(ptr);
> +					}
> +				}
> +			}
> +
> +			if (image->elfcorehdr_index < 0) {
> +				pr_err("unable to locate elfcorehdr segment");
> +				goto out;
> +			}
> +
> +			/* Needed in order for the segments to be updated */
> +			arch_kexec_unprotect_crashkres();
> +
> +			/* Differentiate between normal load and hotplug update */
> +			image->hp_action = hp_action;
> +
> +			/* Now invoke arch-specific update handler */
> +			arch_crash_handle_hotplug_event(image);
> +
> +			/* No longer handling a hotplug event */
> +			image->hp_action = KEXEC_CRASH_HP_NONE;
> +			image->elfcorehdr_updated = true;

It's good to initialize the image->hp_action here, however where do
you check it? Do you plan to add some check somewhere?

> +
> +			/* Change back to read-only */
> +			arch_kexec_protect_crashkres();
> +		}
> +
> +out:
> +		/* Release lock now that update complete */
> +		kexec_unlock();
> +	}
> +}
......

