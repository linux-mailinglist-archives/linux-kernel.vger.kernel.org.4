Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB86094DD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJWQqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJWQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:46:38 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD85143E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:46:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j21so4925458qkk.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyuixz7FtK5XW5CZmBbyCIN1cJYtJoIWuEPQgd8UQk8=;
        b=Ar2qvKdq3KASst+JAnLN4i3PBzt/KTrS4k4cU7mIoDLH8DUYQtr46t5+ZnanGN0xRL
         djudYLAKPcmeN70dLbgtNxqsQHpn7WfyvVK26d65TV56W7o/IXAKyj3P92etth7qIvd/
         BCXKa0eR75PsXxeNNdPIjyBDL5B1U5svAQg0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyuixz7FtK5XW5CZmBbyCIN1cJYtJoIWuEPQgd8UQk8=;
        b=PAsBtHMylZ+bmOO2w4Ls7dF9UFdtaFBeKKMwUmaSv10b+UaApGHaPBv9VPV81tDsbF
         fx3cCVCWXYHmdIp08LHZWMfkC91XMhVIev//WZRy4S+Riz9qcTagrTlYDhau+UYfZYL/
         WGeGmdTsv3pT/lmvIT1PJRkZXKno6zc4p+pZux8ZvHFuqPNXtA+iVDtdu5DJqVESQi1D
         rNjA+/WJfixx9rASGj5OlxlOIRC5zNFPUllykFQORFLO4h59COYO/TDLO35b2nqNS4Kc
         xjALWaRWYt+IrZG6bh7PIsxbwDzGLltMurDZquJ9D3RdQN/Xc5Z6pNgjzbgm1ar/0zPj
         L2FQ==
X-Gm-Message-State: ACrzQf1v1ZpUgk00WI3e3kxLOp1YFokL/b5+LGmhodYsYrycJ53/qptP
        KMxZ3cVKeaj6yE+q9cwkmt/Y48nDCudZFQ==
X-Google-Smtp-Source: AMsMyM5zz5pJo+W5ZzhkVsvEj9bgCmpzn/JN9lukX7ibWUx52EJNV2EYfmkEhnV9uN1y2ruwBbN01Q==
X-Received: by 2002:a05:620a:1329:b0:6ee:dfb8:d438 with SMTP id p9-20020a05620a132900b006eedfb8d438mr18954755qkj.686.1666543595445;
        Sun, 23 Oct 2022 09:46:35 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b006ee949b8051sm13229111qki.51.2022.10.23.09.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 09:46:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3321c2a8d4cso67506607b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:46:34 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr6530111ywz.352.1666543594506; Sun, 23 Oct
 2022 09:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
 <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
 <Y1Vjb9v2ggSjhRbc@kroah.com> <Y1VmBuVrkL7MSzjY@kroah.com>
In-Reply-To: <Y1VmBuVrkL7MSzjY@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 09:46:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLgudbtXKbnTzGnqP7E2rY=BNSWayMbcZmPUHr3j8y5A@mail.gmail.com>
Message-ID: <CAHk-=whLgudbtXKbnTzGnqP7E2rY=BNSWayMbcZmPUHr3j8y5A@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
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

On Sun, Oct 23, 2022 at 9:04 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Along these lines, do we really not have a predefined macro/inline
> function that does:
>         (value >> 8)
> to give you the "high byte" of a 16bit value?

No macros like that. And honestly, why would you want a macro that is
more complicated than the operation itself?

But it sounds like what you actually want is just

     put_unaligned_le16(dum->devstatus, buf);

which does both bytes correctly (and turns into a plain 16-bit store
on sane architectures)..

               Linus
