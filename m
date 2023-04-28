Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596276F170E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjD1L6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjD1L6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:58:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B521BEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:57:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so48764475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1682683078; x=1685275078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsX+f2IVkrgIdegQ6uKKgRhQWYSnAO+rZAXPTc6eFzQ=;
        b=3jJQnCut07J8zy9Biyr+bO/xtD8DeDGs2SxiwURex4qhDQ1Wb01+iECUaNheV/doqD
         OG9nnuhy3zqksjIxpm0cwBhP4Jtv4NqkFy6//G3vwyJpVwvi2U15N7CZBtJppiAu5rx+
         zLvyTpXv5Ey4SrOfq22A+yT/ybX7mx5e6XqIpgi++Bffp1U+72yv6lmEFwOhLQKENg7e
         k+UiDrTNj24lY0l2FgZhHfpoP/sDkMng6Th/lZilXHPYYHQLmO6NtOSRahiKi/nugeWj
         fjJcFfg1iI8oe/glKmhxEIXl6xvP852dDZ0aNotqCGyZsvtuZJfTJLMt7Q1yrl8jO3lI
         CPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682683078; x=1685275078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsX+f2IVkrgIdegQ6uKKgRhQWYSnAO+rZAXPTc6eFzQ=;
        b=kV10pCaT4kI332n5y1p38+7TfDC+r5gYJ0iSAW5aFQk8pMltRf7ixop11XyF3IY/Rf
         rNiY4VV8RmI919ReKP3CY9uAXpzC+VczTxIWSfjY6ai88LKkxW2y6EXR5ehUYC1zAlyR
         9R9Tow1Sywi9TyGuv2RDkO+TbVE3BE6EIIWEZ31R2TI410IFyDwT/XBWhiFRiLUmY+su
         AwimogGFpIDP7DLEUbcahKkEbaTm2BXSlvMneO3KpqRgVxk/jjXmr/VcTe+o8At40VpQ
         McZKbALnTPwQC0N7lwLMiq9cImJ/hTLL1E+OHTF8klhLHJNyFC3f25i/lWKnC3bWdgot
         sdtw==
X-Gm-Message-State: AC+VfDyr18IUA5YPpGwa7DbPpsUMruSTWcan33ZINr3k9DxcmmBekl/e
        6dE3iBBfU3wCw3i7PkuhcY/lZA==
X-Google-Smtp-Source: ACHHUZ5qlznKumS9+Zdawgx01GzOraXJNXDFT99JHjP3PH6HlY7mwqao0AKyOVTi4esaViSkw/YLxQ==
X-Received: by 2002:a7b:c5c6:0:b0:3f1:9acf:8682 with SMTP id n6-20020a7bc5c6000000b003f19acf8682mr3483951wmk.17.1682683078081;
        Fri, 28 Apr 2023 04:57:58 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id y32-20020a05600c342000b003f173956a82sm27332528wmp.21.2023.04.28.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 04:57:57 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:57:55 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230428115755.7uklfd4fmpoee4dp@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <20230419175414.ycnlaperdkjxgypx@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419175414.ycnlaperdkjxgypx@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/23 18:54, Qais Yousef wrote:

[...]

> I was considering to have something a bit more generic that allows selecting
> which attributes to reset.
> 
> For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
> SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it extensible
> if we have other similar use cases in the future. The downside it *might*
> require to be done in a separate syscall to the one that sets these parameter.
> But it should be done once.
> 
> Maybe there's a better interface, but I think it makes sense to do it in a way
> that we won't have to do this again. Would be good to hear from maintainers
> first before you take my word for it ;-)

Actually I think we can do a better and simpler generic interface. We don't
need a new flag. We can just add a new parameter for what to reset on fork.
When this value is 0 (which it should be by default), it means reset
everything.

// pseudo code

#define RESET_ON_FORK_ALL	0
#define RESET_ON_FORK_POLICY	BIT(1) // implies resetting priority
#define RESET_ON_FORK_PRIORITY	BIT(2)
#define RESET_ON_FORK_UCLAMP	BIT(3)

struct sched_attr {
	...
	__u64 sched_reset_on_fork_flags;
};


Cheers

--
Qais Yousef
