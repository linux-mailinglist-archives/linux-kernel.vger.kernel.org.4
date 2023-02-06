Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116268C7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBFUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBFUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:38:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849083DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:38:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d189so7914916ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p7ue1zRU/AjU5knacS3GDq7lajmNru08tnSXNxYZ0Gw=;
        b=BHQbX5u1aQjTGJ1iP02gP7C0QSZh7RNID/98p3Gti/sTWNvXOb+gt3LwB4/Uc7gkZP
         3GEPsR084v4Y0fRYnVQXN78I4o7okvqXp3PXfcH4GP4+L4PSVu8uy1tyQyaOOE7lbLcs
         Fo7hfGgcMEvvAFzYESxq//p8nL6SfxRmjoriOJvjljK0cie+wYgUN7SJeOalP+EhWpgW
         bly8+GUnTgUTD5D0KZ3uNFU4vdPn5gvuaRC/UJ5LjRB+aNSnGzflUs1D14KNmaBpUcnt
         60IU7w969ZTJ9VVmRpVLldsvXmNZp73T2c2j1l4hw7TCf8aGfK+4L7V5TqndMk8ggUAY
         Azrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7ue1zRU/AjU5knacS3GDq7lajmNru08tnSXNxYZ0Gw=;
        b=dSFlDFO3TOFUkbYs1UBkVM7g5OSBhcuZyZFvWnr/rz6mAyln/jA8GC/ZTK3z67/f1W
         oD3hpR3UEWuh9TD0C7ekfPGDNCdEn1afIafmzXcwCxdfdzaLXJFdAYZTDIuzShPMu3Hh
         3MeS/0XjsybT9kabneH+vgaoPUWH7Mkluw2coxLUO4FjsOH1wJCr9ozuFGfKVZi+Vrt5
         3JZ1is8gqIQWZzYrI1P3JzG8T/PZ17YVIc2KvzcZHUzWdIhCwqyo7k5ImOvHDxEL5/+r
         3zL2wc3UwpFFTmT1E61hUHYKG4g/NAPxUBpTnr8Xq888BBy/0xIy5QY4bkjNUIzT5Pfq
         Ihvg==
X-Gm-Message-State: AO0yUKVuxwQcH08Jm+MFT0/0MVsuSVu+blVilD6J0mVtiQC2ljHEt3OD
        BTIjJ2uYLxocuboguT1fSfTyH5mojzp75nnFvLBc
X-Google-Smtp-Source: AK7set+WmFVIug6Skz6bZ/gvAML8mj5Vd83GEt/x5/P8BbbID0lkxXu5H30afIDNA+CbTbvxEcM2GMpQq/xcrypJkOU=
X-Received: by 2002:a25:22d6:0:b0:861:6af2:d2f3 with SMTP id
 i205-20020a2522d6000000b008616af2d2f3mr122168ybi.330.1675715887097; Mon, 06
 Feb 2023 12:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com> <20230203200138.3872873-4-jstultz@google.com>
 <20230205190548.7auywdoagy6txpla@offworld>
In-Reply-To: <20230205190548.7auywdoagy6txpla@offworld>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Feb 2023 12:37:56 -0800
Message-ID: <CANDhNCrG5zRZCFdz_k5fnsc8vqNbEu_9++qvR34FW_DXJcpVNA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] locktorture: With nested locks, occasionally skip
 main lock
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 5, 2023 at 11:33 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Fri, 03 Feb 2023, John Stultz wrote:
>
> >@@ -754,21 +755,28 @@ static int lock_torture_writer(void *arg)
> >                       schedule_timeout_uninterruptible(1);
> >
> >               lockset_mask = torture_random(&rand);
> >+              skip_main_lock = nlocks && !(torture_random(&rand) % 100);
>
> For the sake of future readers of locktorture.c, this deserves a comment
> as to why we wanna skip the main lock (copy/paste from the changelog).

Good point! I'll send this update out soon.

Thanks again for the review and feedback!
-john
