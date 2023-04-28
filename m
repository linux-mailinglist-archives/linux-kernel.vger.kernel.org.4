Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BA6F1611
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjD1Kye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjD1Kyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444F2112
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7FEF642CD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27736C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682679270;
        bh=aS30DvrsbbI97fb4uPz55dG3Gtly2aNfa7KnyEdltTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOGr3tDB+20C8Js7poMaw+oKtk/uc7lGPErg2ro3jxSP+x1T/8e8eO8U8Orw2npwj
         HGFObHqjDBnRe4iZezd5lEXOC+V3JUFRYuI/KdLoDlleCaw47gX7SD2MZgnLiCshge
         ZCt/aq8H63UWLz3nMYQLd/NPeCIBq5LyZjEPTt7ELI+6T8zhb+EixSInR/Y7A4qZgg
         8LIv8t6yA7sulf7VTfXWQcExOkZo56ZyUcloZHmDyD5vnpSiyQeEmdsatBeKUvcrni
         elPqfi/zj7GGekd6TamyexARSle0D80+qH6N1kzFbZSMvH4l361bHQ4LrpnvS/uhEW
         fYjCIf7Vj4Z6w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso9226276e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:54:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDwNgb++b+Hs87F/9iVNbgj3NULFBU/5vxPih3A37vhoNGBqaob1
        0pfcCXF51WyifArnhmSrHe20TkPvUX0WAMUCWxM=
X-Google-Smtp-Source: ACHHUZ6ntMVmx4y1Va1OxojjE5FfZw6CpFpdst983upY3CzYoKg9pMF+wJ1v3ZTV6XD5dZRReh2gh2wRitpkIxZSThQ=
X-Received: by 2002:a19:f617:0:b0:4ef:ebbb:2cf5 with SMTP id
 x23-20020a19f617000000b004efebbb2cf5mr1427188lfe.17.1682679268146; Fri, 28
 Apr 2023 03:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-2-ardb@kernel.org>
 <ZEuh/V6luuvCjd55@FVFF77S0Q05N>
In-Reply-To: <ZEuh/V6luuvCjd55@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 11:54:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEueDPt9TJVh4NmFtJG-nJFgrHNsqykzQNQZPrGwRz8pg@mail.gmail.com>
Message-ID: <CAMj1kXEueDPt9TJVh4NmFtJG-nJFgrHNsqykzQNQZPrGwRz8pg@mail.gmail.com>
Subject: Re: [PATCH v3 01/60] arm64: kernel: Disable latent_entropy GCC plugin
 in early C runtime
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 11:38, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Mar 07, 2023 at 03:04:23PM +0100, Ard Biesheuvel wrote:
> > Avoid build issues in the early C code related to the latent_entropy GCC
> > plugin, by incorporating the C flags fragment that disables it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Just to check, are you seeing issues today? IIUC the plugin only instruments
> functions which are explicitly marked with __latent_entropy, and if we're
> seeing that happen unexpectedly (or due to that being applying to __meminit /
> __init), we might need to do likewise for other noinstr code.
>

I don't quite remember, tbh, but it is unlikely that I would have
written or included this patch without having run into some actual
issue.

> Regardless, for this patch:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks,
