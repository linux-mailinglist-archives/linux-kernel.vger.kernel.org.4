Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA072CE89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjFLSfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbjFLSfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:35:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44D1990
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:34:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f620583bc2so5469596e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686594886; x=1689186886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd62pmi6vde4J9GeAbTB+1XNz/5Y4SFzi53ndiAQrHU=;
        b=NS7S4u5cz2qj3dc1Gt+QteeddIkMeO0wFy7nbS5DDIEKxk1gy/jQ7u3VmHA2s4Rpsr
         X1KywOGQ0ozpRy9W71JPfF1PXSkGXjDh8bj0CTRYDsrP83t5VUuSju8bB+j4bFogaG0b
         LBT94dzCGD66JPiXPowtCOrNHQkQMI3GMvYn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594886; x=1689186886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd62pmi6vde4J9GeAbTB+1XNz/5Y4SFzi53ndiAQrHU=;
        b=FbSpHj072frc6r+pnxrLHftz4B2LXy4zEBmLJLh6Wj1dE02zHFbaSxVkDfukVSD7zE
         HRicvju/l6uJ2OFuOFB7l2bj1pBk4rWNjLQOKPMUndNFJKEF9EAkHb0TUEakG2yc7tAM
         omYDN95BY5VLf3OwLWgZoJNbW9m0NeA31c+RcEE2pHfoo1+algHpEYxhY9kEdyAhLBSA
         qTasv38GXNsupL1Nwz1A5ycNjbAKUECgvwAhL9i1wOP75aFDHW/rUp3e/ecBiPMcdMNb
         bBi1QLkPgxBTKfVTuDunuCDu2M5u6jU9KJHgj+uziJW0IsdTpLinMFPZ+TPd2VopoexA
         u1aQ==
X-Gm-Message-State: AC+VfDzbP9I+VWAJcFouFfBFL6O58uGbBdu7MWUnuOj2coLy2JCOyZP4
        2rfmefk86+ydXNOW7ExnfTq7E28ZIAIP0YISso0p+43L
X-Google-Smtp-Source: ACHHUZ43K0Scaj36bbtwECDSWfcjZK8O7PDONL0FVz9wGd/n1oSGRM2rDA8ya19vYC05v+hiN+JBiA==
X-Received: by 2002:a05:6512:32a4:b0:4f7:5408:ba89 with SMTP id q4-20020a05651232a400b004f75408ba89mr79264lfe.1.1686594886291;
        Mon, 12 Jun 2023 11:34:46 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ot25-20020a170906ccd900b00965f5d778e3sm5485721ejb.120.2023.06.12.11.34.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:34:45 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso8006748a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:34:45 -0700 (PDT)
X-Received: by 2002:aa7:c0d6:0:b0:514:8e4a:15a9 with SMTP id
 j22-20020aa7c0d6000000b005148e4a15a9mr5698676edp.5.1686594885420; Mon, 12 Jun
 2023 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
 <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk> <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
 <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk> <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
In-Reply-To: <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 11:34:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqVEdigZWMoOUMr0J179vfA4G=MwafFh8UStsA-3mHBw@mail.gmail.com>
Message-ID: <CAHk-=wjqVEdigZWMoOUMr0J179vfA4G=MwafFh8UStsA-3mHBw@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:51=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, can you (and the fsstress people) confirm that this
> whitespace-damaged patch fixes the coredump issue:

The proper patch from Jens is now in my tree, and I'm archiving this
thread on the assumption that it's all good.

Dave/Zorro - if you still see any issues with that patch in place, holler.

                   Linus
