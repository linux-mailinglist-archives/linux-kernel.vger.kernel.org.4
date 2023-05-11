Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8576FF72D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjEKQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjEKQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:28:11 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413501AB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:28:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f396606ab0so822061cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683822489; x=1686414489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STetVG+qvi0CL668V0Zk0EbkZzknrcNB3fV6MdWj5bs=;
        b=yKgaAsAqUv9tv0a+VliFPbC2vfoGBjEXEflzcqZYCLvvh6sjTFKgxnM/PQiTbmHswc
         RHSPE3pW+mlbaHeY196ovsZqYHaaLAIeab5lGfC1+fyKQ8mUBaj9beuZDFe3P6q29q7l
         ftj4ndWnExEEwkRiTiRuRDc46iHZRq92zUZ8YzUQcsWXQI6tOcNlkrwqQUw8qjf7lG2F
         XckYIfL9mxK9sAYfimUJGkGXUhoUp8L1myos7QGx+xDpm8Knfho/FpzD0m8yLLPuCxoE
         kjlgo7DeRORguufBXIJzgotmRqsKMDLY80FvI8Lu6sznSxFtTCrMk6khTivgGtbE154F
         kf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822489; x=1686414489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STetVG+qvi0CL668V0Zk0EbkZzknrcNB3fV6MdWj5bs=;
        b=dkGBTzp47IXUt+OOmYVa9OFwJzcad5woFbnaaKaBYWG0RX36bbXYbWYMe9jyfRXaai
         7SEJ0m0EOjOZpA8gAn3kh+nsz9UyQo3lPLcqYLMOca5b1pYhQROcBJF0/oA4MWJB99Rb
         ECClQBE1jTPovx+NNyp1oMd9dNfZ7BDTDy55pY6+vFmUGPzE1Ar6WsbQSZj2EptY7UwZ
         NDGow2qbANBxzNPQEVwjPoZ64sbTeJmz11C698KE2ZRTkh5PxJ8c3JcrFo0pAe+v7qcF
         xekxs2bIO3sO1szCiOKmxD2XtA6KRGVQh2N0vQPuffRDPZ8Arpm2UYY9/2g7zx32Eb+m
         4IFQ==
X-Gm-Message-State: AC+VfDxqEu3DbH70Jtqxzou0Fd2MjwHtASm8P3L9t08Q3L5RaZl/xoLd
        1tGqCoPKn1f/IAp2qNAioa04KjJmlgoUXa3wQhPNnA==
X-Google-Smtp-Source: ACHHUZ6dAh9Vj1WuTA2zlUdr950FE1lq6E1MSpYOEXuUwYhZF9weSQ9S62J2Ub1qtyQ9zdX/h39pTaCsUN6xVEP3+y4=
X-Received: by 2002:ac8:7f47:0:b0:3ef:1c85:5b5e with SMTP id
 g7-20020ac87f47000000b003ef1c855b5emr26870qtk.19.1683822488921; Thu, 11 May
 2023 09:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-2-mshavit@google.com>
 <ZFwJfVOKWsFk8oup@nvidia.com>
In-Reply-To: <ZFwJfVOKWsFk8oup@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 12 May 2023 00:27:33 +0800
Message-ID: <CAKHBV24d3At7aFBu8-ZT+JHxepS0YP7LsN6Msw+oc=cfUtG5OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 5:15=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> As per my remark on the cover letter this seems a bit confusing
> description, but the idea that the CD Table for kernel owned PASID
> list is placed in the 'struct arm_smmu_master' does make sense to me

Ack; glad to hear the idea is well received. I'll rephrase commit
messages for v2.

> This patch seems very big, is there any way to break it into smaller
> steps?

I can add a preparatory patch that defines and allocates the
arm_smmu_master's cd table before this patch starts writing to that cd
table instead of the smmu_domain owned cd table. This doesn't cut down
the patch's size by a significant amount but it's a start. I'll try to
think about it some more but a lot of the other changes in this patch
are pretty tightly coupled.
