Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEDE72B7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjFLFuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjFLFtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:49:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5410D0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:49:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3d44e3d1cso3753555ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686548951; x=1689140951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NOjT3kFEBS5OQNHw58+RCjy2pREgfJy/T9HBw6SYqdQ=;
        b=j2Liob38MVU/aNvJXnDtjyfvdpYpQvVJc0WwYjA8/a2zhKJA3VktzBDwSwOwuFL9e8
         vCOQhL8fF2taAzIAj0iiCbLV0gDco/8jkM8a8aGAL9cNyvmpQaUN9+I/E01Tu77jfQyD
         rJYTn+fp4LLXSzKEmbemwcahuC2MbHdNKA4lSxu/Umv90/tCC8vHqP6h1H7geMi8xyaH
         BO60yV/LZyH0t44Q4ohwgx5JJyHKIzH2jHGnbLh+fhS/cfk7qzqoO9gLPIEPX/19vSW+
         HDuybHRTpsJQveSC3EGqzlrAbJaTqTzj9xTNl+uF24l49/DzdsOz/LqTmPd5Rpv13bes
         YqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548951; x=1689140951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOjT3kFEBS5OQNHw58+RCjy2pREgfJy/T9HBw6SYqdQ=;
        b=QKw8xPSird4UAEIywZWLUXDeX0QHraON0NLLP5jbA0gd/xc/PbXqMNHEEheZ1YJy2m
         IkFQ1wHHPI5AC7CInGuHOIVGpVUPYVJUTLJvj7ugT9gyF2pe9UWpJx+x7Q0WSs20z3xJ
         dWcVGliHzhDzuu1oF1RA0m4vp/nXmr8yK1HdSUSca/kNcGIslZBloN8PWLZ7jaXTZmoB
         DTGjC3KjxqadF4FUgYjPfO+TqSs8AcyU65nVJggEjynBA/Kq510XK2itMSNmGTM2if0W
         UNQZu83qvGSQTYPy3JYRDkpQ5Wshmxo8qQim0fi2Wz6K5PplCTFPrWHfjMo8zJk7ezy/
         Svbw==
X-Gm-Message-State: AC+VfDyFuW7KXlf0sLuBuG7xzdqOGHsy5EOAl3p38lCDyNInyjCzj0d5
        rzcQGg5JGSN8Ru77Hh/EM3qtKg==
X-Google-Smtp-Source: ACHHUZ5d5jC3sa0YBA9xrKGXBPG7fdfc9xdIKadlPGz0lbdIz163Ijnty4tHm3U5Uux7Faso9SsL4A==
X-Received: by 2002:a17:902:ce8a:b0:1b2:a63:95aa with SMTP id f10-20020a170902ce8a00b001b20a6395aamr6351219plg.54.1686548951300;
        Sun, 11 Jun 2023 22:49:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902761500b001b03f208323sm7274749pll.64.2023.06.11.22.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:49:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q8aQO-00AlOI-1G;
        Mon, 12 Jun 2023 15:49:08 +1000
Date:   Mon, 12 Jun 2023 15:49:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <ZIax1FLfNajWk25A@dread.disaster.area>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <ZIaqMpGISWKgHLK6@dread.disaster.area>
 <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 10:34:29PM -0700, Linus Torvalds wrote:
> On Sun, Jun 11, 2023 at 10:16 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > > +             /* vhost workers don't participate in core dups */
> > > +             if ((current->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> > > +                     goto out;
> > > +
> >
> > That would appear to make things worse. mkfs.xfs hung in Z state on
> > exit and never returned to the shell.
> 
> Well, duh, that's because I'm a complete nincompoop who just copied
> the condition from the other cases, but those other cases were for
> testing the "this is *not* a vhost worker".
> 
> Here the logic - as per the comment I added - was supposed to be "is
> this a vhost worker".
> 
> So that "!=" should obviously have been a "==".

Same as without the condition - all the fsstress tasks hang in
do_coredump().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
