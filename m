Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EEA669CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjAMPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjAMPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:42:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1284608
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:33:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y7so812862qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQI6vgm2xgQgpNNvT4RMcnXxKD+7fzh1MD+K+DhgarA=;
        b=Pprb2f4po0IpIe3vbwxVGZBmpybDrmTfJgxva2CmlvWg06Y3JUow3UHlg/AnmwW5Yq
         9V2roOs8bRBvWog3uX4ifMfUR1MYoGklXRENmhDRydxccS6F77l87cUw5kbAaUG7l6Jw
         43Lu0EjlNJa8GOjw1auSYr3r+sz/hCucHRRp3frAnRlmHpoToeAUyO4D1oOzEUiZxzVA
         8onmwupSPKS8LyGskdD7gRz8EG1i0YwmpeMrhMtaiix5TSfB5TiqzSohOmLyds5x6lrq
         IATThdQycbiUifH20/v1MuQuV4OQhUbQDL+OftLrDl73TWTdduBK3nQm9KSo/mXCeIdG
         Bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQI6vgm2xgQgpNNvT4RMcnXxKD+7fzh1MD+K+DhgarA=;
        b=E0x4DUgOD1Lf5f+BYhY8aVx3SmGeuDaOlna9Txal8qtkdOP3LbYIsgCl40h3nCzZTc
         /Egc9K9ak5JooHLLFl48yCeY/mMrlAdWKgx4VklxVzTJ40uihVJofMD7bpgyMXqFj6d1
         44aebc6XF0Er0V8Klu8k9CiOKKOD3GnbgZF60yzsJCFKL2v112KXpJVyP5ielj1uSUAn
         zNwKN2gUMFmWy+GnJiklX0QIuljAMaGdVxW+5hWNjf87ACMPiGLjasMUi2r+k5aZWr96
         WBwOwn6XeDK0HK/OjKCoJ+uX8W6XnXZJ0+3FS/XQSd1QKXiBa19kF2pifD0yoXLCM9L4
         A2Yw==
X-Gm-Message-State: AFqh2krTXg7UFAYoc5xS+35UNo0ZZTHyot4S1IOPOhlX/Slxmi7glRoy
        j2W/mmH/w5sI0JuFsHlMfxCQDQ==
X-Google-Smtp-Source: AMrXdXuZR91ECSn7pKg9pvDh46I8W2eiRyV7xt40EsLkKPvmvLUjBdS0ALJVd/MI5RbEYttreGSglg==
X-Received: by 2002:ac8:41d9:0:b0:3a8:a8e:c0e0 with SMTP id o25-20020ac841d9000000b003a80a8ec0e0mr101344764qtm.8.1673624031141;
        Fri, 13 Jan 2023 07:33:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a240c00b006fcc3858044sm13185779qkn.86.2023.01.13.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:33:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pGM3x-00AJkz-9M;
        Fri, 13 Jan 2023 11:33:49 -0400
Date:   Fri, 13 Jan 2023 11:33:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, ashish.kalra@amd.com,
        thomas.lendacky@amd.com, vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8F53dzdebKLTlOy@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
> Currently, to detect if a domain is enabled with VFIO support, the driver
> checks if the domain has devices attached and check if the domain type is
> IOMMU_DOMAIN_UNMANAGED.

NAK

If you need weird HW specific stuff like this then please implement it
properly in iommufd, not try and randomly guess what things need from
the domain type.

All this confidential computing stuff needs a comprehensive solution,
not some piecemeal mess. How can you even use a CC guest with VFIO in
the upstream kernel? Hmm?

Jason
