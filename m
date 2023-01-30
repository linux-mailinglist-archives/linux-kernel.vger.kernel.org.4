Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D868193C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjA3ScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjA3Sbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:31:44 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA5126DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:30:54 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v17so1080438qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx/PI8cqG2+EaOq03efBGUF5spQGwS7QnFbIzH7bNaw=;
        b=JkcE2So2T5MCTPbp2p8WcW/bU3yjpylUCXz6UlrGmQHcd+PBvO/Lw1AB+QbzggssgC
         sfwruiRnFDwcBb8J7h2XZNYviyjVBxAT2WFSi+SMybKf8coYnhaNKrI9ayQotRXWSeIj
         JptuBbwp2nCoNf8oCCKtqCIoNKoMmUbU52BON5/BenOheOeT4RX4+jNMs9co3kbqHrCu
         5hK1O2jQ6KN+Vr+rBFOc7ghNUtB9SEAr8YcyUKdnnZ7ToiZ47TowjazDZmaSIl6dRTtv
         swc6b1qwkwcxc+Vu/2op7OzSPwNOE+J7tBNHWQqJHsOfCRDfXRMtnaV4GQOTwzygi4P9
         SrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx/PI8cqG2+EaOq03efBGUF5spQGwS7QnFbIzH7bNaw=;
        b=5fgF8x9W7N1u7WbO7thv9V+2D2sPgCg0q6kQMZeTCA58AY6PuMMjUdk0ncOFHbQB+x
         trpk+C0sll9j/oRP4D5z3ynVw0ZxUF4HhyP99YBQrRcsrd7+dmrducc407g4W45mpMhk
         50hmINLCfhLOkczY0wdG+duHfkJwi0vBhHsiEMqS4KZjpcBlyswSKJpoAUVHm74Bgikh
         jCV7aFHg6ar040Qs3f6wFspjoGpfq6bSn5MGIR4ZYTzLOHzJtk/CVE3afS3iHmUfdCVz
         EdG2uCWF1TznwBwR1YxEaoSCedYvHsgw+RaIheSqAta6Ebqg3V10L+MptpKrjoFbOy/k
         jEdQ==
X-Gm-Message-State: AO0yUKUimQWdh6kt5Ed09EBaRBAX5AnWG24kOpkKkJs83yDaFKp1IwFP
        njWmQm/hsjhZzw93nF2WRq3Kvg==
X-Google-Smtp-Source: AK7set8UG2lj0mTFkSwAk6ffmg7pUvx5blWuKd7HMb8t5vhWEH4y1bWQciKzeiyBGfEzfX4qJO9mQw==
X-Received: by 2002:a05:622a:1042:b0:3b8:461c:12ed with SMTP id f2-20020a05622a104200b003b8461c12edmr14300022qte.8.1675103451536;
        Mon, 30 Jan 2023 10:30:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id o8-20020ac80248000000b003b64f1b1f40sm8466415qtg.40.2023.01.30.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:30:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pMYva-001MRl-E7;
        Mon, 30 Jan 2023 14:30:50 -0400
Date:   Mon, 30 Jan 2023 14:30:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bo Liu <liubo03@inspur.com>
Cc:     kwankhede@nvidia.com, alex.williamson@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/mdev: Use sysfs_emit() to instead of sprintf()
Message-ID: <Y9gM2slmBuqZ6QkQ@ziepe.ca>
References: <20230129084117.2384-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129084117.2384-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 03:41:17AM -0500, Bo Liu wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sure

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
