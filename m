Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E5718B87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjEaVCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:02:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192E132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:02:18 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77479a531abso1735339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685566937; x=1688158937;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7ze61W5mDpGIXFew1uV1U9LtQbd68RSAtyboOvbmuQ=;
        b=iRTtzqloS/gnS3kPw16JPgRkCtoop1wn7no76IDFRJbNOOSaiBnCZtZ8jevulOJsWn
         ANQq5Gp1IElGmG5zY8WjcnkGId6NiE8sc1seo8GRQXd8yWddGc0IMDS0oBTKLRpgqD/A
         8JyYkyRhGIL5AQyIiaJmphoejPbvzCTvlidwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685566937; x=1688158937;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7ze61W5mDpGIXFew1uV1U9LtQbd68RSAtyboOvbmuQ=;
        b=CzzQNJuxKeN32gcubVYQggJZbqXBNh0qHD0Y43YCqm6uGHik6Mezz9E0lfQ0d4PA6L
         5vSyD8gixbnDJ1zTM2acMNLmCe+2B90D5bF7XQ7zMMq9B/6WSIdhDPFddSWV2YDyb8AA
         6sAxooD/lTFOYXlTUEE3y8uDc7f0D8WXOzgWRUQKmLPQC9IU8D+uUYhql9MsioCfdgZp
         TSyFZOLkOrwktEY2G50TveUNtaWqyxP9zMcqXh0c59d0VYTRrIAWCnPHalencCawi9Oq
         VO4eCzEOGnILzMDoOP6t4dCMAVY0D8TpwmPh2AGK33mW4f9ZRKXziM+8H2xYCGR3DcMi
         uYyQ==
X-Gm-Message-State: AC+VfDxKg/G4MsgbEAzTqycRmBKfN2tujTHKuQczHwuVLe2XLQhQGhpF
        QpYit7n6fcFqyAnZt4ZZc9hjTw==
X-Google-Smtp-Source: ACHHUZ77QomxYCAi5cPyxHMuVz8JK+42g9/BD2jLICSO9SzgvyhfKgjsmMXuyu95Qjf53d9ryxIsJA==
X-Received: by 2002:a05:6e02:1d8d:b0:338:4b36:5097 with SMTP id h13-20020a056e021d8d00b003384b365097mr2204435ila.1.1685566937370;
        Wed, 31 May 2023 14:02:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t10-20020a92d14a000000b0032f240a0802sm3353407ilg.48.2023.05.31.14.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 14:02:16 -0700 (PDT)
Message-ID: <55e5f74c-6599-e127-cc68-06f1a52711c5@linuxfoundation.org>
Date:   Wed, 31 May 2023 15:02:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 6.4-rc4 - audio doesn't work
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I updated my laptop to Linux 6.4-rc4 and audio stopped working.
I haven't done any debugging yet since this is my primary system.

Here are the audio hardware details:

lspci | grep Audio
05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
05:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
05:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller

I see just the Dummy Output device in sound settings. I will
start poking around later on today.

thanks,
-- Shuah
