Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4A7412AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjF1Nhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjF1NhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:37:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25307129
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:36:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401d1d967beso309141cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687959408; x=1690551408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxNDlyNnnUp8RWBC1VLsgA/+iGnbRpi0J2EVSR52FcM=;
        b=rKNzwVZcU3cLIC9qcDCyNFSF0snGD06RpyVH336Lt8XBAWSm/62RDwSb3Kw5Fnq8af
         071saHOZnx4MsQw+nhZktkAxGksWG5tEFAgrlQaguO2mfB7yCCkdwf4+bHYB5Av3mtJp
         dNyp3ifKrheqK5Jta3DbM+H6crd+V1GjtVJNTdSF0UGZrThghXaiDneFBJcACli21VO1
         siAxo8B/Ihtd6WAMJhH5Dnryki6OvLvSb1eZJBXVSyUi4q40y6y+ZKBrmaN6wj9PHI16
         LoUPy1x4a15Fmenlj7Mnjk4paBdrCMOnqZdw0biiIdZEk7EsDKNMzjsSlCIigIzanab4
         mtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959408; x=1690551408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxNDlyNnnUp8RWBC1VLsgA/+iGnbRpi0J2EVSR52FcM=;
        b=VMs21BSDMIaCHfTiO6FgHxwkRxDsDr8B3jzq0y55+ds2n3NflIxu/d5k6mTPeBLXCg
         c0AdO7zoDulTcnbdSslec2WdlSHUVPv/foe2VVDmagm66AKUdx0cW7XBd4jrvPgGxux+
         51a/nwxjM0jGrEVk++ewdds/tb2vCR4hArin/l3f1syqwtCBASVmsc+Vhi0A/tYsOEtd
         tuU6Q7NNBMG3i/CpFJzz+WMsLP3F9QUV7MalScE7XRl5zre7wA8BnH5UBpoAGsMuAKEX
         mCZMdqPhyPd7CA6s9HXcyhXnPGqrTJ5kRkxCHScg+ZsjePd2WPzDZtuiDDD6rMlP+mBc
         ELKw==
X-Gm-Message-State: AC+VfDyJcsp1q5gFyMrq9lNKnfk5+dx1L62mHUX0YK3DDvafSbkJFRlc
        KMGvziNwguei+OPcqRJxw16hTZok1u/k9OZtZFLIPg==
X-Google-Smtp-Source: ACHHUZ60AjWGc2bglbo+JECbZzsVot+WSWR2GQvtPPz3GEc8kwmp8sEBxLjEpUAJNmGk6Clveh555GFZ7J2VnYGoUdE=
X-Received: by 2002:a05:622a:51:b0:3f8:5b2:aef2 with SMTP id
 y17-20020a05622a005100b003f805b2aef2mr224203qtw.26.1687959407890; Wed, 28 Jun
 2023 06:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
 <ZJToAfeKg8FF1sZL@Asurada-Nvidia> <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
 <ZJnVjvh+kdUfeMcP@Asurada-Nvidia>
In-Reply-To: <ZJnVjvh+kdUfeMcP@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 28 Jun 2023 21:36:12 +0800
Message-ID: <CAKHBV25P7d85LgeAQ7VbLyATjFf+AG447pZC7YRAg=5zty1R9A@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 2:14=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> > I've been considering migrating those tests to the smmute driver if
> > that would be valuable.
>
> Is this on Gerrit too?

It's not pretty but I've rewritten the tests into the smmute kernel
driver. Pushed to Gerrit here:
https://linux-review.googlesource.com/id/Ibb33ba6f9c6d069324f21b9ad98e29c94=
e15374a
.
