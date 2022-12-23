Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28CD654A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiLWBKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiLWBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 20:10:09 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE522296
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 17:04:44 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id c184so3299983vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 17:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/gOWZAaD8SBIOiOmfYa59YShOa8ycZ4ayxBa1jRd7E=;
        b=tmaHZMPcPeETZRodOkbShU4wP1wCu3ctqiGNC19OZf6gr4rulXNp5EZfuq4CH5y8N/
         SVjpjpbPPAoe8VlZ3gMgUYszT5U8lshoTljFb0MQZurhw2j2r5wnY10LW6cdWwlX36hR
         YTOaluFUI/V4/SVekarIA9spgFf4y2lXk/q1+Y0Gqn6rywM979v4uR0kB47S+NIuMsXh
         2R7jCVy0/sMWNjjqT8SQjPMyy79DXKkv+t0nw31l8oNTDGGeVYFpeAanUoqSKZOi1lKH
         C134VdbgAdl/NzxqVQQeNNpmdHAp/H6yhJv05N+nJNZYBVQGxQtoLjkQfbpMDug7svf7
         4z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/gOWZAaD8SBIOiOmfYa59YShOa8ycZ4ayxBa1jRd7E=;
        b=bYycSD5iessC0G/GNa4i4qf6/XwMneE81Fr4CJghSRZvtCmZ3aI09E+DJ+ol3YC2OK
         02ckgnd6/SpHDq67EmHBKZnminMTubkP3YUOkEDyGVg+cw6KAJ9NDjFngIXEepYaWpcd
         8lQP1uz4IVzCRDw+h9AxhGr/OQUIn+7T7dnebWrGtiHqXbgftqHWiopqSBy8gRb6pY5G
         Hu537ydwl8XzR/84L2U45dPCvHzTYpvqsvoYTOhlj8vKvGgfsNg/ivQ6zSarDq2ctEMt
         u4RVXPW5Qw6Nw6zKs7BAnqIa/2oBtm73Kc0K8TFLxwC6T6BLgyxkRmuoO/Qkfphf8YxC
         EUmA==
X-Gm-Message-State: AFqh2kpswVi2ZpZUg2kIkf4EwLF8jpbsvlNEtfMm6ytJyO4MfMw+7iB6
        VKix6uQU8zf0SY4uVTiHr5ZPLwRS1O2MgBVUcKmV9ErECE3kiOmy
X-Google-Smtp-Source: AMrXdXv7OoxaKXo2t6mAbAu8R8miK2JpT2IH8nH1wkesWFiDSJdnax1yDykm+3t9ZSiXE5Sin8BXXdg5tAj231ABRwI=
X-Received: by 2002:a67:c486:0:b0:3aa:f64:fbfd with SMTP id
 d6-20020a67c486000000b003aa0f64fbfdmr975101vsk.15.1671757483050; Thu, 22 Dec
 2022 17:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20221221180848.20774-1-vishal.moola@gmail.com> <20221221180848.20774-5-vishal.moola@gmail.com>
In-Reply-To: <20221221180848.20774-5-vishal.moola@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Dec 2022 18:04:07 -0700
Message-ID: <CAOUHufbcp+VoNR1uonBYi6eEeoG_Td5N_E1hkyaj_gRmRc4vwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org, willy@infradead.org
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

On Wed, Dec 21, 2022 at 11:10 AM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Deactivate_page() has already been converted to use folios, this change
> converts it to take in a folio argument instead of calling page_folio().
> It also renames the function folio_deactivate() to be more consistent
> with other folio functions.

There is one more in mm/vmscan.c.

Please git grep.
