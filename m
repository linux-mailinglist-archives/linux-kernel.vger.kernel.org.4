Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3B636DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKWWxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKWWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:53:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D7C80C2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:53:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h24so143646qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=ZO8KT8PP+ynCgfpAsn0gLSY6SzCQhijyPIHusMskwtf9T1rrauFK8Ru8L7xDqiT98Q
         whp7Qv/cl82o4vi2+YEdK/JvvoG6oPw59CunYWdS4vec2yu+4W+UTQwMrh5IPxj3UHlB
         r/ebpwM/LCmalYllI981sk89ihQ71VnQhIaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=UAS6gJZuggRyn1/NG46WPiJl954izXjvfWbKEWPAwy7dRT/7NYorwckNdq79Gbphce
         7J8WKo/QYHN9HBLi0hfa/ux465CTv1L4AogMhUIEf5nFubBIVBAPX2olPmbjklujkMPH
         OzvSoZOXWJdcjOVh2X8CYVfcoVtdq8iotEdgy6+cksq4HMKGkS2dFYXms3bsKexVO/Xb
         Ks22c/W4mfEWjOmM9yEJ66ZUFFkoiInV8dnvBnj9gKpOmVywHVYNY0r12Bwrk7I9XMwW
         I2xtzUw9ufVXG37Sy8aeisUA4hTuG4uOWbB4pblu69xjp3uBSQaC6jK75s+q6V0sUZLw
         Aodg==
X-Gm-Message-State: ANoB5plUN85VCBSpEVLzg0G4lirQNYWcU903vvqmynuhhyo6UwsP6pPo
        GiK1r8MyRmzKkXYjR9+kUt6foQcCIRzybQ==
X-Google-Smtp-Source: AA0mqf6LaH+rdyPqfKTzCtxfbtDvvPBHlSURHIeQ+Blvq322KUmTN3pkf0UZMfgsTR73qB8Ly6S+ZA==
X-Received: by 2002:ac8:7219:0:b0:3a6:4342:4035 with SMTP id a25-20020ac87219000000b003a643424035mr11903137qtp.385.1669243995693;
        Wed, 23 Nov 2022 14:53:15 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85445000000b0039492d503cdsm10455942qtq.51.2022.11.23.14.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 14:53:14 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id jr19so150473qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:53:14 -0800 (PST)
X-Received: by 2002:ac8:44b9:0:b0:3a5:81ec:c4bf with SMTP id
 a25-20020ac844b9000000b003a581ecc4bfmr16610980qto.180.1669243994092; Wed, 23
 Nov 2022 14:53:14 -0800 (PST)
MIME-Version: 1.0
References: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
In-Reply-To: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 14:52:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To:     David Howells <dhowells@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-mm@kvack.org, Rohith Surabattula <rohiths.msft@gmail.com>,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 23, 2022 at 2:48 PM David Howells <dhowells@redhat.com> wrote:
>
>   I've also got rid of the bit clearances
> from the network filesystem evict_inode functions as they doesn't seem to
> be necessary.

Well, the patches look superficially cleaner to me, at least. That
"doesn't seem to be necessary" makes me a bit worried, and I'd have
liked to see a more clear-cut "clearing it isn't necessary because X",
but I _assume_ it's not necessary simply because the 'struct
address_space" is released and never re-used.

But making the lifetime of that bit explicit might just be a good idea.

             Linus
