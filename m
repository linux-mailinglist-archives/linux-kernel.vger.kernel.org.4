Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADA6953DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBMW22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBMW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:28:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC31CF62
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:28:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so1707359pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bM5Pk1r9A61LvNpyo6xrBlHWlUL/PWvYoyoAiaPU/Yg=;
        b=FViSB4cB+DRembwFmb9eH5IOweO4vTl74PGaS2fJbPGgCDq258sI25vdbAjPcR+DnI
         OTJjxiOb/lOg7McJBnz/i//i5TYVjrUdOGNYYCXUcvdC09cHm+cVQQ3oYjyiQOoQ6CRs
         2ImFULMGqgABYstP4Vexur1Nuv5y6AFrtNn7cuOiY4ck2F1gX8B/pPpzrrknIYHALy3M
         lqYk3RonrsRNAPybvJKx1cQMxaZPNoANVUBN1vp2aF0JiBXh9uGTKBjHokKHz8viT4Ac
         4ms2qpVKIh58qIHPcpGymWFxAmtkcs+oMh0HO1tNI2aZgz57+6r2ezyMuykmhUmetMBD
         swWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bM5Pk1r9A61LvNpyo6xrBlHWlUL/PWvYoyoAiaPU/Yg=;
        b=Ek18MhOEfNeWbLcwwYwgp7aKCPCMAuwzkbSL0pT8cHuJZBzDmlgC97JcWjflFVTSLJ
         j9XZc2pa+RSQZGGT5fPBkRuyfFJlzIbuVji8zbwMDFKlyyJJs1CvaiTrdhQgqZjzEU9F
         hi0Gt5Jb4ojukZYoaNGJkObt1xcEhb5tBnIsexRC+83ytuaypzSs/cIIYeKdUzK9JYUE
         FDgdKpmQvsTcAKWISgrJ8PVbZCRiOEgl2Rc1b0+fgrMtdIQfd/mMA5GbeZ55N14nM3N6
         B+2lC560WYXTFNPo90KFPBAhp4emwbztrZJz3klV3RrQZ2GerfTLREULDxWQGjtdHIv0
         tlnQ==
X-Gm-Message-State: AO0yUKWqsP1spq9ndDAZvvuCQdlnq38DPrqKNiQk2gTtYzdP/EjXTzOn
        32ztl8UlQ7Pzax+jhlOS11VCs6u1ynu5bGJnVwHvhw==
X-Google-Smtp-Source: AK7set+w4EF2gtEjCW89XYQvDH5lChbdAiodMGB49pFG17LNa5YqAewbglOmmamvRZkYgNCcbcVW+XoQZfU4dzJo5d0=
X-Received: by 2002:a17:90a:ca91:b0:234:7d1:b5e5 with SMTP id
 y17-20020a17090aca9100b0023407d1b5e5mr980847pjt.43.1676327305401; Mon, 13 Feb
 2023 14:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20230213172525.575766-1-dionnaglaze@google.com>
 <20230213172525.575766-2-dionnaglaze@google.com> <22e96dfd-21af-681c-22d2-12bcc082f63e@amd.com>
In-Reply-To: <22e96dfd-21af-681c-22d2-12bcc082f63e@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 13 Feb 2023 14:28:13 -0800
Message-ID: <CAAH4kHYrz2pZzwAqoy-mpA_om1+tO8qB-4ZHc9jKh_ucwZe3OQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/3] virt/coco/sev-guest: Add throttling awareness
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
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

>
> This should really be a new, separate patch.
>

I had it as a separate patch and squashed since I felt it necessary to
be considered still a "Fixes" patch. Should both claim to fix the same
patch?

>
> It looks like you will ensure throttling by continually calling the
> hypervisor for 60 seconds, shouldn't there be a delay here?
>

I can change cond_resched() to sleep_timeout_killable(some_constant)

> > -             rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> > +             cond_resched();
> > +             goto retry;
> >
> > +     }
>
> Nit, add a blank line here.
>

Will do.

> Thanks,
> Tom
>


-- 
-Dionna Glaze, PhD (she/her)
