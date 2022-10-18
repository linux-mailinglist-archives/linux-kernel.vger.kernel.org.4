Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F0602BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJRMkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJRMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:40:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A1A59A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF946B81E05
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58A3C4347C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666096841;
        bh=cDI8VfW/AF6NrGhMRTUwjxIejQkorXt38BMo18OIObo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f3Psn9sX5ux6fiZFNToYOp8kdGy1VH9ed3u6L3BG6YBvRFnHk5Q/kh6Qbo6v4RPJU
         PuO6XFq69OkrDfuWE6wz502RFbIhqbmxgGn0DB8bmzhun/D/H4cEBl9wcOOKu5DoHX
         OjT6V/MFV6CtHuPqymX3wXFPyxgNgpwICZJkLKDKBa/xD6Nlgjoo+ozvXvWo6jVUCu
         vCcNBb0FqYTys9nI/zL28why6WnEq/9exmjLdiFayBfAAi5m5vYYSZjhISIWiN+oOn
         UMM4oVD6fV4IW5GVhcB6Yyu3nBc10Oo1reKOqA0tXx+81hNQ/wo6YHZeHmKnO1zjl8
         wAAULoeV24Xag==
Received: by mail-ed1-f49.google.com with SMTP id a67so20192000edf.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:40:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Sif313n4A0D1VQJJfKLINY4oBxL7zIoZkkgYA+dZQqgnCeBVY
        Gl6/8nltbp/v7H7m3smB055Nea9yfz6zgjZTLp8=
X-Google-Smtp-Source: AMsMyM7L9/2fDG8D52xfgKVGygf0bMgoEg7J0xxPTSpynEjWLF0JmV5E+wQd31WHXA+etoCNEDCoEC0biIb2lYhEvQ0=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr2436200edr.254.1666096839795; Tue, 18
 Oct 2022 05:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221018094742.324576-1-zys.zljxml@gmail.com> <59b75b38-8995-ea54-b5cf-eca78249b65e@xen0n.name>
In-Reply-To: <59b75b38-8995-ea54-b5cf-eca78249b65e@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Oct 2022 20:40:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H614sr9zqVdqiAJ-XKsv=6g0XK49G=AKXCFsOe0TeVZyQ@mail.gmail.com>
Message-ID: <CAAhV-H614sr9zqVdqiAJ-XKsv=6g0XK49G=AKXCFsOe0TeVZyQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: use flexible-array member instead of
 zero-length array
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     zys.zljxml@gmail.com, oleg@redhat.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, chenhuacai@loongson.cn,
        lixuefeng@loongson.cn, yangtiezhu@loongson.cn,
        Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-fixes

On Tue, Oct 18, 2022 at 8:27 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/10/18 17:47, zys.zljxml@gmail.com wrote:
> > From: Yushan Zhou <katrinzhou@tencent.com>
> >
> > Eliminate the following coccicheck warning:
> > ./arch/loongarch/include/asm/ptrace.h:32:15-21: WARNING use flexible-array member instead
> >
> > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > ---
> >   arch/loongarch/include/asm/ptrace.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> > index 17838c6b7ccd..7437b9366c3b 100644
> > --- a/arch/loongarch/include/asm/ptrace.h
> > +++ b/arch/loongarch/include/asm/ptrace.h
> > @@ -29,7 +29,7 @@ struct pt_regs {
> >       unsigned long csr_euen;
> >       unsigned long csr_ecfg;
> >       unsigned long csr_estat;
> > -     unsigned long __last[0];
> > +     unsigned long __last[];
> >   } __aligned(8);
> >
> >   static inline int regs_irqs_disabled(struct pt_regs *regs)
>
> Seems good. Thanks.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
