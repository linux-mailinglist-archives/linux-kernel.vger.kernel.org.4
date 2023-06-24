Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B973CCB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 22:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjFXUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFXUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 16:39:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103513E;
        Sat, 24 Jun 2023 13:39:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so23922075e9.2;
        Sat, 24 Jun 2023 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687639172; x=1690231172;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1tQEJ0k7bwPr/I1jZcsjkwi2z2V1iF0ppEDhL3SNuk=;
        b=FdQ/fT0MOVzBPKxjV9625PKp1CoRl3lF62b1U+x+Wa0XAWnb3tilfWr+XLI8BhArMa
         4HqK7dXKt1ancSps79b5kuIx7Pdf8igvYt+bpHG39PFQFfE2BZ81d5RG1BQPgZFufb61
         7UAXf5+3s7oJ9rOvCF+POv4fm7nQaa3sAgM/tcykuAvFBC90f3dTewSLMNuk4+Xt2r6A
         vgb0i07nLc4CGsYx8IIy5mHQ/U6GbuAQDHMtx4dkm6QMqWa7bzm5txhy8tsPP98W4eQ5
         DKDLd80iHVga+z6yv4twlzxdCmwb/y1ZGNfyhOUfRDAhOh/Q3rVUs4YSU4dV+o9vxPx1
         0IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687639172; x=1690231172;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1tQEJ0k7bwPr/I1jZcsjkwi2z2V1iF0ppEDhL3SNuk=;
        b=GZtOoG8MUThBW1yV9Vc6bHS0npsRcRGsNC8baOTy3mA9cOKTT2whCSZU5GQjnAIJln
         F3HKU5NH30rcRdBFJKQhuIQ4gknP4ybybzaUplCO32uyCy1Ps2yVgIWZDxtkjE3dHm6y
         JzP5OsHBp6fJFc5HWNfd+Xh9P1GqZuXW0RIIrgc+Xx0+dFWbFimsHqjOct5BCxUG82R8
         n16eeZa9cQwrT/8icsP4gtGhY4+UCdywpgjcQIzuEFeCYTWo2ChT14wnpy3GlN2dzAz7
         Kzi7lAMfFWnv3QxRfKwqIVVIZqkksrV+Z6AMr18uOSmc0RX7uykKWA8lC57f4y+w7Y+6
         Eggg==
X-Gm-Message-State: AC+VfDwoM1p9s94KXYlX5HxDWI6AQQg8rwj6dNWivcNFwVumJd7VySzL
        r2wJDm92Elb3aS2to2C8UT/Z1RQJkCRUzZOBwaVDHZXSxgoaTQ==
X-Google-Smtp-Source: ACHHUZ5utXC5XVC2n7mtVYnKClEx4riP+lN2BpDmk/NR0y22fQrRzYvsKArktfprRTzo/zDqIdPsHmgSvb46uDrH0mI=
X-Received: by 2002:a7b:c7c9:0:b0:3fa:7d11:ad00 with SMTP id
 z9-20020a7bc7c9000000b003fa7d11ad00mr4023734wmk.25.1687639172242; Sat, 24 Jun
 2023 13:39:32 -0700 (PDT)
MIME-Version: 1.0
From:   Pascal Terjan <pterjan@gmail.com>
Date:   Sat, 24 Jun 2023 21:39:15 +0100
Message-ID: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
Subject: rtsx_usb_sdmmc not detecting card insertion anymore
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an ASUS PN50 machine with a 0bda:0129 card reader. The card is
not seen unless I reload the rtsx_usb_sdmmc module.

I found a Debian bug report for the same regression
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=993068 but nothing
to see there.

Trying to understand things I found
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
which seemed related, so I first tried to revert it and that worked.

Assuming the description is correct and the rtsx USB driver runtime
resumes the rtsx_usb_sdmmc device when it detects that a new card has
been inserted, I assume this means it doesn't detect that a card was
inserted and the problem would be in rtsx_usb rather than
rtsx_usb_sdmmc.

I am not sure how to debug this further, usbmon doesn't see anything
when I insert the card.
