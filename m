Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08116723E55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjFFJwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFFJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D61E69
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686045073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38AKLlfRzFfzbHumACWesn62Y/isbifhTQ7f9ujx0kg=;
        b=GzEXbdaVDjzPbPjgQgeQtgAp8zCW/GvcpnJRDrdx2CbsS8VOqdLNgOkf2p0kVUG7Xlt7Hj
        lSEkd7KRuEFHJutkO9l3wy+XN1BnD01fYN3RM3uJ7FRfVNObElQWec71jNx33sL4DTxrnS
        QYNjc8RJ/gq6CbvI5JMPoDluRv5Udxs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321--SG56-0uMqSnUqn8dF6LQw-1; Tue, 06 Jun 2023 05:51:11 -0400
X-MC-Unique: -SG56-0uMqSnUqn8dF6LQw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97455ea1c14so368000166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045070; x=1688637070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38AKLlfRzFfzbHumACWesn62Y/isbifhTQ7f9ujx0kg=;
        b=BYvmVZcn6k2YSSR7q1jsn2cAoyha8EjSSuSf/FFrcWO2VCRQRIRnBvlxGCqV40AvZY
         EfjVktIbr75NMppdgJF1dZM636qrQ5y/Ifgw/yjgIMZwLcE8zOTgBqtHvwNYJ70OXPNP
         uldnJrzvzc4w404ylmFDdABMbdmwqs2XuzQO4P7fYw4ebRWgdOj/pe1HaNkF8TlEK6pF
         Js/klu/BsaouiT2OTgPV7LhkQ832NkQNxBaQhwTeDRBQu6HNhr+1X04VKIo7wUmYstrx
         +lg/3p9bG4QsB5tKVOraZQRAsDSHD+zhJTF9Cy0Po6Lo3h+tj6cQrPdag1Ze2utmkRzG
         r1OQ==
X-Gm-Message-State: AC+VfDx+fkphfE6VuxCAnmg1JX+jVbHo6w+QTFsVMVatNYiQwmNdvlhW
        HDaWl8XUcff3Hv3+mT8gJ55GsPgcQ5WhmqZvdOFkQgAu68TpvvipbHJ2ZK+KqdWx9bDd3iU7htc
        arYatnzXgpK6moCRUfE/z4j87EJoCdM/+zh/e0T7mAmjlyuoi
X-Received: by 2002:a17:907:7da5:b0:976:b93f:26db with SMTP id oz37-20020a1709077da500b00976b93f26dbmr1746050ejc.53.1686045070071;
        Tue, 06 Jun 2023 02:51:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Dv3AJpDlVEjRtuKVJHJ8H8bJ9LrW98cfd9HvqCm7NXhOTBDEvR3sZYKUjCUGJsG8TnUKUHFJh/2NwjIVZfoA=
X-Received: by 2002:a17:907:7da5:b0:976:b93f:26db with SMTP id
 oz37-20020a1709077da500b00976b93f26dbmr1746034ejc.53.1686045069784; Tue, 06
 Jun 2023 02:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
 <ZHWo3LHLunOkXaqW@corigine.com> <ZH3srm+8PnZ1rJm9@smile.fi.intel.com>
 <CAK-6q+hkL8cStdSPnZF_D1CtLvJZ=P16TJ8BCGpkGwrbh8uN3A@mail.gmail.com> <20230606114743.30f7567e@xps-13>
In-Reply-To: <20230606114743.30f7567e@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 6 Jun 2023 05:50:58 -0400
Message-ID: <CAK-6q+hoNTZFyg6cGDHmJYV+mw17AgJ6EEkgDz=qrNa3pkmtrw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue, Jun 6, 2023 at 5:47=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
>
> aahringo@redhat.com wrote on Tue, 6 Jun 2023 05:33:47 -0400:
>
> > Hi,
> >
> > On Mon, Jun 5, 2023 at 10:12=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, May 30, 2023 at 09:42:20AM +0200, Simon Horman wrote:
> > > > On Sun, May 28, 2023 at 05:09:38PM +0300, Andy Shevchenko wrote:
> > > > > There is no gpiod_export() and gpiod_unexport() looks pretty much=
 stray.
> > > > > The gpiod_export() and gpiod_unexport() shouldn't be used in the =
code,
> > > > > GPIO sysfs is deprecated. That said, simply drop the stray call.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >
> > > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > >
> > > Thank you!
> > > Can this be applied now?
> >
> > ping, Miquel? :)
>
> I already applied it locally, but I am trying to fix my "thanks for
> patch" routine to not tell you it was applied on the mtd tree :-p

okay no problem. Fully understandable as we have a new workflow
mechanism for 802.15.4.

Thanks. :)

- Alex

