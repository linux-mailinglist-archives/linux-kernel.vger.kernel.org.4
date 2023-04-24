Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2C6DB1AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjDGRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDGRe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:34:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC5B45D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:34:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so43866728pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680888897; x=1683480897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL8XT2dmegghAeYpKyssd1/mU3F1iBt8lThUBp5c4gY=;
        b=QWyy+rpanfpbOQipdK4S0IuAPz4YxLzjaGmsTfT+dojd/dx5oCHxpkZmWzrh3J93ZM
         k896UTgn1JLv25w/ht3L4yDtHyRgX12VNGz2wet1zb1IyjvC48JIpm6YRR5zOHlvYpyp
         vg/NuD08IwdhtiyPjudoTrzqBmmgyigyV8fDswWrB3eTk4f4yKz5fkjaUV4UlxdQd2z+
         d4I7MvDi3NTWFDrNqDYA7oEL8CXAv9Lk67oe6OXhYYMzmBXuygmurYSrXIiZHSa/qbad
         wgsPc6MG4Yg9DQdgn54u6IUkJeGPyHRBJmqz2mQbIV18xthIetTpt81WmwcUEFUMLDhN
         wHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680888897; x=1683480897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL8XT2dmegghAeYpKyssd1/mU3F1iBt8lThUBp5c4gY=;
        b=2THjs8+cT+eSBhDRgmXa0nfza3LYJBwBgb/0TX6sNr8rTGBnEFEYRksZtoJMbeb+0+
         gMAvPzXpCAp0AKpYGEeJygOSpJckvG+mGj0WapTYwQogDdwDUehX+3mYr1VdMtWqN4p4
         B6QfGzVZNS2Bg+qU+d2cfVie4K1YO3VptdJWxeaeWcfAPSdDsj+Mq4RA1UQN1rIAQupz
         Um1SRdt40I5rkbbTIuVkCzPf8cSBgwWM38HnnzO4im4QC67/7eEXtVJGVx6jxEE1H7dZ
         Jsm0FxELJZnfeJPEQcOKjE6gkK965vWRNR1EEYVVqsoFLhHKahpEzFmzuoVPSJgt5t/i
         bnsQ==
X-Gm-Message-State: AAQBX9ep6fxGZJFmSoak8ydhpy8EcPprnk7lgjyKdey/W2r294Q0NplF
        KhRN4P4AgQQ2KY9aGtojVW0FxLCk3pSsLDH8YFjNAw==
X-Google-Smtp-Source: AKy350Y3+tyc2y5AqmX+ezlQ/w8+BR5lVu9JAdgHFRIjCTIVUzXOhXQ3/IkTS6gnhNWCbqRBOnYyquPB8sl9mA83s1Y=
X-Received: by 2002:a17:902:6b81:b0:1a0:4aa3:3a9a with SMTP id
 p1-20020a1709026b8100b001a04aa33a9amr1129540plk.2.1680888896519; Fri, 07 Apr
 2023 10:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230307151239.1994179-1-trix@redhat.com>
In-Reply-To: <20230307151239.1994179-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:34:45 -0700
Message-ID: <CAKwvOdnGnGVk21Yh2GsH-fNx_M48f9CU05nnHSbnJd_Zq3En2A@mail.gmail.com>
Subject: Re: [PATCH] bpf: extend btf id list
To:     Tom Rix <trix@redhat.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        joannelkoong@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, Mar 7, 2023 at 7:13=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> With clang and W=3D1, there is this error
>
> kernel/bpf/verifier.c:10298:24: error: array index 16 is past
>  the end of the array (that has type 'u32[16]'
>  (aka 'unsigned int[16]')) [-Werror,-Warray-bounds]
>     meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
>                     ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared h=
ere
> BTF_ID_LIST(special_kfunc_list)
> ^
> ./include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>  #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
>
> When KF_bpf_dynptr_slice_rdwr was added to the enum special_kfunc_type
> the total exceeded 16.  Increase the array size to 32.
>
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr=
")

Looks like Nathan's patch got picked up.
commit 2d5bcdcda879 ("bpf: Increase size of BTF_ID_LIST without
CONFIG_DEBUG_INFO_BTF again")
https://lore.kernel.org/bpf/20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191=
f3a6@kernel.org/

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/linux/btf_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 3a4f7cd882ca..166c387b48f7 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
>
>  #else
>
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[32];
>  #define BTF_ID(prefix, name)
>  #define BTF_ID_FLAGS(prefix, name, ...)
>  #define BTF_ID_UNUSED
> --
> 2.27.0
>
>


--=20
Thanks,
~Nick Desaulniers
