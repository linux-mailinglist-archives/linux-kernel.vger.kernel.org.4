Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81795F5AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJEU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJEU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:29:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9794F271F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:29:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s2so133182edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Poen6yISP0M2ySyDXJTla1arHaCuw6dM2gnnJZIpk=;
        b=nv4LN43x37ei5cSd/zX+afzYMuCvOJGrL+N3rqvg4KKJtRprnHKooTvMSGSpE8tRWf
         fdHEmPmFIrHPKURblhdkZ5V8KNY+F8lDFM2RAhIlxoygrkTDlk+WtFxgCkB4uDKpanMk
         +1rK9JGjdGSInp33xZIDrZzPP/Zr6QYb7pN12lj/7KIDkRQwH/KQSW16GQH25tVGNo6s
         ZL+rODBnXHlIeS/XmalTzYVtJaLSKrl6HpHKvJ0q43KfdEw/S+jNQ74JVAZvu4GECS8J
         uyyRKCDu6JN4MXKC4qSXPK9bQ4ieJhdLmRMFObdY6SITqUmOou+FS8r3MuLuPe1k7X9M
         eQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4Poen6yISP0M2ySyDXJTla1arHaCuw6dM2gnnJZIpk=;
        b=gBMyzIaP91bf7M0FTqVoXd+HAhGrlrDj+Jc3xL2ig5rFGiZCkwXEG6fYeVSJUGyXSZ
         eLnsKbuBu/okStNcwiXUPEUVrr4fL0G1yM1vCU1VDojAAVqoCazLF7tQM4H5VeKD3PJs
         eo50hxTkXuWHzhH37Yftii7mZoCBw9P+rsRJOJOxnv66Mva8kj/xTLNMeOdxss1uJIiD
         v3w02J4Gxu9C1i7J1hrh8EzDc0QQLafrNzmGGEUS0RC0R2OsT2no7d/2e98ZaXqTCdlm
         qSZMFM5P3+XLjO8z3REz4SQz5I82byZxwaGEXzzNtLiSQlYW/WcCpMmJkoUtgCNSC4jT
         +7NQ==
X-Gm-Message-State: ACrzQf3/YYjk/MBHaHcLP5uN/UYcuJrXXomy4KRvL7hdI4yW9XQMXiNz
        Y2oogR65NnuFcREShZMzO/3ij4X0GMH3hgNRCBeJDw==
X-Google-Smtp-Source: AMsMyM55YAoYQA7BeOEG2HhT1mPC4gHA/gUc6VckANG8wkCaqHQsmaY3Oc9LccLPVT/ld9va7xDoUOkU3ZNp+4jbqwk=
X-Received: by 2002:a05:6402:3890:b0:451:ef52:8f9e with SMTP id
 fd16-20020a056402389000b00451ef528f9emr1393020edb.107.1665001749012; Wed, 05
 Oct 2022 13:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:28:57 -0400
Message-ID: <CAFd5g45B4+xZeFHp6nWPca0udk1xkAatiJAu2Y7z2tsYVi9E1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] kunit: string-stream: Simplify resource use
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Jul 22, 2022 at 1:15 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: David Gow <davidgow@google.com>
>
> Currently, KUnit's string streams are themselves "KUnit resources".
> This is redundant since the stream itself is already allocated with
> kunit_kzalloc() and will thus be freed automatically at the end of the
> test.
>
> string-stream is only used internally within KUnit, and isn't using the
> extra features that resources provide like reference counting, being
> able to locate them dynamically as "test-local variables", etc.
>
> Indeed, the resource's refcount is never incremented when the
> pointer is returned. The fact that it's always manually destroyed is
> more evidence that the reference counting is unused.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
