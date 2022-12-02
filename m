Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F0640E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiLBTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiLBTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:38:42 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB76E5A85
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:38:41 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id h11so9296712wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trrjEoQhdweZnQxt/ue9J7DGg6KSv0mJpfqXOAr3F4Y=;
        b=58aq//SpG50DaIhfuPDDe+9Wx+doTOZbmZ1ntnlzssyKwgm5xdDmaJ2M1BL1pThX15
         TRTiiVNer0GwUwMESrHX19ESKwykWBPrQyNFvWRCTZ4qU4p0LzGVwoEUpbiTqxXCQXXm
         ITj1yIzQcoq38PBivkDzSbJuD/bHVmM1g2ShbvkV8eA+LGqjuodbvcygO0mcfAAkEEdo
         s7LBwsT4fmreefThn9JAE/fzNCnPpI8ZPDbQxiiofhw9BgsiCiB+GYZv+MAtWDV41UJD
         Bj1VRg1fVqEAHJHTCDOYLMfA5OgxYQbwKvumJmGI31H3up5A6heS2Q1Xg7nRfn5DGUTd
         Im3w==
X-Gm-Message-State: ANoB5pnsYZMJ4VlgMOXdv0UeeRD1jRP7PkfXPFFbuCcSxu0/mw8eZzND
        hO5gzWJcatTAxRKCd1KZ2Z/3Xj2PCuZUKd7Ebh4=
X-Google-Smtp-Source: AA0mqf6N6KOb0W1bO75h3dXVUNKIKdpJ+BwGVaDijBYey7vMdiTSXh1Tx2S87n9783YHE/CTrD89mqfi2YYOrnObIAs=
X-Received: by 2002:a5d:69c6:0:b0:242:1b9d:1bd5 with SMTP id
 s6-20020a5d69c6000000b002421b9d1bd5mr14921570wrw.232.1670009919975; Fri, 02
 Dec 2022 11:38:39 -0800 (PST)
MIME-Version: 1.0
References: <Y4pN9MbSuANbn68W@kernel.org> <CAM9d7ch7EkOhQGSXZDzbhdGTP_4L243Kyt3FrT6Nv3Rgx-xKtg@mail.gmail.com>
In-Reply-To: <CAM9d7ch7EkOhQGSXZDzbhdGTP_4L243Kyt3FrT6Nv3Rgx-xKtg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Dec 2022 11:38:28 -0800
Message-ID: <CAM9d7ciq+FDoELa-RqYi+hyxZEqD4ucUEtCpoZWzNidQ4=OAUA@mail.gmail.com>
Subject: Re: tmp.perf/core segfaulting on metrics test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 11:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Fri, Dec 2, 2022 at 11:11 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > While trying to get back at processing patches for Linux 6.2, what I
> > have at tmp.perf/core branch is failing like below, can someone try to
> > help in diagnosing this?
>
> I think you missed this
>
>   https://lore.kernel.org/r/20221130111521.334152-2-james.clark@arm.com

Or, it could be something reported by Ian.

  https://lore.kernel.org/CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com


Thanks,
Namhyung
