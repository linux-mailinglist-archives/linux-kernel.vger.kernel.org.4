Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8542621ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiKHRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiKHRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:36:00 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC85AE0D3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:35:59 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m15so7837242ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=EWVfAUTumk4AQ08iyW9Q5OaA+9vWPO6YXORW8T5vAzOH6R3K7ePQEkc/AHQzv4NKuL
         axNwPnt9zkKFcnumeuq3Ni1HnW4BX34Gn59FgjBhrGjPTd7VNT02mNylwqxlosNEpljw
         gLj1g5pPGDGSu6B3Cm6i4ai6v4hnqaafLqm+ZgKjB2oZ3rA8N/es+FSCve4w7CPWpPJ/
         hQ4h4K2FlUn0ck3GDKUnxoSEdgFcMavTdrYKR5NbpX6LOqJPIkI1BOtWMGSlsYzuBv7p
         VRAR7d0ny4wxqRYewMATM3IX2ICxnAgla9kFsIz76KsTayT2UWLTnPsofs3xrHEHKeSJ
         BhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=xqkpQj86zBHGGz91oCyPH434dv06pq0Tye9t5DwRuYRm1HfMLnl53vo89gYGlgtvLl
         6JMY7YI2Mpq3OX+lDcOSvNSBwkzDo9WUXoYmJdJtQWjJSHzmZeqEpZ1aLq5ZVK5rsDll
         pfJ0Q2XYLgKH6/JqS+vNRVJWnMnimLGhgCDkkSAYwbmOwCvnZAZTlMA8aLSwSblW495F
         WcgZA8BXl1Iqbpy3lJ2HjUakN7Uk8+Jy1lk2tcliyLO+jYC8Gf3CT2CARDN83M0dAvkE
         4N0zmlVt7Cf/60d2glvNUZBfCav3eeugBIM1aMQ7mofWB3hfKIVUUWky5FP3YHR74c0p
         PlTA==
X-Gm-Message-State: ACrzQf0W1bBbXrZpN1j+3VD0q4HppLHdFv5mNbM8VfIfhMvHjzpqQGXU
        Rbo1+w7dqnTLuKEvBVHIyNEKGvPeviPXaxXZ
X-Google-Smtp-Source: AMsMyM45bvy/64lNW4dHL3SZe0PN0KsWFFiszerLfZ0l1x4JN7xNJQy40y5C6TaqXPGbKUXelxVvNA==
X-Received: by 2002:a05:6e02:be3:b0:300:c33d:4ad7 with SMTP id d3-20020a056e020be300b00300c33d4ad7mr22795761ilu.150.1667928958975;
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v14-20020a056e020f8e00b002fa9a1fc421sm4018267ilo.45.2022.11.08.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Keith Busch <kbusch@kernel.org>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-nvme@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-Id: <166792895795.7601.10122514732945288817.b4-ty@kernel.dk>
Date:   Tue, 08 Nov 2022 10:35:57 -0700
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

On Mon, 7 Nov 2022 23:39:44 +0300, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms [2]. Seeing the
> opal_dev.{cmd,resp} buffers are implicitly used for DMAs in the NVME and
> SCSI/SD drivers in framework of the nvme_sec_submit() and sd_sec_submit()
> methods respectively they must be cacheline-aligned to prevent the denoted
> problem. One of the option to guarantee that is to kmalloc the buffers
> [2]. Let's explicitly allocate them then instead of embedding into the
> opal_dev structure instance.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: kmalloc the cmd/resp buffers
      (no commit info)

Best regards,
-- 
Jens Axboe


