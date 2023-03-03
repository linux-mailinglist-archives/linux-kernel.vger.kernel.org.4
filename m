Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E833F6A8F05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCCB5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCCB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:57:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935415CB9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:57:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p20so1186403plw.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1JY9qAQaVPtwW8pbTi193xRy3To8OgGxPisxr9W/+Q=;
        b=XfgMeJU2499eB7h4inb3tPyBLMSEri3RDc/Y1tCyRvdVwLrqssnUhp82FJzJQTjDrT
         G/qkZjurQdkL7CQ9eJSqhmOFLLXOn6Ioqn/gUw/Ilnf/aka67SO/LXI+F3UVbJPHLJW7
         /piwT5e34DTdkYHDcVNtJZ7SoDL3X2vTshLAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1JY9qAQaVPtwW8pbTi193xRy3To8OgGxPisxr9W/+Q=;
        b=uetDjaHc2yh3fTXJPJccpf8lGA0g9adyEKLT8GAHYns1M+ZmlE/PH1bEWOJ7fl1n8d
         z1f7ONuH8+t6gFzZjLbLb6HN2r4BZLxXgsIakR0p/WlFoKoQQ4EXTRzpN/Uhxv8OOO5y
         6s7MWagAJRlnS+rm8UBImD+HYbSU7OVUuhIfaRq3Z/9uuTCmPZKraOysdhbnppxPnI/t
         kdPp+7WybHQbDA0IqyfCOZDtZjVEY0iktlWLD57nkbSRtF93S+tMe3vHLcnCXnPFr0zM
         +qlOdUcminZBMxPCxEsHZmsAP/GovCgvRxam2GWFk3x8rbeaaLDJUeodOx3m6htMxiLv
         SuZw==
X-Gm-Message-State: AO0yUKXJxfB82Es+kgaS67vy6dvlNx5oidxPwDQdLLewN3W/1ZQ9P0SA
        vYrzs8k0F6wgsdfBRgPob76NIg==
X-Google-Smtp-Source: AK7set84d7+Pv9ZbBDJRsmxLnTvKT9/3OI5J587MlSNWV12F04oQRLoXViDlM5tKVb2tantx0/IEUg==
X-Received: by 2002:a05:6a20:1585:b0:cc:32aa:8570 with SMTP id h5-20020a056a20158500b000cc32aa8570mr640098pzj.14.1677808663408;
        Thu, 02 Mar 2023 17:57:43 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b005d791692727sm320573pfi.191.2023.03.02.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:57:42 -0800 (PST)
Date:   Fri, 3 Mar 2023 10:57:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <20230303015739.GC4022757@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
 <Y/f75fkcQg6m3cbG@google.com>
 <Y/rYQdUDNHDCJJTO@google.com>
 <Y/5+PEfuEl3b/sDR@google.com>
 <Y/7MkLdVXImxPQeJ@google.com>
 <Y//kMuCV7dzdrfGp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//kMuCV7dzdrfGp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/01 15:48), Minchan Kim wrote:
> > in general does not have to do comapction, since the kernel will
> > handle it.
> > 
> > Just an idea. It feels like "pages compacted" on its own tells very
> > little, but I don't insist on exporting that new stat.
> 
> I don't mind adding the simple metric but I want to add metric if
> we have real usecase with handful of comments how they uses it
> in real world.

I'll drop it from the series for now.
