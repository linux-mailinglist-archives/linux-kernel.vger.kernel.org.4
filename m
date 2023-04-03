Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5616D5345
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjDCVQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjDCVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B1E42
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4782262B39
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 21:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D78C433EF;
        Mon,  3 Apr 2023 21:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680556602;
        bh=q8GofUuMfaapfTme03j9jsX3YGZomqPFR6QYbw5D7oE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KLJr4TYlnRg2CormlCd/a+KVd8BCYzWLst+s9rE1E+mVzY6nUdDHAqHUQlWVbNJzw
         c+N88VLvCEloavhVGj9N9sYgmtXdOssGgN5M/dnfgzsj9qQcS5vXTaEPyYGuyciRVo
         EQMU47XaweCbf+dRPxxfi9+0i7FWLwH8dMuWiq0s=
Date:   Mon, 3 Apr 2023 14:16:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: implement streq()
Message-Id: <20230403141641.6ace0d85fd48fbed5c02d7ef@linux-foundation.org>
In-Reply-To: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
References: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 20:48:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Most of the time strcmp() is being used, strings are checked for equality.
> Add wrapper to relay such intent (it is shorter to type, too).
> 
> Use
> 	if (streq(s, "s")) {
> 	}
> or
> 	if (!streq(s, "s")) {
> 	}

Gee, do we really want this?  I mean, we all know how strcmp() works,
don't we?

I'm thinking it would be better to remove the various cute little
streq() macros and open-code strcmp(...)==0.

