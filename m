Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A665473A73E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFVRao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD4195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687454998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1APpD2vCMiT5KNJq2ZJ0gxW8qYfJ/rnhipLtpA4m9ns=;
        b=eeppBWTCp4e0D+e19WvjZE9d80BaXZ2fgQJtFaHjbNqIwEPa9Q5FC4Vudi7U0KlOp0vrof
        ykzcfb67g2P6u+bLUDkh5lcscufLhWXgt0pdBunYprLd6SDTdXVArjn0CYAY8sojn9Vjh2
        wU8fl123Rmd9DtqCH24uKtW426bcvXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-MhddANRwMcuqvJ5zSiXJnA-1; Thu, 22 Jun 2023 13:29:55 -0400
X-MC-Unique: MhddANRwMcuqvJ5zSiXJnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2017B80123E;
        Thu, 22 Jun 2023 17:29:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4F240C2063;
        Thu, 22 Jun 2023 17:29:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id EEEB630C0457; Thu, 22 Jun 2023 17:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id EB4353F7CF;
        Thu, 22 Jun 2023 19:29:52 +0200 (CEST)
Date:   Thu, 22 Jun 2023 19:29:52 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 1/6] device-mapper: Check that target specs
 are sufficiently aligned
In-Reply-To: <20230603145244.1538-2-demi@invisiblethingslab.com>
Message-ID: <7d56d190-b97c-f515-ebd0-c3790f11954@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com> <20230603145244.1538-1-demi@invisiblethingslab.com> <20230603145244.1538-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jun 2023, Demi Marie Obenour wrote:

> Otherwise subsequent code will dereference a misaligned
> `struct dm_target_spec *`, which is undefined behavior.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> ---
>  drivers/md/dm-ioctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
>  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  		       struct dm_target_spec **spec, char **target_params)
>  {
> +	static_assert(_Alignof(struct dm_target_spec) <= 8,
> +		      "struct dm_target_spec has excessive alignment requirements");
> +	if (next % 8) {
> +		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
> +		return -EINVAL;
> +	}
> +
>  	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
>  	*target_params = (char *) (*spec + 1);
>  
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab

Hi

Some architectures (such as 32-bit x86) specify that the alignment of 
64-bit integers is only 4-byte. This could in theory break old userspace 
code that only uses 4-byte alignment. I would change "next % 8" to "next % 
__alignof__(struct dm_target_spec)".

I think that there is no need to backport this patch series to the stable 
kernels because the bugs that it fixes may only be exploited by the user 
with CAP_SYS_ADMIN privilege. So, there is no security or reliability 
problem being fixed.

Mikulas

