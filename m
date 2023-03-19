Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01366C03C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCSSXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCSSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:23:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B18693;
        Sun, 19 Mar 2023 11:23:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso804326wms.3;
        Sun, 19 Mar 2023 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679250182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSlmso6KkBwBklxSLJ75f8Ha+gCZQtySj8JbPBjFDek=;
        b=RJ5EyvENhicDdyJ8u4kBtkLgOG7blSSpE2ZeS1AZBwp3+mpSZWBC84pWpRfTqUpxyL
         PCgJzWu4u2ir4NkajumTPbsNUZuXXLkJunZyegIyesvFLzA8jbflEcPUMysMbyiP491X
         Cy9KOg/kd9E44C9cvkzmWov7KMJCu7C+bD7RA4K37ud/svjLyym0tBn95Ku52HDouHJc
         je76VmevGV071YHhdPL/of6EH/BZckyG6wFFTwXaaW53tL8UCfDroQPIoiz3HpWp5G4B
         wn1JZTVgxwOj8DmD7DgHk4ApQNEE101BA99/RIvbmKKbYLuC7A/Au7D3bD6FKrP4q82D
         XYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679250182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSlmso6KkBwBklxSLJ75f8Ha+gCZQtySj8JbPBjFDek=;
        b=wVPIKbp/ZNx+dgTqk774luEgKYQ2RWtmg8t6p3BtAwJbJPQcciVpZANvaEcCbb7vki
         S0qtdqH+mSS1810ZaQMdw/vz2qaA6+HaSdnXzYP+1zwtYWk8D9+MhU1V96JuDsKgszLs
         p21qsekrngDV3dpCBmSz2aj6DI24ysq6w3RqtOIfVdODQldyVo70r6xYCOPsJvoPqfTw
         RqICDoiNvspInjzdjgYoQ9gbHDEgCbQvMjCeJwVNzvHchmiFTHViHQ/QyrIAkq7GM3zb
         4uMWv7HHh94ttLGmKpyV/YYIwiOrG+z6sYLpjGdxViLWv02OhAQuP8Esac230FFlJrdd
         w+Iw==
X-Gm-Message-State: AO0yUKWMY1X7/A+JlL8k+XrK8SmlYXwCXyTFTEwYRj48iOhA1iUl+Ova
        sEFL7NIpQyLoDmaJh/sRCOGCtSty2altZgPNu+w=
X-Google-Smtp-Source: AK7set+8PK8WzQdWYQnVV4eGQct12+K+dhBfQvg6I/KNECs5hAlQxWqYAfkve4BhnwqumFr/YbeZqg==
X-Received: by 2002:a05:600c:4fc9:b0:3ed:3d5a:ac99 with SMTP id o9-20020a05600c4fc900b003ed3d5aac99mr12965796wmq.5.1679250182451;
        Sun, 19 Mar 2023 11:23:02 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003ede178677csm2007680wmq.45.2023.03.19.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 11:23:02 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Mar 2023 19:22:59 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <ZBdTA0gKh2xAk5Ay@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-5-revest@chromium.org>
 <ZBcqWqWyq0uW/wj7@krava>
 <20230319135550.22aaa04b@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319135550.22aaa04b@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:55:50PM -0400, Steven Rostedt wrote:
> On Sun, 19 Mar 2023 16:29:30 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Thu, Mar 16, 2023 at 06:38:08PM +0100, Florent Revest wrote:
> > 
> > SNIP
> > 
> > > diff --git a/samples/Kconfig b/samples/Kconfig
> > > index 30ef8bd48ba3..fd24daa99f34 100644
> > > --- a/samples/Kconfig
> > > +++ b/samples/Kconfig
> > > @@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
> > >  	  that hooks to wake_up_process and prints the parameters.
> > >  
> > >  config SAMPLE_FTRACE_DIRECT_MULTI  
> > 
> > nit, we could perhaps remove this config option as well
> > and use SAMPLE_FTRACE_DIRECT_MULTI
> 
> Remove SAMPLE_FTRACE_DIRECT_MULTI for SAMPLE_FTRACE_DIRECT_MULTI?
> 

sorry typo, I meant SAMPLE_FTRACE_DIRECT

jirka

> -- Steve
> 
> > 
> > jirka
> > 
> > > -	tristate "Build register_ftrace_direct_multi() example"
> > > +	tristate "Build register_ftrace_direct() on multiple ips example"
> > >  	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
> > >  	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> > >  	help  
> 
