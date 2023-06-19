Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8104735919
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjFSODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFSODT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:03:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB100FB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:03:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b50d7b4aaaso13164935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687183398; x=1689775398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4zA2x2rf1p5pzoQJxSBuzoBeRkUzNS4Bq8HFTmaCoE=;
        b=b+fkLYr3MnYz/OQ9BhX6fL07uLzvPcMpQDFVDzDecktXyoL50Q3ZJxYZPSun/2NE/k
         KAeGe8M8bNjBkwmPAz++D+U7I948YLAmWCn1fOit3orWSOPF/RnJZYfh3GMaN9pBA8N3
         3V7ScFFz8VQoikvuMgU/IicArKbCOUt6tCa2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183398; x=1689775398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4zA2x2rf1p5pzoQJxSBuzoBeRkUzNS4Bq8HFTmaCoE=;
        b=abu0Q0kvrhk/MfOdWA9Hn2RIuFEYMc5eDQ6Zg/nFiLsXhIcBg197igNo/rmSvgq59+
         PeFvRMLgbHyCBwUbHvimsMfakVaUmE/+b99q/begpewruaDbhbG8MdYvKGC0wD6pSDwU
         wpieT9/5Kuc7d9jxI+v2V4BGnrOIu4Cyad/80iZWRbroRwHj5E6wBpxaTSY9tF7FdW6e
         7q5AAtmgPAWHVA2JIFmcMY1TyY092YP28OmdEdyyqXW0JVUpinJQnGpvbTMcb6sa35TN
         R+TYFK9VJgmJvJpCNmELphbDjgtfBBA2VV1Ewvx+m5YHgjYMvYO1dZ/09TNA6aztWHKq
         zoVw==
X-Gm-Message-State: AC+VfDytN8DFQbQll5x82vVse6bXt2KwpVhd72pe0S9IwdbdrdqcC0NW
        9H86T0ha33JYpP5r84KaDaYa2WdmJNTc5+zLKIWFJQ==
X-Google-Smtp-Source: ACHHUZ4v3i2RgZ9YWY86OIWqNc5hX+EADjk5U09Liihu9nq6bBliCQ8oKBwC0e38lv6wShZ5U2kDtW6XiCKfFXAjnS0=
X-Received: by 2002:a17:903:1112:b0:1af:a293:e155 with SMTP id
 n18-20020a170903111200b001afa293e155mr6269262plh.16.1687183398115; Mon, 19
 Jun 2023 07:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
In-Reply-To: <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 19 Jun 2023 16:03:07 +0200
Message-ID: <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 6:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 15, 2023 at 7:56=E2=80=AFAM Florent Revest <revest@chromium.o=
rg> wrote:
> >
> > When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=3Dy=
, LLVM
> > leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
> > pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
> > metadata validation fail because they contain a dot.
> >
> > In a dramatic turn of event, this BTF verification failure can cause
> > the netfilter_bpf initialization to fail, causing netfilter_core to
> > free the netfilter_helper hashmap and netfilter_ftp to trigger a
> > use-after-free. The risk of u-a-f in netfilter will be addressed
> > separately but the existence of "asan.module_ctor" debug info under som=
e
> > build conditions sounds like a good enough reason to accept functions
> > that contain dots in BTF.
>
> I don't see much harm in allowing dots. There are also all those .isra
> and other modifications to functions that we currently don't have in
> BTF, but with the discussions about recording function addrs we might
> eventually have those as well. So:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks Andrii! :)

> > Cc: stable@vger.kernel.org
> > Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec"=
)

So do you think these trailers should be kept ? I suppose we can
either see this as a "new feature" to accommodate .isra that should go
through bpf-next or as a bug fix that goes through bpf and gets
backported to stable (without this, BTF wouldn't work on old kernels
built under a new clang and with LLVM_IAS=3D0 and CONFIG_KASAN=3Dy so this
sounds like a legitimate bug fix to me, I just wanted to double check)
