Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4472EC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFMTmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFMTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:42:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536581720
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:42:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3c4c1fbd7so18659555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686685335; x=1689277335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxEcj49+vGwYkRgl1icr+yGC9c7gL0eXEsyVyEAa72I=;
        b=QDF6XybuuSbESC6lsMPSOgkZPqsKAZRVX6eAzuQeJFFgsCxewr0dbZQsAQcrNv/Jt/
         cUwNgWA3FaBmym/Q0URJfdCq/RYEH3el9I+AIsJg4wNI/j3dqAL883+nv6ycCEqwu8Is
         szTUB9KYgk+4+OrfO9cFjQmr2dHKH1dCCXOEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685335; x=1689277335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxEcj49+vGwYkRgl1icr+yGC9c7gL0eXEsyVyEAa72I=;
        b=QW5shh3YGp0s5D+Ri8eOxd4wVuMK2gv09xQkhX6iL8Z1XfUZZtudRii/EZlKaI61Fv
         BJgEjgvgUgajAFqp0mKSd8NRCBcEUTRTMhuBugL24z4xJk7WLG/DI3Am9zZtIHCoBvqr
         3SkW4/3jftqai03eBHqHM/57e7ffy/D9RlCoL+1dMyiBs44RlQ/MXwSue2UgoOz/pA39
         R8VD/bxFTtTC3DwwC74m4T6Dqb4g7BtTv08fHkPIIryy2VrgR9xe69B5Vmbb7eAUd/qm
         FV0GoXahQXhHl1QDfU/+fLTBeChpDRVt50qdX0cRuVBRHLBvqhVTbmP1qQg0M0e8OyOZ
         If6w==
X-Gm-Message-State: AC+VfDwk090+wmu8lChv9E4Slpj+JuNG1reFErL1eYmrgkkKr5Sak9bb
        AgWHDu6+WkTnFJnx9C8D6p0g7A==
X-Google-Smtp-Source: ACHHUZ4ASqDKrvZKerhnxXxdgCYThmTm+1P/kHDzqnN8JNmhcPCltk7Mdv4E+dofJzdv0DLD1v2ZjQ==
X-Received: by 2002:a17:902:e88f:b0:1b3:ebda:6563 with SMTP id w15-20020a170902e88f00b001b3ebda6563mr2783752plg.53.1686685334830;
        Tue, 13 Jun 2023 12:42:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001b3c48d01d0sm3902plz.65.2023.06.13.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:42:14 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:42:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Replace strlcpy with strscpy
Message-ID: <202306131238.92CBED5@keescook>
References: <20230613004054.3539554-1-azeemshaikh38@gmail.com>
 <01E2FCED-7EB6-4D06-8BB0-FB0D141B546E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01E2FCED-7EB6-4D06-8BB0-FB0D141B546E@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:18:06PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 12, 2023, at 8:40 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> > 
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> 
> Using sprintf() seems cleaner to me: it would get rid of
> the undocumented naked integer. Would that work for you?

This is changing the "get" routine for reporting module parameters out
of /sys. I think the right choice here is sysfs_emit(), as it performs
the size tracking correctly. (Even the "default" sprintf() call should
be replaced too, IMO.)

> 
> 
> > Direct replacement is safe here since the getter in kernel_params_ops
> > handles -errorno return [3].
> 
> s/errorno/errno/
> 
> 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> > [3] https://elixir.bootlin.com/linux/v6.4-rc6/source/include/linux/moduleparam.h#L52
> > 
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> > net/sunrpc/svc.c |    8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index e6d4cec61e47..e5f379c4fdb3 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -109,13 +109,13 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
> > switch (*ip)
> > {
> > case SVC_POOL_AUTO:
> > - return strlcpy(buf, "auto\n", 20);
> > + return strscpy(buf, "auto\n", 20);

e.g.
	return sysfs_emit(buf, "auto\n");
...

> > case SVC_POOL_GLOBAL:
> > - return strlcpy(buf, "global\n", 20);
> > + return strscpy(buf, "global\n", 20);
> > case SVC_POOL_PERCPU:
> > - return strlcpy(buf, "percpu\n", 20);
> > + return strscpy(buf, "percpu\n", 20);
> > case SVC_POOL_PERNODE:
> > - return strlcpy(buf, "pernode\n", 20);
> > + return strscpy(buf, "pernode\n", 20);
> > default:
> > return sprintf(buf, "%d\n", *ip);

and:

	return sysfs_emit(buf, "%d\n", *ip);


-Kees

-- 
Kees Cook
