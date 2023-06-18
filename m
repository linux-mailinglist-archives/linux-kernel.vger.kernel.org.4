Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4D734534
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFRHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFRHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 03:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB010DD;
        Sun, 18 Jun 2023 00:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BB860FD7;
        Sun, 18 Jun 2023 07:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C1C433C9;
        Sun, 18 Jun 2023 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687072038;
        bh=YgC6nIkZIoztX/ro4qb6ifmd3O8sXsDl31N6GbTv0hU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qGaFRHu6bvljYhA73syGxrqSJlHr4aP35lfa7IOa3F9gw312xAP4cxxR8pZg8P/Ng
         0OqnzmAlrwDDpXnG29N3Ec4E7fDe0xB0WBWaaCU7dfeGQNzB1AEVG2DZfNXWX9WRB1
         QcL0yALLoXjOGBUsRoxB6nf9YmNnl3mO6yTYA0J6W9/ssuerVovcxhVtinf/FTDleQ
         X4zkQ+cjw3wkopHiJ5ILEAr/+5HRo1+nqoAT+a0M14vsY5IonO20pFChBqnjs2JS1D
         b2HeEasLYyjwwk33uyL0oKYPCLGRFTn3CMZL1efuVA/Wo7Jx5C1DB258hqiIJRpBd3
         Hb0i/8jw8dqcA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso3232123a12.1;
        Sun, 18 Jun 2023 00:07:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDzJEKyzp/m/KkiEuvUCHts73QoGsEtzdmlKzE0nHHmk5BF0N75x
        hPteu+DV4vc+HocgRj/wEcjvjTg+DbLc/WLi1iU=
X-Google-Smtp-Source: ACHHUZ4QwomyFiPEIpzIZG11XSiPDrxJjfLMdsSRVgzC9LSRXYTe2lcttjrowhta4YhABaheGi43wslKcaTvMf+A6oY=
X-Received: by 2002:a05:6402:64a:b0:510:f462:fc47 with SMTP id
 u10-20020a056402064a00b00510f462fc47mr4885034edx.7.1687072036371; Sun, 18 Jun
 2023 00:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230424152815.GA32615@redhat.com> <93544487-4015-f89f-44cd-754670c354e5@loongson.cn>
 <20230615165636.GA3886@redhat.com> <0e3c5e6a-084c-d417-4582-651eeca8ed32@loongson.cn>
In-Reply-To: <0e3c5e6a-084c-d417-4582-651eeca8ed32@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 18 Jun 2023 15:07:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSazSbgTbkw+wyHLRxvpKcuxx8iQDoBuJCitfeDUiDNkw@mail.gmail.com>
Message-ID: <CAJF2gTSazSbgTbkw+wyHLRxvpKcuxx8iQDoBuJCitfeDUiDNkw@mail.gmail.com>
Subject: Re: [PATCH] csky: uprobes: Restore thread.trap_no
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        srikar@linux.vnet.ibm.com
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

On Fri, Jun 16, 2023 at 9:20=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 06/16/2023 12:56 AM, Oleg Nesterov wrote:
> > Hi Tiezhu,
> >
> > I think you should ask arch/csky maintainers ;)
>
> Yes, thank you, sorry to trouble you.
>
> >
> > On 06/15, Tiezhu Yang wrote:
> >>
> >> ping, what is the status of this patch which has been received Acked-b=
y:
> >>
> >> https://lore.kernel.org/linux-csky/1682213987-3708-1-git-send-email-ya=
ngtiezhu@loongson.cn/
>
> Maybe Guo Ren (the maintainer of C-SKY ARCHITECTURE) could
> take a look at it, thank you.
Sorry, I missed that. I would test it and put it into for-next.

>
> Thanks,
> Tiezhu
>


--=20
Best Regards
 Guo Ren
