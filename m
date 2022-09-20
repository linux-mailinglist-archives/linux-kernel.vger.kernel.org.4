Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050C65BEB15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiITQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiITQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45835A14B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76999B81643
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F7C433C1;
        Tue, 20 Sep 2022 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663691145;
        bh=C5q9Co4NCMuDWPDIy18NIrRPLs3YS6viqEBkhpcXokQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiaGdfdNgWNjjYzCY6GxYsbSlhht8rThCwesmppTQNpo45yEPuKZT3YP+DH7EpmOV
         O7ecbuOfGcphHr6PzBdqARarUtJ6BqO/Z9PTEWTKTDiF6eqNxL90yP6ZFKAkbBNprM
         LnSN90j4IMgOj5LgOusVTodVjxIw0EJqmrw/u/vZt/enEjQJEqrlKdjD4eFPv2O/c6
         3HQkFPLWZq71ARTjrJDa2xnHBp/RBtJUEgqgf9CKjIgEPEWH8+Trrb03JWaD6KXOwd
         FtMuad/w00HW3L2gOMgTmBhQsvCjRxMZJRb9uHAHP/K1BTcFok/Wg7GGPI+Whlqr19
         JzjF+edCspwoQ==
From:   SeongJae Park <sj@kernel.org>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to simplify codes
Date:   Tue, 20 Sep 2022 16:25:42 +0000
Message-Id: <20220920162542.52554-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <10f3f03d-e616-0619-cbe1-8515a3d7fc0e@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Tue, 20 Sep 2022 09:58:41 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> 
> 在 2022/9/20 上午1:22, SeongJae Park 写道:
> > On Mon, 19 Sep 2022 23:12:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
> >> we can use kzmalloc to alloc instance of the related structs, This makes
> >> the function code much cleaner.
> > This definitely makes the code cleaner, thank you.  But, the initial intent of
> > the code is to initialize the fiedls that really need to be initialized at the
> > point, for the efficiency and also for making it clear which field is needed to
> > be initialized to what value here.  It's also intended to make readers wonder
> > about where and how the remaining fields are initialized.
> 
> Maybe the other func like damon_sysfs_kdamonds_alloc() also need to do 
> like this, you can see it return directly by
> 
> kzalloc.
> 
> static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
> {
>              return kzalloc(sizeof(struct damon_sysfs_kdamonds), 
> GFP_KERNEL);
> }

In this case, all the fields of the struct need to be initialized as zero.
That's why we use kzalloc() there.

Of course, my opinion is not a static and concrete rule, but changing mind.
And obviously everyone makes many mistakes and DAMON code has many rooms for
improvement.  I really appreciate for your greatful efforts for that.  But, at
least in this case, I think it doesn't really need the change at the moment,
IMHO.


Thanks,
SJ

[...]
