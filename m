Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE7077E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjERCLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERCLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD042D7D;
        Wed, 17 May 2023 19:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD11D64C60;
        Thu, 18 May 2023 02:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41109C433AA;
        Thu, 18 May 2023 02:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684375902;
        bh=9ng61A0bjmF1FECy3to2rZ8fQuj5oKzHMtPXutPazGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+e5hVwsZOKgwd5vYPPHy4zBax4MmuIRQhmxVrq96dHk48PPolwRjZdX/Uhi/LDBu
         cOrf0nS7lBZufJItaC8Kok+5zbJ8NXGUy9DVjH1o+iD/X48NboK1fWUvmgZfmP4kVz
         1yPcw2WsFYb6n+kYxFBmxc6Vi/qJD2D+6wmcam5nC6VFPqf8i7p6YLpNMowrBsk4is
         8ugY93t/q8rSTMSiswGL9B9vnDdx6uZKj9OhYtgTrZ2PGTJJtWcRAkBm/2RX+OZa/1
         Ktjj/+Cbp2fqMaT9X/sCN2jqT2jwPjWtLYpKqMTJU2NMh0PylewgQ2FQx9uKnqxU/8
         6v2uTDdji8ogA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96598a7c5e0so238667166b.3;
        Wed, 17 May 2023 19:11:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDyFtnBAEC0FPVOvaF+0H5elzdjmC/bcdDpCMlgY/03a4HBExjUX
        quXT02aGwMlx/+0Tl7vgDfpXgE/jl7F/68jq39s=
X-Google-Smtp-Source: ACHHUZ6xkUAAvNSUoGpT2sJjHnMqUCTHfTsFHFPyaj8zciHLa9Ow9EFBJvbYUSz18aFTGzjZMM2L35f8THqzbh8ZQ/E=
X-Received: by 2002:a17:907:a410:b0:96a:90bb:a2d3 with SMTP id
 sg16-20020a170907a41000b0096a90bba2d3mr22402953ejc.71.1684375900385; Wed, 17
 May 2023 19:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 18 May 2023 10:11:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
Message-ID: <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Huacai

On Tue, May 9, 2023 at 2:56=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> We can see the following definitions in bfd/elfnn-loongarch.c:
>
>   #define PLT_HEADER_INSNS 8
>   #define PLT_HEADER_SIZE (PLT_HEADER_INSNS * 4)
>
>   #define PLT_ENTRY_INSNS 4
>   #define PLT_ENTRY_SIZE (PLT_ENTRY_INSNS * 4)
>
> so plt header size is 32 and plt entry size is 16 on LoongArch,
> let us add LoongArch case in get_plt_sizes().
>
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/e=
lfnn-loongarch.c
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> This is based on 6.4-rc1
>
>  tools/perf/util/symbol-elf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index b2ed9cc..5d409c2 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -411,6 +411,10 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr=
 *ehdr, GElf_Shdr *shdr_plt,
>                 *plt_header_size =3D 32;
>                 *plt_entry_size =3D 16;
>                 return true;
> +       case EM_LOONGARCH:
> +               *plt_header_size =3D 32;
> +               *plt_entry_size =3D 16;
> +               return true;
>         case EM_SPARC:
>                 *plt_header_size =3D 48;
>                 *plt_entry_size =3D 12;
> --
> 2.1.0
>
>
