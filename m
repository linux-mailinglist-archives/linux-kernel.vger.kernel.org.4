Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F566F4340
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEBMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:03:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545B19F
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:03:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94eff00bcdaso731461566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683029008; x=1685621008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/YRcfxmNsr6Lwk5XiJCdhjiGVkTxQwDjCgW062Di2c=;
        b=o4kdKwTRk33hC4HFcBT+9b69VKLPjjiKCZpZtoFD1ZnB8NitPdOUHk5aiyQQdQKpnE
         S755qs/iAEPdoqWzgHnm8nvpBxEL4GerVyo1qoRBz8+M+DCyhRyh/07WdUCO2qd2rtKh
         hn71j5Hb+bm8A3fyrNZz9tXMVybcf3jvbZnA6Xa22Oroh+uATM0eoq4nbzeV9ZvmjmWa
         CYtI3Y7/Qqe9yDTxyyyPVlzXNgaJe0uU6csAwyWLOQWoZ1egG93e4fNOB4SQuQ2Uukis
         EF8rlIuLxuXTZTLbNzJ4awhOe8mC14lHN36kPXG8XJeOY5mTMbbyc/MidvKmbiKVf5vh
         E1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683029008; x=1685621008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/YRcfxmNsr6Lwk5XiJCdhjiGVkTxQwDjCgW062Di2c=;
        b=A0+qFL4koCLSQi1uBEQv/LOPYJ/crMU3R7iUcjADm67H6eN4hEpK4SN5QgsYzvIzSz
         p8KHN+TwUF/ZSB3FIBkrVdNbx+tiZIeZ1zATost1dpymBjEKH0D4Fa0KsPm/+m2njkvT
         e3O+BnMjO2sEi2Uy4ckFEOpTH6v9hHciUCwBaEB3ZVycTIQuRogA0huJU/oR7NMawfel
         HFstgd54zAV744Fyi92nOuMWorhCvbektRThAOcJNa9ZEJ3vXasQpfvLCxghPE5c+YKK
         diBty3FckWf6wzR93J34MhmSo8rXBVhqWRcABd9m9pMEcYQDYlFu+1hrWrsKJ2nXkrvj
         KeAA==
X-Gm-Message-State: AC+VfDwxFaaut8fUx6tcgskNwINpvXO0AXfldw+gtf6Nlc/Y7qmr8e01
        8+TDj5hNaXwG/eoOYvGD8P/mZVLeLyPmc2aB190=
X-Google-Smtp-Source: ACHHUZ77IpXZRekNr9ddahoipzbC1kDJT3R5mRFNBoWxh8ZKY2WJdgkQlRP98U6GJ3oEml7kk+65AQHLB49FL8/62VM=
X-Received: by 2002:a17:907:1613:b0:94a:82ca:12e5 with SMTP id
 hb19-20020a170907161300b0094a82ca12e5mr16593096ejc.45.1683029007546; Tue, 02
 May 2023 05:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230501190602.86281-1-jandryuk@gmail.com> <ZFAWaQbDR1_r5jf-@codewreck.org>
In-Reply-To: <ZFAWaQbDR1_r5jf-@codewreck.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Tue, 2 May 2023 08:03:15 -0400
Message-ID: <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Remove INET dependency
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dominique

On Mon, May 1, 2023 at 3:43=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jason Andryuk wrote on Mon, May 01, 2023 at 03:06:00PM -0400:
> > 9pfs can run over assorted transports, so it doesn't have an INET
> > dependency.  Drop it and remove the includes of linux/inet.h.
> >
> > This allows configuring 9pfs over Xen with INET disabled.
>
> Good catch.
> Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?

trans_fd.o builds without INET and without UNIX.  Looks like trying to
use either TCP or UNIX sockets would lead to runtime errors, but it
also supports generic file descriptors.  That could be useful for
someone.   Since it builds, would it be okay to leave this patch
unchanged, or do you still want the depends added?  Leaving the patch
unchanged provides more flexibility, though the runtime errors may
surprise users.  While I built a Xen kernel without INET or UNIX, that
is an unusual scenario.  Typically INET and UNIX sockets will be built
in anyway even without a depends.

Thanks,
Jason
