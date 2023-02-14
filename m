Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2923696447
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBNNIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjBNNIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:08:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463942659F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:08:37 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g8so17207127qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfdQq+F8pxhCiZXJI9spn1EmIoAF1U/FtCml8oB2JiE=;
        b=gGwBDnjEau2txTGFIHtJEnHNbKfKrUR7V0UxsMWyI6VUQW1/FELWF9mHqzAgVDZIVx
         6CMmV4RJHIKD0XpX4jCJuScZUJX7IW6XcDxEKx/uz75IejEY7A+DeqYPXvRKJ0rAnhXe
         /DPfmbuJo8jeQX3wutarW+4WfDiGBErNSAlcs5+0o3ZkS3BlmNsmQqWHqTLg1tk1EXyQ
         VE1zMgGDp9emrP7/GuG9HtWzWowKx0X/Yc3gxqiwJDsFB8D5t86ZIEnXH5NlkZ+AjGsG
         nmr5TC0wIg9PtoUcit1m3flhyzO1znx4gkPRhu2wxs2QPF/TFIouJnSY9N+YCJzB2fHd
         80pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfdQq+F8pxhCiZXJI9spn1EmIoAF1U/FtCml8oB2JiE=;
        b=Uee5IYEVUKmov3wQM7l/IlBovNF4hC2EpcbJI9TbmgSIxzMYv7vB9noKqQyjZlVWjH
         fTn2Ez488pfr1LknWztWhPc5hsEjALqmLEoCEUTxtoCfMZyV7hzSj8pl5hB6uSUEhFXG
         /gKUREWJPgJ0UktMlvctJvB1YUaJoI8cvAcKJ/59eIEWo7v+E4n64DE7eqOC7oSi7+hc
         7tU+FKWHQiTHMNXiE3v6iYvqdR1xhp0ggFH4NnMBOdxIjzwVEsofcLnkLCZY9Zmv9pk1
         G7vcO2e+KeID2huEuBNA1TMU7xy7jxTe9jyHkDB+mPoY3E4zHv/UToaoVvSpC1gKw1Sn
         NpTw==
X-Gm-Message-State: AO0yUKXukkjFsJupCq9OiBxMmgLKHqlHT+Oipwt0XX9Ps0m6RhruDgac
        LHb7Suwt9EfOCd+PMmr9/q2N6Q==
X-Google-Smtp-Source: AK7set+MaeX7ik1ihC+rrS/ZOuKzkcMiO+KvgSwVKQXxMU7SatIrqqn37Zcr810SmE+GMux6NDItBg==
X-Received: by 2002:a05:622a:1a8b:b0:3b8:6d3b:b083 with SMTP id s11-20020a05622a1a8b00b003b86d3bb083mr3951303qtc.10.1676380116352;
        Tue, 14 Feb 2023 05:08:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id fp41-20020a05622a50a900b003b9a73cd120sm11199274qtb.17.2023.02.14.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 05:08:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pRv2w-000PTY-VB;
        Tue, 14 Feb 2023 09:08:34 -0400
Date:   Tue, 14 Feb 2023 09:08:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Reorder fields in 'struct
 rdma_restrack_entry'
Message-ID: <Y+uH0k0OBzPip1P8@ziepe.ca>
References: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:53:52PM +0100, Christophe JAILLET wrote:
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 8b7c46daeb07..da53fefe6f9e 100644
> --- a/include/rdma/restrack.h
> +++ b/include/rdma/restrack.h
> @@ -80,6 +80,10 @@ struct rdma_restrack_entry {
>  	 * query stage.
>  	 */
>  	u8			no_track : 1;
> +	/**
> +	 * @user: user resource
> +	 */
> +	bool			user;

Can we combine this into the bitfield above?

Jason
