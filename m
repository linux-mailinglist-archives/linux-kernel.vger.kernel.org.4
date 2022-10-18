Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63360325F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJRSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJRSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:25:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70540DF08
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:25:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so14642839plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnD0cUVp+TOTlgr52vU4IJ+UQNYJwnMUoL+t7q45VyE=;
        b=knjecM+JwXsRjmXTN38QTXdo60yLmZbtz3TiWB6dKs1qQ30ZMLuU5uJKsLks+W19SL
         MhCYYnb+l60NN2dFy1uHPJPAONKJjdBvZIKuQ839w8pnHn6FV3rCq6AXDJoeopNRIXa7
         NAdJf2F6f8oMnGxEvBxeISjz0+pS8DGQ57Cvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnD0cUVp+TOTlgr52vU4IJ+UQNYJwnMUoL+t7q45VyE=;
        b=jbOe5sLsW+uK52HjHyMp8zh0+V+NRd6wk1tYMV3aq0XznxhhLOdUVlvjL0WSlOU2es
         Wp1N36TpR1WIXzdh0vonUwL5rVUvboCbKDLmdOmLLuWaFxMDWRNcwMc03kzDNrHJN2dr
         DlHJ1R1V7M/VqyiD5bXMZjc8ciOUBvB+TwlvLDR/QdThJsE5hFp+5IujtJpXnOMuvbdd
         LT/o8ZSlEztfTZX2IMVK/sJ5iXkIfvSa7dmJGb51i9YcamGOAnBNJ9Jz8A8iOh9YegEV
         IA8z0dD1qA10glTLMyfXOoHjRjzb7QV3S5SYYzAnQYpH7iwnQ8+DN1svilDyipfgIbn/
         iT7Q==
X-Gm-Message-State: ACrzQf3YXI7zYNI2SPxEdF3tIgBwGkfO0HZ8rG/Psl5hG1fVNvZTM8AO
        8O/PXnUEDXODk2MSHr6brIBT3w==
X-Google-Smtp-Source: AMsMyM56wYSQF4d6PdxkC9KXMD1lXxNzi/2pnc/ihUXr+HLyRnxmdbs1/lcrj69ovUsn97pESxrYwQ==
X-Received: by 2002:a17:902:ea85:b0:17f:88c1:7015 with SMTP id x5-20020a170902ea8500b0017f88c17015mr4189852plb.49.1666117504543;
        Tue, 18 Oct 2022 11:25:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902f64400b00176b84eb29asm8884968plg.301.2022.10.18.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:25:03 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:25:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/9] fs: Introduce file_to_perms() helper
Message-ID: <202210181124.73B5B7ECCE@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-6-keescook@chromium.org>
 <20221018141037.zzpfjzutqbutbpiy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018141037.zzpfjzutqbutbpiy@wittgenstein>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:10:37PM +0200, Christian Brauner wrote:
> On Thu, Oct 13, 2022 at 03:36:51PM -0700, Kees Cook wrote:
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
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9eced4cc286e..814f10d4132e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -993,6 +993,28 @@ static inline struct file *get_file(struct file *f)
> >  #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
> >  #define file_count(x)	atomic_long_read(&(x)->f_count)
> >  
> > +/* Calculate the basic MAY_* flags needed for a given file. */
> > +static inline u8 file_to_perms(struct file *file)
> 
> As long as there aren't multiple users of this and especially none in
> the vfs proper please don't move this into fs.h. It's overloaded enough
> as it is and we have vague plans on splitting it further in the future.

Sure -- this can live in a security .h file somewhere.

-- 
Kees Cook
