Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3373A74A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFVRb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFVRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD21FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687455066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XwheaDZGZRpJwzvs7S81oxlOK2dxP/D6trWluCaM6o=;
        b=D6awooF+VGb06s4LnvDd2CVN4Q9SUR0bOkG4NHo04Se0NYGDI88vYJ2W65vfMVxEJG0C1O
        IGgxUk1t7hS8vIb63ZguyTgMd+4H3OR2h+nUwyFnDLZUq9Vx9EaAEc+P1Xy42tIIG2sRga
        0FCHlBd/7kdvuhszwWs0ZfHpZ+i4PV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-m_NT0INGNfOCJC9XE_vJGA-1; Thu, 22 Jun 2023 13:31:02 -0400
X-MC-Unique: m_NT0INGNfOCJC9XE_vJGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48F1490ED25;
        Thu, 22 Jun 2023 17:30:57 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EA6D2166B25;
        Thu, 22 Jun 2023 17:30:49 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 78C5430C0457; Thu, 22 Jun 2023 17:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 77DE53F7CF;
        Thu, 22 Jun 2023 19:30:49 +0200 (CEST)
Date:   Thu, 22 Jun 2023 19:30:49 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 2/6] device-mapper: Avoid pointer arithmetic
 overflow
In-Reply-To: <20230603145244.1538-3-demi@invisiblethingslab.com>
Message-ID: <d0ac7c9b-fbb-b79e-3a34-f5bc4ae87ba@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com> <20230603145244.1538-1-demi@invisiblethingslab.com> <20230603145244.1538-3-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

> Especially on 32-bit systems, it is possible for the pointer arithmetic
> to overflow and cause a userspace pointer to be dereferenced in the
> kernel.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-ioctl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc..64e8f16d344c47057de5e2d29e3d63202197dca0 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1396,6 +1396,25 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  {
>  	static_assert(_Alignof(struct dm_target_spec) <= 8,
>  		      "struct dm_target_spec has excessive alignment requirements");
> +	static_assert(offsetof(struct dm_ioctl, data) >= sizeof(struct dm_target_spec),
> +		      "struct dm_target_spec too big");
> +
> +	/*
> +	 * Number of bytes remaining, starting with last. This is always
> +	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
> +	 * out of bounds already.
> +	 */
> +	size_t remaining = (char *)end - (char *)last;
> +
> +	/*
> +	 * There must be room for both the next target spec and the
> +	 * NUL-terminator of the target itself.
> +	 */
> +	if (remaining - sizeof(struct dm_target_spec) <= next) {
> +		DMERR("Target spec extends beyond end of parameters");
> +		return -EINVAL;
> +	}
> +
>  	if (next % 8) {
>  		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
>  		return -EINVAL;
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 

