Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7F618CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKCXSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKCXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:18:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221E95A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:18:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so9159455ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nFukTkOw1gbW4oWy1dnnjZjTg02KMsHFw8GpjXtUYU=;
        b=geRfAiNqwqJECVjVtpvPh5ybjpsHLeWnh1QnALVgXWTQjFlb/Z0cQvQQ4/yQG4qQ8W
         NGbCmycbKo2k+riXNNdGIP4FXw2D2PKAZ68ecs2Gtq2Maj+ZMlrHLaV5DnH2sI8Tnqsh
         /Pd1th7/joC6KAYBLTaldAkqAMhJg1EitLf+TIKPllOfzF/Hsr1zAoKEAGihqSZOuFJg
         ZVNh6RIRYq3wmRyKf/HMfnBrtmLxiVan0NL/rHwzsowOMiWYsI7yUv4WGzI+9LkXKjRp
         vhCxhturzIsbZOtfnQ8RVpiSvbUz52uk5u/yxLAe0ch/8gBBBYOKOhLMKpqC3vtvFJP8
         asgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nFukTkOw1gbW4oWy1dnnjZjTg02KMsHFw8GpjXtUYU=;
        b=fLqsZSLG0jirFmMisOt4i3Prbb4voWlYqTMQPB1J/MFXD/SUVpMz1/iMLzR/p8/zke
         Oy4khOYEvpSVfDsx83qEzKndqJUO9Ya9WVT5AwSsWwU9TcELc4m8SfkUL6IBVNDKYbnm
         Fj4S0JW5WCyt3ejmBXwE3aJmiFukLojb0eoq1tkj8WJwRexZSYEMiRsWXQfTU0ylnhG9
         G/A+Krxvrum3MtoB4Z4+cZveO+dJ3UY0v/f1kWSl0rXAXT363PHmhGkqS0DaOvIXvUmP
         d4dkJLx4iuE2sqt2N5WQUMtDRk45RBfykeZpFpfGYoEeOfv1hqyaTrohguUOxFW+dPTj
         8/NA==
X-Gm-Message-State: ACrzQf0qKsMhKwHAgu2mMn05X7AgTHBedXd3AlOxLpHm2vMvuALkgECb
        1joM7yIooxeCjL8FLzk1lcST7bUUAoxb4g9xBWHphw==
X-Google-Smtp-Source: AMsMyM6hsn6YVhgFd5QkS0dns+dZWnGy8H25gQirK3LwhxHjBI+5T14PQQIwPtGB4ESce7EVy5loikiB2S+qGFbmHic=
X-Received: by 2002:a17:906:3f89:b0:7ae:35c9:f098 with SMTP id
 b9-20020a1709063f8900b007ae35c9f098mr53045ejj.303.1667517506498; Thu, 03 Nov
 2022 16:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221102163252.49175-1-nathan@kernel.org> <Y2LJmr8gE2I7gOP5@osiris>
 <202211021259.9169F5CBE@keescook>
In-Reply-To: <202211021259.9169F5CBE@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 3 Nov 2022 16:17:50 -0700
Message-ID: <CABCJKud+RJKeiPypej+s8bW506m7xCY97NLm7EkLzUp8fZiBPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] s390/ctcm: Fix return type of ctc{mp,}m_tx()
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Wed, Nov 2, 2022 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 02, 2022 at 08:48:42PM +0100, Heiko Carstens wrote:
> > On Wed, Nov 02, 2022 at 09:32:50AM -0700, Nathan Chancellor wrote:
> > > should s390 select ARCH_SUPPORTS_CFI_CLANG in the future.
> >
> > Yes, s390 should select that :)
> >
> > But, is there any switch or option I need to set when compiling clang,
> > so it knows about the kcfi sanitizer?
> >
> > I get:
> > clang-16: error: unsupported option '-fsanitize=kcfi' for target 's390x-ibm-linux'
> >
> > > clang --version
> > clang version 16.0.0 (https://github.com/llvm/llvm-project.git e02110e2ab4dd71b276e887483f0e6e286d243ed)
>
> You'll need the "generic arch support": https://reviews.llvm.org/D135411
> which is _almost_ landed. Testing would be welcome, for sure!
>
> Sami, do you have any notes on what common things were needed to get
> arm64 and x86_64 booting under kCFI? My only oh-so-helpful notes are
> "keep CFI away from early boot code". :P

You don't need to keep CFI away from early boot code, but bringing
this up in qemu+gdb initially is probably the best way forward. We
also had plenty of type mismatches in syscall wrappers in the
currently supported architectures, so that's another thing to watch
out for once your kernel boots far enough to start init.

Sami
