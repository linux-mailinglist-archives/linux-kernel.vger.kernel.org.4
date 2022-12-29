Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E2658A60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiL2IQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiL2IPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:15:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684113DDA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:14:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so43382165ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf4Oclx/s2DatfZfaRbzTJQI1IZBAeRXW5JK4LTSla4=;
        b=NU2n1cZSHmMnwavRmjaGTIOlZm9KKoVlTctPjkyNTmZUljpRpEn9h6P8v4Hs9lilpI
         mkCIQ2k2l/xfRvQXQ69rAtGkTcoyANDRbInSespNg/TQMBEiJJphNIESLhmtweJP/7+h
         Wp7m19/xGESByGcjrF6tidvzavgdhhzaF0/Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf4Oclx/s2DatfZfaRbzTJQI1IZBAeRXW5JK4LTSla4=;
        b=e9ydlu1acKIky886OWdUhkHFDKkGeAB96gaUU9jyPA+7mYqbttp6jj2AG1Ic3oGklq
         rQq+gPROXyEDxwpYOsX7yRDXfeldQ57S2Tv+Szhne0P19717udobNLx72qtD8synwnTc
         ezRbBE9qev1RR6Vsp5Zbe8wJgOrSKxtE51JCOfksiIbEpJhZTnNXKzpSbihklsZJPmUt
         nvhzWGw18NiAb5i9R5L0lbl1x+WqMN9OGW4Bl8/H6lXIjG2JVN2wyRdO2/1BrdR+CJQ6
         u9+wJak2/AsMofmiNdr92hypmRcMFgabZxvZFKb64jrHiFBh5OEENGXyvl32DKy/J0PM
         rEuw==
X-Gm-Message-State: AFqh2koCWnwHxutvKbtEBBqphSpINQwFJlndlm2Q6/WzqOvEQOWm2zKk
        HbidQJsCKiFb+LHaE2bSkOkP3Zh4MOePQe/t4nl+NQ==
X-Google-Smtp-Source: AMrXdXs300Z+BXOJPxEJlPkjyVUzSJVOjoySN3yowIHivu+kDMNajS+vq938RArP6B2ta87auqxQOwl3KblSmt1bED8=
X-Received: by 2002:a17:907:c013:b0:7c0:eb3c:1037 with SMTP id
 ss19-20020a170907c01300b007c0eb3c1037mr2068068ejc.663.1672301676050; Thu, 29
 Dec 2022 00:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com> <Yy1yOGy7yF4AShDB@infradead.org>
In-Reply-To: <Yy1yOGy7yF4AShDB@infradead.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:14:25 -0800
Message-ID: <CAG9=OMOLLjVJHTPmDSPM3t+Ko90CcN5C01UhEadZReECUE5umw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 1:45 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 20, 2022 at 10:54:32PM -0700, Sarthak Kukreti wrote:
> > [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> >
> > would be predicated on the guarantees of fallocate() per allocation
> > layer; if ext4(1) was replaced by a filesystem that did not support
> > fallocate(), then there would be no guarantee that a write to a file
> > on ext4(2) succeeds.
>
> a write or any unlimited number of writes?

(Apologies for the super late reply!) In this case, even a write won't
be guaranteed if we run out of space on the lower filesystem. Looking
at the fallocate() man page, I think the key part lies in the
following phrase (emphasis mine):

```
After a successful call, subsequent writes into the range
specified by offset and len are guaranteed not to fail _because of
lack of disk space_
```

So, it's not a blanket guarantee that all writes will always succeed,
but that any writes into that range will not fail due to lack of disk
space. As you mentioned, writes may happen out-of-place in one or more
layer. But the fallocate(FALLOC_FL_PROVISION) ensures that each layer
will preserve space for writes into that range to not fail with ENOSPC
(so eg. ext4 and dm-thinp will set aside enough extents to fulfil that
promise later on for all writes).

Best

Sarthak
