Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402066A284
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAMTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAMTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:02:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A35544FB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:02:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b17so16842178pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raqwfmS5ezGe2r4Lu6W18MRvn2Z8rsMCFVLHUYQMGi4=;
        b=VpNEwDa8ekrOW9Gaa/5koOQgPdPQ+t6OoNPgUKx8ED6A6wd6EduKTahaq7aeYT6q2c
         Xqkh6LT3Gkm+MwpUSDBemCEVnLgVzkaa4JtoSu4KUHtqTbi34d74HlScYMkkQxpSxLdo
         avS5Ii2RNX92iXaQKRqA8dYoQ4eYCwLNG0CSS8GybdZR4CawbeSOQM/0AuiWicHWxCTc
         6/AfpNea6KTYgxBYba9bkZfgS5fx30eZJOqIu3ji2StQUzYm8jUE4VsTfKkpLbOGMKS5
         ZEwAvmMIeCwoEcND18tP88vPQKTKf/5tj4EMSf3rHwmCzwBHyav5wTlMnz4K7EaWYRDf
         o2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raqwfmS5ezGe2r4Lu6W18MRvn2Z8rsMCFVLHUYQMGi4=;
        b=eQJ9n7Y2VngtuU6ic785GzQ55R6qv8uE+tOsZSjEf/WnTryFSQtHNklUp0Ez4/sdbZ
         bjCq1AsXsoa5mfYYaRefyZDRULUlLTYBe5cHFVrXBJnO+jx+L6xzXElX+5jKGmOvRqUE
         Th8AZjw0K9q9fBooWft3COnnUHsXVNfhLNLrJSdtbicvK4VmcuUXgllRxrlmUaG0ThNf
         WzXZ1l+qqVmqR2SaOIOvb+777afe3O7K4GrT9VCMxZ56SH4cLX2FvtmDFBq3fY1xQrMI
         NwzklfwywC+4X8pdfXvn/mcDU6JjgUxdPuvX+3ow6x8BnKpG7UIsaKk1PxK7lrQZjUFE
         fmtQ==
X-Gm-Message-State: AFqh2kpf/0mq9ulgmWYsZhvJABU/GQ5yTtbUMal93jCL1AyrugltEYhf
        WBJqPuZIU4yzb7DM03tDnGctraU04AQ=
X-Google-Smtp-Source: AMrXdXuk3EO0514PKKfEcmJtSLFxb7sFiLkyr4/AHda0XKFtpOMQQgCGVyF4UVfhp4o1YklMCo/9Wg==
X-Received: by 2002:a17:902:e043:b0:194:5c63:364c with SMTP id x3-20020a170902e04300b001945c63364cmr7163115plx.62.1673636529695;
        Fri, 13 Jan 2023 11:02:09 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2e4e:fba:501b:3a8c])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0019472226769sm1603702pla.251.2023.01.13.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:02:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 Jan 2023 11:02:06 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8GqrrkZhT9PAHNt@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:37PM +0900, Sergey Senozhatsky wrote:
> Remove hard coded limit on the maximum number of physical
> pages per-zspage.
> 
> This will allow tuning of zsmalloc pool as zspage chain
> size changes `pages per-zspage` and `objects per-zspage`
> characteristics of size classes which also affects size
> classes clustering (the way size classes are merged).
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>

with addtional patch to fix UL in the thread.
