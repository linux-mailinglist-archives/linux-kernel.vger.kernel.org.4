Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE676C3937
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCUScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:32:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F14DE0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:31:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so17761970edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679423513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rarCJTaTo4fdrlFa6VngK6oUmjz7+X/mzHPYdyRgEGI=;
        b=FF1iHk/5Gnr8aDscZUit9Y8GtXIQAL1e5mjGc2AbjwpZTDOWsV8MomqzMfskU2blnF
         jmgmomSxcT8rAbFK2fSSYTEs0Hx+ZkUdL++GsJuGjv1xJzo9K3QX8dX2PV34A7FHquep
         x2+CXrgMgneDP3vHP+8mC3TlA6H/uZyKBD1tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rarCJTaTo4fdrlFa6VngK6oUmjz7+X/mzHPYdyRgEGI=;
        b=SIXzGPa1qZwVPqTyats/AIzGlWQlSXjXz8pRk7RxvdC7jCKygg4uBPY/jyC9QnvsQX
         CEJyHWU7LseJlMUoDOah5PbpFh9pZuIU/mq8HslgD4czsjFzD59Z2YPFq9bcgKM5ARUJ
         Ng/YFHCV3MuyL3u57B5S151uKmAFDA/k7Ya00yLuv0ji3Taiw6ym9tkJ5gJYIzpPau5D
         jl5jRt7K69QrFXY+GvOX6qRXo/9TsnVY7BMS7rpOvLLFtk5mN8NwOZvZagguzf4rvrr9
         XdVI2YwqhPH034lnKTSOSNIbs/L4h1Mluzd0FsBstgWRcoPfvhTQ3/swAXWRr9iDyGxc
         aZ4Q==
X-Gm-Message-State: AO0yUKXy5uofRkPWCScj+jmb+MV3eKEKZqPeWbZ/j+YZjBWDoEJsm6qw
        /3IXmVp+Tk0iwZWmktNaJuTSbuAru/mf9mEOwtdhpg==
X-Google-Smtp-Source: AK7set/1kW0s1t903fb/BIbriySDe8ONrSu/sf7I4ABkY/p9l7NPT9AovQKwh5zNLh6wy+wNKnCy8w==
X-Received: by 2002:a17:906:5046:b0:932:ba53:83ba with SMTP id e6-20020a170906504600b00932ba5383bamr3800945ejk.34.1679423513734;
        Tue, 21 Mar 2023 11:31:53 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906250600b009306be6bed7sm6072781ejb.190.2023.03.21.11.31.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:31:52 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id o12so63376579edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:31:52 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2384431ejc.4.1679423512122; Tue, 21 Mar
 2023 11:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230320210724.GB1434@sol.localdomain> <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
 <ZBlJJBR7dH4/kIWD@slm.duckdns.org>
In-Reply-To: <ZBlJJBR7dH4/kIWD@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:31:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0wxPx1zP1onSs88KB6zOQ0oHyOg_vGr5aK8QJ8fuxnw@mail.gmail.com>
Message-ID: <CAHk-=wh0wxPx1zP1onSs88KB6zOQ0oHyOg_vGr5aK8QJ8fuxnw@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
To:     Tejun Heo <tj@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:05=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Do you remember what the other case was? Was it also on heterogenous arm
> setup?

Yup. See commit c25da5b7baf1 ("dm verity: stop using WQ_UNBOUND for verify_=
wq")

But see also 3fffb589b9a6 ("erofs: add per-cpu threads for
decompression as an option").

And you can see the confusion this all has in commit 43fa47cb116d ("dm
verity: remove WQ_CPU_INTENSIVE flag since using WQ_UNBOUND"), which
perhaps should be undone now.

> There aren't many differences between unbound workqueues and percpu ones
> that aren't concurrency managed. If there are significant performance
> differences, it's unlikely to be directly from whatever workqueue is doin=
g.

There's a *lot* of special cases for WQ_UNBOUND in the workqueue code,
and they are a lot less targeted than the other WQ_xyz flags, I feel.
They have their own cpumask logic, special freeing rules etc etc.

So I would say that the "aren't many differences" is not exactly true.
There are subtle and random differences, including the very basic
"queue_work()" workflow.

Now, I assume that the arm cases don't actually use
wq_unbound_cpumask, so I assume it's mostly the "instead of local cpu
queue, use the local node queue", and so it's all on random CPU's
since nobody uses NUMA nodes.

And no, if it's caching effects, doing it on LLC boundaries isn't
rigth *either*. By default it should probably be on L2 boundaries or
something, with most non-NUMA setups likely having one single LLC but
multiple L2 nodes.

              Linus
