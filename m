Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CC73001A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbjFNNbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbjFNNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:31:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DE1BE8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:31:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f98276f89cso191741cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686749470; x=1689341470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPogWzmsJ1uvTQmxk29cAdOXJbnNlr5lDiNRKRRfY+Y=;
        b=uD0jAp/lTJTKXuircqMDJh7ibnACj3Kymu3Rc/QmTOPRqLUM7CGWWjC1/Sj8QyDl3k
         6KXJd7yNCltiUbmlaniei7G+fyaEOirccZnQCqYu7o0UJPPBz1kt9xynZm19ACbIsrtS
         84iJPzLYoSU9QAJarFECN+V4RAwsoVbQlB396Wrty5lS8XrwEn2eJli66e4mcGvguTiq
         niJ/JMFW3AYlPi68nLDUWZCAAmocN6T9vZOusEaDAT7JHlT2TzQx9VK10LhFRgFYSWkX
         rfX6DCoDTM5CBcVpJlcpStCdXCaKrOG3czdGbp6TWxqQyB2STjzyO+G8c3tuZDCtqoMG
         xFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686749470; x=1689341470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPogWzmsJ1uvTQmxk29cAdOXJbnNlr5lDiNRKRRfY+Y=;
        b=Jq2XxTDvohG0VRl1QlIPT/11DBC6WDbrJrUKlmN6edf0xcai/U+cOIxd+8y8ONXubw
         mqzAnkxY45ihgRMVlifM5wRjjyZ5BEKKi7W9lMVm+u8UwkXyq1MdrrP2/ZPmotQ+IDI3
         i+/O+i4R7d8tt+WV52fOhiQbXwCa0XcVAW1h5OPXRRNoU3RX+RMYDi7PdYiTEZJMPcDz
         0m1nHCfG0aPHLLXNf4xZpLFB6KSbnQAZ5vkta0LTOGw+PzpdHisbMN/mzGEQhiNFj8zf
         DP8WEMcDvXHy9xcM45Ixnfgj9Tk1dXu4St+y3c3/7qpn+pp4/+VrvoLSG+/nL4iSsFly
         8KZw==
X-Gm-Message-State: AC+VfDxalkQFgBM2nMg0Hn5nCPwtBttSZ19Z2Sj9Q2BT3sHia+bHwTiJ
        FkkAZyuvp4c5PGTLnxC9V2BjHanYILBxK1MhrRyCSQ==
X-Google-Smtp-Source: ACHHUZ459VPSubsKO+LN6a8B8Ad5v2JYGZHNAmEqMt29iXtS2IDCmjQodsu6UZ0tCBNXSEK9t6Fevh3pk7oiUFyoqVA=
X-Received: by 2002:a05:622a:188f:b0:3f9:56c:1129 with SMTP id
 v15-20020a05622a188f00b003f9056c1129mr174966qtc.5.1686749470220; Wed, 14 Jun
 2023 06:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com> <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com> <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
 <ZImuIPrB2YeulNn3@nvidia.com>
In-Reply-To: <ZImuIPrB2YeulNn3@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 14 Jun 2023 21:30:34 +0800
Message-ID: <CAKHBV25g2M-35ZQ9X-mx-La7jVDgBm6rw-umOkNdgu3_jAiA-A@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 5:57=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> In practice it would be entirely reasonable to only support
> cross-instance attach between instances with matching capabilities such
> that they *can* share the pagetable directly.

On Wed, Jun 14, 2023 at 8:10=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> When we talk about multi instance support, it means the iommu_domain -
> in whatever fixed IO page table format it uses - can be attached to
> any SMMU instance that supports it as a compatible page table format.
>
> ARM doesn't quite reach this model, but once it passes the finalize
> step it does. The goal is to move finalize to allocate. So for your
> purposes you can ignore the difference.

Got you. Failing the atach when the page table format is incompatible
with the smmu device is a lot easier to handle. I didn't notice that
SVA was already checking this elsewhere.
I can give the multi-instance support a try (with the rest of these
patches on top) and send it out as a follow-up series to this one.

> I think it is good to make progress, it looked to me like the first
> part stood alone fairly well and was an improvement on its own.

Sorry for the noobie question; it's not 100% obvious to me what the
next step is here. Is there anything I should do to progress that
first part forward?
