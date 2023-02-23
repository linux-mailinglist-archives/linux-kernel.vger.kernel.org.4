Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE16A0EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBWRcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBWRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:32:07 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46E580D6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:32:03 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id a3so3655112vsi.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iNwsirsHSitd5ovdXTVmlUwXEHgLLx0BuoMwSCFrYuo=;
        b=tH4QkN1zPxvtTatEQOkk9r1/iGdRQFuYysFRTZcgRpbcmNxoeg/uYpN3ZQfa+cPCen
         jggGGGFxjXslx5oGdMiL/tvObVKcw0ecdp2/CcO5zbm8xQpJs/pwF7D4kKvUXs0iwaxQ
         oXwY5zClEIEeN720v3xTOUKzXxR1PLnCYMPNAsNDP2Llzcsp44z/7LBpt5BglyFOQHR7
         3hJHXN1SDu+tGfdCAKWpJOpJG8h2TLGAp71csUBXz0Tq1DhijbFq8GaQEusaqUQ+14ZB
         DeGzAXw43XINQGLD0tyCLLmMYbxCP5u78jqcf1jZgmexpO08XLOZ7C4jbbukMlCaZlNj
         x9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNwsirsHSitd5ovdXTVmlUwXEHgLLx0BuoMwSCFrYuo=;
        b=FdHJg82mLXY3W2twx4lymrJ69sdF/HO6uuCY6S1Ee5XM7RSY1qKsNY0pfnPx7xz4gH
         iaq7AVOYuFBX6P9jaE8VBU2hzy0wqNfMpEcHViHBHN0fZDuU/BJ5wg3uoJRoiLt5pnZe
         TViVE9SlyJdNyBr1P6RxKh68I7f8aRVSHm8tp4KI/j0PJQ82aXaFs+rEUiUJAvgd4gDL
         gY2o4PF+v7uUHlGCLOSiOt3j8vA1jqn2uZQrngSOY99M478vyjnExJQceuUUIfsplcjt
         TjsJdDKHwjGTlMKi0Zs/DC4qouwBbtH0hsyhlBNLVk2/ehRD4O9LlMD8Q/uIT/XXb9VQ
         Yf1g==
X-Gm-Message-State: AO0yUKW6W8tOWJhlzbs+asQVpXJG47P5uXiMAvY/ANLxTJmMKpKQuXZE
        XZE5uBN1l7sz8SSGJMpg2o3HmfIgU3n+WqOqy7wAcQ==
X-Google-Smtp-Source: AK7set8oRuO7MAtve7f+P56pgl8X3cg9W3IMKZZftNya4jBm7eT5RaRh7hAOVcui96sC9p7fepjw4G5RQvt5EhcCloc=
X-Received: by 2002:a1f:5fc1:0:b0:412:611a:dce5 with SMTP id
 t184-20020a1f5fc1000000b00412611adce5mr349173vkb.0.1677173522541; Thu, 23 Feb
 2023 09:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20230223005754.2700663-1-axelrasmussen@google.com> <20230223005754.2700663-4-axelrasmussen@google.com>
In-Reply-To: <20230223005754.2700663-4-axelrasmussen@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 23 Feb 2023 09:31:26 -0800
Message-ID: <CADrL8HXQTbqNAYW4h-EXe=wBmAQ15Ta1K5my9xXKPPz0vKX4XA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 4:58 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
> argument. In future commits we plan to plumb the flags through to more
> places, so we'd be proliferating the very long argument list even
> further.
>
> Let's take the time to simplify the argument list. Combine the two
> arguments into one - and generalize, so when we add more flags in the
> future, it doesn't imply more function arguments.
>
> Since the modes (copy, zeropage, continue) are mutually exclusive, store
> them as an integer value (0, 1, 2) in the low bits. Place combine-able
> flag bits in the high bits.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: James Houghton <jthoughton@google.com>

I don't see anything wrong with this patch. Thanks, Axel.
