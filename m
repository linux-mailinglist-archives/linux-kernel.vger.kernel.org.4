Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4932572C31A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjFLLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjFLLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064C7EE1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:27:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53f9a376f3eso2853755a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686569248; x=1689161248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOWI21B75ASkWGO+WORn/+w003EKs+yAHQxQRLz4/zA=;
        b=h2SWT9IgOYJwvSX7kRGbSjVvLXchJCdbCghd+9UWoHqN5kDlF3Z+vH8G8uD7qxx2nr
         wLQO+cWxgM5Fu1SC6jqElX/ca+4rWDILjJBU63cW/B68yCQwicZWS6UqjsyT7mZlvXLg
         5Ce9TkMAYb2xUvVvMKru/CC04TtTDu4jxoroFtYJQgOqOfuuytZOtow1oGT6L+dtn4Qe
         D/zb5Uwdr2AOYiyy68HgKEpAICDETjN1rU04PYW8ghEVa30T3TIOdPyD1rmAvsi/TPwr
         c2DDRJxihHhe0fDH+xf5+aLRKMhhYGmNxWK7RnJWLeCJNV6m9Hgi5v6YQTFS9dO8L++P
         D34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569248; x=1689161248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOWI21B75ASkWGO+WORn/+w003EKs+yAHQxQRLz4/zA=;
        b=FutKdhv13PJF1hJCRpqdoXSDFf6Ui6KLR1bm3TfjKHcYfYO3hUGR0xz/pehS3Rhtck
         5hlaj7t6ggEu+sjYAnQxVVyeOTzn7NscvlWpQuzJnL4Mif9rAmDFF7ioW1K/o6cPAuoQ
         cY0sxIi/2Qp0ZdJvSAlHmEk03emy05k6OlG3tm7FVU7vMPgU3B4+6838rsmKGaasyjrD
         ICYJbnjFzQlm1L+IQghpgiUfyJ6f9h1RuP8dTs8bnNFjsOh2Mwnw7VNnDHjhNc2M3qiW
         uJdQruA7ws/Gou4WvQTX+XZunsAEinPawVatSfXHdP98645bILwBgEXuONY+11TWHKBV
         //5A==
X-Gm-Message-State: AC+VfDwagGzyQfYy8Ce1L6zqcBxTHgW43/sXgbdA4aQNsvgLEhtInExM
        bav9XsRenb8sy6kqawV2ZLODVw==
X-Google-Smtp-Source: ACHHUZ5RVvZVxaTBU4dEGCYOtfmPsR3k6Ij3e1NSvGy23zMOAWhLHFiKqksmr3WxtOS0bQJ6AVem1w==
X-Received: by 2002:a17:90a:f312:b0:250:9e7b:2798 with SMTP id ca18-20020a17090af31200b002509e7b2798mr7962839pjb.18.1686569247771;
        Mon, 12 Jun 2023 04:27:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id ij14-20020a17090af80e00b002502161b063sm9011135pjb.54.2023.06.12.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:27:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q8fhk-00ArMQ-0U;
        Mon, 12 Jun 2023 21:27:24 +1000
Date:   Mon, 12 Jun 2023 21:27:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <ZIcBHH4ITLiQNCqK@dread.disaster.area>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <ZIaqMpGISWKgHLK6@dread.disaster.area>
 <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
 <ZIax1FLfNajWk25A@dread.disaster.area>
 <CAHk-=wj0NuJaRNC4o6FVAJgKAFJ5HWcBV5VJw6RGV0ZahqOOZA@mail.gmail.com>
 <87r0qhrrvr.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0qhrrvr.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:45:12AM -0500, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Sun, Jun 11, 2023 at 10:49 PM Dave Chinner <david@fromorbit.com> wrote:
> >>
> >> On Sun, Jun 11, 2023 at 10:34:29PM -0700, Linus Torvalds wrote:
> >> >
> >> > So that "!=" should obviously have been a "==".
> >>
> >> Same as without the condition - all the fsstress tasks hang in
> >> do_coredump().
> >
> > Ok, that at least makes sense. Your "it made things worse" made me go
> > "What?" until I noticed the stupid backwards test.
> >
> > I'm not seeing anything else that looks odd in that commit
> > f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps
> > regression").
> >
> > Let's see if somebody else goes "Ahh" when they wake up tomorrow...

....

> About the only thing I can image is if io_uring is involved.  Some of
> the PF_IO_WORKER code was changed, and the test
> "((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)"
> was sprinkled around.
> 
> That is the only code outside of vhost specific code that was changed.
> 
> 
> Is io_uring involved in the cases that hang?

Yes. fsstress randomly uses io_uring for the ops that it runs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
