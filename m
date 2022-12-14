Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185B664C307
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiLNEHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiLNEG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:06:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6E27B0F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:06:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e126so1203814pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rKEV9W9fSxR0xRR3DSmLMtebWk2YTiMQPBl9c/07mg=;
        b=JUiHhh9U/ve+vlJsWZf7ZOpMUM4syjPZb4nbKg2MzXiIWlXZiUPAaNjul/0MQBPViO
         rLPF5uUfmLfksFpudg2ZTn1bZ7RsrJl4+UuZpbCHeENZTxOP0kohNFFJQClyqwxAjIME
         RNOqlmy8zOow1j9BiCDP81jWWATVny8BRH9O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rKEV9W9fSxR0xRR3DSmLMtebWk2YTiMQPBl9c/07mg=;
        b=IMTVISSURZgmIHWkcTshMB5sO9xpgbEhc7uoLmz8iKgVKdYuJ34fuFDMaCMwkPrual
         /jfXQbcw1OIDL74l+uRnolcoYUhpMdqXC9xz7QTlrr2i8UTfAh8jJjmAFcFZugf30Upk
         xb75JkrjP6Hzl0RB6lCK6h0DIaeviJWn434cQUmRFmER0GDDc5UlNxvGwCkYq1I8OMOq
         plZc16p4a3640cm3LOa30DdAhnsHd/AIkfdDW5fr6dlEEF9kuFVUgRyaIEJO9sD8zkTP
         ZnQ0Gze9eqGJYgIqLMSQSaGi+81pZ5P4d/oZ6h8VZSB6MiUc4n1bNIU7WJ2sE8bqtJuG
         f8Aw==
X-Gm-Message-State: ANoB5pkCPxgNlZSJDyljCkeJeW1oO1bmdSAt7F5cHl0IwBpxAtYcxIPC
        FbYKRhiwB3zimNrfvkulJ+l+vg==
X-Google-Smtp-Source: AA0mqf5ory1OhG7Na5zVVXjcLYy36xrTIivlxVIKKQi8e4DGPo71Kz5Rawog/uBIvlTrVtV6PN9Yag==
X-Received: by 2002:aa7:9243:0:b0:56b:fa67:1f7f with SMTP id 3-20020aa79243000000b0056bfa671f7fmr22439011pfp.19.1670990816786;
        Tue, 13 Dec 2022 20:06:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b00576e75e753asm8378718pfl.27.2022.12.13.20.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 20:06:56 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:06:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Message-ID: <202212132006.F29BB81A@keescook>
References: <20221209195453.never.494-kees@kernel.org>
 <20221212211319.GA15511@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212211319.GA15511@mail.hallyn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:13:19PM -0600, Serge E. Hallyn wrote:
> On Fri, Dec 09, 2022 at 11:54:57AM -0800, Kees Cook wrote:
> > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > or not it was a partial read isn't important. Remove the overly
> > conservative checks so that things like partial firmware reads will
> > succeed (i.e. reading a firmware header).
> > 
> > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> Seems reasonable.

Thanks!

> So the patch which introduced this was
> 2039bda1f: LSM: Add "contents" flag to kernel_read_file hook
> It sounds like the usage of @contents which it added to ima still
> makes sense.  But what about the selinux_kernel_read_file() one?

I think those continue to make sense since those LSM may be sensitive to
the _content_ (rather than the _origin_) of the file.

-Kees

-- 
Kees Cook
