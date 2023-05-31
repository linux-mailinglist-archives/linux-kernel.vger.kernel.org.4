Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F771727C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEaAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjEaAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:33:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ACFC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:33:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f829e958bdso15322001cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685493214; x=1688085214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
        b=NSprOvANr8rmmNMRfGUGQhrlbjOY3VNneKCREemdYMFsq+wZseIXs4cVn2cfctqTC4
         l/Fex2UztpB64Sv6bVKzNW2Qn0dqqb5NbD1cJWjIOn75Zk0NXfpMON7ItM9ydFy5Ew5U
         s1hUijdnCq5qu7Zs5EJmJe13GN3xQ65TBxqudO3SU+vn3Sqj6RrsWVsk2oCYcnPG3p84
         jQDN28rHXrMKZ637sGrN6F/CCcU4XEcphoJElhcnaXxrFBaFj8p/dlxWO0sR9zCxF7Dn
         z3eQ+08mRG3B2cvqFNdTFZputqdjR8OXMmJun0qCmRxWBxzTeKu07oZNguwRyhjTnf+2
         ghdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493214; x=1688085214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
        b=W0aeKnlfDjyAsu93Ht+xMQCvcOoFOCso2HQ0ZKd+OrzCa+jhT7idcgxy8E5Rm9tru5
         AG+9UoiXa6TZEzcTHbBfanl2VNfeAoDMYt/gJ45wPef52JKlXGCEMVOmgtr9YCNuqC9z
         C7/Vk3nBwMpPZ/AUaO0QKJiPmzitpohS72SN0n9EjDRzp1/+sHAJuj7tJidHfOzEcIDc
         ZRfWHlS35VcbC6dnpjHRbh0K8BVKmbgcZ3S71nbOE+YbF0bMKmx45N7WTn38TtP6Vio2
         922lcMJPwLh70mr1nTvfqefdBuRbgYEQCDp06la9hthadj+JfYw/5PXiySvVr7i8GZds
         UaOg==
X-Gm-Message-State: AC+VfDwvG3gln9xtQmxffctOoS2xWUCjlXpJA/5c9YOXROfOX1fGYAXA
        4vQWU4xwpFiznthv9Kf3UOZ7Phu6LlfHgy4/gkM=
X-Google-Smtp-Source: ACHHUZ76cGYRoxD2nR+OVC7+AsKBaaMRBv2OxrvCIPruwBslaqJO8TAA8q2yEjn3iVhl/m095jOZyA==
X-Received: by 2002:a05:622a:198f:b0:3f6:c52e:21bc with SMTP id u15-20020a05622a198f00b003f6c52e21bcmr4111272qtc.19.1685493214434;
        Tue, 30 May 2023 17:33:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ff27-20020a05622a4d9b00b003f6bbd7863csm5256617qtb.86.2023.05.30.17.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:33:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q49mO-000kYe-OG;
        Tue, 30 May 2023 21:33:32 -0300
Date:   Tue, 30 May 2023 21:33:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZHaV3GwYXCvfNUBn@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. The use case is nested
> translation, where modern IOMMU hardware supports two-stage translation
> tables. The second-stage translation table is managed by the host VMM
> while the first-stage translation table is owned by the user space.
> Hence, any IO page fault that occurs on the first-stage page table
> should be delivered to the user space and handled there. The user space
> should respond the page fault handling result to the device top-down
> through the IOMMUFD response uAPI.
> 
> User space indicates its capablity of handling IO page faults by setting
> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
> will then setup its infrastructure for page fault delivery. Together
> with the iopf-capable flag, user space should also provide an eventfd
> where it will listen on any down-top page fault messages.
> 
> On a successful return of the allocation of iopf-capable HWPT, a fault
> fd will be returned. User space can open and read fault messages from it
> once the eventfd is signaled.

This is a performance path so we really need to think about this more,
polling on an eventfd and then reading a different fd is not a good
design.

What I would like is to have a design from the start that fits into
io_uring, so we can have pre-posted 'recvs' in io_uring that just get
completed at high speed when PRIs come in.

This suggests that the PRI should be delivered via read() on a single
FD and pollability on the single FD without any eventfd.

> Besides the overall design, I'd like to hear comments about below
> designs:
> 
> - The IOMMUFD fault message format. It is very similar to that in
>   uapi/linux/iommu which has been discussed before and partially used by
>   the IOMMU SVA implementation. I'd like to get more comments on the
>   format when it comes to IOMMUFD.

We have to have the same discussion as always, does a generic fault
message format make any sense here?

PRI seems more likely that it would but it needs a big carefull cross
vendor check out.

Jason
