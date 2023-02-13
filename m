Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65188694B50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBMPgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:36:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0714238
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:36:52 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h29so3513506ila.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676302611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UyDU4MXdtcc3tPXUF91DR09nLEipLuz0x/ndWCd0Uo=;
        b=4lFt/ogHTlwnZIXVLIkV8bgFRCeSSwEh+zi7NGrdnuHeCeXVVTGgYZGgoSAdf3XAHs
         11zm8Egmm5E7+DrMqBsTQuSEH1FwcHa9aCORPu3ESeFhe3cCt0hkLTGYadH0sjDShRUL
         fb+2ulZofBB0S9oe/QrG2mJLBrCseMGr+4VAQdRtKe49ir7iqhoUk7yU1psH9SGcBcgi
         eYVB82KHYK9yUj674/LV0S3Q2HHTpFBTlDfaovIHz0h9o0IGDV8u6+xaDt3gON9vs/FG
         6kNnhB33/tRWuqxwo68WON2p73xV9wiNdFGyqcmj453MqNIhXxExDGYhOJ/LBrXCIzv9
         i8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676302611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UyDU4MXdtcc3tPXUF91DR09nLEipLuz0x/ndWCd0Uo=;
        b=C5nNdvOazdTPbBHGrsfRS8akbL2gNRYcKmjJ5TtdUqHWr/uXFD+F/nZbYKZ6S5cKRd
         SoMq2e3XfRymOEoq02fLfvqrzZLKdAVLPZETH0SgwPs91/M9zTq8zq4HMAZvcZF3Mgf/
         1dZdnobCtYO8L9R4Uwn4nuUR6oPGxPW9wK3b+2tTF5E29UQc24CWWmJ6NrggoH/l44op
         BsrZWtvKUCJ9xXHA4CZdycnq4Axm5KX/dqjJ8PNfNYvtIho3scCGlCEu5FjBnBMxbw4x
         CAe1KLMTENEqnIIJzavtB574uEGTAh08slHNr8Sc4GbesfbzB5I5RcDKH6jK3untl0+3
         Ir7A==
X-Gm-Message-State: AO0yUKUhw8mNU7y+pi880bVergkYrx4p+zQoMGFUg8dsGxBxebliDDYi
        b++EiNzggQqn2qhIbfmY79pr2g==
X-Google-Smtp-Source: AK7set+BeomEo/V9FsYyesBa0xKvkKn3cC6JBPZ+9tDcK/WyTLrd2sHqTa4xKLWJ8YwZBxtG5ea2/w==
X-Received: by 2002:a05:6e02:1c24:b0:315:39d2:d5e8 with SMTP id m4-20020a056e021c2400b0031539d2d5e8mr4567402ilh.2.1676302611483;
        Mon, 13 Feb 2023 07:36:51 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k18-20020a02c652000000b003a4e6b1e064sm3996935jan.90.2023.02.13.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:36:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>
In-Reply-To: <20230210141356.112321-1-xiaodong.liu@intel.com>
References: <20230210141356.112321-1-xiaodong.liu@intel.com>
Subject: Re: [PATCH] block: ublk: check IO buffer based on flag
 need_get_data
Message-Id: <167630261065.98786.1863973416590406572.b4-ty@kernel.dk>
Date:   Mon, 13 Feb 2023 08:36:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2023 09:13:56 -0500, Liu Xiaodong wrote:
> Currently, uring_cmd with UBLK_IO_FETCH_REQ or
> UBLK_IO_COMMIT_AND_FETCH_REQ is always checked whether
> userspace server has provided IO buffer even flag
> UBLK_F_NEED_GET_DATA is configured.
> 
> This is a excessive check. If UBLK_F_NEED_GET_DATA is
> configured, FETCH_RQ doesn't need to provide IO buffer;
> COMMIT_AND_FETCH_REQ also doesn't need to do that if
> the IO type is not READ.
> 
> [...]

Applied, thanks!

[1/1] block: ublk: check IO buffer based on flag need_get_data
      commit: 2f1e07dda1e1310873647abc40bbc49eaf3b10e3

Best regards,
-- 
Jens Axboe



