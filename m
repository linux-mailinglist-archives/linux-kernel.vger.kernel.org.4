Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22567DAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjA0AyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjA0AyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:54:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C4D5895A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:54:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so2027825pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEIeBysx6lstniqvWYEj+an/AzIWqhVrgAAj5NjMc4s=;
        b=dBowJHoLQntMw8JzlzkdP8SJUrroMPRbSfJTI8HhH/6fQc8mzyj63PewT8H2g70JZO
         XR2rXXjb5tR5ah3wpNw7zXK78wc7coTdEgmGr1NDOCGinNE4CqPZOoGeyVmvAwvjntCF
         lVQPa+eWVM+SESt0wQlDsThyixlxk9P5xRBcb4BUyvRxIbkEAobrcUabe00qevYN4yld
         Rj9lX1McxpNS9fy7ahyv0HGRZK4DLEE207MkhofsvkRoA6XZVvyldJBwt97aVMZUh001
         QSyI8VWP9ebgpDSaODWYvC4pyWbCd+XmQyNRme0cIW3bZFIWDhtb57nRqJC5KQgoBMW8
         iCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEIeBysx6lstniqvWYEj+an/AzIWqhVrgAAj5NjMc4s=;
        b=GfZo+OxxIxQcUe9Wns76QjdiDgvVWZf4aOmc4PVpjpUjFV0MXkHuejwCkpg8RsP9uA
         WHPfvIc7TUqD758AfZ4aq4e321wNBwuhqX8bY3qva0rKEUHMdRS2/jVAMmvVXPLUcn3L
         wdXYA+S5LmumksPydjMrovTPdUI01TcOPDV7nVCXmgM5nxY1dKUSMdhCM7FawhnUNGjx
         9ZsJa2xwHF6Cbk3He2SSI1MNzmwlFCWaHXp+HgzJFQKbD+Rgcw8gN43V79P/CATV/aOV
         VRYYr8WkdefyhpPJqeS3H/kyeouWrCgr8uUc9tSbjZqDgQu7TOfNJvU7M3GoG2+vZMU0
         ZfGA==
X-Gm-Message-State: AO0yUKX0sPs3tuD7NI8/EkRG9tno26SrpoAHIaEsLW2/pBIGEwftI7yn
        qYWNUdRlfkhUvlgelG9Nn8JTBA==
X-Google-Smtp-Source: AK7set93yuuj9GvSPwrVqsYKu8qp4aLjfMFToEQojUORfgciZYzThZo6pOLUfrAAuhAS88V+09gYnA==
X-Received: by 2002:a17:90a:eb06:b0:22c:952:ab22 with SMTP id j6-20020a17090aeb0600b0022c0952ab22mr863690pjz.1.1674780852536;
        Thu, 26 Jan 2023 16:54:12 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:497:8b7d:bb75:1c3])
        by smtp.gmail.com with ESMTPSA id g12-20020a63374c000000b00476d1385265sm1274993pgn.25.2023.01.26.16.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:54:12 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:54:07 -0800
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-mm@kvack.org,
        Saravana Kannan <saravanak@google.com>, stable@vge.kernel.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "mm: kmemleak: alloc gray object for reserved
 region with direct map"
Message-ID: <Y9Mgr0NhaTWCsXYz@google.com>
References: <20230124230254.295589-1-isaacmanjarres@google.com>
 <20230125210215.GA2879887-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125210215.GA2879887-robh@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:02:15PM -0600, Rob Herring wrote:
> On Tue, Jan 24, 2023 at 03:02:54PM -0800, Isaac J. Manjarres wrote:
> > This reverts commit 972fa3a7c17c9d60212e32ecc0205dc585b1e769.
> > 
> > Kmemleak operates by periodically scanning memory regions for pointers
> > to allocated memory blocks to determine if they are leaked or not.
> > However, reserved memory regions can be used for DMA transactions
> > between a device and a CPU, and thus, wouldn't contain pointers to
> > allocated memory blocks, making them inappropriate for kmemleak to
> > scan. Thus, revert this commit.
> 
> Both commits talk about the same type of memory as CMA is used for DMA. 
> Neither commit tells me what are the implications of kmemleak scanning 
> or not scanning the region? Are there false positives?
If kmemleak scans the region when CONFIG_DEBUG_PAGEALLOC is enabled,
and the CMA region is not in use, then kmemleak will cause a page-fault,
because the region is unmapped from the kernel's address space. kmemleak
scans the region because it thinks it is in use/allocated, when it's
not. While this sounds like a problem of kmemleak not being informed
about the region not being actually allocated, it's also a matter of CMA
regions not being suitable for kmemleak to scan in the first place,
because they don't have pointers to other memory blocks; they might have
data from DMA transactions with another device, so it doesn't make
sense for kmemleak to scan these areas.

--Isaac
