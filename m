Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08CE65FF38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAFK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAFK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:56:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769E6B5E5;
        Fri,  6 Jan 2023 02:56:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so927092wro.9;
        Fri, 06 Jan 2023 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mWOqsJxxhaYX11aVse0gF3iuzzCyD8Tm3ggJlMzbco=;
        b=ZdC9rjcxkBTLbJcL5wOAh+p7ibccSZW3xZfYMQrJNhgylswEV01HwZI3we4UYGftLP
         lTicQNZNzY3Go+TBfhMYpZ6Ug/pCXx0WsLpkCPp5UbyD8Xp0TYj+OD8z9wG7iRdvig+z
         lOOhLowF7Z+6FTKGeN+6QKNSGwSGKftJbhhWEo2JBlKaAryF+zjiCIcGz/UYeFCwzrIT
         eUv8y5AuupfuuHqpfYK5cyMzRUs5d1TdsJbR8daja6TjwA/VnJhaG0jFyFeJZVDmkPA9
         1EUNt+MAtzVhF+/Bo4fwKvOXeUn3d860SIEm0Qjvh8us/Lr2QQcHw64iX6bmUFxbHKpq
         770Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mWOqsJxxhaYX11aVse0gF3iuzzCyD8Tm3ggJlMzbco=;
        b=hTu38QrEZ0C5uLq1THTJV1ZqDyTFV6BIBFcMLs1EPIOHOfvXva05JlzoxWLxorSSNo
         VtRkHq9SsmMbUsgslKgWT5E8A8cjznpBZDqr9oQHUoz8M9rARuHhVRnvflxeI9xyV6SZ
         sqWcoazG0rhxwB2dxsGDU1BOjOC3lDiK7GAaMX7QBPPdeP6b3MC1nHC3NCUnn32xmgyc
         hTMRL1IVJUQxu/83HQ3syDzxvDcfv3+MNhE9rte3qEimK2/oX5F8kjWoP98ZCUfPCx1i
         FuJAOu9f/bPa1qKC9e3CQRq6udeRck6aJtXx8hGlk+YIQ9VdQdyXSZB/vk75R9+WQXEy
         HR7g==
X-Gm-Message-State: AFqh2koEHD6navwwu4SqX6vf5OHD9I1HoScKPTRdNJnxL7elrtuFYkw2
        sgq+k7TtHCktYbn4fKXdozo=
X-Google-Smtp-Source: AMrXdXuuFTroJ+2P4EeAszGlF3/F6A7wsVMdsRXssbHSDgugThP/LwQmsWXLjttpUmhwIDynXN07YA==
X-Received: by 2002:adf:fc01:0:b0:297:dd4a:9207 with SMTP id i1-20020adffc01000000b00297dd4a9207mr13817809wrr.10.1673002583921;
        Fri, 06 Jan 2023 02:56:23 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002779dab8d85sm854904wrt.8.2023.01.06.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:56:21 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 11:56:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Message-ID: <Y7f+UqN5qqfJUeoy@gmail.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
 <Y7f6RhF8FuK9R399@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7f6RhF8FuK9R399@zn.tnic>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jan 06, 2023 at 06:05:41AM +0000, Zhang, Rui wrote:
> > But I still have a question.
> > Take RAPL feature for example, the feature is not architectural,
> > although 80% of the platforms may follow the same behavior, but there
> > are still cases that behave differently. And so far, there are 8
> > different behaviors based on different models.
> > 
> > In this case, can we have several different flags for the RAPL feature
> > and make the RAPL driver probe on different RAPL flags? Or else, a
> > model list is still needed.
> 
> Well, you asked about detecting CPUs supporting RAPL.
> 
> Now you're asking about different RAPL "subfunctionality" or whatever.
> 
> You could do the synthetic flag for feature detection because apparently 
> giving it a CPUID flag is soo expensive (/sarcastic eyeroll) and then you 
> can pick apart subfeatures in the RAPL code and do flags there, away from 
> the x86 arch code because no one should see that.

It's a trade-off in any case: there's a point where quirk flags or even 
feature flags become harder to read and harder to maintain than cleanly 
separated per model driver functions.

Especially if internally at Intel RAPL functionality is not yet treated as 
an 'architected' feature, and new aspects are added in a less disciplined 
fashion ...

Sometimes the addition of an 'architected' CPU feature iterates the 
feature-set non-trivially - as people consider it a last-minute chance to 
get in their favorite features without having to deal with backwards 
compatibility ...

So I'm somewhat pessimistically leaning towards the current status quo of 
per model enumeration. Would be glad to be proven wrong too. :-)

Thanks,

	Ingo
