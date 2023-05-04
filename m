Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE536F70CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEDRYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:24:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C388149D3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:24:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso1532068a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683221049; x=1685813049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjowc/gRt/pdKPtgyZqkM5OSn7+TcLpFEiLZrM6tdM0=;
        b=hEQ+VutEhKDPZsOTY3XnPqGUM+jUOkVftCAYeNoJ4w3CBdvYz51hSrfFPk0ItbcABz
         d5+QMeVED0eT+5bv3KPIY9pNk5a73FBGTDiBm3+TJ2Ox5W0Lb6EnhHjXGnvPD98mvCJw
         BME8+zc6On0S4WeykifZ3C8b1Io1CQrXYoYoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221049; x=1685813049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjowc/gRt/pdKPtgyZqkM5OSn7+TcLpFEiLZrM6tdM0=;
        b=c9NMJm51onJKiTG32JXhSduBoR8au/foGS6qeXSnsH4x7WwqNR64m50U9kZvT8XFp6
         kQH3rhCv2P7NZtyWLr0EMH/JithtXzJ3jOX7KYS1YXkooO9yCcZd2JJAhsZ0OaSZhZG3
         K+90lpa7coHS3bPtM/fIjPdhKY2XmgqYW8ChgIsSs5XErYynLexB+WpjQ0wRiI100x/6
         ykuBqskGkwFy7dxmDDJ7QqOU8vQcDbZQpVZs9iv/ZajhDchGRjsQfml3FRg2YAy/OPo3
         GS/GQHoMUPuY1uj8wP99TtEac0Y9kr4QjkPk7uugsjHLzq+SE8rJ7a4jvgi4Ef8yriKq
         FH9w==
X-Gm-Message-State: AC+VfDxGLFX2p8CaPRoauTMFW0lONYVNnUuwUlX0lI4TwU29ziDkRUeT
        8WkBj/Y/yiBl54Wqk9hFIavf4vN6dBRbLHECTHjRi6Ve
X-Google-Smtp-Source: ACHHUZ6BfK2SwxRnUcowJpnOrCrVv8PFbiIhvPlQv6T7i0vFLpk0E7ANs8K1krO3cmHERz8dcoyiEw==
X-Received: by 2002:a17:906:ef0a:b0:958:5c21:3fa7 with SMTP id f10-20020a170906ef0a00b009585c213fa7mr8250889ejs.25.1683221048890;
        Thu, 04 May 2023 10:24:08 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id qm10-20020a170907674a00b0094f282fc29asm18774883ejc.207.2023.05.04.10.24.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:24:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-956ff2399c9so132468366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:24:07 -0700 (PDT)
X-Received: by 2002:a17:907:3205:b0:90b:53f6:fd8b with SMTP id
 xg5-20020a170907320500b0090b53f6fd8bmr6290287ejb.31.1683221047723; Thu, 04
 May 2023 10:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZFI74eeUzVPKhi4f@matsya> <20230504150624.GA1000378@dev-arch.thelio-3990X>
 <ZFPPucb9VNLB8r8v@matsya>
In-Reply-To: <ZFPPucb9VNLB8r8v@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:23:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-ve0h02vsNrzuox58rLXSbzcjay+k=XnUueWRh6cO2Q@mail.gmail.com>
Message-ID: <CAHk-=wi-ve0h02vsNrzuox58rLXSbzcjay+k=XnUueWRh6cO2Q@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v6.4
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 8:31=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote:
> Sorry between vacation and travel, this was missed.
>
> No worries we have process to deal with this, so this shall go in as
> fixes.. I will do the needful shortly

You need to do it *now*.

You should never have sent the pull request to me in the first place
if you hadn't checked the status in linux-next.

The point of linux-next is to find failures. And if you don't then
*care* about the failures, then it has all become  entirely pointless,
and it's effectively the same as if it had never been there in the
first place.

So this needs to get fixed *PRONTO*, and it needs to never ever happen agai=
n.

Because if it does happen, I will consider your code to effectively
never have been in linux-next, and thus just not be an option for
pulling.

This isn't debatable. You don't put things in linux-next, ignore the
reports, and then send things upstream anyway.

If you don't have time to check the status of your tree in linux-next,
you don't have the time to do a pull request. That's just how it
works.

                      Linus
