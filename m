Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F86E1C41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDNGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDNGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:15:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C25271
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:15:14 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A33B23F447
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681452909;
        bh=4x1ielA7OU/wWOjnJ79+3XpTDh/ue6rRtFlaiIdzFqA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=JDwuh2/Lfz1Jwh+sCxY4uiruBUrTtDijWoPVS4AW/NC5YCPwJiojL8eqriGtg4Mxm
         Uq/BKTre6AbPF9dDCPktc0hevj7kQ6Mhw5OHi4MHAaqZPxJfzw+pWw7EVoOX7wS2vJ
         kw8TMF85TTzG7fu7Ffx6T14HwmjUijh6ib9/DnBP2jdg1JTVHR558+etFN6u7YL88O
         aUxTEVf09T10s3FnJ/7OQR8O38l5dOLCKYZ4wjeyRUALqQFZWWs3eFPXBTR9oDjyHz
         rH2ongiXhLFmJz+cXESXkDz7LlJp/HlyeaunLiVL8WvQzsamoGyzhvzvQG2zXJdEF5
         ClQV+vpBYhcVg==
Received: by mail-wm1-f70.google.com with SMTP id w16-20020a05600c475000b003f082eecdcaso6676960wmo.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452905; x=1684044905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x1ielA7OU/wWOjnJ79+3XpTDh/ue6rRtFlaiIdzFqA=;
        b=YwRT5xaIj/JqcLkHTbbCyt8ZU1Oc+kMTAjEGT0igtrMldPQOlNhWMst0MG2E4dSFev
         0DcXuruD+T9zhBLup+hnY5pCUUAVGJyI4HSmIulIIhUG+zs7p4XZj3q+Iupvi5qyHG0k
         nPeyvRL1gcwhmk07bdPygLGbnj7yMrAj+kMbqWV8OMiGjtYH1qZm6EsEEROXAnwmma4h
         P5qqor4ggtDf0EluLYP3jN0VUPAYql7muVF/pQ4uHwgxY5f91JDsj3JKwboMS4U9yCiz
         19RWCqLt5007umNZW68Kn7XYg5FJ1AtPjwtKKKtu8ktCpNv4ZmVX+AunUwRED6X1Thq/
         kfWQ==
X-Gm-Message-State: AAQBX9coUWsgAS7+moQwNMLcisPRoyc2zRW03m5yR8VumOhV0VMmXN/i
        yg5ugEfGt2gDSOsGvQSQ6KaLo4Wy8lJRNqCRhGvqb31SMm9ZgoYWD6QDff9uodtEPWbIuYQxBFr
        ZwpEeQhXdqPPniyEFXRa9iV2sjluAsRcwoX/qWpiVDA==
X-Received: by 2002:a5d:4949:0:b0:2ef:b977:ee3a with SMTP id r9-20020a5d4949000000b002efb977ee3amr3214594wrs.34.1681452904876;
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZMWU0obXURDtM8C4VH2fQ+FRH6qv3QJQSMmxiEYCANgKRxwrF1qmRXzaL3awQ3sa15QW1Pzg==
X-Received: by 2002:a5d:4949:0:b0:2ef:b977:ee3a with SMTP id r9-20020a5d4949000000b002efb977ee3amr3214570wrs.34.1681452904560;
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d4911000000b002e55cc69169sm2794289wrq.38.2023.04.13.23.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:15:04 -0700 (PDT)
Date:   Fri, 14 Apr 2023 08:15:03 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
Message-ID: <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390>
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 12, 2023 at 2:59 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Building bpf selftests with clang can trigger errors like the following:
> >
> >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
> >         s = &nlk->sk;
> >           ^ ~~~~~~~~
> > 1 error generated.
> 
> I cannot reproduce this and BPF CI doesn't complain about it either.
> What kind of clang do you use?
> Some special version and build flags?

I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special build
flag (unless Ubuntu enables some different default flags, but it
shouldn't be the case... I'll double check).

-Andrea
