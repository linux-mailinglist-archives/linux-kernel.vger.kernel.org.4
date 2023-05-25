Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD8710921
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbjEYJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjEYJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:43:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A27191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GTCv05NKX7fYVfcWA9mF9yBEXPLxaqPCHQmLNCv1ZJQ=; b=TJQ/U68WU/s2VYiJ/03J7kmoh+
        YblMToMJpjlLY+OOjtRXYhlbHukydmw3PUftGnI27aU1oJMzLVXvU3OYxSMvMHmhEtzU0tY9KhA/K
        mMDtIgHzw0Us/B5mctq1KmB0zDiCzIW8QQl2oo8eWAlFZnvsVmRgQWnbRpEkwzys0xhzTWdTEzcsR
        CJ/kw8rEjWcpI1k4GxbDPAuQDGGSTcR62w2b3jTFlXr+17TQyG7fVzVmJ5ur1bFaa/RL0UA8MRnYC
        8KZaYVgF8Fb5kNlHNEvEHQ8QlrrZM88RmzzNDbkzeYR6tJsKXJ0twKVQXskmpLGw6kXepWjIlJFX4
        UWb9YshA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27V6-00GBCU-2n;
        Thu, 25 May 2023 09:43:16 +0000
Date:   Thu, 25 May 2023 02:43:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Kenny Ho <kenny.ho@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
Message-ID: <ZG8ttJ7VFrJCk8tB@infradead.org>
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524191955.252212-1-hamza.mahfooz@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +subdir-ccflags-y += -Werror -Wunused -Wmisleading-indentation

We have a config option for -Werror.  Blindly adding this will create
problems with too new (or sometimes too old, or just too weird)
compilers all the time.  Don't do this.
