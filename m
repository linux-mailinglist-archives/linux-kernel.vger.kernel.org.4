Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93F65DCB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbjADT0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:26:00 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B8140FC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:25:59 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id i20so28029375qtw.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3L4oJG1letLbe7R99Lgy4o7vkNUczJyo6sqausg45E=;
        b=PiHQA0E0kT6tVveS4LGtKJumml5kxckwf7boTZcyshuM9NNanFM6gdgJkMUBsuU2Zo
         7L4SPYMvzYyQIYqmy60x0leeMrPUv1WyJzrtBP+plHUFOtkE6mwKQTuAR0pIxfIwqseY
         y3Axwle2q9aWCeqLoUVUn5aX1lzygIHUwFkdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3L4oJG1letLbe7R99Lgy4o7vkNUczJyo6sqausg45E=;
        b=PSh/eGTX97iGDtl/T61e8YxBr1JkQYtbxukSkKnYSSzmYQLcXj0UA5jXJOI3g6Q2b/
         x1QYoQzK1erRKbIN6RFeeGvXQxUu39/izN3uItHP/HpKQKrzpSUAzxnAyNFedwTuQbSm
         hAKZnURpnNjt0atbun29it7H8p61+bFQxCKbgB3LVIZvyVBVXoi8uXgmZDtZQCEJFTns
         aJHrNJ2ePVUxc82YChswF2wyT8uYwyoVmnZ49jXuRp5ZfRSVv68x6ARSLFGc8oCg4Hrd
         7jfo6lRfrB+kr4XX1A5Nj3k3Gqqahyy5l6ZjJls/YWx8aLH4HMHTB0CvrzgjnI5JWnDn
         3jAw==
X-Gm-Message-State: AFqh2krbpZTVgQ9IqUvfmv+4oRxsyaj+BKhfeKYT+Br6M/FFJsyk/YSF
        gI+Ue7dW2ZwJnngS1PS/dzsVU8w5mvGjmdAN
X-Google-Smtp-Source: AMrXdXv0K26ULWISA2G/6U+QoguEVBeTWEOKTvVtYL4KA2I8B2mhmEGXZ5/qcCieoo8ngBYDcjYUpg==
X-Received: by 2002:ac8:7303:0:b0:3a8:1747:90fc with SMTP id x3-20020ac87303000000b003a8174790fcmr56632025qto.29.1672860357831;
        Wed, 04 Jan 2023 11:25:57 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id l3-20020ac80783000000b003a4f22c6507sm20584620qth.48.2023.01.04.11.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 11:25:57 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id pj1so16784327qkn.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:25:57 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr2190711qkh.72.1672860356867; Wed, 04
 Jan 2023 11:25:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
In-Reply-To: <20230104190115.ceglfefco475ev6c@pali>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Jan 2023 11:25:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
Message-ID: <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
Subject: Re: Linux 6.2-rc1
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 11:01 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Driver is still used and userspace tools for it are part of the udftools
> project, which is still under active maintenance. More people already
> informed me about this "surprise".

Why is that driver used?

It's *literally* pointless. It's just a shell that forwards ioctl's to
the real drivers.

> Any comments on this? Because until now nobody answered why this
> actively used driver was removed from kernel without informing anybody:

Well, it's been marked as deprecated for five years, so any kernel
config should have gotten this notice for the help entry

          Note: This driver is deprecated and will be removed from the
          kernel in the near future!

but I guess people didn't notice.

It could be re-instated, but it really is a completely useless driver.
Just use the *regular* device nodes, not the pointless pktcd ones.

Is there any real reason why udftools can't just use the normal device node=
?

The historical reason for this driver being pointless goes back *much*
longer than five years - it used to be that the pktcd driver was
special, and was the only thing that did raw commands.

But the regular block layer was taught to do that back around 2004, so
the "pktcd" driver has literally just been a pointless shell for
almost two decades.

And I know it was in 2004, because I actually did most of that "make
SCSI commands generic" work myself (but had to go back to the old BK
archives to find the exact date - it's been two decades, after all).

I did it because I was fed up with the crazy pktcd driver requiring
extra work, when I just wanted to write CD's on my regular IDE CD-ROM
the obvious way.

So if there is some reason to actually use the pktcd driver, please
tell us what that is.

              Linus
