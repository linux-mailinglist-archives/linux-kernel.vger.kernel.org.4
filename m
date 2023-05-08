Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6536F9CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjEHAa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEHAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B7659F
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 17:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1670361D85
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59613C433D2;
        Mon,  8 May 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683505823;
        bh=Ku2BCycuOdBG80SFOKA5kbRxCQtR2qKfQc50CpXVufY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZIllEHhRUrFIWI47sBt/vsXJlLqnQOnLiEdORTmPnuZQaSEmSXnXdZrOCyDODQ46
         2xTIkzO5J+It+eCoWaNMYurOO0oSV2L1qfxW6YOsO6lWwyMdRrMfB8vVZFfwEA/hkY
         WT5ednNEx2Fvqk3X8c9uTz/FSpYGscShWmEGShPY=
Date:   Sun, 7 May 2023 17:30:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/gup: add missing gup_must_unshare() check to
 gup_huge_pgd()
Message-Id: <20230507173022.96c9d24cb1aa6f57ed50f5fa@linux-foundation.org>
In-Reply-To: <cb971ac8dd315df97058ea69442ecc007b9a364a.1683381545.git.lstoakes@gmail.com>
References: <cb971ac8dd315df97058ea69442ecc007b9a364a.1683381545.git.lstoakes@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 May 2023 15:05:25 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> All other instances of gup_huge_pXd() perform the unshare check, so update
> the PGD-specific function to do so as well.
> 
> While checking pgd_write() might seem unusual, this function already
> performs such a check via pgd_access_permitted() so this is in line with
> the existing implementation.

Rationale seems strange.  "Other sites do it so this should also".  Why
is this a desirable change?  Maybe the "other instances" shouldn't be
performing this check either?

IOW, what are the runtime effects of this change?

Thanks.
