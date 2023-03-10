Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED86B40A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCJNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCJNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D9710D743
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678455604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ec5XfNjxgy0+peAVSlU3DabxggNLNiWQ6hIV8ILc0ww=;
        b=YYRmkBo9A2BPq70tI9+WQ6i6D3CB3O2URzSZvR2tfZUI9NPKLvUGobG3U/NtG3CNtImavu
        eNFSKcTVn6QbTIhKOrj3Z8r0vXT9SAr6z/cwJaBbZUHvu9uvg8zAcLSW9nVPfDLtVBSc38
        Gp7R9K7HE05xUuxXR/J15l435I8q0zM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-NAInj2cgPHGKvzxTQB0fwA-1; Fri, 10 Mar 2023 08:40:03 -0500
X-MC-Unique: NAInj2cgPHGKvzxTQB0fwA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-536b7eb9117so54332707b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678455602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec5XfNjxgy0+peAVSlU3DabxggNLNiWQ6hIV8ILc0ww=;
        b=H99g2EZVLPTA9rfzm5ywE+234zCq3W5yBo0pqpAOo7rrb66oY6GyZRzT0/QjY2b/CK
         n/j/QLdcuYRXy/2GSM5770R0htK7irl6cjfuPlQF6pYEbJHjnjZt13HaD8gHayL77EM9
         VlMHuFwm3vqKRa69lCux5EMMNTCjNq5QCUP6Bq3cNDEvt+n83JTn9K/7UZ2lKLxcixq2
         FYCWSL88ti+c0SE4UUrPDAw/vJIa9JWmNkw2oWRfAv0xCbKJI79p9oZsxPRRdY5OJw7l
         GV0+z4msPqOCadhwhdwpJBD3DzLzlQ+NWPYEWNN1FuwT+rDxfI8UCq7LnThRpPG0oz5s
         N9ZA==
X-Gm-Message-State: AO0yUKV1MUyk3Wsuot1VXE+359+E0XggEr8lTaEwjbzzTd0grje4j346
        bBvMfGuK1ZRH9Xzr1BpTyZ+emNN7KKBYY99lOdeJFvMkt5YFb3qDCl18HquHN8Wc/roKTK0PgEg
        QNZ43YPzUS9DKJyaQFmYE5mHWNMq1LQNESWawxc16
X-Received: by 2002:a81:ac09:0:b0:535:8cb8:6ae9 with SMTP id k9-20020a81ac09000000b005358cb86ae9mr16625683ywh.4.1678455602593;
        Fri, 10 Mar 2023 05:40:02 -0800 (PST)
X-Google-Smtp-Source: AK7set/5VI1jqwwIL95f7E9ael6l5fc39fVSnt5yYua59iTmCvE+HObP8/dA4tH6a8PyRPfheRlOalbqTQhZQilnc9k=
X-Received: by 2002:a81:ac09:0:b0:535:8cb8:6ae9 with SMTP id
 k9-20020a81ac09000000b005358cb86ae9mr16625674ywh.4.1678455602386; Fri, 10 Mar
 2023 05:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
 <20230310114150.GA62143@black.fi.intel.com> <CAO-hwJK+yF+0u6cbw4CoV8vS80Vx5xkC2vwPjOQvnUox2SMdTA@mail.gmail.com>
 <ZAsyaNzhbcWuJS2q@smile.fi.intel.com>
In-Reply-To: <ZAsyaNzhbcWuJS2q@smile.fi.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 10 Mar 2023 14:39:51 +0100
Message-ID: <CAO-hwJL1YA0MnYkQ5pOgCoOd0Kga3+F2nnzkLu=9PdggrB=y6w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 2:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 10, 2023 at 01:51:38PM +0100, Benjamin Tissoires wrote:
> > On Fri, Mar 10, 2023 at 12:42=E2=80=AFPM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
>
> ...
>
>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Thanks to both of you for the reviews.
> >
> > Andy, should I resend a v2 with the rev-by from Mika and the Ice Lake c=
hanges?
>
> Yes, please.
>

Alright, v2 sent just now :)

Cheers,
Benjamin

