Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BA67C387
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjAZDdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAZDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:33:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE00A457F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 19:33:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F7F61735
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82726C433EF;
        Thu, 26 Jan 2023 03:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674704007;
        bh=CzMVFshXJoCyFHd85N4aDYps2J8K7GRCWKRDTTHk2k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzQbSe/XmGgnXqnCQTR0t0omsW2ckdJBpR67gysPD2ph1h6nZl/rgrmjKKMxy1n4b
         tSFi5ibIK1hfUVPu+rVLq+NWzWIjIsj6b/YjLAgr+9E+vbNfM0oNWe2sMBxPBeQeFi
         KdGbL8O5HqnaNMBI3X/T98eE3o+xxosV/FQw3CPl944SKrzuVZ3MvitongerEMW5qs
         I4tW6YjvFH/cELd6XrHqX7p82Se2iXOiMpCF4/03ynJNhFMR62LBpr+5OXLlD757V8
         01v0y2EVI5nnthXwfdLi1cz5WIdxNttHuh7eR/J74pb9zPHoMU9ZT8hMx1yYIov2gM
         cTxmi8f+IgvnA==
Date:   Wed, 25 Jan 2023 19:33:25 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: check that module init/exit function is an
 indirect call target
Message-ID: <20230126033325.kuww43xyqykikuw4@treble>
References: <20230118105215.B9DA960514@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118105215.B9DA960514@lion.mk-sys.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:52:15AM +0100, Michal Kubecek wrote:
> Some out-of-tree modules still do not use module_init() / module_exit()
> macros and simply create functions with magic names init_module() and
> cleanup_module() instead. As a result, these functions are not recognized
> as indirect call targets by objtool and such module fails to load into an
> IBT enabled kernel.

I'm struggling to understand why a manually created init_module()
wouldn't create the ENDBR.  Does it only happen when init_module() is
declared static?

-- 
Josh
