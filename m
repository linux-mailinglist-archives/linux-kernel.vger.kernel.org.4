Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89D73B91E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFWNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:50:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA02699
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:50:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so497344a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687528210; x=1690120210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+1pIFBwxpLNL/VoMpzyTvuzZptHIhilPLYErQwUS8k=;
        b=hAT1OlnZCSwyNFydf13NvIycgXr5/iIfC6r8/nd0zLufzjnG76xScQ8fkAvjuDR9HA
         LKstTMkVB1IimZFBU+AILwUx2GaOikMy+PW2Eg7+k6BnlRwGKiPDbsTCp9VVgh0lD6bi
         8QYBpzPAZyybBHinxa4YFTWPP0+n1bFlI15Wjv6yMRRcN1lRHOpBz63Iootsc/mjPBYf
         YMeoCsk0bHsnceZKYdKo46Nve3OJdWtoZevSnvjANuI1wSA0s6vRTB0FXzEE4I7M2vF+
         lGRMvxSZ4U+bjAWHupE09pIQBGQgCvCiABu5+zuXGjJLJXB75Ua+e9EoKOR+y1vzr1qk
         UKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528210; x=1690120210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+1pIFBwxpLNL/VoMpzyTvuzZptHIhilPLYErQwUS8k=;
        b=kWLM6Dv6TQf9qG3/bNeVo0tuViWqQRIm4vvfuR5uckAt2LPbf/sxsFa6u7z715kaHB
         xylpwvoo3WXwQoIWOYhzE56dGbwygzB9/uQiEJsywipgl3AxOWVGNmDxNmyoo1ZLjwZJ
         MQ1d8fRUQlXq5Zb5lnpsgekzwn+5OJ/JrdUf/FySK45jKh3BCIdrhwAVI3ubzPzJf+sf
         TCYtJzPJ6k6AqGc/CwtzGMBP/ixLauFw99/GZQdW6/JDWb91rq4Re5kK3jeGdqeG/wQ9
         yNnyk8fQagLm1rJUtTqo69q2FX8OUgknBLoVwMnMHMIgQbgr+GylPEIxE8hh8gJp+qo1
         UDJw==
X-Gm-Message-State: AC+VfDzSZ/lxF8Eqx20nRq9/XIhRD1nGHqMXAzoz441kDv7LY+xy01zP
        5SvlxFGb4kswc1c9Meq2TUqEPg==
X-Google-Smtp-Source: ACHHUZ4GZmcSemtE667i1A/XCxE0H28ULkbHrmN2r73R4aAzspqKPCakvWEfvpegChi/MFwoMtwoWw==
X-Received: by 2002:a17:90b:811:b0:25c:7d4:7cd with SMTP id bk17-20020a17090b081100b0025c07d407cdmr25932024pjb.24.1687528209792;
        Fri, 23 Jun 2023 06:50:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a2cc100b0025bdc3454c6sm1647744pjd.8.2023.06.23.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:50:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qChAt-007z7M-Gb;
        Fri, 23 Jun 2023 10:50:07 -0300
Date:   Fri, 23 Jun 2023 10:50:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <ZJWjD1ajeem6pK3I@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHaV3GwYXCvfNUBn@ziepe.ca>
 <a3c15dff-c165-57c7-16f6-072e251a9368@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c15dff-c165-57c7-16f6-072e251a9368@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 02:18:38PM +0800, Baolu Lu wrote:

> 	struct io_uring ring;
> 
> 	io_uring_setup(IOPF_ENTRIES, &ring);
> 
> 	while (1) {
> 		struct io_uring_prep_read read;
> 		struct io_uring_cqe *cqe;
> 
> 		read.fd = iopf_fd;
> 		read.buf = malloc(IOPF_SIZE);
> 		read.len = IOPF_SIZE;
> 		read.flags = 0;
> 
> 		io_uring_prep_read(&ring, &read);
> 		io_uring_submit(&ring);
> 
> 		// Wait for the read to complete
> 		while ((cqe = io_uring_get_cqe(&ring)) != NULL) {
> 			// Check if the read completed
> 			if (cqe->res < 0)
> 				break;
> 
> 			if (page_fault_read_completion(cqe)) {
> 				// Get the fault data
> 				void *data = cqe->buf;
> 				size_t size = cqe->res;
> 
> 				// Handle the page fault
> 				handle_page_fault(data);
> 
> 				// Respond the fault
> 				struct io_uring_prep_write write;
> 				write.fd = iopf_fd;
> 				write.buf = malloc(IOPF_RESPONSE_SIZE);
> 				write.len = IOPF_RESPONSE_SIZE;
> 				write.flags = 0;
> 
> 				io_uring_prep_write(&ring, &write);
>             			io_uring_submit(&ring);
> 			}
> 
> 			// Reap the cqe
> 			io_uring_cqe_free(&ring, cqe);
> 		}
> 	}
> 
> Did I understand you correctly?

Yes, basically this is the right idea. There are more complex ways to
use the iouring that would be faster still.

And the kernel side can have support to speed it up as well.

I'm wondering if we should be pushing invalidations on io_uring as
well?

Jason
