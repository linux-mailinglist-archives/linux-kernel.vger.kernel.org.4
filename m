Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E96C0BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCTIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCTIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:05:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733013DEA;
        Mon, 20 Mar 2023 01:05:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a05600c354a00b003ee0da1132eso289291wmq.4;
        Mon, 20 Mar 2023 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679299541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/P71frEcH2Ptvt6OvUiP4jDXbdRBVOUmTFIf0mXTCI=;
        b=osQhTOWzydX1M8AN7E88QZiS8JCzt6b5QzhDJGoJSxDY3Q95h+Lz4B5HPbfPoj9wCO
         svSvznvgsU69F7ZME8zrfNJm7V9Cd6z+p5frHzTrgIj7sAhTvMHfY/vwwfxQ866ht1Yp
         kSZQDk2QmG+u1B2gxRRGOPmpyoT7g6e3nDwCSRYu8YaaGG2CabdbiBBpyHIMneytVCnw
         AEGFGNuIzQ2FnFa16gdfVqRKwU/CcOPXKbUPtXDScs5nu0zfimQ4ilPZKBC0OKY62ong
         4sAyJG5HBwOlapd4AuCDAqrBYYV8CkjJCwGWju6Lfd2xpasry+syHifubWy0oPQjlg8i
         NC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679299541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/P71frEcH2Ptvt6OvUiP4jDXbdRBVOUmTFIf0mXTCI=;
        b=0U8xLyzhv9iyK1p7t/wR2ZBIjn0+lulswyeZoKlfPq5NAMk5QgO0vfYu2HCRnMpIiZ
         rQM9fXunl6YafBMS86slvSWbGGEfaMy1EIsGFHYvw344h+kWEAEvbSVZGqzDtmdADHnb
         BM/uNRMTRYalcB8z+N6lfUlaX3tDXCdLWdsx7mkkfyANxSLpS1qoVYTc6qRy8NiNLdU1
         Q4O4IUTUz4cKh3aLGn1xbfIjPe6TSzFjQlcerPuLKpST0qgLGtPShe6giQRN5rVbDXjV
         uPMltf963dVqba0kp38kJCCQlLdl4Ogzxu5NPkb0H77QuM1DtotWU4QiAHxqqNutd2Zr
         zGTw==
X-Gm-Message-State: AO0yUKVYpRzg0ViGodL4AV7YiPwtX0+fI5H3yIuPCh5RXnSzuVY0RBlh
        aCacHLKyG+vu3UG2wdltAaI=
X-Google-Smtp-Source: AK7set/4x5u751ZAQwe0/rqKPNenqM200IRub/sBKM8OfD/PiB5aUPJy32/YFnncJEm3ZQVYj7bZ6g==
X-Received: by 2002:a05:600c:213:b0:3ed:c84c:7efe with SMTP id 19-20020a05600c021300b003edc84c7efemr4515782wmi.7.1679299540570;
        Mon, 20 Mar 2023 01:05:40 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05600c3d8600b003ede178dc52sm3563167wmb.40.2023.03.20.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:05:40 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 20 Mar 2023 09:05:36 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <ZBgT0FINOmW7c4pK@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-5-revest@chromium.org>
 <ZBcqWqWyq0uW/wj7@krava>
 <20230319135550.22aaa04b@rorschach.local.home>
 <ZBdTA0gKh2xAk5Ay@krava>
 <20230319204731.6691dedc@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319204731.6691dedc@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 08:47:31PM -0400, Steven Rostedt wrote:
> On Sun, 19 Mar 2023 19:22:59 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > > > >  config SAMPLE_FTRACE_DIRECT_MULTI    
> > > > 
> > > > nit, we could perhaps remove this config option as well
> > > > and use SAMPLE_FTRACE_DIRECT_MULTI  
> > > 
> > > Remove SAMPLE_FTRACE_DIRECT_MULTI for SAMPLE_FTRACE_DIRECT_MULTI?
> > >   
> > 
> > sorry typo, I meant SAMPLE_FTRACE_DIRECT
> 
> I believe this was discussed before, and I thought we decided to keep
> them separate. Or perhaps that was at least for testing?
> 
> Anyway, we could merge this in the future, but I don't think that's
> necessary now.

yes, I said it's nit earlier

jirka
