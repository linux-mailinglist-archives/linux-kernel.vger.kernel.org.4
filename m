Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699E60D8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiJZBsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiJZBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F7A8359
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F17B81FE6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9257C433D6;
        Wed, 26 Oct 2022 01:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666748884;
        bh=DeNUe/+thSCrXVF482VVO4niwzLe1FwTzl3oKIQ+v/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MOLScLugkE2Xjrku4vNwQQ2x+3ut851N45uuEkEn3TPLzBwaoNrRV1WlJZ31GRhOV
         tnvPZ2EUF96cYEVKfXieBiQAcOiLArtryDwevpxqzdKIMFCN1A9sIZubhBoB3V237n
         412KLgsmhKWF4KYtegvDx8hqWvWNsXQAywd6RbyI=
Date:   Tue, 25 Oct 2022 18:48:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/khugepaged: Initialize index and nr in
 collapse_file()
Message-Id: <20221025184802.7d4611caff603fecf98330b6@linux-foundation.org>
In-Reply-To: <20221025173407.3423241-1-nathan@kernel.org>
References: <20221025173407.3423241-1-nathan@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 10:34:07 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> Clang warns (trimmed for brevity):
> 
>   mm/khugepaged.c:1729:7: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>   mm/khugepaged.c:1716:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>   mm/khugepaged.c:1729:7: warning: variable 'nr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>   mm/khugepaged.c:1716:6: warning: variable 'nr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> 
> There are two goto statements that will use index and nr before they
> have been properly initialized. Zero initialize them so that they can be
> safely used by the tracepoint at the end of the function.

Thanks.  I've actually dropped the offending patch - I'd like a resend
which includes a fix such as this and a good reason for making the
change.
