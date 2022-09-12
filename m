Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7685B52F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiILDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILDrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F122281
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662954443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YI2fZY4L8mJJbSUbUjIEfSD3oHCErBi4sdySSSE2E0=;
        b=Gsa/qohreWaxf74a5Aq1YjHyQDL6mokrZ3hp7sP5KlTWzTMZ1yRFMCrmAIgDzvXl5l1wnh
        1gOJxc+ym/Rv8s9117ZKQ1OgeBm4mtod83LvcFmFoNv9o4NXvRZXqbxZOMMMj2aqXUW7SP
        aXfE+DOEAjwq6vUj6Nbpy9SdCSoU5i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-3HCIQzL1M1ydpu-6_MnOoA-1; Sun, 11 Sep 2022 23:47:20 -0400
X-MC-Unique: 3HCIQzL1M1ydpu-6_MnOoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD1D185A794;
        Mon, 12 Sep 2022 03:47:19 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8552026D64;
        Mon, 12 Sep 2022 03:47:18 +0000 (UTC)
Date:   Mon, 12 Sep 2022 11:47:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>, bp@alien8.de,
        akpm@linux-foundation.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <Yx6rwt+nMybIzlAz@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/22 at 05:05pm, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.

Thank a lot for all the effort, Eric.

Hi Boris, Andrew,

This version looks good to me. It introduces a framework for kdump
to react mem/cpu hotplug eveut and add x86 handler. Should this go
to x86 tree or mm tree? Please check what else we need do to fix or
improve.

Thanks
Baoquan

