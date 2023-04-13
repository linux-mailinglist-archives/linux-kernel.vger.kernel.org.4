Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900356E0D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDMMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDMMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:38:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151793D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:38:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ga37so37406829ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681389528; x=1683981528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80XOupwEydImNFImNi9YzwZQAYrfVPalPz/6koNH+OQ=;
        b=WbVa8mtEKFuN8Fzn/sc1Ag//M4u6Tv5kyOLYzxXpgsNB3kQOvmss8fAbTSfgYAqrXz
         Nz2gdQrelH8JdEkKyk5V5QhlHd6mtgGgZfhNjAaLYa7ccyQIzf/kcqgdvMsMWuqpmwbm
         3U3PuUG+M0Cm9IQC/KXg12OKTeqLLiws1BHfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681389528; x=1683981528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80XOupwEydImNFImNi9YzwZQAYrfVPalPz/6koNH+OQ=;
        b=FrVQTZ9EvZD9GzonKnL9OU/gSL+if1u0f0jnvWgRvwrva0/El3zKiJQa212yIP8mj1
         Bjd48UxIAZvpZoARuWzGqAdNIUTL8H7ew6Uz/Xd0QTqPnTclR6dr9RBrePExnMpRgLFe
         qna7QaU1ZCJJVJyXlajFOoBV0KqGPVwXZQcbGGJBRETsPkKiAcYfLQRm/0WPTtNckAaA
         VSJ2dTnMmr/RzVqKg+CV6QNKzOj7WJe9JiuwQKrJT13KmSgj3y97AXfmgGA4gvlC1ONj
         h04kXsJuYgTI8WM3FFGXYdjppfLemBtYKhdExJO0fzjn5wOM5ZhwHHAfzCmme8vLahuy
         +EGA==
X-Gm-Message-State: AAQBX9cUZUOnRbh6BpXusEGUNSsCUjWaFTfZK46qWIxF2hEXHJU/C+Aw
        466QiAySC25/ARKkgqI13cOXO44UdVHBcj1WfZoqJg==
X-Google-Smtp-Source: AKy350Y86kypZ6iuf2r0dmwP5DoiggvZU1uQ7oDQ8/09NxbbY91pFRClYxEJzsMHwUVBAs0KUgj6mQs5p9MZGnzV/BI=
X-Received: by 2002:a17:906:d298:b0:932:1bdf:be3e with SMTP id
 ay24-20020a170906d29800b009321bdfbe3emr1232299ejb.0.1681389528500; Thu, 13
 Apr 2023 05:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk> <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk>
In-Reply-To: <87ile011kz.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Thu, 13 Apr 2023 14:43:32 +0200
Message-ID: <CAHApi-m4gu8SX_1rBtUwrw+1-Q3ERFEX-HPMcwcCK1OceirwuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, you mentioned yourself that:
>
> > The disadvantage of this patchset is requiring the user to allocate
> > HugeTLB pages which is an extra complication.

It's a small extra complication *for the user*. However, users that
need this feature are willing to allocate hugepages. We are one such
user. For us, having to deal with packets split into disjoint buffers
(from the XDP multi-buffer paradigm) is a significantly more annoying
complication than allocating hugepages (particularly on the RX side).
