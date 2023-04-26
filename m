Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AEB6EED20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbjDZE4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjDZE4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:56:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83042709
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:55:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7606ce9b213so581562339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682484951; x=1685076951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z77Lp99KgcT2Wl/yW+5859xGJbOMQeZV3ZO2k95WTCU=;
        b=VLk8VpQu6VEqBB7XqGIgB69IlX3h8NQYLDTRFECqcCsPskaZ6J1TJrMxr1f1bUHXhu
         k9LdOLzuHBz8iR+3f8hu8vok/4fA10PLqQaqqQA6otP71gVO4bO9oAv+H4HwhYRBUv+q
         t2EMkIu9qSlgL1MnFJGN5XFv/vsoGgCrF1uTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682484951; x=1685076951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z77Lp99KgcT2Wl/yW+5859xGJbOMQeZV3ZO2k95WTCU=;
        b=Uq1u7fFZrFQw+9SOo1leD780EleYTrXEUKEaNBgtRtF2zffus/lhDwRd6bIPJ3+ciC
         CKoxYQzYqzIPv54UEeUiNs/2o0TuWcCtVNupTYi+q/jDd98F/PZly2+PPiaRvGidpWF8
         8qvpSkAbOTmadJ1y6b3Pr+W9a7xHstaKmRJGaP8J4CdP/lzrhGB4i4ebEFN3/nBL3zuI
         /yPesKS7q7P8Y089em+kq+oypGUr6HHBtz5xI5WGG/r/diovWBRRRPiQkuK/pCGpn/Lf
         7Rusvx9XJq3K14gOh91uCim/7Dw5afb+iHLZExosdjztuXKet1DMnhRsxLK2bK00n24S
         TKSw==
X-Gm-Message-State: AAQBX9fbmaFs0RDztktu+2UezxIgqXzhLwr/rhn9O5Mx1UbwdtFS83mw
        DExj2OMCG0lePW81Bv2F8/ddhx+EzKW9lri1nmE=
X-Google-Smtp-Source: AKy350YnSessS7mK5r+R0jMPTdLSBHSZ3t6oRr5IPmJLJvEXKILw33Lq/Uxp7yNe5yYEK95wJxpNtw==
X-Received: by 2002:a6b:ec0b:0:b0:760:e9b6:e6d9 with SMTP id c11-20020a6bec0b000000b00760e9b6e6d9mr9021343ioh.1.1682484951149;
        Tue, 25 Apr 2023 21:55:51 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id g13-20020a5edf4d000000b00763da065395sm1305808ioq.3.2023.04.25.21.55.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 21:55:50 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-325f728402cso198945ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:55:50 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bc3:b0:32a:db6c:d51d with SMTP id
 x3-20020a056e021bc300b0032adb6cd51dmr192042ilv.12.1682484949689; Tue, 25 Apr
 2023 21:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com> <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com> <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426044207.2378-1-hdanton@sina.com>
In-Reply-To: <20230426044207.2378-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Apr 2023 21:55:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UE=4-oR5hvUMt0e1G5a4bbmzcQGPs9LkjTVasWwV4uBA@mail.gmail.com>
Message-ID: <CAD=FV=UE=4-oR5hvUMt0e1G5a4bbmzcQGPs9LkjTVasWwV4uBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 25, 2023 at 9:42=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On 25 Apr 2023 07:19:48 -0700 Douglas Anderson <dianders@chromium.org>
> >
> > So is this an explicit NAK on this approach, then?
>
> Ah I see your point. You misunderstood because I dont think NAk is needed
> in 99.999% cases, given the fact that 1) your patch will never be able to
> escape from standing ovation 2) every mutex_trylock() hints the straws in=
 mind.

I'm afraid I'm still super confused about what you're saying. You
think I should abandon this patch series, or that it might be OK to
continue with it?

-Doug
