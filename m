Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A489712CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjEZSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEZSwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:52:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2C12A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:52:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso27371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685127136; x=1687719136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR4oeJqmOlTeZziilw2pYUhae8MRA2mQQoVrekapX1Y=;
        b=Qz+BYl7aT9JXo13xkBr+cg6STdDW/DISzgnu/3q2a7KyoW7PWXvRA5tR1QExlGRTMe
         dstv/G7jyoflL/mHoOp0kVBZwuvRLpIh57Sc684zPHJl7dYwyPE2eJ6B6NwhlvLyUZJc
         oCmeRsJKn8TkUAR0kPTPn7Oz1RPZDVjb+DbTlQ3PhC6IKW1bawvX6xZhoFwJcSUSKKDL
         j8RV15cRmPe4W6k17A6IBv6xodfpfVUFAmA/gK7L9CiIlcCk3qDkelwDFoKj6VNT4WLf
         5Zn2kSD17s4VM3Td2gDFJaEiJ8W7f1b7G/TYc9G/rkYTu+vH4ko6RDMRLg/C1DCc0yEl
         Zy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127136; x=1687719136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR4oeJqmOlTeZziilw2pYUhae8MRA2mQQoVrekapX1Y=;
        b=htHHBxisFC7Io5jwPIqqYAfSvh8vkvu18DVur4EnVo1ywRlleG9QfSzQn9PCjvQNjp
         OjvwgkBYGnDAFe/MEz4VuLusqsjmJkQB2Ec928fO38mZ0W45eCC63OARMjjnmMBwZVOL
         DGlfTzLd59394v1kKWOkjAUqZJf0ekpz1Wf4vR8y9Okl8sN/t9sWOsGwaeFrkqUQZdVd
         Hd/VZZ1QZbDU+IxAEoenKFP4Ldh7Y07sUFEq/DfYZ6RAj4rgcjJUSUA3dfcoZyXokTgA
         vdNj1nZkZ/lCFd4wsHCWNNx7SWVuFVwe2kYTXqa7PxSl3aLUMP2x5zwx3c5LlLI1jSh5
         Ei6Q==
X-Gm-Message-State: AC+VfDx1xRkKfIDOOsuNakoMqHW7poOtYNC27joWCvFjBYIMQJel3+bw
        VvENd02dXDmlwH5N6aG0ioKOV6YgTleq/i/pFg9m9w==
X-Google-Smtp-Source: ACHHUZ4M8DEI0Tdun8SLqksnPN4JKE0wIBIzq0MYbMAD1vEq1DPyQajDwvrOFQryT8+84i8dQvJP2sY44u/hWQ+/3Ck=
X-Received: by 2002:a05:622a:2d4:b0:3f7:ffc8:2f6f with SMTP id
 a20-20020a05622a02d400b003f7ffc82f6fmr22879qtx.28.1685127136612; Fri, 26 May
 2023 11:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526075355.586335-1-davidgow@google.com>
In-Reply-To: <20230526075355.586335-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 26 May 2023 11:52:05 -0700
Message-ID: <CAGS_qxqJeMDXA1b_MJrHSg8rGEM6K2UXqaxNVmwW_oQEFwQ1Xw@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
To:     David Gow <davidgow@google.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:54=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit aborts the current thread when an assertion fails. Currently, this
> is done conditionally as part of the kunit_do_failed_assertion()
> function, but this hides the kunit_abort() call from the compiler
> (particularly if it's in another module). This, in turn, can lead to
> both suboptimal code generation (the compiler can't know if
> kunit_do_failed_assertion() will return), and to static analysis tools
> like smatch giving false positives.

Another thought: this impacts
https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs.
They're currently calling kunit_do_failed_assert() always with type=3DASSER=
TION.

This change would actually make things better since they could handle
shutting down the thread themselves instead of having it happen behind
an opaque FFI layer.
But we'd just need to make sure we get that code updated around when
this change goes in.

Daniel
