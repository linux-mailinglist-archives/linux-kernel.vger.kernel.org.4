Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DFE619D5A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKDQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiKDQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:34:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58CA2BB0A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:34:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so5378844pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65ZgVVpFNi6t9ZbbFlNcLrUCFgll39HRPUe2NP0G3ME=;
        b=Yn1Jq5Rypb5TMFcclS+/xh9ALhTtJPg7PyVMuQuuJ7Uvyo0swjuJqSJq2hinNlNX82
         HyS0bkaDR3FBTdVdNjB99r6urxJTtgTZRQESivu7k32X1Vm18rfFEzq6175sVdmcgdrV
         waq/7Wd2wRB/4OTTLKLzDiYkcCEnk7qKvNb7ddEl+BSojHQ5bMeOexWHk4ybhRMMupEY
         I6Bv3kqsWVldlATIPztxsqZFomXI0eeKU7BfMy+wgsi1DEqU+nR/4/f33APFZj49fckP
         Qkyq+gDEJkm9BD1/+nNZ5UmkB5SNWGLPRUlUfW+SvtE60Fcp9CMT7hbM2wlhz1fOBD0x
         UEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65ZgVVpFNi6t9ZbbFlNcLrUCFgll39HRPUe2NP0G3ME=;
        b=LSg5pwyHjyu6N/TlJC7pb1IkqnNtP2wgXx3detzQqqk+yPnhA/ZUEU+cAh9B8duq4w
         zeN8r2lryVx2wKGQ0Uo6hywA0WhxX4tNlq7cO3rK+uVe62LUcRs1/PMIWdFP8IXL9J6D
         bM/X+DDUDUSQL7AOyGMXHBfXCsvQs7Yj7k7qx1H3l22GTnOqDh0MZygcmqVkOMMeR//g
         0YVOT6MtQJT1vsv6PBEVNVP3ne3b1i5u9PPxqTgD6+7/pVvqgY6trBQdx9XQje4QRx17
         hoNmNcD+3mrtThwYsRXclhW2cGynMbOgUticNAQtRJP5rF+06290CYmijnS1HHSUOpH+
         5ZBg==
X-Gm-Message-State: ACrzQf3pBg/sOJ7KOUQXt99TBlZ90xDU848Iv5Lq/etEpY6zm8h2cWTp
        fpg+ILgGf/Q/SuA3gZBbzQVJFkzSm8M=
X-Google-Smtp-Source: AMsMyM4Jd1xizkclHqBmqKkerb0oqiNvijhcQpagma+1dspcUyG/cjondYuYDQfGlVS88g0QTk219A==
X-Received: by 2002:a17:90a:4386:b0:213:df24:ed64 with SMTP id r6-20020a17090a438600b00213df24ed64mr27859441pjg.89.1667579650088;
        Fri, 04 Nov 2022 09:34:10 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b005624e2e0508sm2874118pfq.207.2022.11.04.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:34:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 09:34:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2U+/xQBwR3MPygL@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2SEkzKSWx2iQzLl@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:18:43PM +0900, Sergey Senozhatsky wrote:
> On (22/11/03 09:34), Minchan Kim wrote:
> > > > My point is that we don't need to implement it atm but makes the
> > > > interface to open the possibility for future extension.
> > > > 
> > > > What do you think?
> > > 
> > > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > > right now. And existing recomp_algo does not enforce any particular format,
> > > it can be extended. Right now we accept "$name" but can do something like
> > > "$name:$priority". The only thing that we probably need to do is rename
> > > recomp_algo to either add_recomp_algo or register_recomp_algo?
> > 
> > Yeah, I like the name and priority format.
> > 
> > Only question is how we could support algorithm selection change
> > under considering multiple secondary algorithms.
> 
> So what I was thinking about, and I'm still in the mental model that
> re-compression is a user-space event, just like writeback, extension
> of recompress sysfs knob with "algo_index" (or something similar) which
> will mirror algorithm priority.
> 
> Example:
> 
> Configure 2 alternative algos, with priority 1 and 2
> 
> 	echo "name=lz4 priority=1" > recomp_algo
> 	echo "name=lz5 priority=2" > recomp_algo
> 
> Recompress pages using algo 1 and algo 2
> 
> 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> 
> Maybe we can even pass algo name instead of idx.

Let's use name rather than index.
