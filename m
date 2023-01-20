Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24876674816
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjATAfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjATAfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:35:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B83113A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:35:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id dw9so4104878pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCyHYDBaLz6Z1fnURb4Qt86BkMinRyKO3diRuQ8zNIQ=;
        b=FBaVD0AphRnSW3+d4Io8JKM5qHrhrD9aj6RRxavcMl5GaSljqKfdgCFj2APabAKbhJ
         Kb9wYmXsBtUXR4HORNlJz+UNCGdaQE5j622iNjQMH7xLiRk31W/FK3aJtPL1eZePwFjv
         FXX2J4HL6eSotv8w2xbtwAiR258xqN6OsGgIC4Kvr5R+gEJNnjpgIjOO13p4bHNwKW3c
         Mg/K5rnssRLuX2EWbyZRZujGSR6JevEDZb0FgwelBoiL3yp3RxA7gAM5AoWYR6rhUuak
         9P2VHbQp1QqRv5edt7Jq5aY41xGKO7w70X3MmoiATLUsEWFKCXImEG8lWhKvKdTEXfoX
         f9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCyHYDBaLz6Z1fnURb4Qt86BkMinRyKO3diRuQ8zNIQ=;
        b=J0Ax0AxfJ01uOjuD/ipFUS704iY6stdQfFr6c4ZuAyTd7KtN8kS7n7lIL8O8feUz6T
         PTIxCGkonYIKN1CAglUXEuFjTj8NllUi534GZVaLeFDTFbeanj12nmmW3xn6qzbi7Gds
         XWEOUjV5qvQU1iRsBf3CGkS16raZlQleqcXortYtV16lWASmkz6H/tziZFHox7wsHe2e
         wFq8Qf61yie73JwKnACs3/yBgbt25DgBVEB2JYfz6Wm99M9lXtgcrlLxxipsIj9yAHc9
         q6G5fDD2zGbvD42n27L7897xD8VGmOjW7cEjCaLczlA6BccF5OTs+aqv2jaX8x+fv0I1
         hcgA==
X-Gm-Message-State: AFqh2kppW48dAgAUEwjyuMK1YEU7sS8scs8JVDwQEZBnvp28c8aQC/wH
        CQ/tF1XJ4DYYmbGHVmNdtWNEu2H3LPt3RtsTNNs=
X-Google-Smtp-Source: AMrXdXtW/gjsswmMXQs8zN7fOL5tJQ/DbmZ9t9MtI/Qsn25B5KiT4Vcq6i0ONVemt1tKl+q/X7ad+A==
X-Received: by 2002:a17:902:e1ca:b0:189:b910:c6d2 with SMTP id t10-20020a170902e1ca00b00189b910c6d2mr52949pla.1.1674174906389;
        Thu, 19 Jan 2023 16:35:06 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00192c5327021sm25767179plg.200.2023.01.19.16.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:35:05 -0800 (PST)
Date:   Fri, 20 Jan 2023 00:35:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag
 testing macros do
Message-ID: <Y8nhtjFcsB63UsmQ@google.com>
References: <20221107211505.8572-1-bp@alien8.de>
 <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
 <Y2okdzF60XHLCK2v@zn.tnic>
 <Y22IzA9DN/xYWgWN@google.com>
 <Y8kRuUwsKxYsk1AX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8kRuUwsKxYsk1AX@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023, Borislav Petkov wrote:
> Another belated reply... ;-\
> 
> On Thu, Nov 10, 2022 at 11:27:08PM +0000, Sean Christopherson wrote:
> > What about doing the opposite and folding cpu_feature_enabled()'s build-time
> > functionality into static_cpu_has() _and_ boot_cpu_has(), and then dropping
> > cpu_feature_enabled()?  That way the tradeoffs of using the static variant are
> > still captured in code (cpu_feature_enabled() sounds too innocuous to my ears),
> > and as an added bonus even slow paths benefit from build-time disabling of features.
> > 
> > Hiding the use of alternatives in cpu_feature_enabled() seems like it will lead to
> > unnecessary code patching.
> 
> Actually, tglx and I have a sekrit plan - a small preview below. I don't have
> answers to replacing all functionality we have yet but it is a good start and
> the goal is to eventually get rid of all the gunk that has grown over the years.
> +struct func_1 {
> +	/* EDX */
> +	union {
> +		struct {
> +		u32	fpu	  : 1, vme	 : 1, de	  : 1, pse	: 1,
> +			tsc	  : 1, msr	 : 1, pae	  : 1, mce	: 1,
> +
> +			cx8	  : 1, apic	 : 1, __rsv2	  : 1, sep	: 1,
> +			mtrr	  : 1, pge	 : 1, mca	  : 1, cmov	: 1,
> +
> +			pat	  : 1, pse36	 : 1, psn	  : 1, clfsh	: 1,
> +			__rsv3	  : 1, ds	 : 1, acpi	  : 1, mmx	: 1,
> +
> +			fxsr	  : 1, sse	 : 1, sse2	  : 1, ss	: 1,
> +			htt	  : 1, tm	 : 1, __rsv4	  : 1, pbe	: 1;
> +		};
> +		u32 edx;
> +	} __packed;
> +};

IMO, switching to bitfields would be a big step backwards.  Visually auditing the
code is difficult, e.g. when reviewing brand new leafs, and using cpufeatures.h as
a quick reference is essentially impossible.

E.g. I often look at cpufeatures.h when I want to know the leaf+bit of a feature,
because trying to find the same info in the SDM or APM is often painful.
