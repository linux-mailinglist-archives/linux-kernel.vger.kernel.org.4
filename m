Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717DA6C6228
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCWIoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCWIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:44:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE4BD;
        Thu, 23 Mar 2023 01:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F056B82010;
        Thu, 23 Mar 2023 08:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FEEC4339E;
        Thu, 23 Mar 2023 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679561051;
        bh=vdt+VTF6s151E+GhH+YVcJOM7fD0i+oL71q1c78abEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aynJ15a/tvPj2HDrhf92SPwKAZ2Rwa7ljQ7jhyfWQ+9i/n6T/VTMWqIi7fiziKufT
         s8s+1nGwzkz5CvvbuMPpm/pJVpmHp95MzcPQ+zAZjfwnGLvJdCwu8egQ6Kr63G+TzT
         6rISGV6Act5ehGocXJSV196XJQ1Zcj2lgLuZyiQx97J71sCgsgV0glR5jCGRKnkIKl
         syKg7vy9S+wWCQISoTHiq5HZwUMfqXjMerqo0HJ3hsztpnQOKS7+zFtx2V9dr78YIk
         2seaOagjsVyrXODtvZqBKMjeVzfDy4BGwcbBEHJyvAVn4AdnQWhOdSwQzjf5bGP2Rc
         4YpsH1n+U0VGQ==
Received: by mail-lj1-f181.google.com with SMTP id h9so21624512ljq.2;
        Thu, 23 Mar 2023 01:44:11 -0700 (PDT)
X-Gm-Message-State: AO0yUKWyoFmBw42RCeAtQNRXM2DHhrn0CKFEKxjOxfzuSzGODINcfM4W
        zmFoOdK8PWYqfe8NjWxowJDnUpSWF4er4pqr9G0=
X-Google-Smtp-Source: AK7set8bOkMSZJ6GS2cm34R4NyMp5Lh44w/sGIyIaQvJrC0AfCeRwKH664LcDqIsZIcP7A0BSFDNfnzYUN4/be1tcGw=
X-Received: by 2002:a2e:a1c6:0:b0:29a:7cf0:3535 with SMTP id
 c6-20020a2ea1c6000000b0029a7cf03535mr1582198ljm.4.1679561049245; Thu, 23 Mar
 2023 01:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
 <20230310223027.315954-2-krzysztof.kozlowski@linaro.org> <ZBPYpYfd29YwN1Dy@gondor.apana.org.au>
 <b8cd828b-edc5-6748-bf97-af0fc85e14a4@linaro.org> <ZBQlKMTcTm1yjete@gondor.apana.org.au>
 <e7cd7252-9cc6-0970-b0e2-35fccde45e86@linaro.org> <ZBQvx0PDQJ4qpnNO@gondor.apana.org.au>
In-Reply-To: <ZBQvx0PDQJ4qpnNO@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 23 Mar 2023 09:43:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3oZhO=dMBmLzNO_nScJBjcjwUqy2sZbCJwmMS1XtLKg@mail.gmail.com>
Message-ID: <CAMj1kXH3oZhO=dMBmLzNO_nScJBjcjwUqy2sZbCJwmMS1XtLKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto - img-hash: Drop of_match_ptr for ID table
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 10:16, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Mar 17, 2023 at 10:01:44AM +0100, Krzysztof Kozlowski wrote:
> >
> > That's not true. There is no waste because having it on x86 allows to
> > match via ACPI PRP0001. It's on purpose there.
>
> Alright how about this, I don't have any OF devices on my machine
> yet this structure is still taking up the extra memory for every
> single device driver.  This is wrong.
>
> > There are OF-drivers used on ACPI and x86/arm64.
>
> Well then they should be selecting OF and everyone will be happy.
>

No. PRP0001 support in ACPI does not depend on OF, so drivers that may
be bound to such devices should not either.

If you are concerned about the memory used by such tables, you can
always propose making PRP0001 support configurable in the ACPI core,
but making individual devices depend on OF for PRP0001 matching seems
wrong to me.
