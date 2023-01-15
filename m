Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0665B66AF7B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 06:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjAOFc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 00:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAOFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 00:32:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8EBBB6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 21:32:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q23-20020a17090a065700b002290913a521so8678336pje.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 21:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pV+Lc/D2szFMSqw+ADbk9E95BAdnQD4U8oWvWD9EP0=;
        b=UsjVTg8UKzR4bqwwTKuexbqPD1K8c7rYDjqkBdbFTSxrx2z6wdrNX0rYuViUtvpSLV
         aaTQxaoUuT4GWrqxIzEBSwTzVfq97lPKXME7jRoptzIp/axAt1lrlRmLuOo5bQrVrS4a
         GJLrzFIf55B1ja1GDXVtB6vuIGHlmafdSBUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pV+Lc/D2szFMSqw+ADbk9E95BAdnQD4U8oWvWD9EP0=;
        b=3FJ/YEAAcEJff09xnNtRMoEdFPiAt8IE6KbwqPcaVO2DuZhnyYljnt8/yO0uT0fVD1
         Owukr5RXVAXo8vkF574xBqPOmsDVqRpyxL7xcHdWI/yIvU8BdwFRWCNoSzkQJngftEF6
         FccpQAtl5mKuuNDEE9FH4qgCdCO6cb4MwG+0vo9pjh8fe8MR1UoTkGQFAPsccu3jsiOb
         WKjxUgmDvKLqN9PuKTKQu2HlaAi0wkXUonu+9mHx1PvxB4EU9LjM+CP2NJWeJ5rgs9Bc
         u187so9EG9Ugb8OpWiviP/psOR5YohomnIQDWoW2TR10n7O6B3SHlrJp4rsHzvQEOE9s
         npag==
X-Gm-Message-State: AFqh2kpaDpHjTVpZUu4m/ji4l6YIJV8GcWEFoAdAQ7Y/iHBQ58HrauRY
        AjSgp9B7XkXfmGk2VfS+1tXrUg==
X-Google-Smtp-Source: AMrXdXu476ANBdQERztD+vprQduoY6AMavWCXl/BPijSPZwRKQxObo9GyB33wyLGp+GtSOUJky208A==
X-Received: by 2002:a17:902:ccc5:b0:185:441e:4cfc with SMTP id z5-20020a170902ccc500b00185441e4cfcmr100561742ple.44.1673760775240;
        Sat, 14 Jan 2023 21:32:55 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001913c5fc051sm5646253plg.274.2023.01.14.21.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 21:32:54 -0800 (PST)
Date:   Sun, 15 Jan 2023 14:32:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8OQAl6rfjoKhwxm@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Mf4f2TTH8yY8Ic@monkey>
 <Y8N/Te/t9aLkKi90@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8N/Te/t9aLkKi90@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/15 13:21), Sergey Senozhatsky wrote:
> On (23/01/14 13:34), Mike Kravetz wrote:
> > I did the following:
> > 
> > - Start with clean v6.2-rc3
> >   Perform echo, did not see issue
> > 
> > - Applied your 5 patches (includes the zsmalloc: turn chain size config option
> >   into UL constant patch).  Took default value for ZSMALLOC_CHAIN_SIZE of 8.
> >   Performed echo, recreated issue.
> > 
> > - Changed ZSMALLOC_CHAIN_SIZE to 1.
> >   Perform echo, did not see issue
> 
> The patch set basically just adjusts $NUM in calculate_zspage_chain_size():
> 
> 		for (i = 1; i <= $NUM; i++)
> 
> It changes default 4 to 8. Can't really see how this can cause problems.

OK, I guess it overflows zspage isolated counter, which is a 3 bit
integer, so the max chain-size we can have is b111 == 7.

We probably need something like below (this should not increase sizeof
zspage):

---

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 290053e648b0..86b742a613ee 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -129,7 +129,7 @@
 #define HUGE_BITS      1
 #define FULLNESS_BITS  2
 #define CLASS_BITS     8
-#define ISOLATED_BITS  3
+#define ISOLATED_BITS  5
 #define MAGIC_VAL_BITS 8
 
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
