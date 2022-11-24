Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5463781C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiKXLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKXLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:53:57 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA473BB9F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:53:56 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g10so838981qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rryA0sPrDrTCCNWf9O977x3hl7j7UIOszCkFi8a+0vU=;
        b=M1fKV4ZRVo7xIlGVuaF7t2g0y+VoalzFOSoIZzbKppEgf13GYQCKg+becMT7xl2AFD
         pMnOLVnChX4Md0OKrxSVb8q3dkKGQ/YhUX6MKFgE6klyfx7JxE4ovFPXbTrPhs0sA815
         m5q8ajEaI4PxQWmytQLKv0WAXjxZT2bJGekk1PAVKtR1+KpKrihMvlbrlOQkCrbY8zJ5
         SDkGUvhVjbzVxjQukqGG0YJ4Shae7r6cb/8OKziPh4NSlWGO1qGOpyr1KILujCc1RcZS
         JBC2NnziXM/+oaUGNdP5gpbQfUEZkb2u6eS0bgPvLlUnV8pzPuHvZ0xSsPzb/Veyv7XF
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rryA0sPrDrTCCNWf9O977x3hl7j7UIOszCkFi8a+0vU=;
        b=8LnIQ+m2mR07cIsAzYSGIRLuorycRqveOg7F3g/BuM8/TNcLefv1baWtBDpkV2nZe/
         Pw9X+WSiGgnIR0ttYiTNoDjwaOTETVsScTcfoeURew1WC1ZgdNYsyWWrgIIH4vEL8zzT
         7YIHS3bfqu2Dr3ywByaSlnsmc78Wg1oLRVsYKdcNnE79HFvQe82sgPxxAVzGerAgW41W
         txguW58KKNvNNd29w0akvdGajj/1YEylQXRaanj6Pl4jaS7rJwu1gVILp7NqvKHW6B3a
         R/h1On6VO+KysDKbp3bKCmukP+i5Xe4SFLzzaxGyxiv74kclbffPwjl2WBOC/WqjPWj4
         FwHw==
X-Gm-Message-State: ANoB5pkES7xno/a7mE6qyunEq39Jp2VD8VOxQRFBjDuOAFvSSX86F4Tk
        hC6L56370QngQW7UfQ+qY2h3wZ+zT68WUSck
X-Google-Smtp-Source: AA0mqf5QMtc+zdSfKNrw334C5/+oKFRt4VNjgLW7MTaH2zf198kYMHQLLb86ghmYIKXIZX/wYuvlbg==
X-Received: by 2002:a37:6897:0:b0:6ed:9450:9f3 with SMTP id d145-20020a376897000000b006ed945009f3mr28003911qkc.573.1669290835959;
        Thu, 24 Nov 2022 03:53:55 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id bi4-20020a05620a318400b006ef1a8f1b81sm753851qkb.5.2022.11.24.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:53:55 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
To:     broonie@kernel.org
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, nathan.morrison@timesys.com
Subject: RE: [PATCH] spi: cadence-quadspi: Add upper limit safety check to baudrate divisor
Date:   Thu, 24 Nov 2022 06:53:54 -0500
Message-Id: <20221124115354.132832-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y39YJL02jFbkEMqw@sirena.org.uk>
References: <Y39YJL02jFbkEMqw@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark & Dhruva,

Your understanding is correct.  This is just checking if the divisor field has exceed the bit field's full scale (0xF) in this case.  This was observed when we had a reference block of 500MHz and a max SPI clock of 10MHz setting.

500000000/2*10000000 = 25
25 > 0xF (15)

Would you like me to add a dev_err (or such) bailout error condition and resubmit?

Sincerely,
Nathan
