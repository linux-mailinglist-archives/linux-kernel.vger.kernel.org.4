Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C828764A855
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiLLUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLLUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:00:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5183E17431
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:00:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w23so13204513ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1JwA4591V3WWgjpQbG6VpbXkMhkR+cvLtonZzzHudc=;
        b=bfxshwMaLU3HbMZsNFLMaIIXxXoewfJPvLfv8fNcQ9xVzr3N7zUXskhUOSQQ4HOIGV
         C3QkAsPMqE9x3QD15QUA5F/sSa+3a/Tn34Vwyv5VK8DadYLDQeyw/7kH9D1EQMXlwQ4+
         i3NjWmf6KFkx6sjgs3GdZ3twUEYkQPIrpeMgEC84ypMcbtBNq+8RSuV34QNECAaIycaU
         /gPxnh0cjG4GNlLeJwr3R/WOs6dZKmUYQ3B11YFQe2GjhYcWQnlBoXoJ0CdIRy64j6EW
         plDAwQskcl14RF4blhRyL6bmIyresxU6JgVGVcY+a9LuAIS+EADsk3+FyFYGZIZrfZ50
         kqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1JwA4591V3WWgjpQbG6VpbXkMhkR+cvLtonZzzHudc=;
        b=liARqyYHEk2ns1QQ2DpDOxQM7VBS3PzpSa6TPJ729CsiNUp+vgXiN9KCapavLzKBvz
         qePnvxCsOH3h2YsPjlvqyurxXRAdQW6JNwlnV6oFVt3xawy6Rdd928UvqD04gmEWlqfw
         8vAGn62M5ZAwaXjxxKmF9Vi5If5nt2gpK9CoFoU48rPWy2DHV9C/SEiZWqPwIsq3ugcC
         zXLT3yIqMA/ke3SG6evr61aUxabr0CSkIWFFAkE7P3lbHc1F2L5LVth/1pobcyWBzBgG
         VCVVzeHczHxzRKMUwm6Turf6GAQwL5T8Q1zpn+FR3sThleq/MW+3ViNVibQ3fffbVMFh
         /MyQ==
X-Gm-Message-State: ANoB5pl5wZr47wk9pgS0dpIKqmLvLo0md1eDiHX1la4JpWKixXeJkuSa
        CwJn9at8Np94n8mKilcP0zY=
X-Google-Smtp-Source: AA0mqf4RCH4lMqZAY0zXFUoMmJkIUNRx3C+hk8zPIReEVKy7OoeUs6wcMmr6gBWhpPH4x2E8RhkudA==
X-Received: by 2002:a05:6a20:c892:b0:9d:efbf:48cb with SMTP id hb18-20020a056a20c89200b0009defbf48cbmr21757174pzb.15.1670875217772;
        Mon, 12 Dec 2022 12:00:17 -0800 (PST)
Received: from fedora ([2601:644:8002:1c20::2c6b])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0016d9b101413sm6735764plb.200.2022.12.12.12.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:00:17 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:00:14 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: huge_memory: Convert madvise_free_huge_pmd to
 use a folio
Message-ID: <Y5eITvb5klwiczF6@fedora>
References: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:34:30AM +0800, Kefeng Wang wrote:
> Using folios instead of pages removes several calls to compound_head(),
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
 
