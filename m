Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A226FF5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbjEKP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjEKP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:27:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E9197
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:27:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f38824a025so805831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683818845; x=1686410845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZwryojbiiF9EvUp77SgYE7ffGG2HOXgxsgQSk0SW90=;
        b=XK8dfVDhUlD9RY5tIA5pURuiFv0LK0d/fEHTNDlORCZ3wJNn8katgQwGUbN9OG3zsa
         4AneP7QJfPKD97VihJ1s010ULU11wzJ9t3Q9nV0Cq6rIrtmMp3euuGqzNVEYdMYI2xYR
         svwCI+JUp5n7EdS/utV5KL29taeW9gN0WcfHOjKVAUr1h0+2OTEyrUsQQVu1jMUfrF/M
         zNa7bxzir+x581m6XbrcVWIJedGMUdw+UL7VequbRtMpAfmnJD8rU96JjlvUtsupTs71
         oA8SqmJEsK6WzMhxHjg7UMAFs1/mZzIYrQ8LO3AyuQQxhw/Fie4Z7QV43sBSC9Lbe2x/
         /L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683818845; x=1686410845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZwryojbiiF9EvUp77SgYE7ffGG2HOXgxsgQSk0SW90=;
        b=bEcz87j5O+rx2UyfB4J1fXUhnLiveA/P1l4OkkqImWgZQ71O3Atj/XisRS2qVD+gEY
         uhi5y9Tth19FEFQ6SxNr1Tw7zx5PwDOKL2CsfDKg/uYhMuIxqn4fPwTK6ZpaCqQePTc/
         36IbIN++GNmbwmv6NsG2fwWJqrF2kq4cD/4vICoVE/k9i+3zYZlwFl3rHYxveYlS2PXy
         3W+F29q5nPKBg8TwfDuOlWG52dxFU4jiI9RUV2EdDF6PyoN0o3R8dOVlqqfS2M71/gFm
         OH4Ba8EPs2pj6Y1FNxQ08Hx+Tf5f4LDLMz3b0dY0fNB996HzOW9230NHnDhtXdjIGpLV
         XiNA==
X-Gm-Message-State: AC+VfDwNKTkNZCQQoEVhfIASFWIB8/ZUZD2GbNZvbKkk226DueCUAcWy
        IPbjKM4b/OdvgPyXem4NDe8Q2NalD/Lqr9aCMwInZw==
X-Google-Smtp-Source: ACHHUZ6S0b7lDho6w2zD7BoNTHa989m/4tZ6Vf7LXlYaNaMEH99xHjgRjwBKMYW1er0VEh19YV+pCd4yp4igyw0ZPYY=
X-Received: by 2002:a05:622a:111:b0:3f3:a373:c9d5 with SMTP id
 u17-20020a05622a011100b003f3a373c9d5mr367906qtw.13.1683818844527; Thu, 11 May
 2023 08:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-5-mshavit@google.com>
 <ZFwLph9WXByeHxAW@nvidia.com>
In-Reply-To: <ZFwLph9WXByeHxAW@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 11 May 2023 23:26:48 +0800
Message-ID: <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

> You should be getting rid of mm->pasid in this series as well.
>
> When each domain keeps track of what STE/CD entries that point to it then
> *ALL* invalidation should iterate over the list of pointing entires
> and generate the correct invalidation for that pointer.
>

Completely agree. The arm_smmu_atc_inv_domain_ssid function introduced
by this patch is a stopgap to decompose this patch from the SVA
refactor that's required to stop using ssid in these calls.
I also agree that such a refactoring probably belongs in the same
patch series. @Jean-Philippe Brucker and others: is there any way I
can about testing or at least exercising the SVA flow without physical
hardware that supports SVA?
