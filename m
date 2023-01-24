Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B186679633
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjAXLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjAXLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:08:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529EA25C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:08:00 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s26so6895757ioa.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMWpmGty23z1Cl0USDQdSe9An1t47aG10KmxaT3emH8=;
        b=o3ihyVFrSBs7SVg7npdb/TBUqiIwuOObAS6RD+NE7CBxbb7biP9jRr68nOsXv5SrPL
         z5M3AMoCVr9dzSRjMDfcWa5iQ+xbQeJkeLHip7UwJnBRs26QQi40RWh9xKJRuMxZyW7t
         UM3Sl/XSLYrfTwuHAB+AGh7I1n7Sw9h2ICuWN/xkKdh1OvpY27NQkCx7OFmqDb7i09pB
         RbcNIejwZS52iht7TaPHdTlqd7sH6uBkBqi+uXzuma3d2GltBZ46Wv2/3rd82cTKsfPK
         9I7SPsaTph7Xio8EvmWglbDObywizhpqQ+QBHDW7d/sOYXKTK/g9g0+qxdtLkJ2DPpGs
         5uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMWpmGty23z1Cl0USDQdSe9An1t47aG10KmxaT3emH8=;
        b=wqTlGl39/UaCwUnfEOEJm2leS4nJNTBaxwpak2fkg+mskjhWlCw8Ox1sOMXLqsOGO8
         WA3AYjOIiGTXSvwtwkZY7qbe9EggMKTfpiVdpsweb2T/0PTMGNgo45z5HwBnfHrtI6Zy
         oeRUlN7c38jwZZfdNalsSbblmZl8LIURdeI9GTek401FMRNu0lxOh3abkWHb0h/IYvWM
         Shc3rUi9PcSFCZxZU/Hq6YP9NkE2LCVmdzqxp/va2uP8CgFt4YFdIlM94bq8VTg2lYdl
         fW2Vp821sK5mv6kKc6gPwnCLEoqx9Pch8Mxt2brR0yoI9VAKSs0yG3ETpRqeZWrQXWIx
         7Sbg==
X-Gm-Message-State: AFqh2ko6em/zbqTmq4c6i0Xur12f5mb/mVWrEngtdOZ+fzDam5Gm6MlC
        fVvLJDQUQvrUrTkbrOTuw4fF0mUSWNyeGAzlGLv4fA==
X-Google-Smtp-Source: AMrXdXtc6sSARAUtafudwmUwFhsGto4jwg/EurDY/uqJ1z5UCdT6pgw2sDf4Kcv81Z6uu3g66CX+ATbNNHT3G/e+MvM=
X-Received: by 2002:a02:c50b:0:b0:38a:ce9a:5772 with SMTP id
 s11-20020a02c50b000000b0038ace9a5772mr2114591jam.109.1674558479828; Tue, 24
 Jan 2023 03:07:59 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004f995905ef61a764@google.com> <Y5geWpk1WfgwjzuA@sol.localdomain>
 <CAG_fn=XDN23qMwwMCPi=8drv9kE6Z-goFQ8nNN8Qux3bdrnvLw@mail.gmail.com> <Y5o9lHS04s9QTRNH@sol.localdomain>
In-Reply-To: <Y5o9lHS04s9QTRNH@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 24 Jan 2023 12:07:23 +0100
Message-ID: <CAG_fn=Vz2sTxVAu1gfq6pYSvX0qsGpsWU8ap5kHW28oENNtBOg@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in longest_match
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

> > Can't we just pass __GFP_ZERO when allocating the workspace here:
> >
> > ...
> > This is what Chrome folks did in the same situation (
> > https://chromium.googlesource.com/chromium/src.git/+/962cbbe81708214ff8e14e2bc8a07271cb15f1b9
> > )
>
> Sure, the btrfs folks can do that if they want to avoid this warning for the
> btrfs zlib compression specifically.  This would not solve the issue for the
> other users of zlib compression in the kernel.

We probably can't fix zlib without sacrificing performance, so I think
the right thing to do is to actually modify the users of zlib
compression to pass only initialized data to zlib.
Doing so will make the calls to zlib_deflate() well-defined, whereas
marking longest_match() as buggy will just hide future error reports,
but won't fix the code in question.
