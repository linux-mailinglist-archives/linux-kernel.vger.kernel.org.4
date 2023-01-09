Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342C6629D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjAIP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjAIPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7931AF1D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673277916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cwtPm83DzPm/dNeuelfshMOy2ruVKr8GdHiKUI1wQ4=;
        b=Gq79isKgCLSC50Hb7LEUfU2mqYrIjLivEKC73e43h7Ikj/QkIa1XvM1xo7I6CCzHTrT6g2
        vupcV93F/kbU0FQ6gToVd2SZE4o3c8fqdrRSJJNNEBbqHOAYcFZcVVKhYG9JMXqMxszDuv
        +zOzalceAzIGfyt9JmffMH7Dd+bUVrU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-E85W_i6lMay6zdRCcdbYdg-1; Mon, 09 Jan 2023 10:25:15 -0500
X-MC-Unique: E85W_i6lMay6zdRCcdbYdg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-4755eb8a57bso95297157b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cwtPm83DzPm/dNeuelfshMOy2ruVKr8GdHiKUI1wQ4=;
        b=HeHNUTZFIxwhLOZKHaQ1Pakwrc1gwRuuzPLt+YKAeGenEuUE4Oe1dIwrErd77eRBiI
         SzNrM4fzC1p6BSCcRyx2ULNAQVdDLmTyfoEhaupOkNNJmu8V/dO/KwaINm3jUBsqxH3T
         NY9NO74cH6Mgch0WUN+8m2FudjkGZoHfggw2ipD/d3nLc4iL+SswL/sVUojDREKruyuu
         oLf3eoytHJpzcLjb0feAuyOmVIp1VZU+c0ybkZxtBnoarQy9HXuM+Hmj4yhLizdRR1Pz
         jYFPSvz7mWM9AftoqaYZBPF7MQTeecXqgDlkN1xs1OXgqMtGVTc7lBjWNib7msj84tEq
         sGGA==
X-Gm-Message-State: AFqh2kpoPHt3ogmQS7J51Skj8fgi7uVKjiL5k2DEdpJ+SMbQVgNJVWad
        OeMHOvOS/gGRoOxdhhYaJSyKDOnd9527oiFP7U8UjdagKEsB+6MKOJQyaQDcBCY1WKXup4BFh/b
        4g7GktqQwLAjAw2gIIonIdYLo
X-Received: by 2002:a81:1252:0:b0:4a4:e76b:7160 with SMTP id 79-20020a811252000000b004a4e76b7160mr24182486yws.18.1673277914968;
        Mon, 09 Jan 2023 07:25:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuk+uM5VkDIcmYpnZqGv6C7Pu+cSJXlnrOuWyuHdaV8aegf77WPib+gB5SzG40m4PLEvJ5eqw==
X-Received: by 2002:a81:1252:0:b0:4a4:e76b:7160 with SMTP id 79-20020a811252000000b004a4e76b7160mr24182473yws.18.1673277914758;
        Mon, 09 Jan 2023 07:25:14 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b007055fa93060sm5536060qko.79.2023.01.09.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:25:14 -0800 (PST)
Message-ID: <6d1cd7ca1f2ea0f022af1d43999a61e6b17685c0.camel@redhat.com>
Subject: Re: [PATCH 04/11] fuse: Convert fuse_flush() to use
 file_check_and_advance_wb_err()
From:   Jeff Layton <jlayton@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 10:25:13 -0500
In-Reply-To: <20230109051823.480289-5-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-5-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> As with fsync, use the newer file_check_and_advance_wb_err() instead
> of filemap_check_errors().
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/fuse/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 875314ee6f59..7174646ddf09 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -500,11 +500,10 @@ static int fuse_flush(struct file *file, fl_owner_t=
 id)
>  	fuse_sync_writes(inode);
>  	inode_unlock(inode);
> =20
> -	err =3D filemap_check_errors(file->f_mapping);
> +	err =3D file_check_and_advance_wb_err(file);
>  	if (err)
>  		return err;
>=20
>=20

I think it'd be best to not advance the f_wb_err here. ->flush is called
on filp_close which is mainly close() syscalls, but there are some other
callers too, and an error reported by ->flush can be discarded.



> =20
> -	err =3D 0;
>  	if (fm->fc->no_flush)
>  		goto inval_attr_out;
> =20

--=20
Jeff Layton <jlayton@redhat.com>

