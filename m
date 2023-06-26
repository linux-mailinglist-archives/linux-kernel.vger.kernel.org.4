Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2048B73D5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFZCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjFZCeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:34:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E7B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:34:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4007b5bafceso286861cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687746874; x=1690338874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVihiOZ7lPOY7hWnryBrA+/oD8EUpfcein9lW0Ydcsk=;
        b=GhmUcgPljQdG2384d7n4zPhgPF1A8jlJj/FoVpS3RNM7mhOMGGIPZxppBsMavyMNWi
         HRqepk1SgLdE5JPLTmheF5+H8SovFdX6IpPjbQEGc6us6sAChK+55yvCG14vmmkXoWPn
         pPJ1ABIlsLv3Zgr8aAnRWCtZs0I2sk+yAKUxvYiy7KQLO5LHexdpm97nHa1jJOoAaVWN
         poZl9GcVW6o6syEFLGKR6Bp+F1q7SV3NZB0xArX1BCRMvm9cwZaV1p25JLZYYUVhriqA
         IPIK0SbR02E0xlDNoPoWCrODaTO8r9CDCxeABmG3/xLp0r174r1lRlqksMwtfsv7gUbB
         ldUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687746874; x=1690338874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVihiOZ7lPOY7hWnryBrA+/oD8EUpfcein9lW0Ydcsk=;
        b=Yei7pGWA9t1S5rT0LTmjSHyd/LLvLKfmWK9CL/K6Px9OqQco9AJfYtGrv09/RRt4Kv
         cHnw8L4zYWkFSiKFK9NKhyCok8E8DP9zALFaqYYR1cQATxdkbPy/pq14YOsjhA6PpCAV
         ZS3Xnqn6bIKI9cx2zjYLn3ZTJmRzE5DSRGvtNiejc2nev9LSSfVK5i+6qXCyftgktQZ3
         +m8V63b08bnxehOgGJkDPcBLR/H9v6Y29zX3cj//q/hl5gRPhLCfmCDRK2rwquNHtUH/
         JpVtPSJkGUbQ6ElKBCXKUknldcElFrJne7MPVWvNpKWo4KjNy+zMQrFQYISetqjs4D75
         zveg==
X-Gm-Message-State: AC+VfDwL1jAK2PEk/3CvBGvJ1YmnIl5Qz5qZS9j+nIm+gKKdnaD7vFWD
        I22b+cH+ykdEn+cmAZKrBlDKphdUBxsVhvvwAZtpUQ==
X-Google-Smtp-Source: ACHHUZ7KqHud5NmiMLt8ROhheSgT/+vI3VHyqtcHQSYmrTg3qxQ9b3kP3R6Lk5LWQ/Dwf1B2MxFkjILp3mELs2c9mGQ=
X-Received: by 2002:a05:622a:8d:b0:3f9:6930:1308 with SMTP id
 o13-20020a05622a008d00b003f969301308mr267696qtw.13.1687746874453; Sun, 25 Jun
 2023 19:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
 <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
In-Reply-To: <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 26 Jun 2023 10:33:58 +0800
Message-ID: <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you please elaborate a bit more for the use case of
allowing that?

In short; to support devices that use SSID to isolate different
(device) contexts. Those contexts (and the memory available to them)
is partially managed by the device's Kernel driver.

> And which test configuration do you cover
using smmute? Would you mind sharing your test commands?

I used the setup suggested by Jean in
https://lore.kernel.org/all/20230511195928.GA288490@myrica/ , with the
following commands:
>>>
# Basic test
./smmute;
./smmute -u mmap;

# Test invalid access to not-mapped address
./smmute -u mmap -f drv;

# Test invalid access after unmap
./smmute -u mmap -f write -d;

# Check smmu_mn released when killed
mount -t tracefs nodev /sys/kernel/tracing;
echo 1 > /sys/kernel/tracing/events/iommu/enable;
echo 1 > /sys/kernel/tracing/events/smmu/enable;
./smmute -u mmap -k bind;
cat /sys/kernel/tracing/trace;
<<<

This only covers existing SVA functionality. To test the functionality
introduced by this patch, I used a device capable of generating DMA
transactions w/ SSID and a test driver with following tests:
1. Successful dma Read/Write to buffer mapped on domain attached with pasid
2. Unsuccessful dma Read/Write to same buffer after domain detached
from pasid, or after buffer unmapped from domain
3. Variations of the above with a domain attached to multiple pasids

I've been considering migrating those tests to the smmute driver if
that would be valuable.



On Fri, Jun 23, 2023 at 8:32=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> Hi Michael,
>
> On Wed, Jun 21, 2023 at 02:37:21PM +0800, Michael Shavit wrote:
> >
> > This change enables the use of the iommu_attach_dev_pasid API for
> > UNMANAGED domains. The primary use-case is to allow in-kernel users of
> > the iommu API to manage domains with PASID. This change also allows for
> > future support of pasid in the DMA api.
>
> Would you please elaborate a bit more for the use case of
> allowing that? And which test configuration do you cover
> using smmute? Would you mind sharing your test commands?
>
> I have run a sanity with this series using an SVA domain
> with a real master. It seems to be fine.
>
> Thanks
> Nicolin
