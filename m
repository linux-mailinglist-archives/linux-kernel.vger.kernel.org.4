Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6B70DD31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjEWNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6F6126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5CE63235
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63831C433D2;
        Tue, 23 May 2023 13:07:58 +0000 (UTC)
Date:   Tue, 23 May 2023 14:07:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexey Izbyshev <izbyshev@ispras.ru>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <ZGy6q7v+7jsXb1bV@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:12:37AM +0200, David Hildenbrand wrote:
> Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We need arg2
> -> arg5 to be 0. But wouldn't the following also just pass a 0 "int" ?
> 
> prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)
> 
> I'm easily confused by such (va_args) things, so sorry for the dummy
> questions.

Isn't the prctl() prototype in the user headers defined with the first
argument as int while the rest as unsigned long? At least from the man
page:

int prctl(int option, unsigned long arg2, unsigned long arg3,
	  unsigned long arg4, unsigned long arg5);

So there are no va_args tricks (which confuse me as well).

Any int passed to arg[2-5] would be converted by the compiler to an
unsigned long before being passed to the kernel. So I think the change
in this patch is harmless as the conversion is happening anyway.

(well, unless I completely missed what the problem is)

-- 
Catalin
