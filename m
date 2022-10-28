Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A5611D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJ1WTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJ1WTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:19:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFD630E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:19:42 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e788329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e788:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80CE61EC0528;
        Sat, 29 Oct 2022 00:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666995581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TfhnsJUpPMTXVXSAObYcxWoYzhndg9xgfrbCtO8qJg8=;
        b=biUeAUKviqathMxYm+Bwp2HnXAPF3Q0cZ9xpG1gNXK2n1zQAT9gAJrA9ecY15dFOwNJx72
        BU9WupVYS4qRsVX/NFtxogp54qzVsLcpqjfMgYq/IgphWfOW+vlZEeyWrDj9T5skvB3j4c
        k6GBeC0u8oqcEm6ue0er+Ip0x7VnrnU=
Date:   Sat, 29 Oct 2022 00:19:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, david@redhat.com,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1xVeP/RtG37zLYm@zn.tnic>
References: <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
 <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
 <Y1w76RwZUKUvsS7A@zn.tnic>
 <43f16833-add1-80c3-3bf8-5a6a05e75be6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43f16833-add1-80c3-3bf8-5a6a05e75be6@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:22:54PM -0500, Eric DeVolder wrote:
> /*
>  * For the kexec_file_load() syscall path, specify the maximum number of
>  * memory regions that the elfcorehdr buffer/segment can accommodate.
>  * These regions are obtained via walk_system_ram_res(); eg. the
>  * 'System RAM' entries in /proc/iomem.
>  * This value is combined with NR_CPUS and multiplied by sizeof(Elf64_Phdr)

NR_CPUS_DEFAULT

>  * to determine the final elfcorehdr memory buffer/segment size.
>  * The value 8192, for example, covers a (sparsely populated) 1TiB system
>  * consisting of 128MiB memblock size, while resulting in an elfcorehdr
>  * memory buffer/segment size under 1MiB.

... and it is a sane choice trying to accomodate both actual baremetal
and VM configurations."

Yeah, it's a good start.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
