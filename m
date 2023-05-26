Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E49712E15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEZUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14FF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685132331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K+NKhhSWMXaeALHcoBFkaKbpOK9/rzoJSpWkQXlKvtE=;
        b=HyJfwSzWHnpul2hGYKn+cyV+x/P+5i0bpsrNdF3onQgzvwlhR9sXK/rYHzpHnz/4Zk5KAs
        rxfIjZC+COdhA7VdPspTdiMW/QtK89DW8Ca5+1BYgjdz3HTt1Ao2KO4dVQHDycf0bdi1Aq
        i/42habuYgRUiKvaQBWN7mUFIy9+IQQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-Qg-0G8r-PNWU6K1idrFprw-1; Fri, 26 May 2023 16:18:49 -0400
X-MC-Unique: Qg-0G8r-PNWU6K1idrFprw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-774efe8c0cfso85229739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685132328; x=1687724328;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+NKhhSWMXaeALHcoBFkaKbpOK9/rzoJSpWkQXlKvtE=;
        b=Apx35yMizIF283vruQgHlQTjaU7v+smUOQ6ZMUY6jlQKWkMn6Zbh04G4vgDKBY8X/i
         TKqu4sUp9xrMox5DoC7pxNutaaQuJxJJ42kppxbwsmUV7wl8AzkQVCV1BKhen6rmgKB+
         Ldmq9ovXiPCWycLGAitT3zKHv+dgaAjjaAJ/Z1wwT+DNmKyUU2bE+xTSMhn4wXB0bb79
         it/cX2BiJEm4hWTbrSv6HIPD4p/UeI1nwWPQNNV/7eHaAgtnttRmO9KyH5tofYdgUqFW
         Fj/wkUALaFXTJnSxuQ9p/2qGiSN43O4pcZpEZEHEnm3UDfnOo4d9R65CgJzuYaxg+WP4
         SvIg==
X-Gm-Message-State: AC+VfDz6XWO1iJAmBYf5rzAKNewifJd1mv2JCm/LHu9RaQa71H49+cTF
        BUCkt9r9dohmurptwspsKrMZsH/E+TBC+ZDDwV3XSuWHRLA5xc3Yw/Q+HG0os5T2w5W81TUElv3
        Cft6sSPWMISWNQmOUEylGgIEjWAYNnN8F
X-Received: by 2002:a5e:8b4c:0:b0:76c:56fb:3c59 with SMTP id z12-20020a5e8b4c000000b0076c56fb3c59mr1794585iom.10.1685132328492;
        Fri, 26 May 2023 13:18:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NbeEx+NfDc/UMOu7Pl0K4c7vVOWs5JK9Whd5LODCKEHzWv2DLGvvkKN15/6kMTMira7yHMg==
X-Received: by 2002:a5e:8b4c:0:b0:76c:56fb:3c59 with SMTP id z12-20020a5e8b4c000000b0076c56fb3c59mr1794570iom.10.1685132328108;
        Fri, 26 May 2023 13:18:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s16-20020a02b150000000b0040da7ae3ef9sm1340021jah.100.2023.05.26.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:18:47 -0700 (PDT)
Date:   Fri, 26 May 2023 14:18:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fix for v6.4-rc4
Message-ID: <20230526141846.6f549439.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.4-rc4

for you to fetch changes up to 4752354af71043e6fd72ef5490ed6da39e6cab4a:

  vfio/type1: check pfn valid before converting to struct page (2023-05-23 14:16:29 -0600)

----------------------------------------------------------------
VFIO fix for v6.4-rc4

 - Test for and return error for invalid pfns through the pin pages
   interface. (Yan Zhao)

----------------------------------------------------------------
Yan Zhao (1):
      vfio/type1: check pfn valid before converting to struct page

 drivers/vfio/vfio_iommu_type1.c | 5 +++++
 1 file changed, 5 insertions(+)

