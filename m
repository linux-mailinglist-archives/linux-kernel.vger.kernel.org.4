Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D10717C50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjEaJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjEaJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:45:37 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1710E;
        Wed, 31 May 2023 02:45:36 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4911757a12.1;
        Wed, 31 May 2023 02:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526336; x=1688118336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/2aFBpIsqpE5f/CcamhdekTeF9dAuGTGy1N658Z3Aw=;
        b=YpvqIF6sjCT028bnduUEPYNw38JvAqY+IPI/cxef6XFIQvhLfzkB3FMygvoJf87c2I
         T34xKd4kGaBOpMFReQXRXXjY+a1lvs/IFb8ciWma1eFb8XQUFxHgyet7Gu4EjRMBHECj
         Rj+kBR3YjGRcwgD2DUVELllJlhlWWIfnhZsNNTJRA2L+xUWcgd9P0Fcqwyics628IHD4
         DuzctOKA97z2F4VEU+M2hEVPpKla0WlmEoVl1jOc3w1QBhEUAYetB/L7wn+67UYpCzpX
         e6AYP8JmIIqDeJXV2R5p8Rf4Refe/0LVqzt6927sT6IJZ48iZhyrrqM0sehJOSJSqw8J
         itxA==
X-Gm-Message-State: AC+VfDwQUztd7OskD+HTDuO3DiZDdzsuMbkBy1wzaevBCUsV+OxOrPh+
        dQz2zlEyBmu1KuGxwgOhhgZCwRYaHdRbhLje/7w=
X-Google-Smtp-Source: ACHHUZ6keaXUYHaJYg6vFOspqfoUed6ZnCFmBKZmVeFdviOjIuQo6mQbZ2GJJKlVVoH9EV6aBxz/wMIDSqnCz222cKQ=
X-Received: by 2002:a17:90b:951:b0:256:35f0:a2b0 with SMTP id
 dw17-20020a17090b095100b0025635f0a2b0mr5138557pjb.0.1685526335890; Wed, 31
 May 2023 02:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <20230530144637.4746-1-mailhol.vincent@wanadoo.fr> <20230530144637.4746-4-mailhol.vincent@wanadoo.fr>
 <ZHYbaYWeIaDcUhhw@corigine.com> <CAMZ6RqK2vr0KRq76UNOSKzHMEfhz1YPFdg7CdQJqq4pBH3hj5w@mail.gmail.com>
 <ZHZTUw9HWE10CUn0@corigine.com>
In-Reply-To: <ZHZTUw9HWE10CUn0@corigine.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 31 May 2023 18:45:24 +0900
Message-ID: <CAMZ6RqL=hB_566G4rmOYksgnSV1sQEyQEgjHPfkVEL5TQfejqg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] can: length: refactor frame lengths definition to
 add size in bits
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Thomas.Kopp@microchip.com,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org, marex@denx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 31 May 2023 at 04:53, Simon Horman <simon.horman@corigine.com> wrote:
> On Wed, May 31, 2023 at 02:29:43AM +0900, Vincent MAILHOL wrote:
> > On Wed. 31 May 2023 at 00:56, Simon Horman <simon.horman@corigine.com> wrote:
> > > On Tue, May 30, 2023 at 11:46:37PM +0900, Vincent Mailhol wrote:
>
> ...
>
> > > > +/**
> > > > + * can_bitstuffing_len() - Calculate the maximum length with bitsuffing
> > > > + * @bitstream_len: length of a destuffed bit stream
> > >
> > > Hi Vincent,
> > >
> > > it looks like an editing error has crept in here:
> > >
> > >         s/bitstream_len/destuffed_len/
> >
> > Doh! Thanks for picking this up.
> >
> > I already prepared a v4 locally. Before sending it, I will wait one
> > day to see if there are other comments.
>
> Thanks, sounds good.

On a side note, I was puzzled because I did not get any documentation
warnings when running a "make W=1". I just realized that only .c files
get checked, not headers. I sent a separate patch to fix the
documentation:

  https://lore.kernel.org/linux-doc/20230531093951.358769-1-mailhol.vincent@wanadoo.fr/

Yours sincerely,
Vincent Mailhol
