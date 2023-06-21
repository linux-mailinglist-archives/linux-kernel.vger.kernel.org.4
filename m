Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED15738885
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFUPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjFUPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE6558B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687359905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
        b=HeGkDIO1u26bjQ1/pS5A2Op5OI0Zcq0hBCr3dd4EXJPTIe6U07xvC1IOkT0wccA7TrRbUe
        YtjIdNg9NMu4m7RWffi2oxJuuYSzDX/5EIPiGVnFuRaj6+RTORH/59f3DLGw7v7/rs4nvs
        ZQGtIyTYbACQdFVai4Ad/E2lHv9vt+c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-8H8o5csQN7Wr6gOe-FaajA-1; Wed, 21 Jun 2023 11:04:43 -0400
X-MC-Unique: 8H8o5csQN7Wr6gOe-FaajA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b46dc4f6faso33392851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359881; x=1689951881;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
        b=aOTTx1SXcCR58JMWtDglpQqoaLRjLUHvtwH7HytBeDSVwlz9YYIqj90lK9xoDDbNEs
         JidTbJHNlGhu3l+sT6R5rFO7mM6vx65DWhZM9xWn7UhdhexydkkRkFEa599EWGi0oOUt
         7CK0vj2d7gmHMv2rbXoq1gszvO1yN+xPOCdLqHOXZhSdoOIbKG7ThHN6GR5xoGZOBmns
         /ZpNff2DVALpsYGycHu1x7SYJsqs8HPu3yVDKqnX14aWACXWYoyXjGs90r+n5TZaRUwN
         lY4zjjpZyVWN2WCQBfineaxpxJr52xJcMtXNG+/RJ5UvI9//n8MwQQ7Ml/SD4hYoe8Rk
         73eg==
X-Gm-Message-State: AC+VfDxEjI59jr17kYrxLRdwi5YD1PifoQL3K4eOXbP5Aw+xMeEyyakD
        riIBWS6BMDfz2wdq/HpR7dCoA1loWBFH8GgZG+OMCUZTgATvpYVy5DK3wRXJry6kk9+Lmljyg6+
        ocxrKzWdXEXVhF2YsInQrn3HV5OurFflZ
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id 12-20020a05651c008c00b002ad97830bcamr9809838ljq.27.1687359880943;
        Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vuvyyKGk8qVbIbbO2C0uzdA3jUE5LT/K/8MPLqve8CmK2tHPbnZ1hPdf3acB2DVxep5kd3w==
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id 12-20020a05651c008c00b002ad97830bcamr9809823ljq.27.1687359880587;
        Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id e14-20020a50ec8e000000b0051a5c6a50d4sm2743117edr.51.2023.06.21.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:04:39 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:04:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edliaw@google.com, lkp@intel.com, martin.roberts@intel.com,
        mst@redhat.com, suwan.kim027@gmail.com
Subject: [GIT PULL] virtio: last minute revert
Message-ID: <20230621110431-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to afd384f0dbea2229fd11159efb86a5b41051c4a9:

  Revert "virtio-blk: support completion batching for the IRQ path" (2023-06-21 04:14:28 -0400)

----------------------------------------------------------------
virtio: bugfix

A last minute revert to fix a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      Revert "virtio-blk: support completion batching for the IRQ path"

 drivers/block/virtio_blk.c | 82 +++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

