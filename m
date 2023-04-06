Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211A6DA074
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbjDFS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDFS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:59:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09426B2;
        Thu,  6 Apr 2023 11:59:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n1so20340204ili.10;
        Thu, 06 Apr 2023 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680807588; x=1683399588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUyJ3wxzxoqSuvxPI58fy1Btf6mp8kX94ybQptXUc3Q=;
        b=YkKIr0GocwTAvB4t/GGojOyjJQrlawJFDeEIq7fgZQ0DqGk5NImD9Go7I7XBAQOfW3
         eYq5ujzUXkEzVnaC07MyyL2e529FZ81atwYQQLFZ9Kb+a+wpWSJjppzOiN8EPS+O/KpE
         BZIdqjdajls2tbOYgstJBf3atbMy+dZAgb4WZGEHdwwSQfZENcA19TYYhLdkrxfjAkoK
         NFptTaCqhJiss0Yd4T/aPtBP7+430FpAK+iFijJgvN9PmOXqKoUmQ6/5tAMRTyiV7QUC
         2j1LYK4snrCVyLKee25ixG7vc3NoQ5YF0Eio3pnk3FktYwFACXEjuHN16jKqFDhF79mL
         Pt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807588; x=1683399588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUyJ3wxzxoqSuvxPI58fy1Btf6mp8kX94ybQptXUc3Q=;
        b=jqkJOSuiqzZ0OTtg8usyy3IMWRiBRjybROhJ2Tf6DVeBBsn4F2m89Oo6jAY+MjUJ//
         CBIuFOyKRkF7dtjVxYa2N9UD7LIeCfQp70iO/WwM5uvXv49JUCZv4S0X972MlQrVEtZK
         CdH7Awxb5Cq2lsgpP1wg/DzkWWL0dPHL+yoKc1rD6t+HeQ1Cr7d8PZhU7rycGDjuoobq
         VnXIpP1HvPUh1wu7Sbw+L8r/+VqKH7k/NbzFxN6IVspgr+knzYWzev7mhGJ2EDSK+NjZ
         94csohZWRHqYrAIUwnQvHAcCgp30c/SlyFWBYHJ6K+kgRRuirRfCe6KcPknQmcZdqPTl
         ZBCQ==
X-Gm-Message-State: AAQBX9cBLbvJIkGmAq/fCBXByNKpP1aER3sjjdl5RINx/rGjThVwsWVR
        I10+DgFQ+beDA3jwcdAii+mjl1EvJ8F5sgDU0So=
X-Google-Smtp-Source: AKy350bQp4WCCWwuYEVoVmA1ow6eFikyqvIzEhmOaus7gRujSkLUdnIxlEeOdiLBcMiNn18hKyvJs5Bu35ppe0l85QE=
X-Received: by 2002:a92:c5cf:0:b0:326:4201:2d8c with SMTP id
 s15-20020a92c5cf000000b0032642012d8cmr6810904ilt.1.1680807588655; Thu, 06 Apr
 2023 11:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <ZCu1tFrQCVe2sgNz@infradead.org>
In-Reply-To: <ZCu1tFrQCVe2sgNz@infradead.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Apr 2023 18:59:22 +0000
Message-ID: <CA+V-a8sn8ai1h9+D-b2+Uj2xGcPOw95ukFPy=T_jL+EjTuqApQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Apr 4, 2023 at 6:29=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently, selecting which CMOs to use on a given platform is done usin=
g
> > and ALTERNATIVE_X() macro. This was manageable when there were just two
> > CMO implementations, but now that there are more and more platforms com=
ing
> > needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageab=
le.
> >
> > To avoid such issues this patch switches to use of function pointers
> > instead of ALTERNATIVE_X() macro for cache management (the only drawbac=
k
> > being performance over the previous approach).
> >
> > void (*clean_range)(unsigned long addr, unsigned long size);
> > void (*inv_range)(unsigned long addr, unsigned long size);
> > void (*flush_range)(unsigned long addr, unsigned long size);
> >
>
> NAK.  Function pointers for somthing high performance as cache
> maintainance is a complete no-go.
>
Ok, I will take the ALTERNATIVE() macro route.

Cheers,
Prabhakar
