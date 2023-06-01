Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF37199B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjFAK2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjFAK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:28:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44BD19AC;
        Thu,  1 Jun 2023 03:27:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba841216e92so690056276.1;
        Thu, 01 Jun 2023 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685615261; x=1688207261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+7FpAWqJ9UaTJolR3fhX+VLULajdYAdz5DrVldjg9M=;
        b=DNPDU5955K3+hJXFzOhvILPyfqhiSdd9AH82pxA7AZjcBYekzjwTVcHeYa5kxirgAO
         Zsqg9Mg7i09PWZMBkKR7GAnp8ApHEPR/Ngb4zXdIsbHhJ2yHMUtuKsa+hA1WMlIBXDaZ
         f5aECL2Gh3Xr5TOs0ItqQjUOT/xZD07F4DerYW8MthBWzV1iasujQH82WKNARh7GgVhv
         RGxSnQJpSYab1qYmx8r7cey9siNoVykynMlqHekdt4eUUPcU8QbgHsus2PuNMBfIFJIn
         wbOdnSrHZ8yKkEnZAa8jCXmmAosVEa2dhbK92w49HB5Bxw4jMYLpapeOHTgKpe+O3OCV
         jJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685615261; x=1688207261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+7FpAWqJ9UaTJolR3fhX+VLULajdYAdz5DrVldjg9M=;
        b=OmTieXZVzPCNt4w6A9PQpk1iUVPi7uzCMzphN+8+DTuZ2AtcTvlNUkTvtZ0rKsNID3
         wvEKNPgHioXZXV+4yisVgf/6LtN6iFbp+3yfEMdZjDEc4WFCkljfDhITSJWAka0g/SBk
         epWTCAlnOBh48L374tLyqluo4CBO5joLwGawlsQQPcwbID1ueiWcomUHrox+5+TVy3Ky
         aTOCP1Zo08XL3DvYs6Cdk+cQ/jI7Rd+uVxjbcnM5b18EakgSMR6M6bYH9WhM3jrXsOqx
         Xhl1kX4QmrX6KHXUSPukcmRV83Nazlr8AAomW/D4TY7I1xoNY0gwMjrE30tDzwDKv9cW
         CI2g==
X-Gm-Message-State: AC+VfDyokE00sCPOvtHcjJXkmOL3x/rdSAkPPeqO22nz0y+i05zGggWl
        fBhPJzel91Gwxe8cUOKc7xV9Yu7vhVEBMnqrcMk=
X-Google-Smtp-Source: ACHHUZ5Rl9j3K2nrrXUI/ytZpuvVrpIbThy1vg7TGrRlvrVK4YOxw4JnS8GJOEYrUj1mJ3ErDXiEdVBrPMLLYU7fcMk=
X-Received: by 2002:a0d:d712:0:b0:561:abb8:3b38 with SMTP id
 z18-20020a0dd712000000b00561abb83b38mr9719929ywd.17.1685615261437; Thu, 01
 Jun 2023 03:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com> <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com> <87ilc8ym6v.fsf@mail.lhotse>
In-Reply-To: <87ilc8ym6v.fsf@mail.lhotse>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Jun 2023 12:27:30 +0200
Message-ID: <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org,
        alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org,
        pmladek@suse.com, wedsonaf@google.com,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>
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

On Thu, Jun 1, 2023 at 4:02=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
>
> > Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
> > used, but the name seems discarded? Can
> > `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
> > usage of the buffer there to begin with?
>
> A few lines below it uses the modname, and AFAICS there's no (easy) way
> to lookup the modname without also looking up the name.

Hmm... I think you are looking at the `xmon_print_symbol()` one? I was
referring to the `get_function_bounds()` one, where the `modname`
parameter is `NULL` (and the `name` contents are not used, only
whether it was found or not).

> > Side-note 2: in `scanhex()`, I see a loop `i<63` using `tmpstr` which
> > then is used to do a `kallsyms_lookup_name()`, so I guess symbols
> > larger than 64 couldn't be found. I have no idea about what are the
> > external constraints here, but perhaps it is possible to increase the
> > `line` buffer etc. to then allow for bigger symbols to be found.
>
> Yeah that looks wrong. I don't see any symbols that long in current
> kernels, but we should fix it.
>
> Thanks for looking.

My pleasure!

Cheers,
Miguel
