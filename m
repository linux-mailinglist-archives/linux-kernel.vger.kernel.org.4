Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475B6865EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBAMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:31:17 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C55723662
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:31:16 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id j4so3898719iog.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry7RKsC44YIA2lXtFpKOlx3NNoFtQJigiycKjbL6JaQ=;
        b=KitrQxaEEe2X7W4RGsO4hTJUOIAwmyBay0jinYYXO80qAHYeFCpuduxjqhv2SIKhCL
         aa2zfWn0VHEakeBohCzxjl3SUeChrjgPbFJh7LEG4M22UF2IJFdb9cvlhsc+qB9sXARq
         kCBJ5b7bNUVPAWaFiU/CThMb9EaIsTIns10cBENuiK3nz3nIovr4THdh/H292q0ZLf71
         4XOjsobhHPEmQSuM7Feykd/7UUuU8FxKDBH3Lf+jn93Rwoz1GB5gqzWef4mnkCItHsUs
         9v1UMHQXWl/FYlmYFWhzMLYdvg9B7yoyH3J9HpdgbdxUyQhTW6gsBBXdWI8V6mYgAJbz
         SlWw==
X-Gm-Message-State: AO0yUKXf20UG6UGX9Siar+NTIZKaRucfKK4Yzgb8ZGcXtQ34bwzyr/Lf
        4xe4xjhTlE/cr1GgJ97yIo9M9Th4kF1dnmXoPDI=
X-Google-Smtp-Source: AK7set/22zFbaAD/SedVoGIZzZWDAmeupj6/sVk0gpmsbzpaeR2J7s0j8j0EBKaHhVqMtusjJWmKQe9/Y/braAmuCeU=
X-Received: by 2002:a02:a58a:0:b0:3a5:f7fb:178e with SMTP id
 b10-20020a02a58a000000b003a5f7fb178emr372339jam.86.1675254675457; Wed, 01 Feb
 2023 04:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20221125094216.3663444-1-bigeasy@linutronix.de> <Y7/KN7amVvF7NAiV@linutronix.de>
In-Reply-To: <Y7/KN7amVvF7NAiV@linutronix.de>
From:   Roland Mainz <roland.mainz@nrubsig.org>
Date:   Wed, 1 Feb 2023 13:30:49 +0100
Message-ID: <CAKAoaQnTwOxQCxp5uy8mFmHz_46SQFDboPVRJrpHFZcu0n5=vw@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86: Provide a vdso for getcpu on x86-32.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roland Mainz <roland.mainz@rovema.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 9:52 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2022-11-25 10:42:13 [+0100], To linux-kernel@vger.kernel.org wrote:
> > This tiny series provides getcpu in vdso on x86-32. Due to the setup
> > RDTSCP now also returns CPU and node information like x86-64 does.
> >
> > The usage of RDTSCP + vdso has been tested in a VM with 64bit kernel and
> > 32bit binary and a 32bit kernel.
>
> ping.

Is there a commit id for the Linux mainline yet ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)
