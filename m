Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C16B6CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMA5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:57:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33FB39B86
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 17:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61DE0B80DD5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A9C433EF;
        Mon, 13 Mar 2023 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678669025;
        bh=wHbqt1J/XtYJxxxsTQgzmD4WRRmmCjsOMfI8qYGXybo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gfrtTYAX2BZ1JuQYHpXWmAL2kRpaBSXSCs4sgTFYpl37KyWv6nJj/Ww2jxX0JFIai
         18lo3QY/C2pNXUq0dACdaJt5T5IOuRfINjtwfLdDyHbs9oYMgLqFhxxc4juXPU/njd
         QnRw8ZTYM9vrCxCZtZW0pF88BH9AYO3idA1qfmM4=
Date:   Sun, 12 Mar 2023 17:57:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        Liam.Howlett@Oracle.com, jhubbard@nvidia.com, david@redhat.com,
        willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the
 vm_flags in vm_area_struct
Message-Id: <20230312175703.d8d8e0192387dfa9592ee8e5@linux-foundation.org>
In-Reply-To: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
References: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 23:42:50 +0100 Vincenzo Palazzo <vincenzopalazzodev@gmail.com> wrote:

> With 6.3-rc1 is not possible to build the following drivers

Well, let's cc Suren who actually wrote bc292ab00f6c ("mm: introduce
vma->vm_flags wrapper functions").

> - nvidia, that the compilation returns the following errors
> 
> - vboxhost/7.0.6_OSE where the build fails with the following errors
> 
> ...
>
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -497,7 +497,7 @@ struct vm_area_struct {
>  	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
>  	 */
>  	union {
> -		const vm_flags_t vm_flags;
> +		vm_flags_t vm_flags;
>  		vm_flags_t __private __vm_flags;
>  	};

These out-of-tree drivers should be converted to use the wrappers which
bc292ab00f6c added.  Their maintainers have a couple of months to do
this before bc292ab00f6c is released in 6.3.

It's unfortunate.  I guess it would be better if we were to find a way
to permit these drivers to compile OK but to generate warnings, as an
interim thing for six months or so.  Perhaps there's some clever way.
