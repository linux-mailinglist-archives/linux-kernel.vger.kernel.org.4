Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B5722D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjFERWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjFERWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:22:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5C106
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:22:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39c40b94fedso29661b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685985725; x=1688577725;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XZ3PYFTW8wBOrcxa44gmTJZRL7p9p613s1N10mZMVY=;
        b=ycFVn/L/naAjRsAnEqR9ysNncUv/HbQfjetBqXx4erHA+VIlFcLYsCCYZpKwYV2LfY
         KG9fKbgqWBtjwwWULsEPR4hELvi+OZ1caxlR7XcilK6EroWpiY6H/p7eKLSZ+XxaHD3z
         Np995JYCblZZVyD3K7OFjrqfChq6ClFMXNni2e95MICclPFh9tYtD96AnJBnDqL0e5h3
         gNQx/XCZtwcC6ZUYiuGd7rF+gU4oSsIdadeHa4vlVuCgI+cVs0ugq+AgzEMh9VhTYA88
         lKTzoHiM5hZHwFCpR2aBwpBWlk5yBK2tuS/6r6Rh0flFXVi7X0z9nkLjh+5izffZ0SFk
         gqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985725; x=1688577725;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XZ3PYFTW8wBOrcxa44gmTJZRL7p9p613s1N10mZMVY=;
        b=gESMy2t7GGRPIPRqdO9JvRZlueFbZaOy8BZSeHpTOxsUFfkVfTjaTyo9a1c88FHgyM
         suQks9VqbeKKZcPPDWIzRwN2AsToLPtsxd35qr5vs5zelqSWBzs13lRxmd7FdfdPBZsp
         IPj/qzbc36nCb3QWyxS8s5hDmJvsT76vCNv20BNXKjfsIpbLEbNBcuD5/Mcfliz3sfqO
         BdZxfYLz2Gx41XtK4w5AZnntAbtockQIYeGg+KTpRAeVCiP0RS0Mo1CWZTYY6khFUTi4
         cKdUUQOIklBeiWW9DcA1peu89TGzZU4gk9KsK+WhhqU8oKmEkgsw3Ai/E7jGBvXVK/fu
         NXaQ==
X-Gm-Message-State: AC+VfDwE/7du6PqQSbdOiF/KTVS0EK8C1bsnx6eZvPmPVvkHB3Anehd4
        LwOb4ZfF9ZhvATXj8NtRLbx8Kg==
X-Google-Smtp-Source: ACHHUZ55ijmtRxUtr2PJeE7u8S0QvWcKyGSmOe2wfBtgxRK6mvg8iopMfucIMuRB5AN9ZmOkwUXzHA==
X-Received: by 2002:a05:6358:c401:b0:127:6a3c:2280 with SMTP id ff1-20020a056358c40100b001276a3c2280mr4551121rwb.2.1685985724648;
        Mon, 05 Jun 2023 10:22:04 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:c01c:32f0:eff8:7692:bf8a:abc6])
        by smtp.gmail.com with ESMTPSA id cl9-20020a17090af68900b0025643e5da99sm7993666pjb.37.2023.06.05.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:22:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20230531125535.676098-2-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
 <20230531125535.676098-2-hch@lst.de>
Subject: Re: [PATCH 01/24] driver core: return bool from driver_probe_done
Message-Id: <168598572280.2504.3952473013804137907.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 11:22:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 May 2023 14:55:12 +0200, Christoph Hellwig wrote:
> bool is the most sensible return value for a yes/no return.  Also
> add __init as this funtion is only called from the early boot code.
> 
> 

Applied, thanks!

[01/24] driver core: return bool from driver_probe_done
        commit: aa5f6ed8c21ec1aa5fd688118d8d5cd87c5ffc1d
[02/24] PM: hibernate: factor out a helper to find the resume device
        commit: 02b42d58f3898134b900ff3030561099e38adb32
[03/24] PM: hibernate: remove the global snapshot_test variable
        commit: d6545e687271ab27472eebff770f2de6a5f1a464
[04/24] PM: hibernate: move finding the resume device out of software_resume
        commit: cc89c63e2fe37d476357c82390dfb12edcd41cdd
[05/24] init: remove pointless Root_* values
        commit: f5524c3fadba35c075a5131bad74e3041507a694
[06/24] init: rename mount_block_root to mount_root_generic
        commit: e3102722ffe77094ba9e7e46380792b3dd8a7abd
[07/24] init: refactor mount_root
        commit: a6a41d39c2d91ff2543d31b6cc6070f3957e3aea
[08/24] init: pass root_device_name explicitly
        commit: c8643c72bc42781fc169c6498a3902bec447099e
[09/24] init: don't remove the /dev/ prefix from error messages
        commit: 73231b58b1b496d631fa0ecf9fa7f64f5a07c6e3
[10/24] init: handle ubi/mtd root mounting like all other root types
        commit: 07d63cbb67cdb5e2a7720fdd8579b3be979c2d66
[11/24] init: factor the root_wait logic in prepare_namespace into a helper
        commit: 3701c600a3e735b9fbac6f7a73e4c086090c97ca
[12/24] init: move the nfs/cifs/ram special cases out of name_to_dev_t
        commit: c0c1a7dcb6f5db4500e6574294674213bc24940c
[13/24] init: improve the name_to_dev_t interface
        commit: cf056a43121559d3642419917d405c3237ded90a
[14/24] init: clear root_wait on all invalid root= strings
        commit: 079caa35f7863cd9958b4555ae873ea4d352a502
[15/24] block: move the code to do early boot lookup of block devices to block/
        commit: 702f3189e454b3c3c2f3c99dbf30acf41aab707c
[16/24] block: move more code to early-lookup.c
        commit: 7cadcaf1d82618852745e7206fffa2c72c17ce4b
[17/24] dm-snap: simplify the origin_dev == cow_dev check in snapshot_ctr
        commit: 26110d5afe8117d1b505fe735ac709bdf063f4da
[18/24] dm: open code dm_get_dev_t in dm_init_init
        commit: 49177377e910a8fd5cd1388c966d8fbb51075c3c
[19/24] dm: remove dm_get_dev_t
        commit: d4a28d7defe79006e59293a4b43d518ba8483fb0
[20/24] dm: only call early_lookup_bdev from early boot context
        commit: 7a126d5bf975f082281fb9b45d110cd49b7c3ee4
[21/24] PM: hibernate: don't use early_lookup_bdev in resume_store
        commit: 1e8c813b083c4122dfeaa5c3b11028331026e85d
[22/24] mtd: block2mtd: factor the early block device open logic into a helper
        commit: b2baa57475e3a24bb9ad27bb9047ea3be94627f5
[23/24] mtd: block2mtd: don't call early_lookup_bdev after the system is running
        commit: 8d03187ee7328af8e18ef1782289e0b034e75485
[24/24] block: mark early_lookup_bdev as __init
        commit: 2577f53f42947d8ca01666e3444bb7307319ea38

Best regards,
-- 
Jens Axboe



