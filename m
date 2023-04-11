Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B726DCF74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDKBig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDKBid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC1E74;
        Mon, 10 Apr 2023 18:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C602761456;
        Tue, 11 Apr 2023 01:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30887C433AA;
        Tue, 11 Apr 2023 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681177112;
        bh=obRgOLwa24A34Xw+WVQ19IPmX3EOzcjF/yQQr8z4UxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FKStRVCjUmppxwt5KJw0FZfvdJ/8tuaWaSbaVLEVv2cE6MpmWCsmO8+7sCx+XZ4IF
         9+NJMoao6weabC/ZmfeOYfLEjT0e85GudexqiTnEC/5/diwWjipbaJki7WumRcNBUu
         VuNsRnT50tdB9rjByw17MxtMI7iW1AEfUj2svXy1UCmXaP/3KKqY3/9N0n0awuuwcY
         3VLYUKNYeBziDU7+m7WPC39YS6jJ2lDXke/HbwkqvB1RvxKOxSo+1mVZwttk6j0Wil
         2XWBrz8udkLTFSknPAxszivKNGhBrIz3tOARFevJTofK1iDyGNNO4NA8stv74SKi7l
         xdBzLt4l3EJdQ==
Received: by mail-ej1-f45.google.com with SMTP id jg21so16229526ejc.2;
        Mon, 10 Apr 2023 18:38:32 -0700 (PDT)
X-Gm-Message-State: AAQBX9dgDeVYErhVusvfA6CeJWmrEF+lycJVduPypZv6vOywb3aREk8S
        EFIKC6rcvY5yoHRrAL93ApH5ykcS6g3iRuZZrRY=
X-Google-Smtp-Source: AKy350ZO+m+Hzk+9BOc3QNXnpM7mFBOw3Rv1kMdU8w6yRrlUuQ2PjmsI8eAiAOl1kaVTrOjH9JGyYIqBp0l//S6K+AA=
X-Received: by 2002:a17:906:c78a:b0:947:eafc:a738 with SMTP id
 cw10-20020a170906c78a00b00947eafca738mr802756ejb.60.1681177110240; Mon, 10
 Apr 2023 18:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com> <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
 <ZDAGqL6CZGrL499u@kernel.org>
In-Reply-To: <ZDAGqL6CZGrL499u@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 11 Apr 2023 09:38:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ-aRfpK_Ct7pbTcgBEU9qkTAr9VG8B66G0NDBmchSYtA@mail.gmail.com>
Message-ID: <CAJF2gTQ-aRfpK_Ct7pbTcgBEU9qkTAr9VG8B66G0NDBmchSYtA@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement crashkernel=X,[high,low]
To:     Simon Horman <horms@kernel.org>
Cc:     Chen Jiahao <chenjiahao16@huawei.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com,
        alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com,
        bhe@redhat.com, thunder.leizhen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 8:03=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, Apr 07, 2023 at 05:06:24PM +0800, Guo Ren wrote:
> > On Thu, Apr 6, 2023 at 10:06=E2=80=AFPM Chen Jiahao <chenjiahao16@huawe=
i.com> wrote:
> > >
> > > On riscv, the current crash kernel allocation logic is trying to
> > > allocate within 32bit addressible memory region by default, if
> > > failed, try to allocate without 4G restriction.
> > >
> > > In need of saving DMA zone memory while allocating a relatively large
> > > crash kernel region, allocating the reserved memory top down in
> > > high memory, without overlapping the DMA zone, is a mature solution.
> > > Here introduce the parameter option crashkernel=3DX,[high,low].
> > >
> > > One can reserve the crash kernel from high memory above DMA zone rang=
e
> > > by explicitly passing "crashkernel=3DX,high"; or reserve a memory ran=
ge
> > > below 4G with "crashkernel=3DX,low".
> > Asked-by: Guo Ren <guoren@kernel.org>
>
> Perhaps 'Acked-by' :)
Sorry, my typo.

Acked-by: Guo Ren <guoren@kernel.org>



--=20
Best Regards
 Guo Ren
