Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD76663461
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjAIWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjAIWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:52:14 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00552DFFA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:52:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id v65so1039096ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhuEvfIcSrjGAHfvyBVwBGgTuBqraMOJL2I7CPm6qJU=;
        b=r6y6863CiE0EXkY1LloGBingCH7tfCNdiaoTpE0nR1uXxT4YPYOdmP+1B6KPFjkyIS
         fYG3Ejc9ylPc/GXQ6hNyLx/fS069MWPDAJytWuL68MZ1+90IkEVFJJ1LHZfIUxhmWY0M
         qzwA7E9ttmlHYUFtoCb0/3rf/0ghfZrEzA9D5cRhG3TfuODTMelUUQyIebY86G3LkTE6
         v5pIAMp3uM91XqRp2PZ1UILTDCSbqkTiXxvPoSHrvh1SPVgDWEGAFfbBsr4FFDMonst1
         GcuNG7MdiNMyVW72G74rqcYWfyRwo3S/ymskaqEnZOHFOm3f4NU6imieqHbralVIBRIC
         zV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhuEvfIcSrjGAHfvyBVwBGgTuBqraMOJL2I7CPm6qJU=;
        b=g3unRsehwX53jBQ1BzfxQPUBGSiCOFYxr5R4heyLb6Mhcu+i4OL6DRl3ddcwB08BTu
         WaY6UJSea4u/ADh7//DZ8SaXnx1g93YlDfvtSbsWzQMErF4+/Q9CYEb+WsJzOGFXMBlS
         8WQ0tlcQEgKIypyalf1dSh3I/y3UyMCbLDu004Adykec2q66hutPdwjMD25uQHfjImX+
         Q/TdbFvjSggD6RRP2PPAutdFgTk9BmYFp53FRZHjA/CbtHPh/YtdKjNJV4E7VjuvJ5ZR
         rGhaSDrqPFbsigOgB79W47E1fKs3F4uVao3i6MSUCFPPeBKmEQYjPBLjsB/DmJeuj2Ih
         p1bg==
X-Gm-Message-State: AFqh2ko5HSaMWrKIcnPHdk12mbaZWTmVOxfiBDGYVl7Im/stUicYuSZM
        5/VRaZCZF3/y7hY/76KP3/iJcOFXG+WD0GDFBJ9XLA==
X-Google-Smtp-Source: AMrXdXvdZnndvSelmDTPtxPR/kBJX+xvDtde+pS0cTV7+POk3l7j8kjUDYUd+10WRuPD3tAersICGnKsbaLyPNr/EXU=
X-Received: by 2002:a05:6638:4b81:b0:38a:6a3a:9609 with SMTP id
 dj1-20020a0566384b8100b0038a6a3a9609mr5796951jab.156.1673304730766; Mon, 09
 Jan 2023 14:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20221230215252.2628425-1-yuzhao@google.com> <20230105200023.ac9f34f5b7738eae4fd940d6@linux-foundation.org>
In-Reply-To: <20230105200023.ac9f34f5b7738eae4fd940d6@linux-foundation.org>
From:   "T.J. Alumbaugh" <talumbau@google.com>
Date:   Mon, 9 Jan 2023 15:51:59 -0700
Message-ID: <CABmGT5H3WBm9ir60FO5BCcT9eWUG20Vx6XE_agK+r9s=GvjZ+Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 1/2] mm: add vma_has_recency()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Righi <andrea.righi@canonical.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Larabel <michael@michaellarabel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 9:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> The posix_fadvise() manpage will need an update, please.  Not now, but
> if/when these changes are heading into mainline.  "merged into
> mm-stable" would be a good trigger for this activity.
>
>

Thanks. Yu is OOO for a while. I think the follow up tasks (as listed
in [1]) are the man page update, the SVT-AV1 benchmark, and the fio
flag addition. I'll be following up on these soon.

[1] https://lore.kernel.org/linux-mm/CAOUHufZhcJh8PdVtFuoOPWBWw_fWNAB61GndXoWjekYaubXTAQ@mail.gmail.com
