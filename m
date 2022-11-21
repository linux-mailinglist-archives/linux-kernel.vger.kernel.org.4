Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516DA631D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKUJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKUJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:52:37 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC31000
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:52:36 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id p4so10670311vsa.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVJfUYwe5iLolb0LBkHyX82AMIwkeDuAU43Tw3iotdY=;
        b=PvaYgoGXPvfrAqZjxhoAM38/m+pTA0m/AuWnCy0QVpbSS+u6dt2dngcfPt8UrbFuLA
         TGsYYijUuZYoQRGCot7/sDmHhbsj3rx9ie3DQ8PeBqV4HRQrTH7mo/11j1v+f+TbKHw/
         cIE2RbsE3tDmk82SzMMFspY2DoInj3MtlkUWjkrhOXaBAHtUWAv/3GcgomgDqU7givfg
         nNeSrwu6s7I0jCHk+cHxUYYNc52TBCv8Zy5QPx5Mq0E4aWQQ6FNnzGlM7wNOH2X99CAJ
         RwknGbu65uNmxvBrY24eQVjfu2FEZWwBJifAbGj53ryaZQ3GV8cv7UxWLRWA54lIAbo+
         mO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJfUYwe5iLolb0LBkHyX82AMIwkeDuAU43Tw3iotdY=;
        b=lhMl9DVfno/7z2Sj7cw5po+NGQNdo42+z9TvSiTmQmtnKNC8kEkSxcsRvQDLzBga6e
         8LdE0F+caSh7kxdWFOswtjMmQiecA8Ospklf8ODK70T3XvlJFCl20wrNxb3OfLYZqHHn
         St9ikqUf6roBTK3Aw282D36iDkW9jISmoxn3rOBQTRR1kBqwmi2rdnCT8AwAtox1Y+9d
         nQu6zm6MPZdT1B85/m8FELSfTrewvwMiH3MfgDzHdfNe9NHQgmQ0c8TIcFcoWfVFZV23
         aoBrrQMFgsbQKFN7Zo/rIcAlQmIwKYbNcfBl1I3YVvfEPICexzwjEVsPbkXwJ39TcYFf
         sjAQ==
X-Gm-Message-State: ANoB5pkihumhAVdiG9M6Y8xr+uUUcEgtDV8WbNA4u4yIyMm2CPAc5vyN
        pGh93WKmTo8GhrxtRhGCn/qkQ/wTr8ZSDIqbl+Sq8Q==
X-Google-Smtp-Source: AA0mqf6TlIKWv3VvjEFTZJKV5E3BYblYaTU3VKPnMqcEHjGejNDE8sx3WtpkG8lhL3SAZM13/t17JvRYA0K68z91EzM=
X-Received: by 2002:a67:fe01:0:b0:3af:5ff9:ed51 with SMTP id
 l1-20020a67fe01000000b003af5ff9ed51mr2821568vsr.46.1669024355893; Mon, 21 Nov
 2022 01:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20221121093245.4587-1-jgross@suse.com> <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
In-Reply-To: <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Nov 2022 02:51:59 -0700
Message-ID: <CAOUHufYVm4oc7JG=y3nwiLqKBBtzBMrHns=1ZNcQRSd1Rk-OFQ@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce arch_has_hw_pmd_young()
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:50 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 21.11.22 10:32, Juergen Gross wrote:
> > When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
> > CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
> > in pmdp_test_and_clear_young():
> >
> >   BUG: unable to handle page fault for address: ffff8880083374d0
> >   #PF: supervisor write access in kernel mode
> >   #PF: error_code(0x0003) - permissions violation
> >   PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
> >   Oops: 0003 [#1] PREEMPT SMP NOPTI
> >   CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ #1
> >   RIP: e030:pmdp_test_and_clear_young+0x25/0x40
> >
> > This happens because the Xen hypervisor can't emulate direct writes to
> > page table entries other than PTEs.
> >
> > This can easily be fixed by introducing arch_has_hw_pmd_young()
> > similar to arch_has_hw_pte_young() and test that instead of
> > CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.
>
> I just spotted that I missed to update my commit message to match the
> patch:
>
> s/arch_has_hw_pmd_young/arch_has_hw_nonleaf_pmd_young/
>
> I'll wait with a resend in order to get some feedback first.

Thanks. For the next spin:

Acked-by: Yu Zhao <yuzhao@google.com>
