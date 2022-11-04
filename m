Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F861A36B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKDVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKDVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:37:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E74C24D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:37:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d6so9043998lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DP55jvYVvLChyUqBN0WgemBdPF1mtSkgaw/KZ8miRCo=;
        b=REGvrAvDwAoTXEum4yhI5ABHp/MEoIvT87pjrXW00hDKKdLV0h9Pv+rCOUn4YlPXKN
         1KzA4Esla6BwpbwVegtlGe/VrNHH+ZZNVz0tiZO8snVlyLC+nwcO1YWHaoA6NNOMz6kg
         mObF7YJx7lN/RrZSuXg0CYmU1TWdQv9JArDakq8j1MS8hs4JHhKNpk0MOmfb7doEdHRi
         eOR1Fp/PS9d4CSYeZJx6c7bHRSYXB/aKZbNAXIjo8SmcbcWhSjMEKT6BTEmHqaYPoKgm
         B1VB8skjTVU5QfI+FXYsFxQLx9Cd5xIk0lDHuA7bWCVvAyFXtqB1WUzDNHV08z4ciWaD
         tA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP55jvYVvLChyUqBN0WgemBdPF1mtSkgaw/KZ8miRCo=;
        b=pWH9I+Hq2w0vygxf00p7xKaI6Euycrf9gpQWZGWV3K/tBSTTiCvuZLCzESHwl5MjKx
         A0wnvKVZ2mE+pce32RrdJQr/TOzfcUEHm24DKUVSUF2f+B7cO9IubdGEkcXPbcoVWbTe
         cAa6t2ATAocrAhH5nPsxT45SfzrnE1vQP9L0ICYnlSbIsuTxdiPc4hD5q8BwkSvior/V
         uY/xOo49i2S2TJDy/Hy1D+tgJxr4B4TRXZSdz0apdb77+iOFFLE7Oa9wz9eyROPRa16U
         css+qqKQeTymVs8oum0+26hFPLCyrqWqleBIPKL0IUy3zsvheyBExZ5SvZdKq5NuXt0r
         ah+A==
X-Gm-Message-State: ACrzQf0uj0m+e3mHcUS39Iw0hnDNuksfJ4y6H2rrdKSnEvnwachRJvf0
        RyvQ9vArj+D972N2KazQfT4mVv/QTwS+gf3qpE2+XQ==
X-Google-Smtp-Source: AMsMyM4VhDP2dYwmTOaAqgDSmZyf8SoPv6TU9cZYNCkWxLMUCYIv3QGSXsa32XkxTEU4UuNU9h+70uc6dcTdNWjHPhM=
X-Received: by 2002:ac2:41c2:0:b0:4b0:e27f:1ef5 with SMTP id
 d2-20020ac241c2000000b004b0e27f1ef5mr9056927lfi.682.1667597829812; Fri, 04
 Nov 2022 14:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com> <20221104201616.2268815-3-dionnaglaze@google.com>
In-Reply-To: <20221104201616.2268815-3-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 15:36:57 -0600
Message-ID: <CAMkAt6r7UPON+sEDXPkT804rszTRBRmAk4pYv6tXjUPThF5fzQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] x86/sev: Change snp_guest_issue_request's fw_err
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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

On Fri, Nov 4, 2022 at 2:16 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
>
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's previous unsigned long*.
> The signature change requires the follow-up change to
> drivers/virt/coco/sev-guest to use the new expected type in order to
> compile.
>
> The firmware might not even be called, so we bookend the call with the
> no firmware call error and clearing the error.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Venu Busireddy <venu.busireddy@oracle.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Michael Sterritt <sterritt@google.com>
>
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
