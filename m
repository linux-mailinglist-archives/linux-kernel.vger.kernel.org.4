Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF90690135
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBIHYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBIHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:51 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E164E519
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:23:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id ay1so741219pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=QTvuFq/7v+CdkDisGU23a4Mg4sCbIx93MNu51rqdsSFelRH+bzFtnIoxiDz5XLtECD
         mVOdxoI+TDOdkZ+OftJL3dm7+U+HdYpulqUrb2jLjjKCqVg0ACdWdD2HO+m/yRYZ3tuw
         wkdhJGyPozWn+PtKhMrcQXV0lfoFGh+g0xgtz67cOirBzeCAtoScHKwH/q5zla5Efj+F
         bOGjzkshWM0wd9jjds9Jgo9wbbEimVjRaN2G/fPBSRVYTKbJ7QTToZAfK2O0wuDdv6lJ
         yO49Rn6wsAx0XAY45aXkgHk7bVpHRoWTWItBRJR4rEGqsJGkEgeumTF3u+UwIkz1j6EL
         2c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=rMkwGCVWJxH+8/USDcjdPrY/KjbPGY3TU29jRlRT3Y7HZKJdDq/r0M5ClSLyyIcJ6B
         BNYjT5+CbB/uaawUVOY/Y50+ZSUg91Swx49K/K0i4AbMfb+kDSwmchPdVb96VNDnfmML
         AzdRSJPbPV06eFzN7wzIxs3YJovvBrXpbPGM5h7X2Gwt8pJCPnc2+k5ffj3nrSf2rghU
         +gByzUjfMqerVONYBETGV9lkvxwy2fQq5F23uCNfugB2TJXE/TJpVXqY9ltTX7qnkyCO
         Gmsn/0rqN0T7GnOJ9ogp6dMv/pvmI2Ank6cZgWEDRf6TbnLld4n4TOF3OrdoFgjFlXB7
         X6kw==
X-Gm-Message-State: AO0yUKV9nK1BceRxJZDUybFw294bhdRHednbxQbyN8/t8AxNvCRw0JYo
        D95bZOQmFZMduU0O7SEej99PN8q+xdt3nIv2ivkrRw==
X-Google-Smtp-Source: AK7set8147oifuJImE5p0zRAylkYykGYufjK3B5xwMaz7PIg/QVSQ6RfLCFlhgyJPReztt3sdy3IK2VJ1VcQgxbPxyU=
X-Received: by 2002:a63:8f0c:0:b0:4fb:3232:8f70 with SMTP id
 n12-20020a638f0c000000b004fb32328f70mr1164056pgd.9.1675927404760; Wed, 08 Feb
 2023 23:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-3-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-3-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Feb 2023 23:23:13 -0800
Message-ID: <CA+khW7iGj=Y3NVxc9Y-MnwmPxCz5jHDmSfW-S6KS9Hko=jgJOg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] bpf: Use file object build id in stackmap
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Use build id from file object in stackmap if it's available.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Can we insert the lookup from vma->vm_file in build_id_parse() rather
than its callers?

>  kernel/bpf/stackmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index aecea7451b61..944cb260a42c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -156,7 +156,15 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>                         goto build_id_valid;
>                 }
>                 vma = find_vma(current->mm, ips[i]);
> +#ifdef CONFIG_FILE_BUILD_ID
> +               if (vma && vma->vm_file && vma->vm_file->f_bid) {
> +                       memcpy(id_offs[i].build_id,
> +                              vma->vm_file->f_bid->data,
> +                              vma->vm_file->f_bid->sz);
> +               } else {
> +#else
>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> +#endif
>                         /* per entry fall back to ips */
>                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>                         id_offs[i].ip = ips[i];
> --
> 2.39.1
>
