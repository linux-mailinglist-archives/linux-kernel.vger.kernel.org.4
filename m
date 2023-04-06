Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5B6D8B82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjDFAMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjDFAMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:12:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE236A4B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:12:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-932277e003cso77595266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680739953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWqojSp8qeBF+mnrDb0v8Y1VEeoiQlSQ1yGGpxufYDs=;
        b=mmtf2AayBWm/z9sUCranjsDtUq8AxYpmX4yPfK4znmF2gMIODJ7tf13ZcvRf7XB84K
         AgOJLhfcSJpYEPHYwm5X0Fu3pt6ZBax5QjRsO69RzY2rTbyqiLNyDuId8qaErMGe3LMS
         iWF5PYWGarqFRVHJNktro71deVYVccaeWoaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWqojSp8qeBF+mnrDb0v8Y1VEeoiQlSQ1yGGpxufYDs=;
        b=C2Ko27EHGBZLLiVS99G2PCVHJqjKJjaa/89ii5NRT63GrNF9nktPjoOB0+qlicLxGf
         vrWfgOYRt3N0hYGpoQiN2yNJFnVybJOXpJbm3rUyfNAwkPhLUOx717BnzrRKVx5UEyDF
         RVbGCaWJQ5s36evXb4kVhizcNx3YVPJCGFejFafT5Q6VNGJKRsWlNYztIfTTMC6xgXk4
         5sCZIBJEfYwp1e5Ez5lsnOh/vXbCs/AcxwWTaWQi4zBNz4bTJ+are6tZk6IYKANgsLnP
         yXugZOS+ROzufQiZXrDFRKMGQHNr09xI0v+PPYWo6NdRVhhHnxlzpLVQoVeXNRiv1UAS
         VAxA==
X-Gm-Message-State: AAQBX9cZfPdcDknnMLhS0vTb32uKqtqGq+aw5un5YNoxgMLNlsoa+lpl
        Sk8BoCElOpvIz0WvxXRQ/yVCub5hfVwZYO+WXs8y6g==
X-Google-Smtp-Source: AKy350bSg5cQf76vayF8cuTHt7hGbMj/aBgU/6HTmDSPmn/KXvw21Y1A4RFFgZK1jB9dW9Ud6Cu2kqEjEDgC+YjCXjw=
X-Received: by 2002:a50:8adc:0:b0:502:3c99:417f with SMTP id
 k28-20020a508adc000000b005023c99417fmr2041304edk.6.1680739953661; Wed, 05 Apr
 2023 17:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235920.7305-1-kal.conley@dectris.com> <20230405235920.7305-3-kal.conley@dectris.com>
In-Reply-To: <20230405235920.7305-3-kal.conley@dectris.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Thu, 6 Apr 2023 02:17:13 +0200
Message-ID: <CAHApi-kRav_7jpkyTf+Ko7LJwx6_UO+1QydoAr-fMqeyBE=OYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests: xsk: Add test UNALIGNED_INV_DESC_4K1_FRAME_SIZE
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add unaligned descriptor test for frame size of 4001. Using an odd frame
> size ensures that the end of the UMEM is not near a page boundary. This
> allows testing descriptors that staddle the end of the UMEM but not a
> page.
>
> This test used to fail without the previous commit ("xsk: Add check for
> unaligned descriptors that overrun UMEM").

Sorry I forgot to update the commit message with the new commit label.
If accepted, please change the second paragraph to :

This test used to fail without the previous commit ("xsk: Fix unaligned
descriptor validation").
