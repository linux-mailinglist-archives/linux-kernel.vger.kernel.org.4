Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F3696C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjBNSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjBNSBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB222B60B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d40so17369142eda.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iygKktnt78admSofr0NrLyYem4i5NC0n/qOyUNQkxrc=;
        b=Ld3T1psNhe2zf6nzM1vI/9qLBaMvZ1LjAW6Lx8KE0oeopTK8GSSBPkTjcrp6X97r95
         XyTU/NHAZ1zZA5dk/CjRA2H5kzFJZQebw7uVTZsarrFMLuoJzoF5lASNtsoRJ/KHEjgj
         QzUyxsUkK1mpnOIS9Q3GlNnJsFG1nFk4l1UNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iygKktnt78admSofr0NrLyYem4i5NC0n/qOyUNQkxrc=;
        b=Uh7Zv4YmornseTehMKIUrOBXkLziTVnFFb01XEDwAxrv+vHlMO+uyFzKotRqpYrRWj
         W6+8BChNxiLHyG2tP7qAdQ8mKbx/rZfqoOjTXis1uLJWDMxncRrg+Zb6up/CBQlb1GRT
         3cuBpn5KKRvUP4mCg1s410vf67YeDOjKLi5P5dtKHo+dvyZMcujCQC5Q1wK75soGlS4I
         Qe/i/uikxW4lL3DGLe9F/MvN086C7tkUn0fNKX5uSDA/YRxEISjg0rd83GQZI806aKKl
         ItM/cuuoo718kENRLdQfPKnMbJadxgfTxu9xMjhCoErWWm5NIS8oqkOffr3ubNOuG+1E
         18Yg==
X-Gm-Message-State: AO0yUKUSjppW7D09c5zzkfliidjQH05RvK1tXvxMmCX4BpnlkPkWJk2I
        VSv7v/P/NqC/J5eVQrJilDQJUUOKowO25MuCHww=
X-Google-Smtp-Source: AK7set+u9j0eDOGGRAWHdzbHiUZS7AdAAgtNMauNLXsSCT5/mOIoVMUEnj6j5lQdTnZ+iazMYSvgNA==
X-Received: by 2002:a50:9354:0:b0:4ac:c635:8e03 with SMTP id n20-20020a509354000000b004acc6358e03mr3070556eda.37.1676397661919;
        Tue, 14 Feb 2023 10:01:01 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709066d5500b008b13039003csm1082220ejt.166.2023.02.14.10.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 10:01:01 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a3so8107601ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:01 -0800 (PST)
X-Received: by 2002:a17:906:5a62:b0:877:747e:f076 with SMTP id
 my34-20020a1709065a6200b00877747ef076mr1697272ejc.0.1676397661032; Tue, 14
 Feb 2023 10:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20230213010020.1813-1-michael.christie@oracle.com>
 <20230213010020.1813-5-michael.christie@oracle.com> <CAHk-=wj0oA0VV77eAgMYFSJm7SBQ15vDLFjcFnNvWrbCRXXSpA@mail.gmail.com>
 <4bf04d5a-c45c-dac9-705f-c7a0adfd37f3@oracle.com>
In-Reply-To: <4bf04d5a-c45c-dac9-705f-c7a0adfd37f3@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Feb 2023 10:00:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe1g=U3N6Bh93E=0HAosUSipnrmE2g4nFMPfssq4KdcA@mail.gmail.com>
Message-ID: <CAHk-=whe1g=U3N6Bh93E=0HAosUSipnrmE2g4nFMPfssq4KdcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kernel: Prepare set_kthread_struct to be used for setup_thread_fn
To:     Mike Christie <michael.christie@oracle.com>
Cc:     brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 4:50 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> I could balance it by doing the following which would support vhost, io_uring sqpoll
> and kthread's name setting:

Yeah, so this patch looks like a real simplification to me, and avoids
the different users doing their own random task name handling.

Thanks,
           Linus
