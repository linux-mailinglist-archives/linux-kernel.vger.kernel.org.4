Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480156CA578
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC0NUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC0NUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC6212F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679923192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fp97bd4egAyMlz94O+W8oRAJLsbe6t9my51Gm91T/aM=;
        b=a6La+48uF1wwhBHmYLfNCk0mzYxOeFLRbpl738We7+ghtDeFwY4/9d0UVQb4pLDyKMxaNK
        8bpMCVmT1CpP3huJtpgGayE+qX1iQsT+CMUK3HU6MIh8KaLzg+ZpXrc3o8xPm+jA3ZM6Uu
        XJSBBxxiGgnBs2Hl/pIABbAmHbWEj6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-zrudTcDHN_2FC-nBTUTtRQ-1; Mon, 27 Mar 2023 09:19:51 -0400
X-MC-Unique: zrudTcDHN_2FC-nBTUTtRQ-1
Received: by mail-wm1-f72.google.com with SMTP id v11-20020a05600c444b00b003ef6803b3cdso2653558wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp97bd4egAyMlz94O+W8oRAJLsbe6t9my51Gm91T/aM=;
        b=tQDHim9QxjCcZNgpt9sbRydivTvdSsVN9pUiX/aBE7UKV3lnsI4bxKTUibY+xu+K8H
         a+K6xFYK/0jTd1xkVn5uKQUCGJ8tScU2n2GrFng57j7prVWJpfmK6I7PRg+949kvbIQf
         Qc8rBGPyVmOorwLEwbz67kxwtUmfU88L5CrypBOfF4UX7lXlpNNZneDFY0QvWZd6o+mt
         bFfecIf/sk41r0hT1SQ8/7L6KEkkwmg2aumeYVysXKgWZjuAl7bNvUp7FfZlPaxmvpwD
         wYp1Q/C900P2zPpR0xju4EaFcIyJ7czRPda0iqBVoLUKMOe/ULmzYXIXvb5Bh+3UzbpD
         c0TQ==
X-Gm-Message-State: AO0yUKVj8r4mX9w9rt7VazCdgiamDKxAHr33WoG3DT0JvvBQ/4V0FI6H
        XoLvGSheaGrTF6Zu6R5M2U90k0ss5J6R4U48byQ+nd6aqxEAYqoHhqqRjj3l8J3aK4YgXHiuOhZ
        W2MissZ2HTpi1bqDQIjBiU8Ot
X-Received: by 2002:a1c:7c1a:0:b0:3ee:6d88:774a with SMTP id x26-20020a1c7c1a000000b003ee6d88774amr8075069wmc.14.1679923190460;
        Mon, 27 Mar 2023 06:19:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set+a3nlhZjRZvrUa3ZYlE0VCFu21NVVFHGZYCsteCubT34r2yrI5XsBkcW+x/td8mODOzUHdhw==
X-Received: by 2002:a1c:7c1a:0:b0:3ee:6d88:774a with SMTP id x26-20020a1c7c1a000000b003ee6d88774amr8075048wmc.14.1679923190202;
        Mon, 27 Mar 2023 06:19:50 -0700 (PDT)
Received: from redhat.com ([2.52.153.142])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ef6f87118dsm2752456wmq.42.2023.03.27.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:19:49 -0700 (PDT)
Date:   Mon, 27 Mar 2023 09:19:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, mst@redhat.com
Subject: [GIT PULL] vdpa: bugfix
Message-ID: <20230327091947-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8fc9ce051f22581f60325fd87a0fd0f37a7b70c3:

  vdpa/mlx5: Remove debugfs file after device unregister (2023-03-21 16:39:02 -0400)

----------------------------------------------------------------
vdpa: bugfix

An error handling fix in mlx5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Remove debugfs file after device unregister

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

