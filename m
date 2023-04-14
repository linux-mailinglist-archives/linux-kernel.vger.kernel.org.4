Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909516E2A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDNTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48335AD2D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C974D616EC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F71AC433D2;
        Fri, 14 Apr 2023 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681499398;
        bh=TIQZT0mY2jTE2KuxlI/SFIOeWFhSzqpa7haXYJVeaVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tveRyrY3tGeQcLwTVq4IhZ4ZN13qG32XxeR+o7uzgO9YcHtksn1rEcNEya3RQXtqd
         sMgprNqjCuz6uK339w/qIvd6xfLmq//LrpNTCkw/H4TsD8oeOo3T/KlqbDMepVqUFT
         a4Br6/3I7UU2mnT1TlkciK7EBgj/J6RGzpdyKVPw=
Date:   Fri, 14 Apr 2023 12:09:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-Id: <20230414120957.d69f471ad9eb2a1d304a4146@linux-foundation.org>
In-Reply-To: <20230414185919.4175572-1-Liam.Howlett@oracle.com>
References: <20230414145728.4067069-3-Liam.Howlett@oracle.com>
        <20230414185919.4175572-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 14:59:19 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> The maple tree limits the gap returned to a window that specifically
> fits what was asked.  This may not be optimal in the case of switching
> search directions or a gap that does not satisfy the requested space for
> other reasons.  Fix the search by retrying the operation and limiting
> the search window in the rare occasion that a conflict occurs.

This is a performance regression, yes?  Of what magnitude?
