Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6066A39C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAMTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAMTpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:45:49 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20657149EC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:45:48 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id k11so2756929qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKGPCf/WnxdeLrYkK1h+ppHtGH89vAKEcp2AHfVnqm4=;
        b=n2gpmqnoZpxhC3drOnKm7dGJnMc+A5U1oEyYzBn7a1CVOiYw71+v2fp7iRd8sYB3IT
         gl0cyILRJ1N5OLYiuVxE/GR20AFXznJH3mPXp9/Q6/jZhtv6xQwpGkpupOoocprdfumb
         5HTc6oYRrawLHVhRVtDT6C6SdwGcYU4FZro0UTJBt+/jX6LA7Bq3rKGCYn0fnVeA+NfH
         wfGVYwod2iwcU4p9MbM/LBJPOe2hB4QK7OQQGQ2n7y4AzbdXgl3hqQidYze7ArRo0FKs
         O0lb0Jg04iN/ie1kC/tTTOpt9elPhN/uV41htq2/HBT1oeqzpZJ7JBYhTbCUxe0TrNJk
         hg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKGPCf/WnxdeLrYkK1h+ppHtGH89vAKEcp2AHfVnqm4=;
        b=gxNtJMpHGNtRq9XpNSQcqQ2F9vUZKjP0jYJbxMKVppcrQDNOrTVu+E2jciC565+qas
         6NXyVR6Dy4mwUkFJZQzrBpJvJZxEAg0OIwzUdHQZ/cl0kl9YoxZwpWLua0zuagxwnVm3
         rMKe1GwArKmrj09Zm8wH7qixze2SQ7EeZx+/vaTQrTLrAC5b9AeRlKCmXHrfvYonfBI1
         z7VOZGSJaLdCLBrgca+dZg7YkfMCy7R6HTs5rD2+cZh9XkfCEEyk/P1gmy9C5Z+TsaEA
         h0Zv3/aXbzN5twNiN9nieYeOwcKxUWM03u5pBOp3vdTQqJrcnqitxml9PxlpMO2rlEdr
         oWZQ==
X-Gm-Message-State: AFqh2kp5bKH8WO3Ff3FAq7sY9cyaqI28iH/6C4theKEqwdqvzxW7K9b6
        jBBgaOOuJ3g5y3w3zqlE+pykPw==
X-Google-Smtp-Source: AMrXdXvfh9K8c6l/h2CIEbjJU3hrWPX5b/ImJDym2kleyYB+2ny0W2SD5wzPbNH4mDp/UDDlMcqwcQ==
X-Received: by 2002:ac8:1382:0:b0:3a8:1793:76d6 with SMTP id h2-20020ac81382000000b003a8179376d6mr108960695qtj.68.1673639147243;
        Fri, 13 Jan 2023 11:45:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006feea093006sm13223828qkp.124.2023.01.13.11.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:45:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pGPzm-00AghL-3u;
        Fri, 13 Jan 2023 15:45:46 -0400
Date:   Fri, 13 Jan 2023 15:45:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8G06onFowE3ZIy8@ziepe.ca>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca>
 <Y8GwHQLKnXyqa3Ty@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GwHQLKnXyqa3Ty@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:25:17PM +0100, Joerg Roedel wrote:
> On Fri, Jan 13, 2023 at 03:12:21PM -0400, Jason Gunthorpe wrote:
> > I'm surprised the 0-day bot didn't notice?
> 
> Well, I think 0-day does not spend that much time on iommu patch-sets,
> especially doing randconfigs or allyes/modconfigs.

Intel folks, can you check on this with the 0-day team? Perhaps since
the list was moved it is not properly subscribed.

> In general it is a good idea to at least compile-test every file that is
> changed in a patch-set before sending it out and not rely on 0-day bot
> for that.

Against every arch combination? This is why we have automation bots :(

Jason
