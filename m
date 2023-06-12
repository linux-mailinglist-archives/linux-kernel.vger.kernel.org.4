Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C072CFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjFLTjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFLTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:39:07 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72077E8;
        Mon, 12 Jun 2023 12:39:06 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39ce0ab782fso798381b6e.2;
        Mon, 12 Jun 2023 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686598745; x=1689190745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqdHZRyf0AXNBHWGF0CLQrBOhqQeYTmWOmQD+ocjfOs=;
        b=Ogus9IHA6us8sNOuE5JmVS2Evb3W5iYBIuuSJFWORtXoBZk8+7CXD3BoX92QUYCJim
         wVI9YKr6/KOAvUNKdhsWpoFExjtH5hndg53tK9bFrvSZocM61DXnfaX/muQUt1vlBvwT
         Z/gO7r01szV3RzdYLvJQrRsZUgcHP3EFrOLviux3wr9tnB8casPxVUeTFDoPgi0gzk95
         LOtZQNxZatW7OJPBGb9iIiEonfdDaajhzzOMbcDYqDOiSLFes7LeaZ4kJuzrdbVfivwS
         eQT6Yt4DBUiA5E9NvKk6Wey9ipKNHnwCN9063GcmHShWAMKnsKrqG8bdz5sGz7sgW3Zs
         kIWw==
X-Gm-Message-State: AC+VfDwN90G4bV3PQQWLX49DYnsb49hDx6bMYU3Vch9n+8bC5UbbiDsB
        cmMWRbAcWZV0SPwWYjY6LThKfpza5OcDeQ==
X-Google-Smtp-Source: ACHHUZ6Uty5lRZvJ3c6m3ghiL5dJ7y9JnzXSJq9hLZwZH69Ty3OvPkRd0YVM8cP4XBPu7H4ttowCkQ==
X-Received: by 2002:a05:6808:1187:b0:39a:b9ae:47fd with SMTP id j7-20020a056808118700b0039ab9ae47fdmr5493051oil.11.1686598745642;
        Mon, 12 Jun 2023 12:39:05 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id y84-20020acae157000000b0038ee0c3b38esm252166oig.44.2023.06.12.12.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 12:39:03 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b2e1023f30so1654013a34.1;
        Mon, 12 Jun 2023 12:39:02 -0700 (PDT)
X-Received: by 2002:a05:6358:c6a9:b0:12b:db2f:9d2b with SMTP id
 fe41-20020a056358c6a900b0012bdb2f9d2bmr2288064rwb.22.1686598742584; Mon, 12
 Jun 2023 12:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230612172805.681179-1-eric.devolder@oracle.com> <20230612172805.681179-8-eric.devolder@oracle.com>
In-Reply-To: <20230612172805.681179-8-eric.devolder@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Jun 2023 21:38:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAbRVALNVwFhO1S3zsOuVj7OidEF8=0K=qQ-kFn6JQiA@mail.gmail.com>
Message-ID: <CAMuHMdXAbRVALNVwFhO1S3zsOuVj7OidEF8=0K=qQ-kFn6JQiA@mail.gmail.com>
Subject: Re: [PATCH v1 07/21] m68k/kexec: refactor for kernel/Kconfig.kexec
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, 86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, hpa@zytor.com, keescook@chromium.org,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 7:29 PM Eric DeVolder <eric.devolder@oracle.com> wrote:
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_HAS_ and ARCH_SUPPORTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
