Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43297633560
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKVGf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:35:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B62DD8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:35:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t17so11756318pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZcw3xphyFpaMwrz2/RfL1TkxCNnDZvBvwaHcEozeVo=;
        b=gc9iRvo0HrISQTXfnCpl6IEX773OMidfAI9E+Bb7/VBj5N0v4YGejsaBNYalbQcr7P
         ca7cJyaLQXrWjybpdkYaCoP5dOAVQ9l0p2JXEr9RDeLXUB4dSPZyPOcWNGS2RPBynVBP
         Y803ZBp6/+ub5d150Lwt44vPD+OpF7ztHLoN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZcw3xphyFpaMwrz2/RfL1TkxCNnDZvBvwaHcEozeVo=;
        b=uLUZvUKVJUBPFJiFqIiDJ/vm7G4TzuA6POHtoL4uoPUobcI8XNgavO6oUoe699k+6p
         wFLgcswQfbdGI0M/yBeL8FCTE7avmzoGBxWORlmH/phcubNMkQyuVuAYmrk/yqb8S7zQ
         bp24fyVJwfVli8rPhUvp4GhlF05EnP5nij0SPk42T8Fo5c6duMb95VrhybxIwkj36BeM
         Z6o0jLHTeKSfW35sba9ifrDIAqwiilzGPQ8uDvvgu4AQmR4+YbEzlkx6zLgodqVUR1Pz
         L6+7JXrDMGexn2ky4uhMe0xxuHshWX9HrDLDUf1I0AT6u5PgM29NVG/H5qLgLwky/wlf
         tGdg==
X-Gm-Message-State: ANoB5pmxsjtH0EEaBiuxiXs/yzJwHNgnHb53+BqRia38K06LV3tsaI4Z
        qEY42ue3eJ25FqiP3iZI0GlR3Ox3MyricQ==
X-Google-Smtp-Source: AA0mqf7R9zv+5zht7rNwqMkVgWWExmmyK2xXlbenlYgDUv8aZO3AGFXUNg4nEe2uDHIGcItotOUx9w==
X-Received: by 2002:a17:90b:2542:b0:1fb:e7a:79b with SMTP id nw2-20020a17090b254200b001fb0e7a079bmr30708699pjb.93.1669098924054;
        Mon, 21 Nov 2022 22:35:24 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b0016d9b101413sm1472468plg.200.2022.11.21.22.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 22:35:23 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:35:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3xtpoQpb8DuiTlh@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
 <Y3w+C8ClzP6VbqrA@cmpxchg.org>
 <Y3xFHIgkiZNYCbHi@google.com>
 <Y3xnf7pR4vI7o9PV@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xnf7pR4vI7o9PV@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 01:09), Johannes Weiner wrote:
> On Tue, Nov 22, 2022 at 12:42:20PM +0900, Sergey Senozhatsky wrote:
> > On (22/11/21 22:12), Johannes Weiner wrote:
> > > On Tue, Nov 22, 2022 at 11:15:20AM +0900, Sergey Senozhatsky wrote:
> > > > On (22/11/18 16:15), Nhat Pham wrote:

[..]

> > What I meant was: if zs_reclaim_page() makes only partial progress
> > with the current LRU tail zspage and returns -EAGAIN, then we just
> > don't increment `total` and continue looping in zs_zpool_shrink().
> 
> Hm, but it breaks on -EAGAIN, it doesn't continue.

Yes. "What if it would continue". Would it make sense to not
break on EAGAIN?

	while (total < pages) {
		ret = zs_reclaim_page(pool);
		if (ret == -EAGAIN)
			continue;
		if (ret < 0)
			break;
		total++;
	}

Then we don't need retry loop in zs_reclaim_page().
