Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7D6EA128
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDUBlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjDUBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:41:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C440CD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:41:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a686260adcso19203725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682041309; x=1684633309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBqsOzJXMqZz87HaUvjwXwIt5Yf5VZ43MrT/J+SNaHA=;
        b=L9HGPktkFIv3hj//jIig628lTCOym6WdYsLabkRjz4vPNx/Pba6pe3Q3eptiQcuDRG
         9E3m4rjFWCaFpRFsu7mO4NR0BqbEtxG3nw41ZssaXYUg+CHOaJSdWhrFsF1uJh5tI0Dq
         16BnQZWO81aN+tvtJRQavuy3kts6YA4HOIscrhU70Uq5A5MduYEansXTUBxhAQMhdriO
         J9UuGnB6GT5yZQkkcVCW/It5f1cvyTPfZg7KyD73MuSwwNtBVK1jj9sAd/22lKVC/R6u
         BPPYC8mk3fYKBtmg5MNSqHtewWe51R7CGJ4F5aY/XhtJnSFFSCoD+uET0bJJuPE76+bc
         unJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682041309; x=1684633309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBqsOzJXMqZz87HaUvjwXwIt5Yf5VZ43MrT/J+SNaHA=;
        b=lMGWU3OWhnVovMe6ZmK14x3UrlBfgrOdam+D41gjDJln1C6k7YSac03LTbDKrwfukO
         uGEyEA4fOqU/Uz/lF0mMVPoXTBnlOYrKCaFkG3+MVbN77L0WETwU1lYNSwVERZZCYtkL
         tjYMnrp9fK2Sy+Gd3svJH87y4uyYetXaEuZzHTRO3pLpFe2nKPPVSwTnSPSDBFgLrWqD
         Fg9ZkxCMTMznp5REJVTuOMafJH6TfdtO+IVpV2Kbz+EzfS5OOeT6hxdaz3lNE6XljpDI
         1XmL9KESxpwgVDpBL5GI8BGVB+bfn2muTd5tZoORITTwbLnXUrL2u+qUQgtfz0hVtYtf
         /3OQ==
X-Gm-Message-State: AAQBX9c6xWtidnGVc0RpERYH+8+lJplHprhHAm0BnX4rXC2okVmmp2To
        edtpQAzUREz6nZC9Tx8lVWCRfl7bwT73xtm5uz/6DQ==
X-Google-Smtp-Source: AKy350YBmPf4UT7+Sv9FBtNv6x75XVeri6923gVAwbzyY1sqQ4aSiLgDLLBLvliUBPKzFSGfTV0H8S0pdRx2oeUV3X0=
X-Received: by 2002:a17:902:e84c:b0:1a0:450d:a481 with SMTP id
 t12-20020a170902e84c00b001a0450da481mr4112675plg.35.1682041308506; Thu, 20
 Apr 2023 18:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <CAOQ4uxhpFrRVcviQ6bK1ZMtZDSMXRFuqY-d_+uQ1C0YMDtQpLA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhpFrRVcviQ6bK1ZMtZDSMXRFuqY-d_+uQ1C0YMDtQpLA@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 20 Apr 2023 18:41:37 -0700
Message-ID: <CA+PiJmT1wCoGnqtVSfcM-0qKm=Vu-jPf=7Op90vcGo3A7kYr0g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
>
> Which brings me to my biggest concern.
> I still do not see how these patches replace Allesio's
> FUSE_DEV_IOC_PASSTHROUGH_OPEN patches.
>
> Is the idea here that ioctl needs to be done at FUSE_LOOKUP
> instead or in addition to the ioctl on FUSE_OPEN to setup the
> read/write passthrough on the backing file?
>

In these patches, the fuse daemon responds to the lookup request via
an ioctl, essentially in the same way it would have to the /dev/fuse
node. It just flags the write as coming from an ioctl and calls
fuse_dev_do_write. An additional block in the lookup response gives
the backing file and what bpf_ops to use. The main difference is that
fuse-bpf uses backing inodes, while passthrough uses a file.
Fuse-bpf's read/write support currently isn't complete, but it does
allow for direct passthrough. You could set ops to default to
userspace in every case that Allesio's passthrough code does and it
should have about the same effect. With the struct_op change, I did
notice that doing something like that is more annoying, and am
planning to add a default op which only takes the meta info and runs
if the opcode specific op is not present.


> I am missing things like the FILESYSTEM_MAX_STACK_DEPTH check that
> was added as a result of review on Allesio's patches.
>

I'd definitely want to fix any issues that were fixed there. There's a
lot of common code between fuse-bpf and fuse passthrough, so many of
the suggestions there will apply here.

> The reason I am concerned about this is that we are using the
> FUSE_DEV_IOC_PASSTHROUGH_OPEN patches and I would like
> to upstream their functionality sooner rather than later.
> These patches have already been running in production for a while
> I believe that they are running in Android as well and there is value
> in upsteaming well tested patches.
>
> The API does not need to stay FUSE_DEV_IOC_PASSTHROUGH_OPEN
> it should be an API that is extendable to FUSE-BPF, but it would be
> useful if the read/write passthrough could be the goal for first merge.
>
> Does any of this make sense to you?
> Can you draw a roadmap for merging FUSE-BPF that starts with
> a first (hopefully short term) phase that adds the read/write passthrough
> functionality?
>
> I can help with review and testing of that part if needed.
> I was planning to discuss this with you on LSFMM anyway,
> but better start the discussion beforehand.
>
> Thanks,
> Amir.

We've been using an earlier version of fuse-bpf on Android, closer to
the V1 patches. They fit our current needs but don't cover everything
we intend to. The V3 patches switch to a new style of bpf program,
which I'm hoping to get some feedback on before I spend too much time
fixing up the details. The backing calls themselves can be reviewed
separately from that though.

Without bpf, we're essentially enabling complete passthrough at a
directory or file. By default, once you set a backing file fuse-bpf
calls by the backing filesystem by default, with no additional
userspace interaction apart from if an installed bpf program says
otherwise. If we had some commands without others, we'd have behavior
changes as we introduce support for additional calls. We'd need a way
to set default behavior. Perhaps something like a u64 flag field
extension in FUSE_INIT for indicating which opcodes support backing,
and a response for what those should default to doing. If there's a
bpf_op present for a given opcode, it would be able to override that
default. If we had something like that, we'd be able to add support
for a subset of opcodes in a sensible way.
