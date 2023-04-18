Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51756E6DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjDRVVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjDRVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:21:09 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE095B8B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:21:08 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fc337a650so224193847b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681852867; x=1684444867;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWdLrM8P5tKlvuJeK/CWoUbY/57OR2hY93j5YcDXvNw=;
        b=rIRTptJwMR9RNS5QlyMl2+kc/TA94WPxxo3f17+iyobEdC0e4rGfCX48D58F9wRJ6F
         si1gyr55NBY4UOviXN1eiHhiQaxYaHuCE5ioCUOVyPjoa+XkSyUu9t8L8sKz7wWAYekm
         zUYRulerwJQcUyMI4D+11I2DEmWz4gCwDJOkEc7MKuDG+DfQ7y0+dsiRfgCNNXmsyJKN
         FfZEw0TtwsR66InOJ0KmbpMkRLVFOFAg4qhbyP4RBveRx3xAkk8RGmBURRUscz64s/1u
         B2dmhngysNOAXtqHSsnNtwNy33v9E1TaHdNjoCQdIFR/tZbAX3SUBDDThd7CqDADtK7e
         iavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681852867; x=1684444867;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWdLrM8P5tKlvuJeK/CWoUbY/57OR2hY93j5YcDXvNw=;
        b=kFF80Qzx/EK52wCuZkoPdUXY+Zoip0B4960ciifkYO3akJa2yCo5gVaI2mx3APqx5l
         E/066w4ltizuEtbXC5sXt7lV/U97nkaMjHZQ8EHaF10Ozob3H0QNPOqHbVA76VqlAFOa
         8xR8IW0mpCZmUUakK5OMiwcHS8Jy9m/i94D6Ba+NH1qnlGw1CdrGB6SQtexvrvgAhAGE
         TzURrzjsy3uOGuatZi4p/U6QhBDwWTqYbXuI9bLHPLj/KXISE+Xk8s05GefMt9KXQCNw
         6NiCuThQ77OalaTNQIu+m6zeENb5idQzpQomc6x+S71kcHFuBNQygh6LYgR9utlC4mrh
         s37w==
X-Gm-Message-State: AAQBX9c1pwK9HY5fukU6Pa/N4VXuqNR0czG3w3KY04+ycTUwJ0cHjKGQ
        Uo6syqTOpAsErA2kozkesZbsig==
X-Google-Smtp-Source: AKy350aPT69etndT9Y5DXnIKWAPOkeuFizCReXExgc8GViiHUiiYdlDYCcOditcCtgaKdDHGXYA48Q==
X-Received: by 2002:a0d:d597:0:b0:54e:f0d1:e3e5 with SMTP id x145-20020a0dd597000000b0054ef0d1e3e5mr1346873ywd.24.1681852867289;
        Tue, 18 Apr 2023 14:21:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l15-20020a81700f000000b0054629ed8300sm4054543ywc.80.2023.04.18.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:21:06 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:20:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, linux-mm@kvack.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 4/6] shmem: skip page split if we're not reclaiming
In-Reply-To: <ZD8HdxbwhUUGvmNC@bombadil.infradead.org>
Message-ID: <8afe1f7f-31a2-4fc0-1fbd-f9ba8a116fe3@google.com>
References: <20230309230545.2930737-1-mcgrof@kernel.org> <20230309230545.2930737-5-mcgrof@kernel.org> <cfaac1a4-20c6-bdd6-ff68-981e9a8858e@google.com> <ZD8HdxbwhUUGvmNC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 18 Apr 2023, Luis Chamberlain wrote:
> On Mon, Apr 17, 2023 at 09:41:41PM -0700, Hugh Dickins wrote:
> > On Thu, 9 Mar 2023, Luis Chamberlain wrote:
> > 
> > > +	if (WARN_ON_ONCE(info->flags & VM_LOCKED))
> > > +		goto redirty;
> > 
> > Well, okay, I don't mind that.  But shall we take bets on how soon syzbot
> > (hope it's not watching) will try flipping SHM_LOCK on while swapping out
> > pages from a SHM segment, and hit that warning?  Perhaps I'm wrong, but I
> > don't think any serialization prevents that.
> 
> I though that may be the case. Would such serialization be welcomed?

Absolutely not!  We don't insert slowdowns just to avoid warnings,
unless the warning is of something that really matters.  This one
does not matter, the situation is correctly handled, so the warning
would be better reverted.  Though I personally don't mind you leaving
it in until the first report of it arrives.

Hugh
