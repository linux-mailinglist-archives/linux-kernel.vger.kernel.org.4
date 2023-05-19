Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12030709411
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjESJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjESJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D85114;
        Fri, 19 May 2023 02:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB8D064CAF;
        Fri, 19 May 2023 09:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0CFC4339C;
        Fri, 19 May 2023 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684489812;
        bh=cxsLRE0alCrf2ZfgwTTn9OcSDuEYffyVmRa3xxSbSVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0RyNwKIDZ0zSSG6wCVVJlHLA9iEGgez/wzoq8th6H7bbLW0ra3DBSoRHEGMHWiNV
         /O2iplAC+fZeRHgge0C1G/uyEYNnMBlVpGQp/AaECLynPQy7bWAYrNV8ro6q4EDve1
         mieTp0ttxxbo2/PkjdVfRMVLNsFQi624KK7RdrEQRgDLB8G8xeUMVnQa7IsG1jBeKl
         b0IQYfsYncQ1s6Ke3MKPIV7oce6X2bqPm+Yf2xbkzsAlDLX7ooxZxHHes8RFOxgb0i
         oJwbN8/Q6sj+n6+A+T30KYqnmYeXlJCLcx9Vy6vfSZBcHkiahCWbD2wy75x1Kli0rL
         A2GYRgE2ttADA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f387d97dddso3508841e87.3;
        Fri, 19 May 2023 02:50:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDwhkgBxf5URlhcB/dTcnZl24ydrmDLEcUYNMFq1YxiF2mjM10Ex
        07zWgaV3UnpQM0ihUKzD0XxBxHIiKijCM2yVoEc=
X-Google-Smtp-Source: ACHHUZ5GcgO2M7ELebyN3Y1RyiaRrgxpvXBxmuk2yUVv8d3D90lsJfyWfmQipdKuDjOf1BlNC20rnWfiygUIXWwKBo4=
X-Received: by 2002:ac2:5a0b:0:b0:4ef:e87e:df88 with SMTP id
 q11-20020ac25a0b000000b004efe87edf88mr603195lfn.64.1684489810195; Fri, 19 May
 2023 02:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230512202311.2845526-1-dima@arista.com> <20230512202311.2845526-2-dima@arista.com>
 <ZGG5rtuHB4lvLyKI@gondor.apana.org.au> <eb6d0724-92d6-3c3f-b698-9734adc7e1b9@arista.com>
 <ZGcyuyjJwZhdYS/G@gondor.apana.org.au>
In-Reply-To: <ZGcyuyjJwZhdYS/G@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 11:49:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFoiJpZLCiE4uNTEXMncvWheSn8nVWGB8g3sL1K8jGyuw@mail.gmail.com>
Message-ID: <CAMj1kXFoiJpZLCiE4uNTEXMncvWheSn8nVWGB8g3sL1K8jGyuw@mail.gmail.com>
Subject: Re: [PATCH 0/3] crypto: cmac - Add cloning support
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>



On Fri, 19 May 2023 at 10:27, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This series of patches add cloning support for the cmac algorithm.
>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
