Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C7646013
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14B5B584
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670433833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nMgzAShnLdForNGMjNIaEeNq02GBD9lKBSGwVOBvyx4=;
        b=fMsRd5AtslDEaZv82LY7JZTJ7er2ltYDQ3ppEzplea7c8P55dLzZF/Q/eB1EYA/5acjuYJ
        R6U9EWyKTdbJb2WVFQR4B9yoJPBylDxw4IpZe0/K6He3XixIPzkrbVzgo7EHR5wEGgx/9T
        ZGvQe3PXa2UMvGt7D6ujDrZW0NH1fvo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-cSJzzEF4P4edlLdTdaA4vA-1; Wed, 07 Dec 2022 12:23:52 -0500
X-MC-Unique: cSJzzEF4P4edlLdTdaA4vA-1
Received: by mail-ej1-f70.google.com with SMTP id js17-20020a17090797d100b007c0dd8018b6so3778583ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMgzAShnLdForNGMjNIaEeNq02GBD9lKBSGwVOBvyx4=;
        b=VIO5qTGfnu4iwxR3gm7zNSp1vu3sWBmXf1UVKfWLGbiVS6GNPRqUe9unvIruXEFpuJ
         N8r3sospPDDh9hyQI5y6CK8JIZURn2pJZDFFKZwCTq+XFZkyDEoLHD+t5o1Wh5OdxM2D
         P/EtHYAMEdQ1VLvw4O5DkCCBQcF2H1QxClv1uOKEsvm1pqSQa3c7aBIbM9AIT/DuBgZ2
         tgh4weggJUICxdGip15K6JrOIjf7T1BBGbugZE0ehqGv8qa6eZzBiwOHKwJb8pPkHgtk
         n9swmDkZi8QCe4O74nO+oISoTbTKsu9+eLhdW1eYu/w5Lo/jajQTXFhKww4Zu5VmSUl5
         MtOg==
X-Gm-Message-State: ANoB5pnT0fFmGrnDMCY2BuwzJgYD5kZ7C5zzvDDKxsE4rlW9hBW2EK0V
        wUO+/BkJnzUKPSq8Xtc7LVAt73Oo/45kmaw1ecY6ITnCnPHWXmag63xTa5Kmo7AlZZlMtkL5hnz
        2ALJw5Mh38wm+7RdzL46+piqI
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr68462280ejb.47.1670433831650;
        Wed, 07 Dec 2022 09:23:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6zR2ok+8go9F2u9gfBWO48RBSHJSLFRvL00jiX6h0au8DS60ohMtM45BvjG5DKhbRVp2iz6w==
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr68462273ejb.47.1670433831506;
        Wed, 07 Dec 2022 09:23:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906309800b0078c1e174e11sm8774730ejv.136.2022.12.07.09.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 09:23:50 -0800 (PST)
Message-ID: <de32d340-7723-f980-4519-d8204a14d504@redhat.com>
Date:   Wed, 7 Dec 2022 18:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.1-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is one final platform-drivers-x86 fix for 6.1,
fixing a suspend/resume issue on some AMD laptops.

This fix has actually been in linux-next for 2 weeks already,
at first it seemed that this bug was hard to trigger, so the plan
was to send this with the main pull-req for 6.2.

But it turns out this is easier to trigger then expected.

Regards,

Hans


The following changes since commit b44fd994e45112b58b6c1dec4451d9a925784589:

  platform/x86: ideapad-laptop: Add module parameters to match DMI quirk tables (2022-11-16 08:47:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-5

for you to fetch changes up to e4678483f9bc400642bbc05c6b75a1b44bcb6c25:

  platform/x86/amd: pmc: Add a workaround for an s0i3 issue on Cezanne (2022-12-07 15:27:49 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.1-5

A single fix for 6.12 for suspend/resume issues on some AMD systems.

The following is an automated git shortlog grouped by driver:

platform/x86/amd:
 -  pmc: Add a workaround for an s0i3 issue on Cezanne

----------------------------------------------------------------
Mario Limonciello (1):
      platform/x86/amd: pmc: Add a workaround for an s0i3 issue on Cezanne

 drivers/platform/x86/amd/pmc.c | 6 ++++++
 1 file changed, 6 insertions(+)



