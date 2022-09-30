Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DD5F053E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiI3GrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiI3Gqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:46:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3C12936D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:46:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so2649192wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BVxxhd0P3RO16wUEKaZ1OfbdLJOAUfOB+25uPzyjrzI=;
        b=KPtRqPdU5T/1c0HU/e1m2zYtZ8Qzh3hTb1QitBm1jjoEGxOYxqsM1NymoNb3toxMeT
         kA3ybjD0mFabuvqXYsSpmpkTfeStWmfZGLZAy4H2gsHYOO09/IrYwB5K2i9LyiMc0UJB
         twP+SsyVD/nVmgP/UCq8aUXttSvmFkMEW9SaZVb3Zg14GRad6C2NfNSg3ZxHuH85egM4
         NLS++jXWIO5OCiX811AcQwsx13TEbrUejxPrtyRbrr5V+r/Nr3qzd4cKX3HWGoRf8lM0
         8bRSnIH7W1tsaYxrWfvim5zvOpLUHMVu1/KknpI2r1Bvu+iM47hvPSv3wH3pHbAtW/Q6
         ysuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BVxxhd0P3RO16wUEKaZ1OfbdLJOAUfOB+25uPzyjrzI=;
        b=lX9ye6o68KpadFpJ6oKYsy3B+VPOD0w/zDTubr0DmHHo4iBPSy+bCBw+fMP+V8w3XD
         sEWzyPDNnBHQBnFb88L2uH39yxhM/9bZZdgLScgHLd/cgyDpoIQIIupeJoEJWV1gQOK8
         HuTWJqfJE/K7GRUubf8Y5SsPWCXgXOoQ+MgMQ4wtbNE7gntOEYh0uZsL7LpEgYI6Ox79
         Kax0cGO8ECSosK3HB+sBjd7gX4kjIM8GbksBfMjnkIAelRrLWgHjf0WJdviaXZMAk+4+
         sEdyjxxE/EwPjuQJInM84IMDU5xmo9ZfoIYijasUPYQCdGWowRbi6nkAyCLPgrhNHR8d
         /dBA==
X-Gm-Message-State: ACrzQf2j+C6Gv5XF7d0SSkj0R/m1nftrgLFHxoHKcPXIS6ZGJGBNcvMA
        7aVHZDP+iYAerKOVa1EYooUocw==
X-Google-Smtp-Source: AMsMyM4poS47diqYbEC2wc5A5DvZ59N2ns1+skYy5zmARGz6rFqKcQHJE6j4dnnhnDFMB6Jw2WuvOQ==
X-Received: by 2002:a05:6000:1acf:b0:22b:ed0:71b1 with SMTP id i15-20020a0560001acf00b0022b0ed071b1mr4956672wry.51.1664520393119;
        Thu, 29 Sep 2022 23:46:33 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c05c800b003b332a7b898sm1154818wmd.45.2022.09.29.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 23:46:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        tytso@mit.edu, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 0/1] Expand get_maintainer to be explicit about supporters
Date:   Fri, 30 Sep 2022 07:46:28 +0100
Message-Id: <20220930064629.329514-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3:

- Drops change to get_maintainer.pl - Theodore
- Rewords around `get_maintainer --nogit-fallback` and gives an example

I think the document text now is clearer and should be more helpful to
others in getting their minimum submission list right every time.

V2:

https://lore.kernel.org/lkml/20220928003006.230103-1-bryan.odonoghue@linaro.org/T/#u

- Documentation/process
  Added in text to also make clear subsystem mailing list should be
  included - Krzysztof

- Changed get_maintainer.pl to print maintainer[supporter] or
  maintainer[volunteer] depending on MAINTAINERS file. - Thorsten/Bryan

- Choose supporter and volunteer instead of supported and volunteer
  Supporter and volunteer describe the role of the person whereas supported
  and volunteer would describe an activity and a role which isn't
  consistent. - Thorsten/Bryan

- I didn't change Documentation/process/5.Posting.rst
  This file doesn't mention get_maintainer.pl and I was mostly aiming to
  fixup the process around get_maintainer.pl. - Thorsten

- Myself and Thorsten discussed changing get_maintainer.pl, how it seems
  like a desirable thing to do but also that "it might break scripts for
  people" and it might.

  I don't know if get_maintainer.pl is or should be considered to be a
  stable interface and an explicit software contract but, making it clear a
  supporter is also a maintainer seems like the right thing to do from a
  transmission of information perspective.

  There is still the option of just updating Documentation/process in
  isolation.

V1:
- Sent a standalone change to Documentation/process stating
  get_maintainer.pl email addresses marked "supporter" should be included
  in a patch run.

Bryan O'Donoghue (1):
  Documentation/process: Add text to indicate supporters should be
    mailed

 Documentation/process/submitting-patches.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.37.3

