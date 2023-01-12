Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2A6684D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjALVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbjALU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:58:24 -0500
X-Greylist: delayed 2393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 12:42:55 PST
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB70F01D;
        Thu, 12 Jan 2023 12:42:55 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id D0E2A7FCE1;
        Thu, 12 Jan 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1673551439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2YK0KStoZilkvt5Gd+Z0QXSKrgiOl1UdETNcSgpEpE=;
        b=i+65F8jlt9SrxFye0Gw20zt6UKpTEaqiZQ5hMVqSu0k7iplUUCLaWGe7MPjLIcUXvR2Ze2
        EPZvayy3ujt17G7U6k4N9U3mDmbAViZrJRkdIjJ30e2YmzNFL9kFY3KN4OmLssXkKylqmj
        E8tOKo4JSk3JfhG8aJ26Wc/wDEh7vUicPsX8QXZqm+7WwOK9nS0qxN7D/+flVsxas11Fth
        oU/iflnYw8+Gm87I9cBkOHMwnYst1u7763QKPIvahJlVCd3cUAf31rG9cwxkdB+Sbii/p1
        NDe89irKrvEmsmtdfYfdlUgHuTnNrT2Ps2o/IkqPzfauQjAjCU8/6VVNF8HXCA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v5 09/23] cifs: Convert wdata_alloc_and_fillpages() to
 use filemap_get_folios_tag()
In-Reply-To: <20230104211448.4804-10-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
 <20230104211448.4804-10-vishal.moola@gmail.com>
Date:   Thu, 12 Jan 2023 16:23:54 -0300
Message-ID: <87ilhb36b9.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Vishal Moola (Oracle)" <vishal.moola@gmail.com> writes:

> This is in preparation for the removal of find_get_pages_range_tag(). Now also
> supports the use of large folios.
>
> Since tofind might be larger than the max number of folios in a
> folio_batch (15), we loop through filling in wdata->pages pulling more
> batches until we either reach tofind pages or run out of folios.
>
> This function may not return all pages in the last found folio before
> tofind pages are reached.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/cifs/file.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)

Looks good.

Acked-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
