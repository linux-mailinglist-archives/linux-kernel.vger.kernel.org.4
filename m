Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3245B35B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIIKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIIKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91EF1F01
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662720750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bBeJNEcuYYhVR/b07R8rp8a2HzeiOk4AQkZ+y0hkJsU=;
        b=MIev8BuIxwBhMeoedplL8iM2tPqr/X3HCl1XtR8l2wMWtg/ZxosJTFdhlC9oBnLDRuANEu
        +BX54pn8GzgFr/tqBmPBCmIGwnwf284+DUlIhJsGf0HiyJLqgE7OBBtTRIs12xbajFowcJ
        R9YVjaITEsM+AwhKg3l+PcWA7pNmKIw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-Y1dqs9-GPsOttiYHj-oDcw-1; Fri, 09 Sep 2022 06:52:29 -0400
X-MC-Unique: Y1dqs9-GPsOttiYHj-oDcw-1
Received: by mail-il1-f197.google.com with SMTP id b9-20020a92c569000000b002eb7fbf5ca1so934075ilj.20
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bBeJNEcuYYhVR/b07R8rp8a2HzeiOk4AQkZ+y0hkJsU=;
        b=swXl7vPmCwDG131gpMjZjamYWUM+QVAmvAJ45AafL8lPynJmOAUQ1oxgp2tMXkiers
         +tw+xUfK/MAgRx2uFvng5ADLJpj5RmYq+YcqpABdmZh2SYr6RoOdMTTQbtytGN1pGskW
         +CYzJrUM7fS/wE2PwHbKcjoxG8Vam0qB3ozNgLFUkazZXl3XuxI9AAFNT1psRzzwGRZN
         BF8C5lHlFADVF/ZncoF441XAWuXf7F2AVOnvH8ykMofHeBfXIYiUm3kflokWTeplBSXL
         HFq7Wr3Eax2ZrQzKnFV7xcPxid/gVmYlGwaqVmb2DO35RB7zF1SB80t38/Dj0ZNU8sCe
         t6AA==
X-Gm-Message-State: ACgBeo1ogDoZDh3jqEvV9wEpL5k9BazipmAqf9XcUE882enLOcjKIKUV
        AQ52xuk0SK3hNAuX0xwM+9bjorkdSaqISOVksWE/tGX6kJQ9UP4vaT95k4xG99HExcvxv3yrmp9
        /WvY/OvQmx7HkilU1j4bW67qv
X-Received: by 2002:a02:cccd:0:b0:346:e38b:1c5e with SMTP id k13-20020a02cccd000000b00346e38b1c5emr6868279jaq.47.1662720748418;
        Fri, 09 Sep 2022 03:52:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Lg7DnuAhs7L17ED1EB+S3tJ6SrMy4bUyNEMRtD8p5j3U6L7hn9ScEGS8pxZqNLkDcEF7aKw==
X-Received: by 2002:a02:cccd:0:b0:346:e38b:1c5e with SMTP id k13-20020a02cccd000000b00346e38b1c5emr6868266jaq.47.1662720748090;
        Fri, 09 Sep 2022 03:52:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id ay27-20020a056638411b00b00356636349c5sm66176jab.157.2022.09.09.03.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:52:27 -0700 (PDT)
Date:   Fri, 9 Sep 2022 04:52:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fix for v6.0-rc5
Message-ID: <20220909045225.3a572a57.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.0-rc5

for you to fetch changes up to 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4:

  vfio/type1: Unpin zero pages (2022-08-31 08:57:30 -0600)

----------------------------------------------------------------
VFIO fix for v6.0-rc5

 - Fix zero page refcount leak (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/type1: Unpin zero pages

 drivers/vfio/vfio_iommu_type1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

