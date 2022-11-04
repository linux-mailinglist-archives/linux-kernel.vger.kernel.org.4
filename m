Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07961A600
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKDXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDXln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:41:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62075317EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:41:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so6262558plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxcWYN0QpMe8IbeHvVbZgmsCBZURKwbyvHbsKgUBwN8=;
        b=NA5/RcyI/+OQpQe3YDFKBazTZ74hQ6GYZu/rT7ls86rRkSQXq33KzmIzA4tRcLeDVC
         6gyEh9+mUbyrpp+zO5QIqSKsNKVsbMhdizrHg5giFmt0cWJn6LnCuYAyvhzaMfgd2nYc
         6NIHOYPZV0ydWx+9jM34Q+l4gcDouHhz5vkqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxcWYN0QpMe8IbeHvVbZgmsCBZURKwbyvHbsKgUBwN8=;
        b=IOJwo9HFc1gcLZF2JF0rQ0xrD5UwNG19gDAFp9JlEe8Md1oKPBDXGU5IzyYrE1BRSw
         /R51B4pYfHWtcroVqVr8HTmG8d7zRt+GGQKawzPCcxTO3ZDUeOMENobHtvBguXqLLB9O
         dUDWf/jwdEPU+oNSvINW0pnjaPnCGbnEHC3YhGkvjRs5MAb/Fh78rqrDUwXw4HdaHqTv
         PYL0eIrjly/PlMi3oQjYdE4+WKNXF1CVHYJ1wDpLFEH8tqcyXhX6P7qo0bsZkUvQ0eSa
         SRCKqaRGO+yRSOM3F7LB1jtkMQzKZxBelgtqD4X+5pmYQOfhSSVrJ3pIja6pBKbT3C73
         U7nA==
X-Gm-Message-State: ACrzQf3+cojs5h8yhLRc06QXlLTUDDzDJJgNMb8mEjBaVJglxGCUOqVP
        v9QedpDuKekbRx8N6lWMslyMHg==
X-Google-Smtp-Source: AMsMyM75VpPRQl80n4mmknI/W8ioPfo1NjBA+r6ehGu10M0mLX99UGnFeH90EokugitlSssMIiRefg==
X-Received: by 2002:a17:90a:4386:b0:213:df24:ed64 with SMTP id r6-20020a17090a438600b00213df24ed64mr29322443pjg.89.1667605301882;
        Fri, 04 Nov 2022 16:41:41 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001801aec1f6bsm290872plg.141.2022.11.04.16.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:41:41 -0700 (PDT)
Date:   Sat, 5 Nov 2022 08:41:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2WjMQeS2DihvPQF@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VPQlnEiP75mY5O@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 10:43), Minchan Kim wrote:
> > > Configure 2 alternative algos, with priority 1 and 2
> > > 
> > > 	echo "name=lz4 priority=1" > recomp_algo
> > > 	echo "name=lz5 priority=2" > recomp_algo
> > > 
> > > Recompress pages using algo 1 and algo 2
> > > 
> > > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > > 
> > > Maybe we can even pass algo name instead of idx.
> > 
> > Or pass priority= so that interface that uses algorithms has the
> > same keyword that the interface that configures those algorithms.
> 
> Hmm, why do we need algo_idx here if we already set up every
> fields at algorithm setup time?
> 
> My understaind(assuming default(i.e., primary) algo is lzo) is
> 
>     echo "name=lz4 priority=1" > recomp_algo
>     echo "name=lz5 priority=2" > recomp_algo
> 
>     echo "type=huge threshold=3000" > recompress
> 
> It will try compress every objects which greater than 3000B with lz4 first
> and then lz5 if it's stillgreater or equal than 3000(or same size class).

One can be SW one can be HW. So I thought about having flexibility here.
Instead of doing

	for (idx = 1; idx < MAX_IDX; idx++) {
		len = zcomp_compress(zram->comps[idx]);
		if (len <= threshold)
			break;
	}

We would just directly use the suggested algo.

But we probably don't need that param at all and can use
the loop instead?

[..]
>     echo "name=lz4 priority=1" > recomp_algo
>     echo "name=lz5 priority=2" > recomp_algo
>
>     # or I realized to change lz5 to lz7 so
>     echo "name=lz6 priority=2" > recomp_algo

So the latter should delete lz5 at idx 2 and put lz6 there?
I can add that.
