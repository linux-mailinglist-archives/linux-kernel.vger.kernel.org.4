Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF16348C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiKVU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKVU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:56:52 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12F79E2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:56:50 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x16so7675762ilm.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlMufq6wwOtc4XGTJGuBUwA4oTDJeZJWTn7LDaX9omo=;
        b=cc48agsV/uOGmMsIxtLLEXqIc/tKDn7MSV+gANC7gdTPlIvVF8YI/++GcxTXOY5wMz
         5Hcv5e/SblT6b22pBjcQ7fTC7BK1T+F59jdPEviqB/Tu/jwEbNI8jCrWbm6sdqcfOU1z
         k7yL/j2qmH9wSR01r8qDn0ypEIbwmb99ruu35UY1zvqrTE9fkQdpoo/ftOuFuV6HmBPs
         Tr4yETlCoCpE5OR8IN+a1YVsGSCpf3Nzc5EQ0LZ5ffg7Y5bFJAf0PzCqVPerNaHsc5zg
         HfYGHcSZO+csoRtO/IYyWtJ2T3/ZHK9XvtR3/GvVcfHJnUxqIbsvSiLlxfa4TmTRDdle
         CMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlMufq6wwOtc4XGTJGuBUwA4oTDJeZJWTn7LDaX9omo=;
        b=GbOBOit5UGHGRJyhs3rEatJGUvJ8vnn+U1WHooeLULPnf/yIb53MI+Bjr4mLKruDSO
         tnM3SI1J4oMyH5V8PyY4qGpI2OXLkidYSx6NMNm/a+RjNkYozI+Hc0YPqRU4GCkgPJoM
         NIYMfYFgGUgSrFuu1sp9da3HI2a5I3dbIpx0JOxwfyOTglRrwM6HlXxH9T13LpDkS5sK
         VpImesC8gdsMEqfqt/wtz/erbTnoqi/YKexYx7X/hni3JGm+298aSoUcruWkV/t1Poc2
         zw3kydC6OG9DTDdeOMJa+lVcCuv9drNdbyvvNgidYMIkRpUmqUMpewXAVubIBZgR8vqB
         WKdQ==
X-Gm-Message-State: ANoB5pneGsUkitTMlTyqrWeaCn7AZJrsQfjaern/3tX9Y9JuCEy0CgPn
        QG4SKEkj4QGAj5/TCExK3/1mzXhzS5xfOki2T+aOTA==
X-Google-Smtp-Source: AA0mqf7MpSN1gs5UHuvg6Y+bJcDNPrwNMRrOYJimH4KCWL1V/xsX7F2M8ZSr2Uw3P0NmLLajaksjhrPeAmAmCr0plQ0=
X-Received: by 2002:a05:6e02:11a3:b0:302:a9a5:d608 with SMTP id
 3-20020a056e0211a300b00302a9a5d608mr3748589ilj.141.1669150609835; Tue, 22 Nov
 2022 12:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 22 Nov 2022 12:56:38 -0800
Message-ID: <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running the generic xfstests against it, with some
modifications to do things like mount/unmount the lower and upper fs
at once. Most of the failures I see there are related to missing
opcodes, like FUSE_SETLK, FUSE_GETLK, and FUSE_IOCTL. The main failure
I have been seeing is generic/126, which is happening due to some
additional checks we're doing in fuse_open_backing. I figured at some
point we'd add some tests into libfuse, and that sounds like a good
place to start.

On Tue, Nov 22, 2022 at 3:13 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 22, 2022 at 4:15 AM Daniel Rosenberg <drosen@google.com> wrote:
> >
> > These patches extend FUSE to be able to act as a stacked filesystem. This
> > allows pure passthrough, where the fuse file system simply reflects the lower
> > filesystem, and also allows optional pre and post filtering in BPF and/or the
> > userspace daemon as needed. This can dramatically reduce or even eliminate
> > transitions to and from userspace.
> >
> > For this patch set, I have removed the code related to the bpf side of things
> > since that is undergoing some large reworks to get it in line with the more
> > recent BPF developements. This set of patches implements direct passthrough to
> > the lower filesystem with no alteration. Looking at the v1 code should give a
> > pretty good idea of what the general shape of the bpf calls will look like.
> > Without the bpf side, it's like a less efficient bind mount. Not very useful
> > on its own, but still useful to get eyes on it since the backing calls will be
> > larglely the same when bpf is in the mix.
> >
> > This changes the format of adding a backing file/bpf slightly from v1. It's now
> > a bit more modular. You add a block of data at the end of a lookup response to
> > give the bpf fd and backing id, but there is now a type header to both blocks,
> > and a reserved value for future additions. In the future, we may allow for
> > multiple bpfs or backing files, and this will allow us to extend it without any
> > UAPI breaking changes. Multiple BPFs would be useful for combining fuse-bpf
> > implementations without needing to manually combine bpf fragments. Multiple
> > backing files would allow implementing things like a limited overlayfs.
> > In this patch set, this is only a single block, with only backing supported,
> > although I've left the definitions reflecting the BPF case as well.
> > For bpf, the plan is to have two blocks, with the bpf one coming first.
> > Any further extensions are currently just speculative.
> >
> > You can run this without needing to set up a userspace daemon by adding these
> > mount options: root_dir=[fd],no_daemon where fd is an open file descriptor
> > pointing to the folder you'd like to use as the root directory. The fd can be
> > immediately closed after mounting. This is useful for running various fs tests.
> >
>
> Which tests did you run?
>
> My recommendation (if you haven't done that already):
> Add a variant to libfuse test_passthrough (test_examples.py):
> @pytest.mark.parametrize("name", ('passthrough', 'passthrough_plus',
>                            'passthrough_fh', 'passthrough_ll',
> 'passthrough_bpf'))
>
> and compose the no_daemon cmdline for the 'passthrough_bpf' mount.
>
> This gives pretty good basic test coverage for FUSE passthrough operations.
>
> I've extended test_passthrough_hp() for my libfuse_passthrough patches [1],
> but it's the same principle.
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
> * 'passthrough_module' uses 'libfuse_passthrough' which enables
>    Allesio's FUSE_DEV_IOC_PASSTHROUGH_OPEN by default.
