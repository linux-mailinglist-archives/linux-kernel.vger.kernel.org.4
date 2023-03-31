Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BE6D275E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCaR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:58:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3712CDE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:58:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so92716660edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680285463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmoA6YUZCJuFE7TG8s09tRDr2zKD7Toe76fnRKIq27w=;
        b=BCgi6fr6icKXDUiNGJ572MAixJP9c4v1IxMZvrdTJ2/5+j/VtHqKYYyS+wYawJiw5s
         XxjPuddKZr3yhflHrkTU0mX+AufNzkfEaSgriJuW0d8gJoAs7kb2Fdw1QV/pQTsUIOGa
         YBihBYSQz3WnQK0svjpsGWdUstjgvWi+qh++Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmoA6YUZCJuFE7TG8s09tRDr2zKD7Toe76fnRKIq27w=;
        b=NQn/9/oFVZzRoed9XcI8fgvbdfrwEis9uwhp/Wot0xVNlUfSl3kay5Zz8JoLFz53CK
         qhaWewYcu5UVi2WG5NTUcAmeG7glybt0sJHH4I8he5d9ZXbK5Uyp9kfybnYgiOLIjbNY
         ULgoEHHdxqxwH9J9TghYozowm7qcnnnq5DCEC7haeUJLPPuIiV4uGaPfy6nfZMtkq4aY
         HNFTw+sA7rvn2iKsWdU5gaOoj1F+QjbzFgX5bkQV/LmTHx7se371UDDiGtUsibpqvzud
         XDf7JU+LIqaFiyAPivgjT9+ri/0Z2gbNXcdh8EeKrSnt/36LPEUSdBTbVNEFULLEnMZB
         wp9A==
X-Gm-Message-State: AAQBX9fRIb1/kMmDkvbRefoiZ+wUQs5o/Ddp1DgryZt+gjYQD8F7VjzU
        BqKf6wRg40laP+Ebhxo0k+IzHqsFCjzeLFqfszW2zA==
X-Google-Smtp-Source: AKy350YYCPiBVPLSqvXpA7SIqoM2KOMWC8vnXBX4J35UNx4Agw4GP7P/RQw0fS2gx91b4vfBzTrv1w==
X-Received: by 2002:a17:906:a3c4:b0:906:3373:cfe9 with SMTP id ca4-20020a170906a3c400b009063373cfe9mr29833506ejb.10.1680285462994;
        Fri, 31 Mar 2023 10:57:42 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906595400b00932ebffdf4esm1183262ejr.214.2023.03.31.10.57.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 10:57:42 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id eh3so92742696edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:57:41 -0700 (PDT)
X-Received: by 2002:a05:6402:5241:b0:502:6e58:c820 with SMTP id
 t1-20020a056402524100b005026e58c820mr4585387edd.1.1680285461441; Fri, 31 Mar
 2023 10:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <202303312259.441e35db-yujie.liu@intel.com>
In-Reply-To: <202303312259.441e35db-yujie.liu@intel.com>
From:   Daniel Verkamp <dverkamp@chromium.org>
Date:   Fri, 31 Mar 2023 10:57:15 -0700
X-Gmail-Original-Message-ID: <CABVzXA=+7wF4=NWxi0x57YSNs1Mpp7pJCODvyC6JRn9tQQAGLA@mail.gmail.com>
Message-ID: <CABVzXA=+7wF4=NWxi0x57YSNs1Mpp7pJCODvyC6JRn9tQQAGLA@mail.gmail.com>
Subject: Re: [linus:master] [selftests/memfd] 11f75a0144: kernel-selftests.memfd.run_fuse_test.sh.fail
To:     Jeff Xu <jeffxu@google.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 8:05=E2=80=AFAM kernel test robot <yujie.liu@intel.=
com> wrote:
>
> Hello,
>
> kernel test robot noticed kernel-selftests.memfd.run_fuse_test.sh.fail du=
e to commit (built with gcc-11):
>
> commit: 11f75a01448f1b7a739e75dbd8f17b844fcfc510 ("selftests/memfd: add t=
ests for MFD_NOEXEC_SEAL MFD_EXEC")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-d4cf28ee-1_20230110
> with following parameters:
>
>         group: group-02
>
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Sky=
lake) with 16G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
> # selftests: memfd: run_fuse_test.sh
> # Aborted
> not ok 2 selftests: memfd: run_fuse_test.sh # exit=3D134
>
> $ ./run_fuse_test.sh
> opening: ./mnt/memfd
> 8 !=3D 40 =3D GET_SEALS(4)
> Aborted

Hi Jeff,

I think this is caused by test_sysctl() in memfd_test, which sets
/proc/sys/vm/memfd_noexec to a non-zero value and does not restore it
at the end of the test. If fuse_test runs after that, it will
unexpectedly get F_SEAL_EXEC in its memfd seals in addition to the
F_SEAL_WRITE that it intended to add.

I'm not sure how kernel selftests normally perform cleanup (e.g. an
atexit() hook to make sure it cleans up if a test fails?), but at
least we should probably set /proc/sys/vm/memfd_noexec back to its
original value after test_sysctl().

Thanks,
-- Daniel
