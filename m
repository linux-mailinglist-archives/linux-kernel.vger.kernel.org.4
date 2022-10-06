Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503225F6857
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiJFNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiJFNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:39:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D8AC3A6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:38:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so4398674pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTCYSZmMysxtSVfEJTY+s0G/UzQUqK+OIX1DRudo8Kg=;
        b=TzWXmCFRuEwSQxIvtrbLg3T/gSXyynJruPXM2VsC2kWTdmxgp2c6gfxpoMvWW3Hghk
         r18GM8xCrKv7P+cPLVf88WS43gkSrm4EvQQeUupsML+Z6vTl6tQfEY3EzjM/V7eL6KAD
         ySdJB2j4CTJAHh3/lCiCWusUXeEvb4PYmS8uBwd5rJOvBkwmxxbT6wFvf0GPhvUuIWLE
         ABDicttkDsY8z2JdCYV2ntUjJm4vRgIIo3vR15PMSmtLqxH0ksziR/0IbTeKoYDO1Rz4
         igkCFxrP29PaR3yEvO09BAcQ7R9FrpqzBWAFAcQZPUBUe8kwpPjNIt8DQ7qKk2m6ghtc
         IR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTCYSZmMysxtSVfEJTY+s0G/UzQUqK+OIX1DRudo8Kg=;
        b=SkHWlXaeagPc8oI2rUEly5EuMEF3623/UtLj5H68oDmfb9YcNpTeM3Pydecj9ZQH9n
         bA0dKko7RQslAph55I5M/HldXMYiDjJkIEaqsiaRPVjnKs+F1zE+adHh7m9PPGyw7Ms8
         6mIDhNBpuCRO2cQo1Etew6podLWOy5LXtwcysCdc24CE6uFHAsqDZMKXIJN91ERcHkBZ
         4yOnMr6tabaGBHfn+tiaGtpIofTH+fYdG87nekXNJcgnzME8fvTfrcOI/hXs1WGQi00o
         2v0eTAy0vVij71Y8j7SKnYp/o5rV/qRgNcxpDq8BtgAbuD/En8EkieaJh0UkOUE3lnED
         d3KA==
X-Gm-Message-State: ACrzQf0CvezNHUf8vxL0/q/R72w+RNq6ni/8u9gY93WJqakN2SKHvzJe
        7iVGvpGrXUxshpwjZJ+FOE5AOfm9UHX4hA==
X-Google-Smtp-Source: AMsMyM6p5emMqF60uEZPjXHkvs1E1VToggNwIb6bqQONyLj6xjXv3FjpqqhDN3PJwImhRiE8UzhFTg==
X-Received: by 2002:a17:902:db12:b0:176:d6a4:53ab with SMTP id m18-20020a170902db1200b00176d6a453abmr5024135plx.113.1665063529879;
        Thu, 06 Oct 2022 06:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w129-20020a623087000000b00541c68a0689sm12890163pfw.7.2022.10.06.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:38:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221006084450.1513-1-wangdeming@inspur.com>
References: <20221006084450.1513-1-wangdeming@inspur.com>
Subject: Re: [PATCH] block: Remove the repeat word 'can'
Message-Id: <166506352904.7298.7396235219714937696.b4-ty@kernel.dk>
Date:   Thu, 06 Oct 2022 07:38:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 04:44:50 -0400, Deming Wang wrote:
> Remove the repeat word 'can' from the comments of bio_kmalloc.
> 
> 

Applied, thanks!

[1/1] block: Remove the repeat word 'can'
      commit: 340e134727c9adaefadc7e79b765c038e18e55c3

Best regards,
-- 
Jens Axboe


