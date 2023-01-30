Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64D68201B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjA3XyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjA3XyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:54:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBE193D1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFAC61274
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C5C433D2;
        Mon, 30 Jan 2023 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122823;
        bh=CSSDgLHo0LVGTelVjgMrQsahICSpa6poHnCqO6Gm6jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYVt8WHTjlkIhCjmamLjYpgaEw6sETyJMLv6ktVd+5mfL9xamo8t9VnyDbX4BAX1Q
         yC3rQDHzxJMLDIlQOp47xzgfMpCiikfzwlGVHsHp9P315mh+5ha8w9xS0G5IGuOZF1
         77KJ1fk4uHOrz5IUiJruB3Ab9x47kKJ8InVhYiEu+V6ib3kN0bXXAtAy94A7eMdW5Z
         47O5oj8kaVWpsvx9T07p5cbhacMw9iXefBiX4yeyZTb75J4eKXyTt8lTnqs4U9S0gb
         K9NZaYwm+LRV9WkqW6+qnPsLQ2kvyh9e8+ZmnGrvk6ZO2gybIx9RBCUfYk30tgPbOu
         CZ9t2vxewbhIw==
Date:   Mon, 30 Jan 2023 15:53:41 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] objtool: allocate multiple structures with
 calloc()
Message-ID: <20230130235341.u2qjearhh3rv6cm4@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20221216-objtool-memory-v2-3-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-objtool-memory-v2-3-17968f85a464@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 04:00:59PM +0000, Thomas Weißschuh wrote:
> By using calloc() instead of malloc() in a loop, libc does not have to
> keep around bookkeeping information for each single structure.

If we cared about memory leaks, this wouldn't really work because some
structures are added in later, after the reading of the original
sections and symbols.  Luckily we don't care :-)

-- 
Josh
