Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF350700D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjELRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjELRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:05:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD9173D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:05:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-763970c9a9eso36365739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683911103; x=1686503103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvBoGilOTpF6ZWmHygwFMFfhMS4VComp9Pvn2nhgo/A=;
        b=t8k2tBQxHaqcqoDKAgZ3qVWNba9q8h6GHr+WoKEJrUJVVlGQVZE1F+70BTr63eY2aQ
         YbaK8yf9fzpwFpYwubQ8hlYUje8+7BuxXS+5z6Tpoo10IwEAR0fQRQrp4m022SUdZR/t
         WtXgmBzhy0h+M8cE8a/xubAawUDHqmq7ofisgsgno+zLArSnlQT6tSX6FjhEPZf8H8qh
         4y0abVoE7JQa9Uiula7sTIISL5qE2kVuFFXM3omYkKoweJr/eV6huzlN9m3XRPRVFHb2
         +EI7PxEy8MKmXbi8aYgCkelXPYoigiPEnfirbS5RRbTsiIfNHZGSh6gQeuPwie10YPrF
         2Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911103; x=1686503103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvBoGilOTpF6ZWmHygwFMFfhMS4VComp9Pvn2nhgo/A=;
        b=UsgaOjUPuetGUM6LPllmKLq8PHzoeshydheKTJra9D39awcA26spo2Wl/bLHh6Qi5S
         6I8T9hjlhHZPvzA7ZCpYlapIVzcA2tQYePOSmtsaGwqOexxXdANUhzO9ZEtdh4DznlBD
         aIT8wRgAhNIqnxzET+BBPUblawF9i2zuZz/9Iz+LFpkn25C6mx5rUqph0AhOe+7yP3PC
         1KFyapSy5u2agldJjIzkft5ecdEH6/RBVYPFGlxT1m2YmLuOE1xKUTqWGmL9AycEcjmE
         YV97KuRMis4O+GtUh7/Q8r7cIHK3vk6VyEL+4bE8ag2hX/NQivwOn6XCJnJPXUvRB/9f
         qhKA==
X-Gm-Message-State: AC+VfDyOM6tLbDaRpEDB4X03Y/Wiw7hPPT/fK4KI7139TwmqjDc+E8Pq
        x3SXkj+ip50ZmM1JZ1Pjs5cTOEaHAL195qNgCCs=
X-Google-Smtp-Source: ACHHUZ74AWP+IpPvKJjHKfbLqGTGNjN1C7+KXzIPhU7y7WRtfFbYpH1akHKb8eWJtI5u2lLaYSB4YA==
X-Received: by 2002:a05:6e02:1d05:b0:331:1129:b8a9 with SMTP id i5-20020a056e021d0500b003311129b8a9mr14721699ila.1.1683911103636;
        Fri, 12 May 2023 10:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z2-20020a92cb82000000b0032b3a49d5fdsm5153088ilo.75.2023.05.12.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:05:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
In-Reply-To: <20230507182606.12647-1-rdunlap@infradead.org>
References: <20230507182606.12647-1-rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/block: drop the request.rst file
Message-Id: <168391110278.907660.18376809564035261812.b4-ty@kernel.dk>
Date:   Fri, 12 May 2023 11:05:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 07 May 2023 11:26:06 -0700, Randy Dunlap wrote:
> Documentation/block/request.rst is outdated and should be removed.
> Also delete its entry in the block/index.rst file.
> 
> 

Applied, thanks!

[1/1] Documentation/block: drop the request.rst file
      commit: 56cdea92ed915f8eb37575331fb4a269991e8026

Best regards,
-- 
Jens Axboe



