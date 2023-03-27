Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDA6CA266
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjC0L35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjC0L3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA049DD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679916534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rkuxBgcicCbLlAWCMSm6u84bCBuR5ufAzUhgm80rCGs=;
        b=Iig7wtyw/Ile8X2T2UF1yAHW9kDKk/PQntgZWb50nrxBz1BiN+kfP25gPm5NY33iPTvTWC
        Muz/3euoGR9uIJAPjQ0mCMYixi5oAQOvF0Eei4VwCk1KUr7RxyKDpY/33c3iMQCAGVe6Cs
        KI6KnNnsty6aGDBHIetHE5mkWvygIGI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-AC2qnlcpO2y1GeIxZLYk0A-1; Mon, 27 Mar 2023 07:28:52 -0400
X-MC-Unique: AC2qnlcpO2y1GeIxZLYk0A-1
Received: by mail-ed1-f72.google.com with SMTP id k14-20020a508ace000000b005024a8cef5cso773304edk.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916531;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rkuxBgcicCbLlAWCMSm6u84bCBuR5ufAzUhgm80rCGs=;
        b=GhXaw+ArW0Qd1a+iOwgt0CkDGXeGxXibrrDNqWaVB4l6vLssxXRwAsOUmWkTSh5Gl2
         UY8p55jkz7eUksG8GQdIkIpf/W8d1Qyc5KamwGeBdNuQ2ll4sUSCfnkROFxsx04guBIo
         gFbYOLtdQciinbXEuB6P6el0gs/+g866e6cSK3ykGrtmHfKWVAc2pw74EZR6cyefxCBv
         wgzBdBbYbGQ9H4u3gJYCcFeCR6S0WqaNF7NxooH5xEkLLcY4SeG0wOPsZgsrMBnlF95R
         K+aqjTDiw5qnqpIp/9Lna8CfaNz/q0fGArjuGDHNMEba8DdfBkaWp3BUCSdg//GRV8Ij
         CL3Q==
X-Gm-Message-State: AAQBX9fHzy1DVYxxmuCtyS2cQnK3MZTn3Yn4781XxINi3rRJOSOxLTTt
        ofUTgvz2mQLkQCzpIdI1/ZvxtRTEUTiwqbDqnnvv9Ji/Ez85o3ln8j42Xr2pc/xXW49N0nJXBt2
        fOPc1jfWIEjWVrdJDQP05xZfd
X-Received: by 2002:a17:907:c70c:b0:91e:acf4:b009 with SMTP id ty12-20020a170907c70c00b0091eacf4b009mr12954746ejc.22.1679916531813;
        Mon, 27 Mar 2023 04:28:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCRAcl533WfxbmZNPNJHMPSUJR4lGWp+1hNdlqCIqDzgiSFMXFE9EE7PfxAGnoFuWK0b0u0A==
X-Received: by 2002:a17:907:c70c:b0:91e:acf4:b009 with SMTP id ty12-20020a170907c70c00b0091eacf4b009mr12954735ejc.22.1679916531579;
        Mon, 27 Mar 2023 04:28:51 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q11-20020a1709064c8b00b00932ebffdf4esm12904064eju.214.2023.03.27.04.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 04:28:50 -0700 (PDT)
Message-ID: <faa15528-9143-7f60-f534-c59f2f6c1ebe@redhat.com>
Date:   Mon, 27 Mar 2023 13:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.3-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

Here is the second round of fixes for platform-drivers-x86 for 6.3.

Highlights:
 -  Intel tpmi/vsec fixes
 -  think-lmi fixes
 -  2 other small fixes / hw-id additions

Regards,

Hans


The following changes since commit 1a0009abfa7893b9cfcd3884658af1cbee6b26ce:

  platform: mellanox: mlx-platform: Initialize shift variable to 0 (2023-03-07 12:08:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-3

for you to fetch changes up to acd0acb802b90f88d19ad4337183e44fd0f77c50:

  platform/surface: aggregator: Add missing fwnode_handle_put() (2023-03-22 15:23:03 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.3-3

Highlights:
 -  Intel tpmi/vsec fixes
 -  think-lmi fixes
 -  2 other small fixes / hw-id additions

The following is an automated git shortlog grouped by driver:

platform/surface:
 -  aggregator: Add missing fwnode_handle_put()

platform/x86 (gigabyte-wmi):
 -  Add support for A320M-S2H V2

platform/x86/intel:
 -  tpmi: Revise the comment of intel_vsec_add_aux
 -  tpmi: Fix double free in tpmi_create_device()
 -  vsec: Fix a memory leak in intel_vsec_add_aux

think-lmi:
 -  Add possible_values for ThinkStation
 -  only display possible_values if available
 -  use correct possible_values delimiters
 -  add missing type attribute

----------------------------------------------------------------
Dongliang Mu (3):
      platform/x86/intel: vsec: Fix a memory leak in intel_vsec_add_aux
      platform/x86/intel: tpmi: Fix double free in tpmi_create_device()
      platform/x86/intel: tpmi: Revise the comment of intel_vsec_add_aux

Frank Crawford (1):
      platform/x86 (gigabyte-wmi): Add support for A320M-S2H V2

Liang He (1):
      platform/surface: aggregator: Add missing fwnode_handle_put()

Mark Pearson (4):
      platform/x86: think-lmi: add missing type attribute
      platform/x86: think-lmi: use correct possible_values delimiters
      platform/x86: think-lmi: only display possible_values if available
      platform/x86: think-lmi: Add possible_values for ThinkStation

 drivers/platform/surface/aggregator/bus.c |  4 ++-
 drivers/platform/x86/gigabyte-wmi.c       |  1 +
 drivers/platform/x86/intel/tpmi.c         | 23 ++++--------
 drivers/platform/x86/intel/vsec.c         |  1 +
 drivers/platform/x86/think-lmi.c          | 60 +++++++++++++++++++++++++++++--
 5 files changed, 69 insertions(+), 20 deletions(-)

