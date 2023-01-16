Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2122266B5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjAPDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjAPDQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:16:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C4B6A54
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:16:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bj3so24588225pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGhl+bEmNKTop20ULDFE8EejwO+jgTJHb03E5tWe5nw=;
        b=eYirs5bZwtS7+QLoGuT2xzKstA9illXRJM/WUIDqdKSqyZsPSW1o/uKwMehMpCeJnK
         qNaeWrlu86iOwaT1hdRKco7Qr2kOUohfo0vre9T4HuVg7cygmjWTftXgCBTItDZ6rpt7
         P8o0AxLG+q1tRUsGwdtj9It5P3fMrtnG7Lx7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGhl+bEmNKTop20ULDFE8EejwO+jgTJHb03E5tWe5nw=;
        b=zUtFqKOtZeGSX4vbHjjLIC9T8kOePan+ENgKBjjlBTfl7IjXuLIYmaAoEHin2MLFZ/
         FEbMQxMAivnxCmlyRdiZV2LqFhNe6xFk/hMOiS/P1VQkGyDgvX3x4rf1GI8AqETOmOeo
         4qu0tSgnO4KjbNhzf7oY5KDkZOcJt53bXRn5cZjc4Qwuz2wRaNcfRQN1x/tY60smisBL
         uh+txzhJHIP6IEDlbWjrD09SEmTAqBcxGZEQpfCzDMe6Rn7Mlgt0yXqRHBxVKU+EJJhB
         vPf0bnSHYUhjhWNruWTPpDXkxLhm6CiPjTZEaS2s7FqBKyyyqfRkD+kSbPH3OOajQ8x0
         VEhA==
X-Gm-Message-State: AFqh2kow7I1rd+IjqMCX+/0SKQcm3OqBAHu8a8jWi1st6NoBlGaoGJLq
        LuxRS8V7CkCpYWGGEpc9/jZ2zg==
X-Google-Smtp-Source: AMrXdXtZIdw5/0d1deIkyFvJuEaWmKkCT59kqjkZEAOz/TkxRq0p9+fHGpkkMIcPlwxcfFBoNegS3g==
X-Received: by 2002:a17:902:a587:b0:194:8f3c:6fc6 with SMTP id az7-20020a170902a58700b001948f3c6fc6mr3236901plb.58.1673838964222;
        Sun, 15 Jan 2023 19:16:04 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b001948ae7501asm1854799plb.298.2023.01.15.19.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 19:16:03 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:15:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8TBbxcc38GsLmjx@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/09 12:38), Sergey Senozhatsky wrote:
> 	This turns hard coded limit on maximum number of physical
> pages per-zspage into a config option. It also increases the default
> limit from 4 to 8.
> 
> Sergey Senozhatsky (4):
>   zsmalloc: rework zspage chain size selection
>   zsmalloc: skip chain size calculation for pow_of_2 classes
>   zsmalloc: make zspage chain size configurable
>   zsmalloc: set default zspage chain size to 8
> 
>  Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
>  mm/Kconfig                    |  19 ++++
>  mm/zsmalloc.c                 |  72 +++++----------
>  3 files changed, 212 insertions(+), 47 deletions(-)

Andrew,

Can you please drop this series? We have two fixup patches (hppa64 build
failure and isolated bit-field overflow reported by Mike) for this series
and at this point I probably want to send out v3 with all fixups squashed.

Mike, would that be OK with you if I squash ->isolated fixup?
