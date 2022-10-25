Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E460D2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJYRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiJYRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:51:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1F1900A;
        Tue, 25 Oct 2022 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5N1wutp/qlXBYy2QP7C/3+5yhBOHXBrYT/91aOtTBAU=; b=QuXa0ioU3lLXiJ3+Vjs8Dn2cxi
        8tMU2Rfj6xaIQAk0vicqGHCxB5kNEn4wZN0kmgGoy2jnGvcLu9WqNKkGBf9u53m97Fe4/t0elf2o4
        ZYG3sHFienIpVx4jnraCmtXmDLvLcr6Oqs8UNEbCRbNtziOeHqCF40ixz3aEppokHXbpoNE2hPWWy
        itEUCJbnFHWTnPBY3YkeREHpder8a1/Bbv1yFaddphXYLmapwe3G4FnbgHTF7G8kCobLQcB9z25cF
        FBH+G6hsvd6KuhwXZMm/GYXeq4uPfCvef4eyw+mX9VvczqJ+2IJEJ35NTYIjKo+Vzpl/RBCHflrPw
        CKf/H6DQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onO54-006YCt-FJ; Tue, 25 Oct 2022 17:51:14 +0000
Date:   Tue, 25 Oct 2022 10:51:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     pmladek@suse.com, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name
 module load requests
Message-ID: <Y1giEusr0/sGNrGC@bombadil.infradead.org>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-5-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016123031.3963-5-petr.pavlu@suse.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 02:30:31PM +0200, Petr Pavlu wrote:
> diff --git a/tools/testing/selftests/kmod/init_module.c b/tools/testing/selftests/kmod/init_module.c
> @@ -525,6 +662,8 @@ list_tests()
>  	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
>  	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
>  	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
> +	echo "0014 x $(get_test_count 0014) - test handling of parallel loads, success case"
> +	echo "0015 x $(get_test_count 0015) - test handling of parallel loads, init returning error"

Good stuff!

So test 0015 mimics the error reported by Prarit Bhargava through
commit 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules
that have finished loading")? If so it would be good to document that
here.

Also, this patch should go first, with the ALL_TESTS variable set to
disable the tests which are known to fail, so to demonstrate the *new*
issues as they are failing and then your fix first and then you enable
that test afterwards.

If 6e6de3dee51a introduced another regression which is not covered
by the tests we'd add it, and fix on top of it as a stepping stone
to prove / send to stable.

  Luis
