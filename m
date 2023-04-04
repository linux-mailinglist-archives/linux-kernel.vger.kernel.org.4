Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E096D5FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjDDL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDDL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:57:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9072D66
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:57:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so33667262pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680609454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTwFcHS/8yOZBWKFlMTZaPkkZCliD1k8JEi+Gd6s3c=;
        b=C1tDZMEihkEQL+ZSeKLYJQFSsL0mNqr8WR2abugowOfpazV3XDbvl1tiEu4ve5LQQ8
         CAVfecYY6QmtqG8HHPmrFjiWNmD3BgrcTxXx7dWfZWkp3PISrAcNI45XQElB7LOMrTlx
         JSHpWcDR9PZ88n8Kv9dD2gOxzoKKStHqLD2NQU64aKDtcGp3noU8/Fg/6p8eh8HN2Rw9
         GHJ+cdKP6BcvmDMrDGrF76dlBaTp/tHunp5I3SkOLqjO930f0P8z8wqciDCt6RAh2wML
         DZZm7p1N7Y4I+aJ/T821M2gsk6eizSMtRebFtcPVDNoz0TGOWFv2jdGQQdCiLufIxN3+
         2ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CTwFcHS/8yOZBWKFlMTZaPkkZCliD1k8JEi+Gd6s3c=;
        b=Sa970W//HrE/1t5BmRCXrZcM7csLjDFgVV4tKsOjbSxTWsfIX37JPOn+FhUvuZHLjv
         5M6cYuCYqrffIPMYNJOy1kB0Zg0NSkfuIua5rr5vnaCDk12q2VYqIbJOE5x5n9Wl7SjU
         rOqfA17eNbP0cii2dH6hnogtMJ5qxsajyCWuvYbRLQ1HNB1cUnumrsvantO5TnO50tGG
         cCDR11FuNiITeM90G+zKz37Sap9ExWRrBubZ6bzKDPtMg0CILpXl2whEdz+Sfg3DO3S7
         pLDDbwH+QFj1gQ/8W+ofXBXP0G4FDCZiJhaA1jQlPsY92y0ipzsUQuGNOdZg/xZbw8wz
         OBxA==
X-Gm-Message-State: AAQBX9dtsNva+HBrSCgjY9uw+zKN7148Gbe5bkXR2+PD8thGrnm+iW7P
        Np++cF1YArbYgWETFHMsr5NOS87w2Xi/xO0ddRo=
X-Google-Smtp-Source: AKy350aD0ufDEk6dm7Sf4cDwh2C8kxgP0F4iRIpac8/dPOMgE7oTDjcBAONiRvEN+BQFuLKLu7saVg==
X-Received: by 2002:a17:902:e2d3:b0:1a2:1922:985b with SMTP id l19-20020a170902e2d300b001a21922985bmr2001300plc.59.1680609453932;
        Tue, 04 Apr 2023 04:57:33 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902b11200b001a216d44440sm8218246plr.200.2023.04.04.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:57:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pjfI3-006WXe-J0;
        Tue, 04 Apr 2023 08:57:31 -0300
Date:   Tue, 4 Apr 2023 08:57:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Rix <trix@redhat.com>
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: set varaiable mock_iommu_device
 storage-class-specifier to static
Message-ID: <ZCwQqzrg6EL7tgdM@ziepe.ca>
References: <20230404002317.1912530-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404002317.1912530-1-trix@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:23:17PM -0400, Tom Rix wrote:
> smatch reports
> drivers/iommu/iommufd/selftest.c:295:21: warning: symbol
>   'mock_iommu_device' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I applied this

Jason
