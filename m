Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3163B608
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiK1Xi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiK1XiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:38:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE397
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:38:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d18so944593pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRqQDlC4NF1cl9mhZT5OOJjaP5wNAID9J2sA8bdU0zA=;
        b=OdXJe+tEmg/2snhvaGybt5MblnkruFi19xMidiljulqy61tIsAhzrXLrEzrTN4REvI
         QWaf7uMequTwF37LRraG6KJ5LjZYplbT97M9bSSoADekmZ2ve5ENgunQqSaVhrD/cnRA
         VV5Vkbv66v5Dt1Ki3HPfOJejcFSvp9Y76Rx2960BTYJ72XkvSMLy1WFBoBbN1fFAQuGN
         o/fumD4dAqSbJiSxZCMln7NcONeXyxmrU3OBq/9O2rRWqm+w0AQD3bl2NlG3sdBK4GV5
         lhHI5zLJ7gOcNpe9k7Hduwp9HW9PEU92Hu3QNxEnWaLoyNDJsoeOAPeSx02gPALkXyv1
         8QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRqQDlC4NF1cl9mhZT5OOJjaP5wNAID9J2sA8bdU0zA=;
        b=2ZJf2l0vNA4WxCx4wTjr8VO/oJAydVDLWXka9mMzjsXw0NVskDeoKzLa4JvG4xGm8g
         HWz1HMaPXwbh5pyUMESrzXpJUOx6xg8D23c1vwYGcy+9ef1Xnvjg8LTcfSQz/uvI2uZ0
         uyqAe4u2r9hzWuSG+94dXvpzwaLLvasFcT+V8tIqITKAri5aMR9KsGdkLV3xJvHlpVeT
         fNcmdZn1U5uSsdyiNpDu5BXvsWyoafjQXt7rPCwooC+4c2u5//x6a/Gn7xLiAS56oe8C
         J9FlbnjF6KCxJo7myZAfSPNZUrHEPy2Q2o5gtYazUe3EpAIWPS9bVn7usu/H4SPMSurI
         xUow==
X-Gm-Message-State: ANoB5pl6nQRfxlC2z9AWZQQ+w2npbUIU7MtYrQ8bHvX3Oqo6+waSG/PS
        sNkJHHFYwbuPzIVyfYVu8KINyA==
X-Google-Smtp-Source: AA0mqf4ZZetnOZgVq0CIkDDuG09QioYMDERHdx2KKF57JhNygelLjbNol6eNGjKVLXR0nLettstKkw==
X-Received: by 2002:a17:902:bf44:b0:188:64b8:2402 with SMTP id u4-20020a170902bf4400b0018864b82402mr33943418pls.81.1669678692173;
        Mon, 28 Nov 2022 15:38:12 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a24-20020a63d218000000b00477f5ae26bbsm4516399pgg.50.2022.11.28.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:38:11 -0800 (PST)
In-Reply-To: <20221126061557.3541-1-samuel@sholland.org>
References: <20221126061557.3541-1-samuel@sholland.org>
Subject: Re: [PATCH] riscv: Fix NR_CPUS range conditions
Message-Id: <166967858805.10679.4577917699615835460.b4-ty@rivosinc.com>
Date:   Mon, 28 Nov 2022 15:36:28 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 00:15:56 -0600, Samuel Holland wrote:
> The conditions reference the symbol SBI_V01, which does not exist. The
> correct symbol is RISCV_SBI_V01.
> 
> 

Applied, thanks!

[1/1] riscv: Fix NR_CPUS range conditions
      https://git.kernel.org/palmer/c/1d6b5ed41f8c

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
