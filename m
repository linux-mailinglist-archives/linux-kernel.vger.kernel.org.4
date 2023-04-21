Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580086EADF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjDUPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjDUPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:24:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE0118F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:24:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-74ac861476dso110640485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682090689; x=1684682689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RftFvtCXSnbWL3l9VrIM7QoXKzHXMSCTPiXt889YEl0=;
        b=2Koj6mzw3RB+sbrzYnqnCKjrjNHpKSVBtvarxtDPzVtew+23aLMKQMKePtcp14DQmb
         PwYLmSeJce+OF4PU8/+dKX00Bia/q/LBbQ9ClaqyBbhtT+qXbhcKkE5VRiZJhJNm9nRa
         5y0VGmQlMXLhnXs7OBbgHqowKSWj9OQO4LKUbYNwE4djSFPOieKv1Guu0rHbzXtJPsSH
         XW8ZJUn0W8O20HSkv7qKX+yhb5b8N4dNAdvt4zGMujMewOhpIpfYU5HhJRycj3vaLfpy
         FigyJpT9bbXeFhKBt6LsRN1q/TlsGfryYW9NbY6EgcHDv0fAwzbTtdBLbpcFyc9IME0B
         fEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682090689; x=1684682689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RftFvtCXSnbWL3l9VrIM7QoXKzHXMSCTPiXt889YEl0=;
        b=VntP8l1mqjADYaENgQiRbYcXt+ZQA31AEqs/65PWM7KL2v08za2B7LqSPYqot4XNxm
         lSIFvP56ZN5ZXll49NuW2Ai+hNkt/1guMY2L/IXdrVNyo0fZYpE72/pMnu41bvuAupSG
         do/6Yp3c8sBSz3bkg6neFt8fitRqGGKLUaQn81+4JOQ33Ca1DyAb60Cuuaf8tb0HtY8X
         sxLvbjcmJ2+zmX2QYXwQTyMirt0XMgmqTRIBAisnLzCjqu0XUs5tla2avJDLph0gYOcY
         6SgkgfMsN7wxZEh7QStHKO8Iwa4tVhmPvG73cEp35Roi/2T8jeksrZRYwJnvdhuqN37P
         Jf5w==
X-Gm-Message-State: AAQBX9elCYTGxZ3BqSX/yRxKm66t+4koFhtMjbHPijZFNfzLJyL/XpAF
        SKP5nxvbfbrbfAKXPo9L0pjihg==
X-Google-Smtp-Source: AKy350YGwgWA7VkCxUROUCL59NSexIgVNi4Dsmr1wFDncC6uDyg04UVnatGNxweGxP/q5UaRc0mMWw==
X-Received: by 2002:ac8:5947:0:b0:3e4:e39b:357e with SMTP id 7-20020ac85947000000b003e4e39b357emr8591422qtz.44.1682090689314;
        Fri, 21 Apr 2023 08:24:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id j18-20020ac84412000000b003e6410b4bfbsm1382312qtn.28.2023.04.21.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:24:48 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:24:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 25/26] mm: page_alloc: disallow fallbacks when 2M
 defrag is enabled
Message-ID: <20230421152448.GD320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-26-hannes@cmpxchg.org>
 <20230421145657.fnpjqkuyquy3z24t@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421145657.fnpjqkuyquy3z24t@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:56:57PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:13:12PM -0400, Johannes Weiner wrote:
> > Fallbacks are already unlikely due to watermarks being enforced
> > against MIGRATE_FREE blocks. Eliminate them altogether. This allows
> > compaction to look exclusively at movable blocks, reducing the number
> > of pageblocks it needs to scan on an ongoing basis.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Conceptually this could be fun if a GFP_NOFS allocation cannot migrate
> enough memory to free one pageblock and there are no pageblocks
> available of the correct migratetype. Fallbacks might be unlikely but
> never being able to fallback is a livelock risk, no?

The reserves below the watermarks are maintained in neutral
MIGRATE_FREE blocks. So just like today, critical/limited allocation
contexts are ensured forward progress as long as there are reserves.

An argument could be made that because smaller orders type-claim the
entire neutral block on allocation now, the reserves can deplete
faster than they do today given comparable watermarks. I haven't run
into this issue during testing that would have me raise the reserves
by a factor of NR_MIGRATETYPES. But something to keep an eye out for.
