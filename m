Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BE6C3DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCUWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUWgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF4D50988
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679438151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7VxWE51mxHaaqCh3Zx+U1kue+ONzb+1Mi/zdWX/rYxs=;
        b=HnWYj88xVS3TxK5QMEHezFDoimEiT/E1XUc33ro46zyq647wpxaD2Qy2FzRPfthua+JgSh
        mrAaLruTEFtflzEp8IoYorOMROcxaTQixjT9upT+rR0DY1F44po5tKZNc+OHr1asFG068j
        HkkkO7eLBHhvoCfKeX4a5EfYB+UdEZg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Qfd-l_fRNMKNSqs6zHSKYg-1; Tue, 21 Mar 2023 18:35:50 -0400
X-MC-Unique: Qfd-l_fRNMKNSqs6zHSKYg-1
Received: by mail-io1-f72.google.com with SMTP id h198-20020a6bb7cf000000b00757eed38c2bso3896589iof.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438150;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VxWE51mxHaaqCh3Zx+U1kue+ONzb+1Mi/zdWX/rYxs=;
        b=ZVaeCNLrSTkIot7qHhNWy7YAfOUmyvVnHktAxVJWXMc0TN8crsYEuqFPyqpTSqB9m7
         nxn95V7bcEDegsMSfHqirQ0mkELTf/ioiTj6rWymt8gPeyNNpkci29bpX+ZNZ6SdoWxO
         qzZbbplWFM3y2aj//unXf6MfWxxPGckZaI0SR77fTenyAxZuZHdq4OVThXkS8VRLQRN8
         nNSUTGSrPRUTJ/TJb4BNG3VkO/D6JHVoAXFb4pht0jxzf05g8unImNkVCQPt+LSZwklW
         VwA9WZNJugTDUuIM4WjhmKC//ye+mswwGbZRBPPMyLLX53jLG2z9XQlnvHxsdzpX25bi
         9PYQ==
X-Gm-Message-State: AO0yUKW60Pt+kOcwnPN/4aBZKQsAlNQCCuDt9DcAhzrXV6mgt2hV8Coj
        biUraSTaVeuHdQLq6g8dfyw/8Y7WnCh6QgXlONIWa2MbyC9T3uH0JN8UGJ6k01ftPf7+F5Km4Vs
        fzN7FU/+PrELouYnLRsIf9iLt
X-Received: by 2002:a05:6e02:f88:b0:324:7374:e8bd with SMTP id v8-20020a056e020f8800b003247374e8bdmr131133ilo.1.1679438149815;
        Tue, 21 Mar 2023 15:35:49 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ZnJcwlc0zrmyiWR4xdjekJR1/dOgb1XN+Yg8VLUq8HIJYcaKSYV61tbamaMt4PAsW4HPaTg==
X-Received: by 2002:a05:6e02:f88:b0:324:7374:e8bd with SMTP id v8-20020a056e020f8800b003247374e8bdmr131131ilo.1.1679438149521;
        Tue, 21 Mar 2023 15:35:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c28-20020a02331c000000b0040071bcb216sm4633121jae.102.2023.03.21.15.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:35:49 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:35:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [GIT PULL] VFIO fixes for v6.3-rc4
Message-ID: <20230321163547.19f15996.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.3-rc4

for you to fetch changes up to 4928f67bc911e46a43004251a4d7eb2259ba6077:

  vfio/mlx5: Fix the report of dirty_bytes upon pre-copy (2023-03-13 12:50:59 -0600)

----------------------------------------------------------------
VFIO fixes for v6.3-rc4

 - Fix dirty size reporting for pre-copy in mlx5 variant driver (Yishai Hadas)

----------------------------------------------------------------
Yishai Hadas (1):
      vfio/mlx5: Fix the report of dirty_bytes upon pre-copy

 drivers/vfio/pci/mlx5/main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

