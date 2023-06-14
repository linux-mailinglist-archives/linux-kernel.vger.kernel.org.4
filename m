Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74BB72F9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbjFNJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbjFNJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13326A9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:43:45 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9d619103dso136891cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686735824; x=1689327824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qu3MImrtsoFSQo9D12BQh0F1vRw24uhJW9sO5eRWsw=;
        b=Ke9sBRa+YAXRQkgGZB2BAtw/UiC0JslVzSUE6ilG43GOBfoOB7pSJjAHngj0d/zn92
         7TGRmOW/rZ4LBKRoJDeu5so6xf6mGwfmGxFgRnbI+wEUraGpS8VRPTs+gkeeWluhpRYR
         DfaIpb92Q7Kclt87Mt8B8LRFPLbkn61Lq+XuzonNHPiUPS+fopUx2iwzGb924Ojd+AFv
         V93dzyIcA1bWc52Y+EJyxgDVa+2QqFjMWH/E1m9dfr1fY12yI9cPOgaIbzzSsqjl3Dit
         V+dhuLogegraNawK2JGcK/0D8DZhDdm9NPnpXj7PU7Yo0qdJIBzVUoxlRZBD+BI1DrJT
         QFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735824; x=1689327824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qu3MImrtsoFSQo9D12BQh0F1vRw24uhJW9sO5eRWsw=;
        b=ez2uPBD/6u03JX7VVEjw/5QTPNGNJNqXCN+Lbskuy4scj0MrRrUbMIz8g+AsWpq6hU
         7Qw5vmRI56rNTsOxk/0X0g7SmrcPkEMSU6CjtsX+uHoWYWnf1zxjhEgo7p4N5hPUPWTq
         XlgC7Ju3wtzBzOjcRlfXkCY9LhROAxUHbSzn3snwduZe1O/K1EudrlJOfX3I3OVCGP4o
         bsisK2wPOBwcgV8evXNXdmEpq6IaQZEZgnBVQNUXuvy7PeKa9j2fKeYEd7HTJ82XAZod
         uVNs65APJaEuU1AudBRMv2YNByY2zV0gfInBZuAXxVj8KALygZGjg86Y+8Ti+4OqiTVI
         HHJQ==
X-Gm-Message-State: AC+VfDyvJ1GyK/zNqvpI49IKkQaoMxcX8HiBCq4UhznNBIxdsFgyfA1Y
        KpE/aIn3nPpCqETezzvXgnOmYAukP+SsUX7M78XQ+A==
X-Google-Smtp-Source: ACHHUZ41slMgNxuS4zG5bSvRmQZARD+F3lz3ob/djkBULk2Zy59tAVxnoqZnBBqzA+ArgvDNoBALza90DXs19QLITtU=
X-Received: by 2002:a05:622a:188b:b0:3ef:2f55:2204 with SMTP id
 v11-20020a05622a188b00b003ef2f552204mr202066qtc.6.1686735824346; Wed, 14 Jun
 2023 02:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com> <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com> <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
In-Reply-To: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 14 Jun 2023 17:43:08 +0800
Message-ID: <CAKHBV25CO-tgxCa6_=yZLGD29hNCoP9s3q0tGy3w23j2N4b9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
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

On Wed, Jun 14, 2023 at 5:17=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> The arm-smmu-v3-sva.c implementation avoids all these problems because it
> doesn't need to allocate an io_pgtable; the shared arm_smmu_ctx_desc's
> TTBR is set to the MM's TTBR. One possible solution would be to make
> the changes proposed in 1., but only allowing SVA domains to attach to
> multiple devices:
> 1. Domain functions only accessed by arm-smmu-v3.c (such as
> arm_smmu_iova_to_phys) can assume there's a single
> arm_smmu_device_domain per arm_smmu_domain.
> 2. Domain functions also accessed by arm-smmu-v3-sva.c (such as
> invalidations commands) must iterate over all arm_smmu_device_domains.

Or rather, arm_smmu_domain would hold a list of attached smmu devices,
but only SVA domains would be allowed to have multiple entries in that
list since the other arm_smmu_domain fields are tied to a single SMMU
device for other domain types.
