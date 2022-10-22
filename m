Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57C608EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJVSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJVSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:33:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04572EEA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:33:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a24so3542371qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVoS3S/7CUh5pjxopjidPBDyCAeTY2XtCZTShr1zcl8=;
        b=Q+HGY7/ezyEpQk+uUr6pprYSEijGjmxmFdifdlg+jNeH8hkQeWUZPPogS3g7Y6jZRA
         SHgU3XT19a0UpRVoH1XqvERrJ5cEGEwi0L+K6HBqT7ILX3bS+xrH6CdTrYglRZUI3pNH
         QCYY0aofz8FBbAbyLI7KhuSW9VVrVDY82+hOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVoS3S/7CUh5pjxopjidPBDyCAeTY2XtCZTShr1zcl8=;
        b=erXxBs1Sy4sbppv1GS3NrW7mTZy5ZJ02b78hwGc4fPVTMlsOF8PkyWe9FxlEKwLDQH
         mNxles0LSDpOtStjgp7hSdba7y+kLO5j+aHWpR4So/1uIt8JQyOZxbt6ZygBP9aigq7S
         qBaD7wvggifL3EjuBeL8CMp1k6BJlVWAKpmpNTTI89KQAPnvUy+RWGYtaZ/HwhakIUvE
         rRTM8smVzosRbQtR9kPyfmIrJqGTEElnsXICPZay60bSRgqZBdy2WODfusNeDDSg68u0
         64XYT6GFBTVLQp1LhX/QZ2PzXQ+477TiApJPpKA/qttNLt2j2pfal7KlqR3/OcVuNV0L
         O7bg==
X-Gm-Message-State: ACrzQf1DqAS2fBD2xyj4ZK91of93a1+utZcH6BkNddxqsW4UIL5oWfg/
        y1+9aN9pxTjNvaiopN+21MkO+FXpjba/GA==
X-Google-Smtp-Source: AMsMyM6DmcznFQ3UH3OT7DNyZh7NkKynwbS0mBHv0MhcO9QDQBcgZFRQtgPbtLa5XQULpfSN9Az00Q==
X-Received: by 2002:ac8:7f16:0:b0:39d:a58:5484 with SMTP id f22-20020ac87f16000000b0039d0a585484mr13540648qtk.381.1666463607521;
        Sat, 22 Oct 2022 11:33:27 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q21-20020a37f715000000b006cebda00630sm11756755qkj.60.2022.10.22.11.33.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 11:33:27 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id r3so6865575yba.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:33:26 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr23440145ybu.310.1666463606564; Sat, 22
 Oct 2022 11:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221021191507.9026-1-antonio.borneo@foss.st.com> <b086dff1295732ad412b4de2f363e75a42bb6069.camel@perches.com>
In-Reply-To: <b086dff1295732ad412b4de2f363e75a42bb6069.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 11:33:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQp+H9OeV9bWvzhxhB5vvQJ-=VA9z-YuoEhU=myYtitQ@mail.gmail.com>
Message-ID: <CAHk-=wiQp+H9OeV9bWvzhxhB5vvQJ-=VA9z-YuoEhU=myYtitQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: handle utf8 while computing length of commit
 msg lines
To:     Joe Perches <joe@perches.com>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:48 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2022-10-21 at 21:15 +0200, Antonio Borneo wrote:
> >
> > Actually it's not fully clear to me if utf8 characters in the
> > commit msg are acceptable/tolerated or to be avoided.

utf8 is not just acceptable, but actively encouraged in commit
messages. Not *grtatuitous* use (please - no emojis) but there is
absolutely nothing wrong when using utf8 when appropriate.

And getting people's names right is not just appropriate, but actually
important. And depending on where in the world you are from, utf8 is
absolutely required, and no, we don't do Latin1 for that subset of the
world (any more - we have a dark history of Latin1 in some corners).

That said, I'm not convinced the whole line length check really
matters, or is even appropriate. A lot of commit messages absolutely
should have long lines, regardless of any UTF8 issues.

Just as a recent example, see commit 71e2d666ef85 ("mm/huge_memory: do
not clobber swp_entry_t during THP split"), which has a 200+ character
line, and that's *exactly* what it should have. Splitting that line
would be actively wrong. The same often goes for things like quoted
compiler warnings etc.

I personally can't think of a case where we've actually had issues wrt
"line length in bytes vs line length in characters". And I'm not
convinced the length check is appropriate in the first place.

The only line that really shouldn't be overly long is the _first_ line
of the commit message, because that tends to be a "somebody write a
whole paragraph in line-wrapped mode". And the first line of the
commit message really is special, and should not just be of a
reasonable length (although75 chars may be too restrictive), but
should have an empty line after it.

I didn't look into what the checkpatch.pl script does around that
code, maybe that's what it already does.

                       Linus
