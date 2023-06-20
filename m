Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF84737490
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFTSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjFTSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:51:07 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0CDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:51:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77e01b90542so54823039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687287066; x=1689879066;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyqVGNKadG/R7AVs5M6Apzil9bNyNNjSghUhi9cT+1Y=;
        b=5pfP/bkC5TqAaYcYBrl2RHZm5ueGoqH8Xgc6Ty+6+oTf2S3ZVTJPCAlKVsgCY7hkAf
         OUBd9bXSETljqNkTHPmq5oTddl8v331gJZ3x6SMpZzUJ0ghH/dkPHqd+UlpIhXziy1Yn
         qEoOg09jOauRPy6Tso/PZCK9wjUwXBrnqbIPTZtrew24b+mPlZ24i+LYhQdxVMguZ6q3
         d+5zgaOUrWsWFBcQ1PgAMusC1E0QYkJUiHa1/0HAzgw351sHurbAWIEOOIlEly3AUqUb
         bDlzxUNdGh2uztR6rZJeECi+IeaqrZeGSIeiN1HC4ENYkVZxud4FTIDginDHF9zvehIy
         4rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287066; x=1689879066;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyqVGNKadG/R7AVs5M6Apzil9bNyNNjSghUhi9cT+1Y=;
        b=ChfO08eVOfZ+4Nn/5Fz1IL9W/NEYYMaIf5BQw9nUzoGGIdMZeCY3JSZ+XbWGxFNnEO
         GuYCidU21Uky6vHX0Pe9wJ6IUDoXcHEZHam0k2nl9wkVs6oaE9SK+TQG3zWcfkl1O/ma
         P3yiiqdBZrwYLxEMvo5+N6p+56ttUbJ+70KD5ti87vSjXDmZ908/KXfKrGIbCBMu4qun
         Mn1sEEaIahmWPKcxjuROAr92V/o9as5zkf92yszc++wYxgd+DSiLwACBAiEhbrB7JTvq
         GpfFYikuO/7cCHA+5aFgaQ86OLJZ+hcKrTxRFXWARKc0JvindhNzcZkMU0eJDceQHYKk
         Ii3w==
X-Gm-Message-State: AC+VfDyjsEFrsvQEQ6KgoV+LGlpPRt9VPzsyL1HprqzSNRZ9IGZeKJ2I
        LzmHyowOzfrbEPj7t8Btm3L1xQ==
X-Google-Smtp-Source: ACHHUZ6DuQRoEasGGC66ipeAXJColUrW4MQPjW//N2R1HqK3GtZ2Zkueo7vchlMMaDoZDF6iMyXK8A==
X-Received: by 2002:a6b:5804:0:b0:77d:f413:3c95 with SMTP id m4-20020a6b5804000000b0077df4133c95mr10855345iob.0.1687287066563;
        Tue, 20 Jun 2023 11:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b004266ca33533sm781009jaj.108.2023.06.20.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:51:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     willy@infradead.org, hch@lst.de, dlemoal@kernel.org,
        gregkh@linuxfoundation.org, wsa@kernel.org, vkoul@kernel.org,
        Min Li <min15.li@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230619091214.31615-1-min15.li@samsung.com>
References: <CGME20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268@epcas5p3.samsung.com>
 <20230619091214.31615-1-min15.li@samsung.com>
Subject: Re: [PATCH v4] block: add capacity validation in
 bdev_add_partition()
Message-Id: <168728706526.3766608.418595838646923782.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 12:51:05 -0600
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


On Mon, 19 Jun 2023 09:12:14 +0000, Min Li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> 
> [...]

Applied, thanks!

[1/1] block: add capacity validation in bdev_add_partition()
      commit: 6d4e80db4ebe76c4a4b6ffb6547cb168275204ef

Best regards,
-- 
Jens Axboe



