Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179A66E8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjAQVnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAQVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:39:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748404E53F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:05:22 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id pa22so16730991qkn.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8vzw4YVtMRSUz3v9Tgk4v9t6M5/XnmiHZaqhNCNW9Gk=;
        b=d9ogxEmuDNgwfLV09PPVDLrVRjJa9Lb6a565zZUrtoVkjyDiQ0zhZSKMf4baREB5qA
         wMEdn9L26GJrXhkbM0HiD7JT5+nHnMMqXJZ4vn3ljBUvTaeOdhVZ3gCrug1i0Gr2i+YD
         G4fQu4J0eVGtc7xQ7+UZzbdgYx+BVW2jSlk/ih51YAHbk4pqKDqG76W39KUWluOfPpbg
         nqzK/VOUitN5V6uUWtym2Dh6QuhshM7uC/ZGL2fp0Z+4ESCQ/wKfDmGIPTFcFrMcbU1i
         QmjBOnV0xKyc9tKAGkMUlBWMq92Xi19yTgzqBF5GzN+m9h5blJFWfN3JIfzuj1hQHxWn
         i3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vzw4YVtMRSUz3v9Tgk4v9t6M5/XnmiHZaqhNCNW9Gk=;
        b=mKy+DRE88ZFYIhuB+Ig+36EXqJ253SRs1ut7TB4YMFyI4ssdxR+XnW0iOAN264DSzR
         ax96DJ78rcIFeusdoFDDOdD3y0yU9pd8XS5pf0ZUEiDWdcQkOxkkfQLO4ByPtI6naels
         50FQJAWQthDguAGgFOkKdHKSZEJzTA0V3A3buVsthdPzM4Yld6PZzUVDiX5ftSaUM9uX
         58UQLYasSvfXHMjX02nLNxj++2ZklRBNW+MOcC4DfuitmwEFvG9WUo68n/J8O5sBfABD
         oaMYLH941PI0bp5ucdb5KmD9KDRGqQXsXS8RKq2tBDdhqz5a1e53pMrs8rVIl/MzHwkq
         3iRg==
X-Gm-Message-State: AFqh2kqNz7S2Vts5gjeSk/NznVDMmk1474yTziN4Y46szZhIZ4hwIXhW
        6qtRVWR1Bx3anFSS+XVw26OPXMkCquXJi5W1o3vi9w==
X-Google-Smtp-Source: AMrXdXsMcHwF7iN4F4ae8o58I+poPjzv+kb7t//4HBRvoDAok9O5ME86npmBDPuCUSudlwS6JE/ZFpcCCQoqrtoN/yw=
X-Received: by 2002:a37:aa07:0:b0:6ff:c9c:dde4 with SMTP id
 t7-20020a37aa07000000b006ff0c9cdde4mr221524qke.18.1673985921537; Tue, 17 Jan
 2023 12:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230113154253.92480-1-pasha.tatashin@soleen.com> <Y8USQBPlMNTTIyIO@kernel.org>
In-Reply-To: <Y8USQBPlMNTTIyIO@kernel.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 17 Jan 2023 15:04:46 -0500
Message-ID: <CA+CK2bDKLfgBdO-b6jZ+_LJf2j8poUsZUfx67LDMMm7670miQQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_ext: Do not allocate space for page_ext->flags
 if not needed
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mike,

> > Also, add a comment before page_ext_operations that describes the
> > field, and remove check if need() is set, as that is now a required
>
> Nit: fields

OK

> >  struct pglist_data;
> > +
> > +/*
>
> Please make it kerneldoc.

OK

> >       void (*init)(void);
> > +     bool using_shared_ext_flags;
>
> I'd s/using_shared_ext_flags/need_shared_flags.

Sure

> > + * Note: that if none of the users of page_ext is setting
>
> I'd drop that ^that

OK

Thanks for the review, I will send a new version soon.

Pasha
