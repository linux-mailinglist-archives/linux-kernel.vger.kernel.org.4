Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C24627513
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiKNDyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNDyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:54:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4E1582C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:54:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso9486305pjc.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRyIj1MI3rmaawWYnnr5ja9VnpreYf1sG1U947nTn4o=;
        b=lcy26kABmjAshodrK6IQSNh3Ghr5HjgEbLqJnzqRCR1aPYx8KDUmpGeHBqMO0wfAhr
         4rOszfyUJfuv3dp00XXf7ofnfjrvDr/3OKK2uYbppomN1o4V8lN3Ehpbrp1cLhDxk5Sa
         LHtIC9Bx+28iBLYe8RveQPFQ1ccEodOBvb/lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRyIj1MI3rmaawWYnnr5ja9VnpreYf1sG1U947nTn4o=;
        b=0/LAGU0VgNgIgbFY4ijduH5g0/X0wAgVBr7+O6HwsNQ8kqZlhBmGnQYT6OFrwrBj8Q
         I0d0pYkPBNzEupq9F4382RMqVmJDJmXPu+6Oc/QhzJFInbTv7nrwbmgSK87R6tSoBnf4
         uWngGPNJYq+K1WKZjXMoAGzhPsGLO4siORN4HCbHG66Hjhf6uIutl173mcwqlMirXuYK
         bjcjyM866YhCza713Y8rsrlS1T3riXn5hU8HfiKame/+1lIGcMRsyVXhhSy4zfT82ecg
         CPBN7cvGkM4DZySCY03EwOldeOqMgyqaU6v75v5pm/9XTDpPB4v6gLu/tF30F+uWzPfh
         LD8g==
X-Gm-Message-State: ANoB5plYQU2F6nijTSuJ0CSM+SNetstw04Vt8bs158B2ULzI0kkCJBeE
        UdFw7i27qjPN5Z6oJH/AjcEejV9SvwIa9Q==
X-Google-Smtp-Source: AA0mqf7PQz7Uo3RVn3xY7oynSbjLV2Ah51DsuBl4biGSr5ADhekePcKR5tqnJeXFtq1ku1CEu8Vh9Q==
X-Received: by 2002:a17:903:3303:b0:180:e685:2db5 with SMTP id jk3-20020a170903330300b00180e6852db5mr12220628plb.112.1668398042215;
        Sun, 13 Nov 2022 19:54:02 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b00176acd80f69sm6059916plx.102.2022.11.13.19.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:54:01 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:53:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3G71RFFZ/HL+yXN@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26AbHxhPBJdWZQE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On (22/11/11 09:03), Minchan Kim wrote:
> > Sorry, not sure I'm following. So you want a .config value
> > for zspage limit? I really like the sysfs knob, because then
> > one may set values on per-device basis (if they have multiple
> > zram devices in a system with different data patterns):
> 
> Yes, I wanted to have just a global policy to drive zsmalloc smarter
> without needing user's big effort to decide right tune value(I thought
> the decision process would be quite painful for normal user who don't
> have enough resources) since zsmalloc's design makes it possible.
> But for the interim solution until we prove no regression, just
> provide config and then remove the config later when we add aggressive
> zpage compaction(if necessary, please see below) since it's easier to
> deprecate syfs knob.

[..]

> I understand what you want to achieve with per-pool config with exposing
> the knob to user but my worry is still how user could decide best fit
> since workload is so dynamic. Some groups have enough resouces to practice
> under fleet experimental while many others don't so if we really need the
> per-pool config step, at least, I'd like to provide default guide to user
> in the documentation along with the tunable knobs for experimental.
> Maybe, we can suggest 4 for swap case and 8 for fs case.
> 
> I don't disagree the sysfs knobs for use cases but can't we deal with the
> issue better way?

[..]

> with *aggressive zpage compaction*. Now, we are relying on shrinker
> (it might be already enough) to trigger but we could change the policy 
> wasted memory in the class size crossed a threshold we defind for zram fs
> usecase since it would be used without memory pressure.
> 
> What do you think about?

This is tricky. I didn't want us to come up with any sort of policies
based on assumptions. For instance, we know that SUSE uses zram with fs
under severe memory pressure (so severe that they immediately noticed
when we removed zsmalloc handle allocation slow path and reported a
regression), so assumption that fs zram use-case is not memory sensitive
does not always hold.

There are too many variables. We have different data patterns, yes, but
even same data patterns have different characteristics when compressed
with different algorithms; then we also have different host states
(memory pressure, etc.) and so on.

I think that it'll be safer for us to execute it the other way.
We can (that's what I was going to do) reach out to people (Android,
SUSE, Meta, ChromeOS, Google cloud, WebOS, Tizen) and ask them to run
experiments (try out various numbers). Then (several months later) we
can take a look at the data - what numbers work for which workloads,
and then we can introduce/change policies, based on evidence and real
use cases. Who knows, maybe zspage_chain_size of 6 can be the new
default and then we can add .config policy, maybe 7 or 8. Or maybe we
won't find a single number that works equally well for everyone (even
in similar use cases).

This is where sysfs knob is very useful. Unlike .config, which has no
flexibility especially when your entire fleet uses same .config for all
builds, sysfs knob lets people run numerous A/B tests simultaneously
(not to mention that some setups have many zram devices which can have
different zspage_chain_size-s). And we don't even need to deprecate it,
if we introduce a generic one like allocator_tunables, which will
support tuples `key=val`. Then we can just deprecate a specific `key`.
