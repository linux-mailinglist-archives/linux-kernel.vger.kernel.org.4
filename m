Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4BA60BDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiJXWup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiJXWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:50:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC331FBD9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08A11B80EE4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF48C433D6;
        Mon, 24 Oct 2022 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666645150;
        bh=yQKyqeoLs5Rv47Fo2GBbipvsMxYrxQQpfG+tX/laYm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UPDkTSMdn3Ykg67g2S3qzDNAnUiqxUqv8UEV55E3bTEz6YSFU3j+liJGol4U3v3iY
         JjWeXaKYmPNXYxbQKZk9aPk1AaJMwDlO0R6KT7ejC2+ybylDkbLqdtDH8Csj3Pcwbm
         NS9IypiL/mJH3oYVAPiKWA5DpZqLHFTzpYAyFy8s=
Date:   Mon, 24 Oct 2022 13:59:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-Id: <20221024135909.e351a2dde4eea521f359a04b@linux-foundation.org>
In-Reply-To: <20221024120942.13885-1-avromanov@sberdevices.ru>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 15:09:42 +0300 Alexey Romanov <avromanov@sberdevices.ru> wrote:

> It makes no sense for us to recompress the object if it will
> be in the same size class. We anyway don't get any memory gain.
> But, at the same time, we get a CPU time overhead when inserting
> this object into zspage and decompressing it afterwards.
> 

Dumb question: is it ever possible for compression to result in an
increase in size?

> +	    class_size_next == class_size_prev ||

IOW, could this be >=?


