Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70D6C7542
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCXB4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:56:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A533723C62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:56:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r187so558624ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679623007;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsiMTy6N1RgTGOvTb4Xekz2TfgGYj4qNFGKLfiNrC5c=;
        b=i/OsODyRFwhKGCQVE5cOGTdtvHCCj1uWMzF2K26hcBSijC8Bs40+uJrOhLxFbYU5z6
         6UAmtrLHZO3hGGsrgY0Qi6Wr24Solw5pnxAXpRqqejv1QKhj15Hnoe0y66GD5GogEMMJ
         uy/BlrCfRTtxAyb0tiLsLk8DeyDYABIs2p5N7H+u4ZnG5fOeBodeZYRDuFNa1XmGSSgF
         VVU+G15TSxO7Bj1pvQDJv+mWp7bhdosjZhCKqIThklR+vB6hKeCl17Jv47VDXzhfEL6e
         fkD4a/RjHjBwdn/9jK2eWZqlAwM7pVq8cLCzYln2IEk5vlmcC572oIqH5nT6eEGJ7Wjt
         q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679623007;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsiMTy6N1RgTGOvTb4Xekz2TfgGYj4qNFGKLfiNrC5c=;
        b=wWinInuwrbNoFHtdu84etmgrA77GY760UURKnQhZoS5bY+WpsMs10J1vAycrfCC06V
         F9p4n2BmAo5sM1LzRlYTCbxFHcuD/5A5s4cn4/PRzCSzfn3JwUlFwzDxK8rIrvvha5X6
         ZiCE/OY/SvkHayxgmv9vMkUgO39LDiheMDQGeVwltbdqS1IDdCx7cOfd9b3z/pd3ykU5
         lDOsl9FFEGB3kI9s0LHt6l49qUubdr9WdfPqNdi7/H47bIOhhKcelGzkHZzHLYHhV+j3
         qZZ45EhFM1riEiAwFSZPeJqJCntE8KlO0u/wjrVL9GZhQ0sKSy2vKLwJcV4e/E9rNfz0
         tUtQ==
X-Gm-Message-State: AAQBX9ctqmUFRAld5UpfO3gk2P+eE7KtREGovtSaiErm41X16MNli9rS
        gxj+LPSZvKPCLwSB2MSMVuhDppUi/i4+JngEfZ92aQ==
X-Google-Smtp-Source: AKy350YpjYImsNOySKYjBd7nGIWFGk6giMK3LiQUNQ9zymyu1GFBcYRTvVx6oVVhLqLV/H1dUZLH/g==
X-Received: by 2002:a25:ad86:0:b0:b26:91a2:61bc with SMTP id z6-20020a25ad86000000b00b2691a261bcmr734070ybi.37.1679623006756;
        Thu, 23 Mar 2023 18:56:46 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j83-20020a252356000000b00b7767ca7469sm178947ybj.6.2023.03.23.18.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 18:56:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:56:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Song Liu <song@kernel.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate
 flag
In-Reply-To: <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
Message-ID: <b49b118d-893c-c749-61f6-9441539418a5@google.com>
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-4-stevensd@google.com> <866d1a75-d462-563-dfd7-1aa2971a285b@google.com> <ZBzK99dSmbPB7vjA@casper.infradead.org>
 <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-38525656-1679623005=:6497"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-38525656-1679623005=:6497
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Mar 2023, Song Liu wrote:
> On Thu, Mar 23, 2023 at 2:56=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Mar 23, 2023 at 12:07:46PM -0700, Hugh Dickins wrote:
> > > On an earlier audit, for different reasons, I did also run across
> > > lib/buildid.c build_id_parse() using find_get_page() without checking
> > > PageUptodate() - looks as if it might do the wrong thing if it races
> > > with khugepaged collapsing text to huge, and should probably have a
> > > similar fix.
> >
> > That shouldn't be using find_get_page().  It should probably use
> > read_cache_folio() which will actually read in the data if it's not
> > present in the page cache, and return an ERR_PTR if the data couldn't
> > be read.
>=20
> build_id_parse() can be called from NMI, so I don't think we can let
> read_cache_folio() read-in the data.

Interesting.

This being the same Layering_Violation_ID which is asking for a home in
everyone's struct file?  (Okay, I'm being disagreeable, no need to answer!)

I think even the current find_get_page() is unsafe from NMI: imagine that
NMI interrupting a sequence (maybe THP collapse or splitting, maybe page
migration, maybe others) when the page refcount has been frozen to 0:
you'll just have to reboot the machine?

I guess the RCU-safety of find_get_page() implies that its XArray basics
are safe in NMI; but you need a low-level variant (xas_find()?) which
does none of the "goto retry"s, and fails immediately if anything is
wrong - including !PageUptodate.

Hugh
---1463760895-38525656-1679623005=:6497--
