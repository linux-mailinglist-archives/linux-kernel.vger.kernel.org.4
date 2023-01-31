Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740168323D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjAaQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjAaQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:08:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25510521DD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:08:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 203so9264064pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCGH+92SGmFm+bJkDru4uxKLQQvLGJCTMjQcAnlJWUQ=;
        b=ez6rA1tLLRtGH0rac3xUGE2Vmi90TAGuzmN2Qk2VYZX2y1ZRLpCVAHUCXCxfr0gb4n
         UxwXyEXW0B5GQMWfFuxXs2u3mkqujdtcwRcTgjql4nHvVmde82CHs9SDK9MaZJpqN8fC
         J718xKmyUM7VYbGnBNwBnkNeuFYK6mqUt10uvb+Bd5iODlMuTZ0TbPhW1Y8OcJ0HUsJi
         XN5syAepWjJXsY1O0kSktCjQ5TMXWzLb172pWMuLMuBpaHsZlomjpfn/pvNSYAVvZnbO
         0bzESWELe74BAoENU1UB88M19tOOD+8IZlm6acu3S9DEr4hohfXx5ARxT0jxPu4YP4it
         ENfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCGH+92SGmFm+bJkDru4uxKLQQvLGJCTMjQcAnlJWUQ=;
        b=UTXJJ3TGwnwIdrVKY4sK2Ui8M+DI2J7OUL7O/faAhhXkZL7lRIm84+HvZlvhOe4qjK
         DktzWk9+ln+WYHF7Q2+8KYqUxwIaCz59tCeJ5D5JHTsraiIawS+klE2QPazn3+fbTK8R
         e8Jxf/nbPi9RXAmaLs8o/ctZmpt1qqvSTcFlABy+QpoPPCETJuWUmbJQ5rei6bMH0MXG
         tZy6zOEgySQ36bXvpb9h92kvoC4L+XHBnQDbb+DkLCgXopoRrZZoWTnaRTsAoeOnhdHE
         CaSlBgFaA3Z0ji5XF61zKnbocRxFToAt8rPUHFiq0r5D3imWIhqS8QLNiei3rOzfOKVm
         8kYw==
X-Gm-Message-State: AO0yUKWukAzMa8NVE8eQZK+b2t5enCl66a0EB3OEI0CW/lVWc17nOwB4
        kvaiehJcfHtluvm9LHsH+WUP0tOZyH7awsQchXiKIw==
X-Google-Smtp-Source: AK7set/3zBEfuo0tk7dwIn7jI2X4ovYj7hBfigwHmlv1EDwBFavs4kB97BdSl8RrUfD+G/KbFimBZtFYqSLzKed6v+w=
X-Received: by 2002:a62:8445:0:b0:593:bcc4:11ec with SMTP id
 k66-20020a628445000000b00593bcc411ecmr1574378pfd.6.1675181296402; Tue, 31 Jan
 2023 08:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20230131004928.153623-1-dionnaglaze@google.com> <CAMj1kXG9ONi4_AD1G0Py_qrLLzRfSXGCTEOeu2xowViO0mJkuA@mail.gmail.com>
In-Reply-To: <CAMj1kXG9ONi4_AD1G0Py_qrLLzRfSXGCTEOeu2xowViO0mJkuA@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 31 Jan 2023 08:08:04 -0800
Message-ID: <CAAH4kHaqObDRfKAzM8tTrhmQWZx7w2oTP=YJOo=fCG1kHDvj8w@mail.gmail.com>
Subject: Re: [PATCH v2, RESEND] x86/efi: Safely enable unaccepted memory in UEFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux-efi@vger.kernel.org, "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
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

> > +       efi_status_t status;
> > +
> > +       if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
>
> Do we need to check for IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) here as well?
>

Arguably no, since the firmware should only make the protocol
available when it determines that the protocol should be used. In our
case, that's just SEV-SNP. The firmware's TDX logic will not expose
this protocol.

This maintains flexibility for the rare case that the TDX go-to-market
schedule doesn't align with upstream's acceptance of unaccepted memory
support, but does accept the generic TDX support. Best not paint
ourselves into a corner.

-- 
-Dionna Glaze, PhD (she/her)
