Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C16ED3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjDXRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjDXRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:42:18 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016F83ED;
        Mon, 24 Apr 2023 10:42:17 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-246f856d751so3417171a91.0;
        Mon, 24 Apr 2023 10:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358137; x=1684950137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7Xt9uEIH90evzQPe7fSyIGgVAJj2Yh/Pr2NGEckxCM=;
        b=WGC2P1dM2wRGtyJkUl+dWdKVmZ2iUiYJd8iw3xygoELLlKGQFZmPY6iuJ8AP8uEiBz
         upjSaef5UU8CwcO0GI+VLvfqQsl6Pl1ziMu8W5dEBLaOAMMLjwpSOxMr2A3O9dpjHlUl
         odiyevsKlGEBbRTZol0C8Bw53OOOwZ+FX3XZLWarSDidQ4FNwW5iLXdp9pbpPluJZfhM
         arNHcrxFKK/XPXJbJrXUONK6ksqIJ0OhrFvUT5M0p85sAEpqSBsBsjDscEc4pFau6eSu
         pj7sYCBUdOqr+so7j8WpMM/3K3Nv7at4FdsuJ39+6IJADJ+T0YGSijYB+A+aAl43cZn2
         GJxw==
X-Gm-Message-State: AAQBX9fID7ifcb75vNF+EOLdm47AeES9kQeCP9lJrbx6ZiFYpIBj8zKv
        JpSaY/R1PQ5VszM9ztRTAv8=
X-Google-Smtp-Source: AKy350Z7R6wHgAEU8CddrgRNHJKpqJqvlfxQ/bj77Rl50unombtqBT40M4SAkwqZjBLJh4fcdXGrBA==
X-Received: by 2002:a17:90b:1d09:b0:246:b60a:290b with SMTP id on9-20020a17090b1d0900b00246b60a290bmr14395359pjb.21.1682358136879;
        Mon, 24 Apr 2023 10:42:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090ae00500b002467717fa60sm6855043pjy.16.2023.04.24.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:42:16 -0700 (PDT)
Date:   Mon, 24 Apr 2023 17:42:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     broonie@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with the hyperv tree
Message-ID: <ZEa/dj2URSx8HPG4@liuwe-devbox-debian-v2>
References: <20230424154742.131094-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424154742.131094-1-broonie@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 04:47:42PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the sysctl tree got a conflict in:
> 
>   drivers/hv/vmbus_drv.c
> 
> between commit:
> 
>   9c318a1d9b500 ("Drivers: hv: move panic report code from vmbus to hv early init code")
> 
> from the hyperv tree and commit:
> 
>   525f23fe58b59 ("hv: simplify sysctl registration")
> 
> from the sysctl tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc drivers/hv/vmbus_drv.c
> index 1c65a6dfb9fae,229353f1e9c29..0000000000000
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c

Although this empty diff looks strange but it is indeed the correct
resolution, since Long's patch made the same changes as 525f23fe58b59.

Thanks,
Wei.
