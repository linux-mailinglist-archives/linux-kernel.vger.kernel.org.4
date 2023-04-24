Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6B6ED85A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjDXXLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:11:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29952976A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:11:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso6810674b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682377864; x=1684969864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcIY03WA/1a1dnCGs26HGTJ6MXmKGqXJgbmrj5s6HYg=;
        b=YNtSLxRHpIrd2F1oEkhRs5nLfVvO1m5pzIyLCVLCGvlxvzKBosPCqAGbM91clf8d9E
         ADMl2lPrpsO/4NM0Xz65Wi4dNQzzEh+Rs5N4538RW9Oq9Zoyn8BBKjT6nYad+iWyI/uc
         0Vge26ludT3S25KS3GjWnzFqyriVxYrYYEueCG5ierqAZdc8844sBNH9uwnyg1BCJ5lF
         DvmjjB0/Tws5reubfG/qf75OHbsG219Ai7zGQhjeePnQPNg6xOMy4x3YdCfuk08azT9B
         F9Jj8oBGfFzGU/95tZf/HGp5X4FYNG4xExLfResLnjAdxVGwAuxiivy1Og2G8i/xzZT4
         OWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682377864; x=1684969864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcIY03WA/1a1dnCGs26HGTJ6MXmKGqXJgbmrj5s6HYg=;
        b=Gi91uWe86TWXNp5KfMFz2J3YZUs+rgiyOGaTlI4CA6T+dt1tJQY5WRXdyKUkL6sko9
         6wamSrUcyI8EIZ359zah9D991Iv7ZVZqEtHkGh/X+j4UERZgsQfCUgOhpm5JTCgkLjzA
         eGcAG0Y5knII5xyWy+xV4Txo3mwrRf+ll4ZH7I6sEeLBEOA2XoBwRrLMHu2dOfmKIiC4
         /WN4v6OpalMdnuKW0cYPVt+w7UIHp+lylNF/Glb4YguVrMaucNCIX8zCFwB6HWPrvDnZ
         /QDd3zQMqCgAmgPiAKJhhaV0uu36qJh18CLnTda8dd8VDxGIvC/i2kf/AWIJtDAC3Xdb
         k5VA==
X-Gm-Message-State: AAQBX9cIPUvKUFAo9ukM520caclRxe0iu5h0TvML6BYyoVAnVue85e9H
        ki/oGY8rI7tYfgqJYJ9X1+pSdQ==
X-Google-Smtp-Source: AKy350bOSAbyKbPH0if2wW9knipI29UE3wDfYgfk8VNgx8M/yWvwPZIgYkWGBoBFXLJtVy4SpoPQAA==
X-Received: by 2002:a05:6a20:9f99:b0:ef:ef3d:6166 with SMTP id mm25-20020a056a209f9900b000efef3d6166mr16094294pzb.32.1682377864374;
        Mon, 24 Apr 2023 16:11:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b0063d3801d196sm7830362pfl.23.2023.04.24.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 16:11:03 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:11:00 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <ZEcMhOywwzsc6CN5@google.com>
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
 <20230424223419.6n2z72mocgmcj3aw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424223419.6n2z72mocgmcj3aw@revolver>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Mon, Apr 24, 2023 at 06:34:19PM -0400, Liam R. Howlett wrote:
> Cc linux-mm
> 
> * Carlos Llamas <cmllamas@google.com> [230424 16:56]:
> > This reverts commit a43cfc87caaf46710c8027a8c23b8a55f1078f19.
> > 
> > This patch fixed an issue reported by syzkaller in [1]. However, this
> > turned out to be only a band-aid in binder. The root cause, as bisected
> > by syzkaller, was fixed by commit 5789151e48ac ("mm/mmap: undo ->mmap()
> > when mas_preallocate() fails"). We no longer need the patch for binder.
> > 
> > Reverting such patch allows us to have a lockless access to alloc->vma
> > in specific cases where the mmap_lock is not required.
> 
> Can you elaborate on the situation where recording a VMA pointer and
> later accessing it outside the mmap_lock is okay?

The specifics are in the third patch of this patchset but the gist of it
is that during ->mmap() handler, binder will complete the initialization
of the binder_alloc structure. With the last step of this process being
the caching of the vma pointer. Since the ordering is protected with a
barrier we can then check alloc->vma to determine if the initialization
has been completed.

Since this check is part of the critical path for every single binder
transaction, the performance plummeted when we started contending for
the mmap_lock. In this particular case, binder doesn't actually use the
vma. It only needs to know if the internal structure has been fully
initialized and it is safe to use it.

FWIW, this had been the design for ~15 years. The original patch is
this: https://git.kernel.org/torvalds/c/457b9a6f09f0
