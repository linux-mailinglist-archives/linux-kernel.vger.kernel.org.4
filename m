Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9504F6C4B14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCVMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCVMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:49:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A18C16C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:49:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e71so20859855ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679489376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwLjUw+kLtsFgGs7g0wrZp4mwqdRRZkR+CkPy3YuE+c=;
        b=MrIfWFDpfNGqQyliaUpvUiaRZ3EaZ/BcFDgH6MRW0hVJVuRLICG6kHyz64kixKWQrh
         NynNnv7H1/KjbpcuPb0T7wTWXrCAwZABUBiMbT8jndjhYJnGcE5EagEF8ZFV+3WQ/XAs
         mnD0BbYTl0yOm4ZHVbQUSow/iDvsqCRNH2kxea0Afi51Nvm/9FVfLtRlYcmK7frAUWA+
         eJXiRdwADNvZBI3MGq9T8Oan0PR4+HgPfA84GIMfXtqx6j+xnVwq6TUlBi3kq/+SkSNI
         5nFgMy5aapfX7j/4ii+OeitLJ4b+RWEjw72gFVfsea7tf/9kUPyACMgfIlRawcWk/LUB
         zkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwLjUw+kLtsFgGs7g0wrZp4mwqdRRZkR+CkPy3YuE+c=;
        b=zWkHFnmnCp+fYq3QyWVn35QGRMqzRfXwYFtDKPlqZiaEfkRMyoFRgVaKQ0Y3qYbGUf
         vXhr1WaP6/2XMUwRpLh3xG/n2oHTJkP4uN/axlrXZZG3OJ9KOzEF/ALdAPoItay3bb+4
         A2L0UbKHhNCmEDCzhKG7wBNrXbim6v23w/a75TzmfvruxK8IaUn0lyfqtAzFZnSHYoQH
         Bs8tT0e7aD0b6g3HRn823pthQplcAA7hcLPuNpJPIQBHY7RE36GTdfKUxf8S3P0VDn6S
         luFxlPhJPzBSyvPzdvzNc5cB8k1/LQ1e3VpxRYqCIN1Yxy9xA6+EnlDxz4X0owhbg4FW
         yQSg==
X-Gm-Message-State: AAQBX9e6yF4siZcEnMjZaLw8EiLhSdAHQFsBXlSTDGFW15lPKm0xjFQJ
        E75eTXB9FFHiBaixCNd0CRkNzX9rrdFWir1yrwA8dQ==
X-Google-Smtp-Source: AKy350bDXy3x35wDwK+SNHYNt51PhM2aXv+bNTnsnl9EXDRm02kIPnGH3IzLuVF9fNwRTjsa9o9B1fAMT2bQqRe7jtQ=
X-Received: by 2002:a25:4807:0:b0:b65:e441:4b6e with SMTP id
 v7-20020a254807000000b00b65e4414b6emr1854216yba.6.1679489375655; Wed, 22 Mar
 2023 05:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=UHz93odccvRFo5H2yKq9URTcQs2jWWc5Yehioq-QC8hA@mail.gmail.com>
 <CAG_fn=XE-iDrPEB=bsnAqxYkRi+nFvTSbywOz56W_xQWLHeCAQ@mail.gmail.com> <06c24686-fcc5-22bf-8a35-e7e18244e94b@intel.com>
In-Reply-To: <06c24686-fcc5-22bf-8a35-e7e18244e94b@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 22 Mar 2023 13:48:59 +0100
Message-ID: <CAG_fn=XBibcjsGZX=+m7pQTduNiaBZLTGEM4m99hwyiT0Q3-mA@mail.gmail.com>
Subject: Re: [PATCHv16 00/17] Linear Address Masking enabling
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 6:28=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 3/17/23 10:21, Alexander Potapenko wrote:
> > On Fri, Mar 17, 2023 at 6:18=E2=80=AFPM Alexander Potapenko <glider@goo=
gle.com> wrote:
> >> Dear x86 maintainers,
> >>
> >> the series looks pretty mature now, any chance it can be considered
> >> for upstream?
> >>
> > (Adding the maintainers just to be sure)
>
> Yes, I'm running it through a few tests right now actually.  If
> everything looks good, I'm planning on queueing it.

Hi Dave,

Did this work out?

Thanks!
