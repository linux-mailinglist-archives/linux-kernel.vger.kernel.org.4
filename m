Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87105E6B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiIVTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIVTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:05:14 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CE2B636;
        Thu, 22 Sep 2022 12:05:14 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id mi14so7426930qvb.12;
        Thu, 22 Sep 2022 12:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ahbFpac96DIxJDNsT74ohI/EcNOmPFJD8vZZOD/pVR0=;
        b=MWRru5VHDy3uZXKNvdviT4Ai/1xgYm+PHxeqxh3+vG8QkDO7BpQiZncO42EPKTgfdn
         A12ylGyuTlPLqhe5lTwjvc/zf8y4upE/kJKVeqdwd0G1dYJcEwlQ63jBdUjxQRPyzJtr
         Yfk4vw4UIiQvNolIKE7vJzwc1LMWC3CXYd2VI4acWdnYWJkCpibZgOZrYppts8tiU6pe
         hRi8MrL54Ll4DUgagw790bXwV32x49BviLsyJIyYJyh915IP/HgJGpBk3N69UaKXdUKA
         CVcm0qfUH0BLqpbK1gt3TmdVzeVsEiqIVFoPU7ktBhTTCCzWoUvx5hexLw73LmSc2xrx
         24ag==
X-Gm-Message-State: ACrzQf34BI8F9qoppmLsl1G69Vj0SncCSlny7RrWT8Hzm9+xHNCHqMN9
        wSdp4iyPaOjOxAZa8tvyGNNoT9kVIbVcB3qppO0=
X-Google-Smtp-Source: AMsMyM47/YRA5/bDBgDm9lD9SchalpTWOGgGcjGDjsK5X4lbbyLnDpSg3SUimsOQSuyA770Jfdr/QRkM6mDxaM1Pkys=
X-Received: by 2002:a05:6214:1cc9:b0:496:aa2c:c927 with SMTP id
 g9-20020a0562141cc900b00496aa2cc927mr3867063qvd.15.1663873513249; Thu, 22 Sep
 2022 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220909153320.501347-1-rafaelmendsr@gmail.com> <20220912082017.iuo35tyzwvq3dqfn@bogus>
In-Reply-To: <20220912082017.iuo35tyzwvq3dqfn@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Sep 2022 21:05:02 +0200
Message-ID: <CAJZ5v0i=q2v3W5COBHQ8nhwFEkJ0CE107YMXF-kPWtHuV5yYLQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PCC: Release resources on address space setup
 failure path
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:20 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Sep 09, 2022 at 12:33:19PM -0300, Rafael Mendonca wrote:
> > The allocated memory for the pcc_data struct doesn't get freed under an
> > error path in pcc_mbox_request_channel() or acpi_os_ioremap(). Also, the
> > PCC mailbox channel doesn't get freed under an error path in
> > acpi_os_ioremap().
> >
>
> Thanks!
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>

Applied as 6.1 material, thanks!
