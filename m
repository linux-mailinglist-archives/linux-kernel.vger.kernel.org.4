Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7828B6A1F65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBXQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBXQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:13:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD2206A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:13:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x10so55922564edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uaxBJSgWqvLaoOMxWgJIqaQBEgKPvnccLZuHzDiq+NA=;
        b=BpwwamzG5OF5Y/Wholvr8UuQC8co6VGUxBK9PHdD8OUSHaQY6t6OCRKE3tYMwFqtvY
         BpxSTehtRoXcyoO6a5GVqmEdBXeJ6c8oE9YuWGTwUkaB9I7oGJflZ9Gt1J5VU2pgxzfb
         UEfYLbkrCzmH2UZy3e1QalYwtuQgpdE346IwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaxBJSgWqvLaoOMxWgJIqaQBEgKPvnccLZuHzDiq+NA=;
        b=aDHSLHlnAtkCTnoI0WI3SD8SZivDunLAluJfNMPX+jqZzbCTckUX3/tR4TYWbxjBLw
         fOlsjBJPrtg6ca4/0Y5OcTRA5qz/yf8xpi7YtxbBhO7/bl5dm3miKAPkXme1H7DDFA+a
         8gaeCk7qx9WvxOiEuOcCP7f/3BFHPJ7SFbxoRGyt4iK4UGdosUkTruFz0LHEpBL6U/4O
         Eq7fgYR1sSzyXbcwkoXhG9+/Q8W1qDlE3Z0Wcy3q2FD0V2O+ctkaEulqUVtGU1rHOjGt
         0FouS2pHXXn5HBf9YBlielSa3F1TOt0K6j/TVb7+VeVe/lHyYs/K/vWrk8P3+lNHxfp3
         E3Cg==
X-Gm-Message-State: AO0yUKVfahxTvOODrQTX80376QMjhVotRmUHFFV6cFSNSGagc+4o5UsP
        0GR2mpuvBlfmVp5VP5qlrL0/bDNGXup5x9hufSrZhA==
X-Google-Smtp-Source: AK7set+2cEbz+VyZHh89laK8AW00k0Tc2K4eDp/ARPdFPBDIeWhMHqXTwi7GU1coXClZh3ZHhNI0cA==
X-Received: by 2002:a17:907:d304:b0:878:5372:a34b with SMTP id vg4-20020a170907d30400b008785372a34bmr27095137ejc.45.1677255212108;
        Fri, 24 Feb 2023 08:13:32 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709066c8c00b008d325e167f3sm6435780ejr.201.2023.02.24.08.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 08:13:31 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id eg37so52911328edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:13:31 -0800 (PST)
X-Received: by 2002:a50:9ecd:0:b0:4ac:c720:207c with SMTP id
 a71-20020a509ecd000000b004acc720207cmr6674555edf.5.1677255210884; Fri, 24 Feb
 2023 08:13:30 -0800 (PST)
MIME-Version: 1.0
References: <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2134430.1677240738@warthog.procyon.org.uk> <2214157.1677250083@warthog.procyon.org.uk>
In-Reply-To: <2214157.1677250083@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 08:13:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz8sE9Dd_f7tER_APsCPRPDdt_Dykn8X62SGrbfzCpoA@mail.gmail.com>
Message-ID: <CAHk-=wjz8sE9Dd_f7tER_APsCPRPDdt_Dykn8X62SGrbfzCpoA@mail.gmail.com>
Subject: Re: [RFC][PATCH] cifs, afs: Revert changes to {cifs,afs}_writepages_region()
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 6:48 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's a more complex patch that reverts Vishal's patch to afs and your
> changes to cifs back to the point where find_get_pages_range_tag() was
> being used to get a single folio and then replace that with a function,
> filemap_get_folio_tag() that just gets a single folio.  An alternative way
> of doing this would be to make filemap_get_folios_tag() take a limit count.

Ack. I think this is the right thing to do.

Except we should at a minimum split this into two patches, with the
first one introducing that filemap_get_folio_tag() helper function
that makes the whole find_get_pages_range_tag() conversion much
simpler.

In fact, probably three patches - infrastructure, cifs and afs
separately. Just to make each patch simpler to look at for people who
care about that particular area.

And I'd still like to know why that 'skips' logic exists, it seems to
be shared with afs. The fact that it actually seems to change
semantics by your testing makes me even more suspicious of it than I
was when I was doing that "skip_write" thing.

(But the change I did was to treat _all_ the skipped writes the same,
while the old - and your revert - behavior is to only do the skip
counting for the "already under writeback" case. But it still stinks
to me).

                 Linus
