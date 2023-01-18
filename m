Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91067248E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjARRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjARRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:15:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AAC56EE7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:15:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v23so32644354plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8URXL0g5rP++dbqWYl28P0iVLebVKCYu9KmAtnC+wM=;
        b=UcSkiLj/NK3o8cjDtgD9XRVk6iG5uDXvyCWSbAWzFGwfi0ESKFCDEMrJP2q8ZrhumN
         TsEih8ko7TgWUO5gBYqS/hgBvRzqH9qT1o83M/TaKLpMNCG/LflUDs3uq8TUXaKsd8nW
         YxQjmi18aQLeoAjvbyX4xdJPfNobPuT64dfCmPOdlpD6FpYnRBBONtXGcwgsh3sjFYIL
         BH8/tScdIO6rxMemPEM6i6mE0joN5TP6+hc+LvBDGSpRj8Vzk5mjDNWZcHHWW+wEYpX7
         TA6/g8QgbOKe4cz9XIR49aU5TavBhcmRME43zkwMmzOJUnLn7aUc7V7AziQsbnQjPZ1U
         jl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8URXL0g5rP++dbqWYl28P0iVLebVKCYu9KmAtnC+wM=;
        b=1cARsAq1wRrWOleZnIsxLhy+YvZbrrywlf3/gqmlI5A4SDXZodsfl2cHWTl6X6KmBk
         MMB3GPHfDjb64kZm9fgitZkok61hlx09c6QZCSANu1AUVx9JO0oFzEsgfrWqWyhIkANp
         x9cfqy3TjZgy5YIIpSN/ubaUwqYv8XE9wwMaUur5Dddh3Pa9q+ItKwRRU1FCY5XBGmww
         FaJU4mc3xOATT2shq6/8xixhiXuSaZplSqQTAweGQpLpo1JzekrVVMGpf/522y0UN0tK
         CWy06cj/czoJUjV0znWXLLN/aea4/vdcl2tXAB1WhHnXu3Bd3tO2jhz/+7gtWzeTfaqB
         aEyg==
X-Gm-Message-State: AFqh2kqI8y4tsrrtxQSZeyRR6WhkPoj0B0VhQaAfosVJ0LyM0Ie+SKs0
        CrwpezygcsRefgx2jekXgFs=
X-Google-Smtp-Source: AMrXdXsT7QerPmp3cyONHhh0km7P1j16p9YaS14E4UFOJwnAFzNu8PPDMDTSSnSZPMPhVcoz3AW0Eg==
X-Received: by 2002:a17:902:c94b:b0:194:acd1:6624 with SMTP id i11-20020a170902c94b00b00194acd16624mr9116898pla.61.1674062137128;
        Wed, 18 Jan 2023 09:15:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001929568afe9sm23268757plk.306.2023.01.18.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:15:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 09:15:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8gpNgkwMqVPN7dm@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
 <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:11:46AM +0100, Michal Hocko wrote:
> On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> > madvise LRU manipulation APIs need to scan address ranges to find
> > present pages at page table and provides advice hints for them.
> > 
> > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > shows the proactive reclaim efficiency so this patch addes those
> > two statistics in vmstat.
> 
> Please describe the usecase for those new counters.

I wanted to know the proactive reclaim efficieny using MADV_COLD/MDDV_PAGEOUT.
Userspace has several policy which when/which vmas need to be hinted by the call
and they are evolving. I needed to know how effectively their policy works since
the vma ranges are huge(i.e., nr_hinted/nr_scanned).
