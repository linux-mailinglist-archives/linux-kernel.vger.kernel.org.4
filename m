Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DF723DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjFFJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbjFFJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910591705
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686044041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wN4b69xo6rSjA1E3xDaIpxOZ9wdwUCtXvAmORundino=;
        b=fBufJexDU1M4lPsBhWtlQ1aPK+FaxPCVvbeO5KiyKfjxN6v+KH0kTYy8l8r3lNWla2SQCH
        wGsVeAJPvnIiLw6P80Umwx8V0/M9HBPuL1NzMOabkgjjYeuWjffwAF7cL9UgLwnj52dJ9+
        pCVpfRF4khygi7qtSQYXTQrw8+lOdGM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-577kUz9WOjO56Uwciy9oow-1; Tue, 06 Jun 2023 05:34:00 -0400
X-MC-Unique: 577kUz9WOjO56Uwciy9oow-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97463348446so371861966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044039; x=1688636039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN4b69xo6rSjA1E3xDaIpxOZ9wdwUCtXvAmORundino=;
        b=PbHu4WltnnvGRFmYg/bvoW/B/UPwcWkMaZ9FDOYRuqwqFSKf2MKyxoclA8eunsKVQX
         CPQoNl6A47J4clo88snnoHrpI0hRTDFO34Z20up3xsTwiEu3T9G+pqmVaQYMEvmml+Ih
         6ZhQfVYJD5hLQaeUWw7EDzf6GhLLIlNKCIAy2VPQFNsoYsYzMB+zXVnX5El2KgFpwdWl
         RlYWCFbCGqXnL9942cDMN0i6K9vW03vkcsaXhpZ1btnK7yLgTBGnte+uPaoSaKs1mZGm
         Gd2mjkhPHmIyzRnNHidtMmDv+xVyFZGsrEi/Zn6/OfSiEehNMdIMgjBLPG2x37cvDWlb
         ib/Q==
X-Gm-Message-State: AC+VfDxg2QMSi9hnoGHa+yw02iR4CMrC1eiCHUANa16D2yW39sWuDtdJ
        9wJTssLKmPIwVey4KnHsKsNawB4wthX1UJFby2f+9K0mctlzl51qgwx0qWxluUQ+gIT5Zykx/q9
        gDZjlVRzYGJ5qjCAVF/Gtd7L8Rb6GYf2GATvHYBlq
X-Received: by 2002:a17:906:6a20:b0:94e:48ac:9a51 with SMTP id qw32-20020a1709066a2000b0094e48ac9a51mr2101988ejc.4.1686044039035;
        Tue, 06 Jun 2023 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pM3VqIk4XNqJUh/s4jQhSFFjen1muE9hAy6St1eT5BhmpLXiidhzMmximTlmxjgPOlULnJgNjfK2ENkswQ2w=
X-Received: by 2002:a17:906:6a20:b0:94e:48ac:9a51 with SMTP id
 qw32-20020a1709066a2000b0094e48ac9a51mr2101972ejc.4.1686044038818; Tue, 06
 Jun 2023 02:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
 <ZHWo3LHLunOkXaqW@corigine.com> <ZH3srm+8PnZ1rJm9@smile.fi.intel.com>
In-Reply-To: <ZH3srm+8PnZ1rJm9@smile.fi.intel.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 6 Jun 2023 05:33:47 -0400
Message-ID: <CAK-6q+hkL8cStdSPnZF_D1CtLvJZ=P16TJ8BCGpkGwrbh8uN3A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray
 gpiod_unexport() call
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 5, 2023 at 10:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 30, 2023 at 09:42:20AM +0200, Simon Horman wrote:
> > On Sun, May 28, 2023 at 05:09:38PM +0300, Andy Shevchenko wrote:
> > > There is no gpiod_export() and gpiod_unexport() looks pretty much str=
ay.
> > > The gpiod_export() and gpiod_unexport() shouldn't be used in the code=
,
> > > GPIO sysfs is deprecated. That said, simply drop the stray call.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
>
> Thank you!
> Can this be applied now?

ping, Miquel? :)

- Alex

