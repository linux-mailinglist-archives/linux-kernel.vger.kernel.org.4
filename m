Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BE6A1185
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBWUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:54:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F92E837
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:54:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555A96178A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DFC433D2;
        Thu, 23 Feb 2023 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677185643;
        bh=q8DyRLIMgS2KCXKrO6yV+k+dUAexX8wa/H7C8HImtG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fZkMOMWLMvKyw7hLEWPKmdrk7YYaVU/R+zmXvZSu/c2gk/87btTwgiNH7EiBBG/R+
         17GKXA+CskkmSMl2ZW1k319eTFxlM0RbAqxrOJUUKw7ouwuaPzi3ywQ2JQ51EWJBgv
         yiNta2D3lsDPcd+aYbvkCOlCIbkW1Eas+V6OiYqc=
Date:   Thu, 23 Feb 2023 12:54:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib/zlib: DFLTCC deflate does not write all
 available bits for Z_NO_FLUSH
Message-Id: <20230223125402.2d9fa0465ed62410dd5b4ed9@linux-foundation.org>
In-Reply-To: <20230221131617.3369978-2-zaslonko@linux.ibm.com>
References: <20230221131617.3369978-1-zaslonko@linux.ibm.com>
        <20230221131617.3369978-2-zaslonko@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 14:16:17 +0100 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:

> DFLTCC deflate with Z_NO_FLUSH might generate a corrupted stream when
> the output buffer is not large enough to fit all the deflate output at
> once. The problem takes place on closing the deflate block since
> flush_pending() might leave some output bits not written.
> Similar problem for software deflate with Z_BLOCK flush option (not
> supported by kernel zlib deflate) has been fixed a while ago in userspace
> zlib but the fix never got to the kernel.
> Now flush_pending() flushes the bit buffer before copying out the byte buffer,
> in order to really flush as much as possible.
> Currently there are no users of DFLTCC deflate with Z_NO_FLUSH option in the
> kernel so the problem remained hidden for a while.
> 
> This commit is based on the old zlib commit:
> https://github.com/madler/zlib/commit/0b828b4
> 

Thanks.  Does this fix make sense when your series "lib/zlib: Set of
s390 DFLTCC related patches for kernel zlib" is not applied?  If so
then should we backport it in to earlier kernels?

If "no" then are you able to identify a suitable Fixes: tag?  So that
anyone who backports the "lib/zlib: Set of s390 DFLTCC related patches
for kernel zlib" series into an earlier kernel has a better way of
knowing that a fixup is needed.

