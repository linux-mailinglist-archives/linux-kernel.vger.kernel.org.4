Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE116328BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKUPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKUPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:55:23 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DDACB9D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:55:22 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id x18so8277423qki.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzcJ7m6RG0X4n6Tx+9V/SeCGzltFocNyCQlYUWsjGK8=;
        b=C/nzGG+7owDjyVyN+SsPMFO0p4QvEEOsbGuB+hy7vFO7NmqKQ7Ag6EDOTvdQVYCiv5
         5BDrTlj7aU/BgAg/jw5QggCczdmqRZI6xQeIZEjgJDnlmxEZSx6fOsIdiZsOsMZ1uRQV
         Tp0ELT1Yjqirmv3IDOIU4wNC5CWRxGGnaln9+hztNTi48FM3zF1xVl1Bxn9AJYqr9/Bv
         PnladyNHyJCsv97Um/GbwVMkEUzGw764kMgwYFcoBBcd5Lv5TIdKUgZkpb1RWP7KU1KL
         4QrtEhMmIKjOIGKU5mSmCtrtAZef2qO4KXCmahGm0XuB+qTNygRXSKtKkwA8+q14eXFD
         0IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzcJ7m6RG0X4n6Tx+9V/SeCGzltFocNyCQlYUWsjGK8=;
        b=vtgMQPihPyK7GM1YWS5WuSUTrtG8zKi3OTbETDXHhh4uxQjEz2oMa+9rnO5hVu3iBX
         xsQwJGMwlFSCnIdtN+749x3tdpUrJivJe4Xr5TmmwOQMUv/yhtgm4skwEGUIQVFlRaO3
         x8HkJRoxdHYu/PjC5FovqyCh3FBKKxhSrhQlTbR3Joh3HEG+G1prth9v4Mn3jZCev6hU
         JJnvAz8havLcRhRqBqao/rfDtlAt00tr6tmVA1yuonQhteftAq5O6mUgsPbGsoo2iMNU
         CB5VRUnUZWHhYRGkpGQP3yoFI3JpR+nPrZ7WU03DLP+4CYWhr7Cy/oN3uBf0Sc3yN6F7
         fFFA==
X-Gm-Message-State: ANoB5pntlMwXtsj9GWmiAL2t4ucDhQsrc5zI9wZMNoTe1PcnLXmb4+QQ
        VopMUyVUajLgUUJFlK9yDULjuQ==
X-Google-Smtp-Source: AA0mqf6N9WcywTslUZQMKcSZLiGSID+mMqoKP7uYR/sGzf48BMoMHcdVdcmOHHIwBburlIfanSD8jg==
X-Received: by 2002:a37:6816:0:b0:6ce:7d05:9f9e with SMTP id d22-20020a376816000000b006ce7d059f9emr3756703qkc.409.1669046121644;
        Mon, 21 Nov 2022 07:55:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id m14-20020ac85b0e000000b003a591194221sm7058090qtw.7.2022.11.21.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:55:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:55:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] cachestat: implement cachestat syscall
Message-ID: <Y3ufgkdmGcYlgQwj@cmpxchg.org>
References: <20221115182901.2755368-1-nphamcs@gmail.com>
 <20221115182901.2755368-4-nphamcs@gmail.com>
 <Y3uPHYX6HxYuE4LX@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3uPHYX6HxYuE4LX@bfoster>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:45:49AM -0500, Brian Foster wrote:
> On Tue, Nov 15, 2022 at 10:29:00AM -0800, Nhat Pham wrote:
> > Implement a new syscall that queries cache state of a file and
> > summarizes the number of cached pages, number of dirty pages, number of
> > pages marked for writeback, number of (recently) evicted pages, etc. in
> > a given range.
> > 
> > NAME
> >     cachestat - query the page cache status of a file.
> > 
> > SYNOPSIS
> >     #include <sys/mman.h>
> > 
> >     struct cachestat {
> >         unsigned long nr_cache;
> >         unsigned long nr_dirty;
> >         unsigned long nr_writeback;
> >         unsigned long nr_evicted;
> >         unsigned long nr_recently_evicted;
> >     };
> > 
> >     int cachestat(unsigned int fd, off_t off, size_t len,
> >         struct cachestat *cstat);
> > 
> 
> Do you have a strong use case for a user specified range vs. just
> checking the entire file? If not, have you considered whether it might
> be worth expanding statx() to include this data? That call is already
> designed to include "extended" file status and avoids the need for a new
> syscall. For example, the fields could be added individually with
> multiple flags, or the entire struct tied to a new STATX_CACHE flag or
> some such.

Whole-file stats are only useful for data that is structured in
directory trees. It doesn't work for structured files. For example,
understanding (and subsequently advising/influencing) the readahead
and dirty flushing in certain sections of a larger database file.

Fadvise/madvise/sync_file_range etc. give the user the ability to
influence cache behavior in sub-ranges, so it makes sense to also
allow querying at that granularity.

> > DESCRIPTION
> >     cachestat() queries the number of cached pages, number of dirty
> >     pages, number of pages marked for writeback, number of (recently)
> >     evicted pages, in the bytes range given by `off` and `len`.
> > 
> >     These values are returned in a cachestat struct, whose address is
> >     given by the `cstat` argument.
> > 
> >     The `off` argument must be a non-negative integers, If `off` + `len`
> >     >= `off`, the queried range is [`off`, `off` + `len`]. Otherwise, we
> >     will query in the range from `off` to the end of the file.
> > 
> 
> (off + len < off) is an error condition on some (most?) other syscalls.
> At least some calls (i.e. fadvise(), sync_file_range()) use len == 0 to
> explicitly specify "to EOF."

Good point, it would make sense to stick to that precedent.
