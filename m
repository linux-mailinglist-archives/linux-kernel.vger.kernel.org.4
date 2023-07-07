Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6C74B76F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGGTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjGGTmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72626BA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFCB61A34
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E629FC433C7;
        Fri,  7 Jul 2023 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688758877;
        bh=BIeNaJY/voqJfd9eF4kJLjzAy3Uzj1oevyqwzuncZRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gsvPIT99tQSE+DZ7q0ml7NndWr+YIdWiM+/tOR6whtqZxWXBeIP96OO2EubetbExF
         a8PEouGBKNZB9nhhVSCv5gJehoxDlnys1PI1zWpbTBKSp0uNv/8VAkFCcsrlfZgDnC
         Q6STSoVuJEI9/vKcwe9rqvvbyYlx2m0xiH0HbH38=
Date:   Fri, 7 Jul 2023 12:41:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd
 split
Message-Id: <20230707124116.d7be4ba6504a452d11e2629d@linux-foundation.org>
In-Reply-To: <20230707033859.16148-1-songmuchun@bytedance.com>
References: <20230707033859.16148-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jul 2023 11:38:59 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> And inline __split_vmemmap_huge_pmd()
> since it only has one user.

"open code" would be a better term than "inline" in this situation.

If we are to offer this change to -stable then it would be better to do
the open-coding of __split_vmemmap_huge_pmd() in a separate, later
patch.

