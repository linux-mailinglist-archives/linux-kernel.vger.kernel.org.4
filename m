Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE16CF816
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjC3AMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjC3AMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD159FD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680135059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJwwoseYXfDmJDLphLxlCuqi1MgqvP9f+lM5hWiKTuQ=;
        b=EnChsljgEa3sc3f8Veh74LEyv8pQQm+CY3hZ9xNJinUktgOqIYvII9G7VffxxHy1zT2KCW
        viL5aa+Z5i2bXAkM+Dyx/9Bm3N7cluIQbvWm1xns2zsppaGqJT2ZfHyti+xWtgl0CC6eoF
        Bth0KenU5kScWSF7Upwz45hmBn3wWFM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-EsxZPTArNsOyL1Kytk7HeQ-1; Wed, 29 Mar 2023 20:10:57 -0400
X-MC-Unique: EsxZPTArNsOyL1Kytk7HeQ-1
Received: by mail-pf1-f198.google.com with SMTP id b3-20020a62a103000000b0062d796cd5b7so5272108pff.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJwwoseYXfDmJDLphLxlCuqi1MgqvP9f+lM5hWiKTuQ=;
        b=sYN6410Nejt5F+KZfyHbCmZBaRXh0659tzoGjE8OdPUT4BJxtnl4c/30XZAt/CHvVm
         03CJidYKUAhOTCagppHMgb1LE14JMoukKeoJtWHuPVqAJm6MrSSstb9ygmlQJ0+8cJMc
         2M6ZK4Obq76iBNIBOkLHdBrogpk04rnW63dJ/6wjGM28THC9mIPJd2o6Owjy9BdEoUj9
         23HfZiAlP3IUy9ZAN413Af9PkHi8vrzi02M9JQs+XfUR8Qq1Oo1yIbq0XNmdl4vZBD17
         8bgWXoE66f7Es8nZhpAswQ2LM2TrRgkL7F9ZMQvaatBYYUTdcAsxjIbhV7JpJJFeDmMg
         rwiw==
X-Gm-Message-State: AAQBX9cUeDfmLCkT+u7Dvpyi2d/XcBl4Vdt1xv4YN81SnnleQaOr9/gk
        bEMYFnHlMar1Bz7/jHyvivQIIxxdihlK1yovEW/NhhbCR7LcQfRfRLJNXEQRw3ylOBx0I6rPjoH
        poW5Qvuccs1ov3njj1qqkc1uMbzkGdvCXFTDu/N+C
X-Received: by 2002:a17:903:2442:b0:19f:3aa9:bbb7 with SMTP id l2-20020a170903244200b0019f3aa9bbb7mr7677574pls.13.1680135056746;
        Wed, 29 Mar 2023 17:10:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350YsEMj7r4L0z/wLASuJ8/zR4+nsT4Ssmbi1Yix7c8rVlq1R49pcvGXt96xxwz/5uYgKuTH3WDKxIrj1E+swa+s=
X-Received: by 2002:a17:903:2442:b0:19f:3aa9:bbb7 with SMTP id
 l2-20020a170903244200b0019f3aa9bbb7mr7677566pls.13.1680135056463; Wed, 29 Mar
 2023 17:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
 <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>
 <167945548970.8008.8910680813298326328@noble.neil.brown.name> <168012671413.8106.6812573281942242445@noble.neil.brown.name>
In-Reply-To: <168012671413.8106.6812573281942242445@noble.neil.brown.name>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 30 Mar 2023 08:10:45 +0800
Message-ID: <CALTww28X1NQecTY3Jbkz_wbHc_N7GOw3hJLEyb2YnxAmQ8PRFw@mail.gmail.com>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:52=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 22 Mar 2023, NeilBrown wrote:
> > On Wed, 22 Mar 2023, Xiao Ni wrote:
> >
> > >
> > > Second, are there possibilities that the arguments "dev" and "name" o=
f
> > > function create_mddev
> > > are null at the same time?
> >
> > No.  For Build or Create, dev is never NULL.  For Assemble and
> > Incremental, name is never NULL.
> >
>
> I should clarify this a bit.  For Assemble and Incremental, "name" is
> never NULL *but* it might be an empty string.
> So:
>         if (name && name[0] =3D=3D 0)
>                 name =3D NULL;
>
> might cause it to become NULL.  So you cannot assume there is always
> either a valid "dev" or a valid "name".  "dev" might be NULL, and "name"
> might be "".
>
> NeilBrown
>

Hi Neil

The input argument name should be the metadata name. For incremental
and assemble, why are there possibilities that the metadata name is
invalid? A raid device should have a valid metadata name, right?


--=20
Best Regards
Xiao Ni

