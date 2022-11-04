Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100A261A045
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:49:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941F1EAD2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:49:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z30so3595210qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9rtjuYQHEdZGFnPi4RO+GW6VHNzPLGvueZ1wnAoh2k=;
        b=OWDsUW0TRqhugSuTXEHAIWTiEORqtx5V3rm6QXXdvdb/+4LTjk8HA1gynX6RS2YvPr
         YwGT0Vmshp0VTPKxfY0x2OPAMJFWxvc63VjG76cOTNECBxWVbm3bFDDUyd4lObbZV3C/
         15holUc1uUmi0znm1aMGfpgmqvl14sVRYOGAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9rtjuYQHEdZGFnPi4RO+GW6VHNzPLGvueZ1wnAoh2k=;
        b=L/T3H1H3r4i7zuPa13mJzCnXkpxsNEB3dsf9quYSNroK9daTenrWy91TTQmOrf+W+K
         FyNiZKft80aZt49TzUGIpJffLD0EE5ctcYLgt+fEVstS3G8VZEQH2L50ZEZnm7HDJwSL
         W17taszxMiwDyKjZaDVNTtcBCrxr236xsWgTFFcoXoFiYg71oFF9W/PKMvNa8Ztr48rL
         JLIHjniVMkHm0Gjq6p9Io51T3oaXD/n1q/E1o46I/uTK3yHIhutey4R+muJBvgHyg6A2
         2XNtfbxRQET8sDjkUMT4ql82OVqSHLm7ln7e7ng55uBdL+4cwYPhh9segpXCsTlaAmfC
         EJ0Q==
X-Gm-Message-State: ACrzQf3WSmh0e6bvOcwY/ZvcxcnYaE5eWCjnOhd/7z06Z9Wjhg6C7/xG
        5ganmNowU7wum8U54/BN6PiinaTZcxiCeg==
X-Google-Smtp-Source: AMsMyM6re9Jzp70463wdPQfa+gjzgI6lyj6nHKR2sgUiCK8TYAjSMm1WQzBNZvWhBnG25obNMjfhwA==
X-Received: by 2002:a05:620a:70f:b0:6fa:21af:ab33 with SMTP id 15-20020a05620a070f00b006fa21afab33mr23149060qkc.595.1667587788283;
        Fri, 04 Nov 2022 11:49:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id bp30-20020a05622a1b9e00b003a50248b89esm48506qtb.26.2022.11.04.11.49.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:49:45 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-37063f855e5so51712437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:49:45 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr27860255ywf.441.1667587785316; Fri, 04
 Nov 2022 11:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <1010626.1667584040@warthog.procyon.org.uk>
In-Reply-To: <1010626.1667584040@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 11:49:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKwjX-hNV81sDy8J3vi9_x5m7iCEOFTR1ijiPGfQdz9w@mail.gmail.com>
Message-ID: <CAHk-=wjKwjX-hNV81sDy8J3vi9_x5m7iCEOFTR1ijiPGfQdz9w@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: Declare new iterator direction symbols
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 4, 2022 at 10:47 AM David Howells <dhowells@redhat.com> wrote:
>
> If we're going to go with Al's changes to switch to using ITER_SOURCE and
> ITER_DEST instead of READ/WRITE, can we put just the new symbols into mainline
> now, even if we leave the rest for the next merge window?

No, I really don't want to have mixed-used stuff in the kernel.

Continue to use the old names until/if the conversion happens, at
which point it's the conversion code that does it.

No "one branch uses new names, another uses old names" mess.

               Linus
