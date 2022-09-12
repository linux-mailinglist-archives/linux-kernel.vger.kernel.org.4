Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063B5B621A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiILUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiILUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:23:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E96481D9;
        Mon, 12 Sep 2022 13:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B3A8B80C68;
        Mon, 12 Sep 2022 20:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29911C433D6;
        Mon, 12 Sep 2022 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663014203;
        bh=V7XKrZJImH3ItQ7EvPsT2qdGqMPYz4GDAX5yuckn2rQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNIPHzmgHprhHCZZQt1KEnDXQwoNzGJBbNmWaHY2Hyr6Y+pFN5ysScUAKnVVLAUct
         1DqNhpDuDZBzf4Gc466iorybnr/i3RCihkAWQY2BIgOCAKTKLIN4Q6qjJ9ipSQvQuh
         YF5asvUxcEqMYSo/t/7k5gSY6zwv4DImn1wpmf5k=
Date:   Mon, 12 Sep 2022 13:23:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/3] page table check default to warn instead of panic
Message-Id: <20220912132322.7c486c40c6acf8eec0785c87@linux-foundation.org>
In-Reply-To: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022 09:59:20 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> From: Pasha Tatashin <tatashin@google.com>
> 
> Page table check when detects errors panics the kernel. Let instead,
> print a warning, and panic only when specifically requested via kernel
> parameter:
> 
> 	page_table_check=panic
> 
> The discussion about using panic vs. warn is here:
> https://lore.kernel.org/linux-mm/20220902232732.12358-1-rick.p.edgecombe@intel.com

The changelog doesn't actually describe the reason for making this
change.  Somebody obviously wants pagetable check errors to no longer
panic the kernel, but why??  (The same can be said of the [2/3]
changelog).

Also, should we be changing the default?  People who like the panic
will get a big surprise when they find out that they should have added
a kernel parameter to get the old behaviour back.  It would be less
disruptive to default to panic unless page_table_check=warn was added.

If there's a solid reason for changing the default, it should be
changelogged.  And if that reason is generally agreed to, perhaps the
kernel should print a warning at boot if neither page_table_check=panic
nor page_table_check=warn were provided.  To tell people that the
default has been changed.


