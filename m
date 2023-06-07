Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A272671F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFGRVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFGRVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6B1BDC;
        Wed,  7 Jun 2023 10:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55467641D4;
        Wed,  7 Jun 2023 17:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80775C433EF;
        Wed,  7 Jun 2023 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686158492;
        bh=U9W9skjifzMR1SASCsAyZOl2XG5xWIPHKBISwhY3XZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bNOvKpTcSlqDpTfs2mNjtbtHZJ5D0sLzsyZjtfcmcHAQCGIBI3DYGduDABBr0Tugi
         XjKxovKnEZw3i6Vo16YibT3AXvFpEi8zCDC3FngYDOTLNqYVECsiMPUKBVvdWic0Jr
         nUUAqsHCJ01UBv+CZsNipshRvjsJJVB/4m2RgNVU=
Date:   Wed, 7 Jun 2023 10:21:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] memfd: Check for non-NULL file_seals in memfd_create()
 syscall
Message-Id: <20230607102131.11964c87b1078374c9d4b341@linux-foundation.org>
In-Reply-To: <20230607132427.2867435-1-roberto.sassu@huaweicloud.com>
References: <20230607132427.2867435-1-roberto.sassu@huaweicloud.com>
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

On Wed,  7 Jun 2023 15:24:27 +0200 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Ensure that file_seals is non-NULL before using it in the memfd_create()
> syscall. One situation in which memfd_file_seals_ptr() could return a NULL
> pointer is when CONFIG_SHMEM=n.

Thanks.  Has thie crash actually been demonstrated?

> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -371,12 +371,15 @@ SYSCALL_DEFINE2(memfd_create,
>  
>  		inode->i_mode &= ~0111;
>  		file_seals = memfd_file_seals_ptr(file);
> -		*file_seals &= ~F_SEAL_SEAL;
> -		*file_seals |= F_SEAL_EXEC;
> +		if (file_seals) {
> +			*file_seals &= ~F_SEAL_SEAL;
> +			*file_seals |= F_SEAL_EXEC;
> +		}
>  	} else if (flags & MFD_ALLOW_SEALING) {
>  		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
>  		file_seals = memfd_file_seals_ptr(file);
> -		*file_seals &= ~F_SEAL_SEAL;
> +		if (file_seals)
> +			*file_seals &= ~F_SEAL_SEAL;
>  	}
>  
>  	fd_install(fd, file);

