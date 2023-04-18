Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA816E581A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDREbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDREbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:31:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C05E42
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:31:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b10so233144ybk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681792291; x=1684384291;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8t7utIVn1NZcTfXhQfNQOixZnM/sHw7ItMZQq+M8aPc=;
        b=Cz9/Rr66vJy1JpuaPb/lZt+BqnIAULlsh/bMEJz7lecp7j2/VqIYFP9lYDAXo/GSOe
         jXegQSsMedSgQT77EeJ2KmfvMzZN6Ljv1+TN3WRsPIfy+i2b79tjjoDydxB2muV0m95F
         TkPvSFKMkzafvTvvY78d+3eTyLdggNl0pJ/8IVftS/PK5rnOzysZHuDvNz2HHgSEmlTM
         IFQJtX1mLDjgI+uRRoYmhs70M5a/m3OoBKLn7JyDtPchNoL/b66Hu6xw8kf3RtaIiqXk
         vwbDlDQqWGfOs1MddFqSn7e1o1bZyRAEkBxq9S98SAthePpj17XI8RVCikHwVaPs+HYc
         nxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681792291; x=1684384291;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8t7utIVn1NZcTfXhQfNQOixZnM/sHw7ItMZQq+M8aPc=;
        b=MbB1I3WJ3TiUvOwNdIl8xTR56aGiGpxJNlKcq0VnHXcCBMRIAlw2GFfZPuzpAoPOTM
         jnOrp7qRS5GgsKnCBqtwz0XMNV0aIbkkkdhA+crb67gH4fYoPq7UVo4K13CwgZgMJVUs
         QVrI61PiU3KtUpLIWHj65rK9rs4835nQTAY2uBaHjdrGqXSeVsUVQgXGgkQ2iy/rf6t0
         oZM2tkVdrUxaR/CCXfFVkeg/Yh7tai+jUIy6AH9CE59lSqBTF6NsqlaMViFIWRMS6u1g
         DvKoAnMhCSmi4rfqtve8XnfhRlOj/nHotPM5rPoOkVTyUGM0nNWvNzbjskVXkl4aZQWR
         C0jw==
X-Gm-Message-State: AAQBX9fwjzjC5gwQK2FOAFuEc9lHTRIc3cRA39XdX0lu0Zwa2wIbN5Xm
        ONRC2RsIWXWSlwAHLrZsG6xXbQ==
X-Google-Smtp-Source: AKy350bkagPcqZa3+5HDiDrj30dc80d8tI3FGCtUz+bHwJx733EmHG6BEvt4HtTfYB6l5+wXa/Zlqg==
X-Received: by 2002:a25:e706:0:b0:b8f:44bc:c4f9 with SMTP id e6-20020a25e706000000b00b8f44bcc4f9mr15495368ybh.32.1681792290910;
        Mon, 17 Apr 2023 21:31:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 185-20020a2506c2000000b00b8f2d726471sm3464611ybg.3.2023.04.17.21.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 21:31:30 -0700 (PDT)
Date:   Mon, 17 Apr 2023 21:31:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
In-Reply-To: <20230309230545.2930737-1-mcgrof@kernel.org>
Message-ID: <3382819f-4a4-8622-5642-78c03ecfb878@google.com>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
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

On Thu, 9 Mar 2023, Luis Chamberlain wrote:

> I'm doing this work as part of future experimentation with tmpfs and the
> page cache, but given a common complaint found about tmpfs is the
> innability to work without the page cache I figured this might be useful
> to others. It turns out it is -- at least Christian Brauner indicates
> systemd uses ramfs for a few use-cases because they don't want to use
> swap and so having this option would let them move over to using tmpfs
> for those small use cases, see systemd-creds(1).

Thanks for your thorough work on tmpfs "noswap": seems well-received
by quite a few others, that's good.

I've just a few comments on later patches (I don't understand why you
went into those little rearrangements at the start of shmem_writepage(),
but they seem harmless so I don't object), but wanted to ask here:

You say "a common complaint about tmpfs is the inability to work without
the page cache".  Ehh?  I don't understand that at all, and have never
heard such a complaint.  It doesn't affect the series itself (oh, Andrew
has copied that text into the first patch), but please illuminate!

Thanks,
Hugh
