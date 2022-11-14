Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2D628996
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiKNTnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiKNTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CEA1A38B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668454941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=etTcQk1F266hdIupm5+ic9SPXuOnJ0Fp357DOYO5OPY=;
        b=ATY8Yn66yw1B+AFrgJyq+7dDsaCvV9vxIrw3tT2Jk3klzGZTkBCOsHNdkb9gkPgYscURqN
        elP1hE0ZolBMBrqC6VDF9zeGkN0F67J71ujOUcYAQEtaY9SwsxITRNNWXDH7LHNL6a/xOm
        C76RT2/vQUEyUZbDhK5b6v39Ety3X8c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-MVotDzCjOgOmDJkFtHX12Q-1; Mon, 14 Nov 2022 14:42:20 -0500
X-MC-Unique: MVotDzCjOgOmDJkFtHX12Q-1
Received: by mail-il1-f199.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so9902772ila.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etTcQk1F266hdIupm5+ic9SPXuOnJ0Fp357DOYO5OPY=;
        b=WJSs0XG8ia7o+XOY89PlNiZo3/CqTzoLLRnq2N2w/Q6ATT3HiR7rwCImoWt0CQlKNr
         QqhADIMr8sQWxMjm7NGYOHR1AV10gkXhTOf59AijfUuePW/xf3lTuHMFlmtwm5/p7T29
         2wPgghsyXOq/uEdyQZlD7gyj1weIxdDVBStGI2bu8VlCKB4lOSToAeFqi1WiUR2wOS0f
         34OwJfyL3wpbHEZjAcT7m2vtlCBSXvhsVeRo+JSYpVzdHbGhz7TTkl+XmduiwAkNwDaE
         6YZeNxfsX5kpWkFakVJNIyfMkEAm9kouWAheNorNUnsUUpbE11tflVu7G81+I93nthPN
         mTCQ==
X-Gm-Message-State: ANoB5pn51Ao1GVQvIYQVSjt0RbpwmFF6FaMHZRQ8ZKK9Np9dxbvtu711
        ihZqH/qAePVwDqzPLEuo2rfBUqz+HSQfsNZpVKVbL9Vk62ls2y3CvIcTqIImRaIImh9q4saDALG
        cUMIun2jfZeYzaNzMqijGqp3W
X-Received: by 2002:a05:6638:4194:b0:376:21c3:23fe with SMTP id az20-20020a056638419400b0037621c323femr16256jab.192.1668454939199;
        Mon, 14 Nov 2022 11:42:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6aSXy25nWpUG2W6rJAgx5bO97582f6XlysUPpT15W+rIiYbkl3WMAJZr6Sm9NDiyVebzOgTQ==
X-Received: by 2002:a05:6638:4194:b0:376:21c3:23fe with SMTP id az20-20020a056638419400b0037621c323femr16249jab.192.1668454938983;
        Mon, 14 Nov 2022 11:42:18 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a59-20020a029441000000b003712c881d67sm3868751jai.164.2022.11.14.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:42:18 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:42:17 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>, ajderossi@gmail.com
Subject: [GIT PULL] VFIO fixes for v6.1-rc6
Message-ID: <20221114124217.784a2d3f.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.1-rc6

for you to fetch changes up to e806e223621e4f5105170df69d7311dc3fb4bbb4:

  vfio/pci: Check the device set open count on reset (2022-11-10 12:03:36 -0700)

----------------------------------------------------------------
VFIO fixes for v6.1-rc6

 - Fixes for potential container registration leak for drivers not
   implementing a close callback, duplicate container de-registrations,
   and a regression in support for bus reset on last device close from
   a device set. (Anthony DeRossi)

----------------------------------------------------------------
Anthony DeRossi (3):
      vfio: Fix container device registration life cycle
      vfio: Export the device set open count
      vfio/pci: Check the device set open count on reset

 drivers/vfio/pci/vfio_pci_core.c | 10 +++++-----
 drivers/vfio/vfio_main.c         | 26 +++++++++++++++++++++-----
 include/linux/vfio.h             |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)

