Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B036950B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBMTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:30:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF0272C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:30:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id co8so9625747wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+PQ5ihkLZBX24QKUEX6RYAfdl271h7g2O+CKjE4XF8=;
        b=W9Fhgi3XjTdcf7W0zcPgebL2IWIvv30t9YVJAYhFMJZgypIwvmhTDrlTjlx7bj4JyY
         PpAj2Rnj+Eu0F/ftO4StwyJ+ydtbU+O5Odfx3z9IVQx9MvXEN+LHzpORKuG7eB6fAvwt
         qVhWF4Qf3TXzdUUzRv9xX+MO49/Vyq13B8YiAjscE+Ww+WQKq8Yqzk7cvzMLN7Lepm4q
         IWAgciG95B8WQUxEIPkzY6VZuyEktXzzv1M81AHayyUqNTsEFvXOcDXuQFMus0P6j/zT
         PJa9kk5ViT/sg0qGq7qAQ8pmUHQIp2ybCri5YlLGTawCl3xOYjgFRVpIJIx1lhGDX87v
         sDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+PQ5ihkLZBX24QKUEX6RYAfdl271h7g2O+CKjE4XF8=;
        b=VPfTEMNf2lGVqsw31ncFXWmWdVqxkCgFL7IvgZzhQ9SOi0v7d2DFrXzhLxg9/RnaGL
         isjExjX7v0QU6oDAOFIKrH7T4CzrtlfoNZdy3+vJ2M+YXEBssM5dsuq4+yizA1s5At+N
         X2k0MH6j5ZtoJ1swq1IXZa1+c3/ap6yL1uwt+Fo5VlsPX1EPEbtvD2+4vmX4OGlL8Irn
         tMVXSTRE3olS9gO5Funxx/rhMgifRKpeDJYDlpoijOQFH1H5SDvIsV65Zhhsfs9VxR5x
         Q2f1YRdPtao+cIV4hJrACgcJAleMdC5ew1VPon/v/dytnNCyaNvb+kExeObRPGf0j5iX
         KS3g==
X-Gm-Message-State: AO0yUKXbfRyiTK9QWHsUX/ltOA3eNlq5B3mmQE1diVbJYzejPoRyc7/l
        g+x06+MGxey7sT6qH1iBB5Y3Zg==
X-Google-Smtp-Source: AK7set/SYf0lCxkP9aBTPKdR3/1lqJqR5cFvQtyk1WKeA0gQqK2dqeIy6SzYJwn/pOlPJbO9Mr0yMw==
X-Received: by 2002:a05:6000:10c2:b0:2c5:53e6:9aba with SMTP id b2-20020a05600010c200b002c553e69abamr4941296wrx.5.1676316636680;
        Mon, 13 Feb 2023 11:30:36 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dc4480df80sm20126681wms.34.2023.02.13.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:30:36 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:30:26 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+qP0q9U0J2UfIxX@myrica>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213103455.02f3ac37@jacob-builder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:34:55AM -0800, Jacob Pan wrote:
> > On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> > private data helpers") removed the last user of ioasid_set_data(). I guess
> > that could be dropped too, unless you plan to still use it?
> > 
> You are right, will remove.
> I was planning on the other way around which will convert VT-d's private
> pasid data helpers to common ioasid code, but when I look closer the
> private pasid xa is just holding a list of pasid/mm which could be per iommu
> not global. Another cleanup I suppose.

Yes that should probably be common to SVA. I'm planning to take another
look at SVA on the SMMU side following the recent API changes, and from a
quick glance the problem that VT-d's private helpers solves is common.

> > We could also merge ioasid.c into iommu-sva.c at this point, since I
> > haven't seen any interest for having multiple IOASID sets on Arm, but I'm
> > not sure what the current plan is for vSVA on x86.
> VT-d do plan to use global PASIDs for DMA API with PASIDs since the
> work submited via ENQCMDS must use a PASID must != RIDPASID.
> https://lore.kernel.org/lkml/20220518182120.1136715-1-jacob.jun.pan@linux.intel.com/T/
> 
> So I was thinking a separate ioasid_set for devices that allocates global
> PASIDs for DMA API usage. ioasid_set will be useful here for limiting
> lookup and resource management. e.g. PASIDs used under in-kernel DMA API
> are not subject to cgroups.

Ok. Yes that was the goal of ioasid_set

Thanks,
Jean
