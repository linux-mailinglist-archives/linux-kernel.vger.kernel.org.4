Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59177636996
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiKWTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiKWTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:09:08 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A63F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x18so13140161qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPgzuaoqHuz3hc6GKBXrRYZsP8U7EhvDm+I1zVt6Kyc=;
        b=EFNC4tQlvCILCh89xvIkqHD2HaIjFKosUdVGMRAv1CFQL71EGGppxAhkFklcwgTSBC
         DHCoZhz3mvQ7jOPniFnrjTEdj3Ju25j/2/tkns12FsXfLuvllqmlGAwtDPqcAFeaDJST
         IkO304Om2ISQ4EzhQM5kzUC5yFRh1EPVo8X9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPgzuaoqHuz3hc6GKBXrRYZsP8U7EhvDm+I1zVt6Kyc=;
        b=IndEki9NJKYPh37YdsrvwpLS02raJ29PU6T0/z5zmZFYH/B17fgprWwuZPH7aPRafS
         9qowHPti84Nfh60bfJ2CSM3o+bEN0b80m7bqwT0NMiVtlhDJ54Vr+DfsoUjwu1Fp3ncF
         5UBMpMpCZcw0LT8qaQCbvIbc08nDCTW80jBgbNfyjTpp4BnpuRmQkoUTvTWhpW7eWZPO
         NINHEeebIEwRt8Yx0wyfKvUQklIcvkcxNNYXdrPsbwdiIX/LH89uXs6hr+e2CUd2HO26
         9t41+Krsiw5ySQloRaBFTkoi1L2uAjW6l7pwGL6uGs4l121zJl64jH3ZnILo0gGkUOLs
         XY5A==
X-Gm-Message-State: ANoB5pkivqX5zxY5dVMTFKcqE+LOWC6STj9dFNgwRPn7eybk29c43DPb
        UxEtPPqTDjrOXgvg+UHESoe7pJXQIb+XVw==
X-Google-Smtp-Source: AA0mqf5vveqyNkpP6E50RVPnUZCdBSTqey9xOCpHEwzD/a3YJaY7FYT5CRp5z5nqV2PHcJ7rHulSjA==
X-Received: by 2002:a37:a816:0:b0:6ee:b301:e302 with SMTP id r22-20020a37a816000000b006eeb301e302mr25895550qke.643.1669230545973;
        Wed, 23 Nov 2022 11:09:05 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id q16-20020a37f710000000b006b95b0a714esm12417595qkj.17.2022.11.23.11.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 11:09:05 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id h7so12182505qvs.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:04 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr9787467qvp.129.1669230544666; Wed, 23
 Nov 2022 11:09:04 -0800 (PST)
MIME-Version: 1.0
References: <Y32sfX54JJbldBIt@codewreck.org>
In-Reply-To: <Y32sfX54JJbldBIt@codewreck.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 11:08:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
Message-ID: <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
Subject: Re: [GIT PULL] 9p fixes for 6.1-rc7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 9:16 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>  net/9p/trans_fd.c  | 24 +++++++++++++-----------
>  net/9p/trans_xen.c |  9 +++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>  9 files changed, 254 insertions(+), 28 deletions(-)

Strange bogus second line of statistics.

But the first line looks right, and I've pulled it. I'm assuming this
is some odd cut-and-paste error on your part where you had some stale
data from before.

               Linus
