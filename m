Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0B5F47D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJDQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:42:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7A5F7ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:42:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 64so10915694iov.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=0i98s1EMzTMBPsiKMIhUHBahDQAZLN3S8+2vEgOt2oE=;
        b=a0qj2Q463SqfIC+Ubs74QDDq2ZbB3HQaPsO5gIq2lbw4HV6gCGWroyQhl7cM7Tqooh
         H98g3g64Nfc9IQAZtf2zBjeUdCOuP/SpwLtixbH3S/VH0FC/8mjLvorGNNyf2jh9P5Yk
         JRQldBkXqa59oDXlPSNgoqeh7L4/hdTjAMLxHa2e2I30mKGVONGQ01QrulJk/VT57NoH
         EdhNSo2Dn68qLIyMXCEU91fmpweAbwHlyIyz6e7wHehVSmTE8B6U/WupgN+wsN7nwYGO
         SyqXSEK4WsM7eX0Tx7AAFa/Xr2R2cMvgD9kdU6k9cUXyr+Cnu4lIBdtdUNlbUomZNDSE
         GlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0i98s1EMzTMBPsiKMIhUHBahDQAZLN3S8+2vEgOt2oE=;
        b=FtmAj43TlulZyl2BMUC0g2D3aBhk+h3hbK3jJYUEV0veuAl81UUSMxhXwglYZuJ+tY
         Qj/1pVi/gVBbbQrYIDlwKJk8BTk3nzsfL4o+C7QkCHnNhrDaeYNxb8u6vh8AtlieJtDO
         NT4eZU1iRH1tOwP3X2AWwj5LMfohKQ709eMY8NJSYviS/GknKiEe4dwh0TEs6amRr6wZ
         zC0ezRFop4UB5tU+aqFpvUib02QkHHIO+pA9YFV+VazAU19pGQzru/iNOwnb8JDNmoN8
         lfxAtFPXom3koH0+7h87+xGTWcQToQxHiVQE4PAarx1f6FlyoCuI82kFGF2iCoQ7lJmp
         oLSQ==
X-Gm-Message-State: ACrzQf3GzoxTqAE9j7cUtlB/Fp5JP9OXwrrxISv8m2ynH2zzFlpyCViE
        PxbrzdSm8P8UG5Sd3VrcDRsytMwQDQLxhw==
X-Google-Smtp-Source: AMsMyM62ZvTH0hn0AHpbQRffdx3Xg4I5EYsBhw3h7vAhYluNamICqCTzx6u/YvAUQwS2jPE/qZmsLQ==
X-Received: by 2002:a05:6638:3390:b0:35a:a74e:44e3 with SMTP id h16-20020a056638339000b0035aa74e44e3mr13205908jav.77.1664901721530;
        Tue, 04 Oct 2022 09:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b003633ef39bd3sm1638823jai.92.2022.10.04.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:42:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     linux-block@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220926220134.2633692-1-khazhy@google.com>
References: <20220926220134.2633692-1-khazhy@google.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
Message-Id: <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
Date:   Tue, 04 Oct 2022 10:42:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 15:01:34 -0700, Khazhismel Kumykov wrote:
> Setting IO scheduler at device init time in kernel is useful, and moving
> this option into kernel config makes it possible to build different
> kernels with different default schedulers from the same tree.
> 
> Order deadline->none->rest to retain current behavior of using "none" by
> default if mq-deadline is not enabled.
> 
> [...]

Applied, thanks!

[1/1] block: allow specifying default iosched in config
      commit: ad9d3da2d07e0b2966e3ced843a0e2229410e26a

Best regards,
-- 
Jens Axboe


