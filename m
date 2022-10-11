Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F845FBB51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJKTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJKTZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:25:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E36165A6;
        Tue, 11 Oct 2022 12:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D18F0B81673;
        Tue, 11 Oct 2022 19:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745A6C433B5;
        Tue, 11 Oct 2022 19:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665516302;
        bh=3fp/xUhgJzjsTGb7S89xAhTVaadS8dJVok86wtoE330=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ow4mDD0TyZCIHW8Ky4hsjr14EBg/rumm8HPFhpn3AvWkbXSMqukI9ghtCWXVcySMr
         CRYTTrRVZYnUiEozI1gPrurONC+qHmIVXAAklJVV01ZojYrDrcJFokJ6rDOHROzv5H
         kocdh2puYT+HjU+N1Ip4zY0NLSXIxklGe4UoYRHnNrzShWgryiAwDRYrLPLxz+NsmY
         ntSqE5RTi6iSrZKWZKb9qHfOerhV3st87AW5py8Tkl/keGy7WTO3JaOmxhWmzrxaCu
         TPLgEjkiJAlTmJVLrLHHTZqPzixn6td2fouIIl3HAjF1cN17i0cLJ5ELkBILOMgGaW
         6ZN64SJ+4LeGQ==
Date:   Tue, 11 Oct 2022 14:24:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XDAtQ4eYTgwIgM@work>
References: <Y0XAxX4g/9N6qdnD@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XAxX4g/9N6qdnD@mail.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 08:15:17AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>

I think this should be versioned as v3.

> ---
>  fs/dlm/dlm_internal.h | 2 +-
>  fs/dlm/lockspace.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index e34c3d2639a5..94fadb619ba0 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -670,7 +670,7 @@ struct dlm_ls {
>  	void			*ls_ops_arg;
>  
>  	int			ls_namelen;
> -	char			ls_name[1];
> +	char			ls_name[DLM_LOCKSPACE_LEN + 1];
>  };
>  
>  /*
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index bae050df7abf..23de0d47cbc1 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
>  
>  	error = -ENOMEM;
>  
> -	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> +	ls = kzalloc(sizeof(struct dlm_ls), GFP_NOFS);

sizeof(*ls) is preferred here....^^^

--
Gustavo
