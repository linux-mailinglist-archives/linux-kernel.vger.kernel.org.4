Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814C739980
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjFVI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjFVI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37B1FE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687422363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S+Ti1dqnxp8NEPmpHi6JTw6FRUjLwFr7pvodcLGKjZo=;
        b=E5ZithucrCKYdMBpbfYGtQZLAkBQdH2C2NKSOjkErZwxs8AtPtSTNQfHqxqZ26aVUd6PuJ
        dMQCuU0+R3lFPMCsdaka6ynKcxKawW6S5zu7r6PGOVwnKOoxeXz+kQQRCt2OGLs2KJxA2f
        H/Q0HEVQujiv/xT1pmwO3s8Rx2jnmf0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-uqA40ZidNdqbJfQ_vRyoyA-1; Thu, 22 Jun 2023 04:26:02 -0400
X-MC-Unique: uqA40ZidNdqbJfQ_vRyoyA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51a5be1c6d6so470795a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422361; x=1690014361;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+Ti1dqnxp8NEPmpHi6JTw6FRUjLwFr7pvodcLGKjZo=;
        b=jhe3SoyeGGSn/2EmNC2AcR84BGjN9YxLVbwLkdEWg4iKtxvEbfUZjZ8u4PiGRgo/vu
         xiJBVYqg43J4DahoF2c5CdBWRF4KPr77ymSjTXiFJlJ7XwNMOr+jMawkrTYgdySSh8GY
         UsKXwhDwMjstYePKLW96nuYz/q9OwsnfpMn1J4Jx6DrxWYIni1GdU6R98Lsnva90Wb67
         rSK+Wo89WXJJnFbSKjDHWT2BzNPP3iCNGuvzof40MAkMDnRzVN4X5TN17uNgFKHYp+Yv
         RaCK/YWb2t3dI7EoMh+9mk5fl1U7auMxWEkFqbQeH3oCtlze7YwgRgdkH1lDcTRVnsev
         nxfw==
X-Gm-Message-State: AC+VfDxL4eNabaCLfSoodsqiG2ciPpwvcL25iXySnKy1C+VAFtdv82fj
        mIGTdxitjTeIz+vo49v10X7uCkLVE8QUmiRhzichw/NZM2XmRYlRK3R8V0KmWEaTzI0t4rCBaRE
        dyTaFxcY0F7kqZnjBnSJXbMfB
X-Received: by 2002:a17:907:d8c:b0:987:3ef4:e6be with SMTP id go12-20020a1709070d8c00b009873ef4e6bemr12995741ejc.12.1687422361096;
        Thu, 22 Jun 2023 01:26:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rCNJx6oxLNWwvzwXRnr5zb55xl350wq0EtNMj7cb0kJcS0UPYSC5XDChWFHVGJmhYUsDb5A==
X-Received: by 2002:a17:907:d8c:b0:987:3ef4:e6be with SMTP id go12-20020a1709070d8c00b009873ef4e6bemr12995730ejc.12.1687422360803;
        Thu, 22 Jun 2023 01:26:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709062c4300b009887bb956e0sm4276940ejh.103.2023.06.22.01.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:26:00 -0700 (PDT)
Message-ID: <075d2f89-aa61-ce14-edb1-f56cfcc90bcf@redhat.com>
Date:   Thu, 22 Jun 2023 10:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.4-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is one last pull-request for 6.4 with a small fix for an AMD PMF driver
issue which is causing issues for users of just released AMD laptop models.

Regards,

Hans


The following changes since commit fb109fba728407fa4a84d659b5cb87cd8399d7b3:

  platform/x86: int3472: Avoid crash in unregistering regulator gpio (2023-05-30 12:10:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-5

for you to fetch changes up to 146b6f6855e7656e8329910606595220c761daac:

  platform/x86/amd/pmf: Register notify handler only if SPS is enabled (2023-06-22 10:20:00 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.4-5

One small fix for an AMD PMF driver issue which is causing issues
for users of just released AMD laptop models.

The following is an automated git shortlog grouped by driver:

platform/x86/amd/pmf:
 -  Register notify handler only if SPS is enabled

----------------------------------------------------------------
Shyam Sundar S K (1):
      platform/x86/amd/pmf: Register notify handler only if SPS is enabled

 drivers/platform/x86/amd/pmf/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

