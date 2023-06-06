Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E181A7235DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjFFDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFFDpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:45:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BB12A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:45:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso21755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686023147; x=1688615147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MODHFUV4L/O4bsTMBgQrkhxsTETNlqjXeaBSjrqN1Uk=;
        b=frxgAGfrDnlTrD42lcQ7EhX80pQETt7hpvj8GDOShd8Qm3LsLOQhXG9GktUcX8+aAN
         FESb+VQ/W9n8KrHbpJ/yssGP8pyUvUeQsV7z7n5BZPAI6DaZ3XBaeGnKrlvJjMPzxL08
         ixdCgE2ARx1DbXxdv89dCRKsmHzSiD8mlk3F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686023147; x=1688615147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MODHFUV4L/O4bsTMBgQrkhxsTETNlqjXeaBSjrqN1Uk=;
        b=Ftsa6LQlKDhMq8EVgJrFrUwf5TiR53G3f/BFBJjRbD0++/eEfltwcgmxl9tfzIKcCB
         +qPohb2rGmTzaSdOLBgD/CExRu3R9akPOw7OOiDqV4oJzeEDjDoVCH24F1Kp6215Ty3a
         akSWq/TjnLO5S8SjtfVkar2ULXg0Dnp/ObA4EXq0qmr8r/7kFx475A/r0fOukRUrY6Y5
         VDtLQlXqZWYjh7Qrsv7CY5NXT+KN30Us6EK/dG/6tJYUAcLiojngZ6TgjBlMAhLt7fNC
         M8QoEEKmqSSlLyQHv5RFhr2NFwJCx1EiwXgt7dQe7OF4LOrHeKLC1OkKw6xDmmRlWFsg
         RBRg==
X-Gm-Message-State: AC+VfDzAhGpymytPf5m+MxL89z8pqjxrioj9k9chLYBwUZ7CPDQvSy2M
        sMD3Rjbdpfo5oBnVWF09SXTfTRfw4hhtzj0j8A7svQ==
X-Google-Smtp-Source: ACHHUZ6cKWdn8RJJ4txWpjrym0MbSBGurkQHLRhoVCkS31iSwlAMf58ngZXL41h0idPTPoMMTPAScMfKOb/zwtTzWTg=
X-Received: by 2002:a05:600c:3b90:b0:3f7:ba55:d038 with SMTP id
 n16-20020a05600c3b9000b003f7ba55d038mr115349wms.6.1686023147021; Mon, 05 Jun
 2023 20:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANEJEGvKRVGLYPmD3kujg6veq5KR7J+rAu6ni92wUz72KGtyBA@mail.gmail.com>
 <20230407194645.GA3814486@bhelgaas> <CANEJEGscz3F-6cZcp7dBVekpxHMNXZWgUW2ic3xd6hm3xWH6ZQ@mail.gmail.com>
In-Reply-To: <CANEJEGscz3F-6cZcp7dBVekpxHMNXZWgUW2ic3xd6hm3xWH6ZQ@mail.gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 5 Jun 2023 20:45:34 -0700
Message-ID: <CANEJEGsP2uV2SnHgs6h4Z9V3Fk9jKK4x2PL8g4a33kqvr0WDEg@mail.gmail.com>
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
To:     Grant Grundler <grundler@chromium.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[plain text only this time...]

On Wed, May 17, 2023 at 11:11=E2=80=AFPM Grant Grundler <grundler@chromium.=
org> wrote:
>
> On Fri, Apr 7, 2023 at 12:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> ...
> > But I don't think we need output in a single step; we just need a
> > single instance of ratelimit_state (or one for CPER path and another
> > for native AER path), and that can control all the output for a single
> > error.  E.g., print_hmi_event_info() looks like this:
> >
> >   static void print_hmi_event_info(...)
> >   {
> >     static DEFINE_RATELIMIT_STATE(rs, ...);
> >
> >     if (__ratelimit(&rs)) {
> >       printk("%s%s Hypervisor Maintenance interrupt ...");
> >       printk("%s Error detail: %s\n", ...);
> >       printk("%s      HMER: %016llx\n", ...);
> >     }
> >   }
> >
> > I think it's nice that the struct ratelimit_state is explicit and
> > there's no danger of breaking it when adding another printk later.
>
> Since the output is spread across at least two functions, I think your
> proposal is a better solution.
>
> I'm not happy with the patch series I sent in my previous reply as an
> attachment. It's only marginally better than the original code.

Despite not being happy about it, after a week of vacation I now think
it would be better to include them as is since they solve the
immediate problems and then solve the above two issues in additional
patches. The two changes I have prepared so far correctly fix the
original issues they intended to fix and don't affect the new issues
we've found.

I'll post a V3 of this series tonight after making sure it at least
compiles and "looks right".

cheers,
grant

>
> I need another day or two to see if I can implement your proposal correct=
ly.
>
> cheers,
> grant
