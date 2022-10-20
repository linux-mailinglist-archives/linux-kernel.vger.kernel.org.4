Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615E5606BED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJTXEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJTXE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:04:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEC1C409
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:04:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12so843506pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsxHsgKsul3CX6WnoenIQl+A+PmhUK8m8Ju/evDvuiw=;
        b=FgyAKaMgjWL3+P/ElDeFqWd5KiexYar13hQ0qzcvSuGQQppb6KYVNIhcU8QBR+sI69
         h2XGo4WtcpSvqCKTJTv5X9lbiRJ8jXZdtUl0+4M72S1u/NM2ho4b1LWjqte4GZyEY5oV
         4Zg4uBptBbTo5QOWrWzndV0ZcEh8UYHmYaU5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsxHsgKsul3CX6WnoenIQl+A+PmhUK8m8Ju/evDvuiw=;
        b=PIw4eWLUWCU6ts++f4VUqGw9eD1zu2vgNZ+cv12AS6VobSQ8eBhV9Zd8nK5KE1Klnj
         CmONr8UgEYcd/+87fsj+JW36H49wRVKyJeLxT+rNFtqNBTty17bAGs5zEFg6ZKjC6Vr9
         Xanpd0sPUvIWGHvnYdfKvQ0gx91vHzumyJUlnx6ftqK1SRQ7PIGV8aPZg0BhgOH1ecnM
         j2v8CjubkJeenQcpNVcaQx+AOxDKwFRNzpVA+HG2idry+K8XvJAMo7vFfSNUCnaCclSg
         0IJ5+vwBCmY7yLHWoxiDmM7SABSx6D+lIDbMdq56/zCG3acyQvuxpMXuPjpXLFL1qrX6
         PShw==
X-Gm-Message-State: ACrzQf1Cz5adImxTImIw07D+lbVvZf3QYlkTKn887l5UBFQOZm9pxnre
        WtSzLBRSvL2w/AWPo0nYqZbDZA==
X-Google-Smtp-Source: AMsMyM7IhsRvOpJPTQYG2msHnT3FQtOisXolaaqWspMBn+v88EQORNzch0OZYEkM8ob+KvWhlXY14A==
X-Received: by 2002:a17:902:f78c:b0:185:3d6a:7576 with SMTP id q12-20020a170902f78c00b001853d6a7576mr16021124pln.86.1666307064615;
        Thu, 20 Oct 2022 16:04:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nm17-20020a17090b19d100b0020a81cf4a9asm436416pjb.14.2022.10.20.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:04:23 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:04:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/9] fs: Introduce file_to_perms() helper
Message-ID: <202210201603.45E53CAF@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-6-keescook@chromium.org>
 <34084e9a-b4c0-95b7-1132-ca95294c8063@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34084e9a-b4c0-95b7-1132-ca95294c8063@schaufler-ca.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:29:08AM -0700, Casey Schaufler wrote:
> On 10/13/2022 3:36 PM, Kees Cook wrote:
> > Extract the logic used by LSM file hooks to be able to reconstruct the
> > access mode permissions from an open.
> >
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fs.h               | 22 ++++++++++++++++++++++
> >  security/apparmor/include/file.h | 18 ++++--------------
> >  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> Smack uses its own definitions for MAY_SOMETHING. Making
> AppArmor's values global is going to clash. If you want to
> do this there needs to be a grand consolidation. It could
> go in security/lsm_hooks.h. I can't see anyone other than
> Smack wanting MAY_LOCK, so I can't say the concept really
> makes much sense.

I left AppArmor's special ones in apparmor/. This only lifts the common
pre-existing global VFS MAY_* flags. (And only the low nibble's worth).

-- 
Kees Cook
