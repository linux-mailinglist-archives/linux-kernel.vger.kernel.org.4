Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CE5BE8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiITOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:25:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923EA237CF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:24:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r134so2369901iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=uenAuVOT/bxl/fI76I4SywNVzY4isahU1hZb5TGGMXY=;
        b=jgVZZyDkXlgWHUcb959Gt/mzoSIgd5HJHHHT0+8BZ79ZoQuPSW+VCaFJcoLM/kziQL
         RvaXZLfOGvCzcBpZpHolGIEuQpkBMPYmxidLfDqj1XfR8MRfpzWahCFUEYbEauWrbFG8
         R7mWxDmBeNhXZh2i0exNMPrz6bdtB5OYQSKR+jIbFrB7HwIzLuDN9GOLy0cqSOx/2LHt
         MQSsehhQlQUjmUtjy2j8Iw/yjWb334Lb8OEGc237u6tZZsh7TQulJxsJwUJUk7EHVRRI
         OeLNubFAKaSffiYvLkkZ0yKJt5HonlUQz19B3h7o8y4lmleALJeGAvybyxiMJZs+3wno
         VMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uenAuVOT/bxl/fI76I4SywNVzY4isahU1hZb5TGGMXY=;
        b=NkqSVW9dd3En1XUgzjjZBRSlE/+7gjjr7bz4I6aYsuvTmovi1AXd4DuVDUxw7ANp8D
         Hh0PITKm3ocfcMDzL6TbogrdQzNni2TH6EJeIB+4h9njtvAHN8h4dA0UfgXovOG/0mAq
         zPIKRXDKjX/sRN20kgmhRGterc6YxAw2wqcHmuPmA6DgAe5cBAe0sq401G7LYeNo6nNE
         oo9tFGLsWXa8VcL5k4qS3+i4kpadrRMF2BcbBjDM6W5mRY6Qber0mn2mUcL0fpg6QYUf
         Fng5qqVBHV3/R6MmZHrojuiZEv5fW5qA0ik0N/xk0NuwKSvgtew0CNOTbxg86Tjj7/+6
         Y9Dw==
X-Gm-Message-State: ACrzQf0DqG3u4pJcq8JXYxxahYfP+LB1JhIxpJcDhSHKgiEQ+Fy7QPgN
        SdEEp5YY0OKBDmDwtLbcqw2/bQ==
X-Google-Smtp-Source: AMsMyM56Qwgef9hgA3SpBySSBsh988NQptBHEJi5k+oAdQCKLE1yN0oYh5I0o3ff/MYGA2nDT5dPSw==
X-Received: by 2002:a05:6638:130a:b0:35a:b44d:f8c3 with SMTP id r10-20020a056638130a00b0035ab44df8c3mr6636933jad.59.1663683896654;
        Tue, 20 Sep 2022 07:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e8-20020a0566380cc800b0035841b40832sm667791jak.162.2022.09.20.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:24:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ping-Xiang Chen <p.x.chen.1005@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ping-Xiang Chen <p.x.chen@uci.edu>
In-Reply-To: <20220914074237.31621-1-p.x.chen@uci.edu>
References: <20220914074237.31621-1-p.x.chen@uci.edu>
Subject: Re: [PATCH] block: fix comment typo in submit_bio of block-core.c.
Message-Id: <166368389585.10391.5193795703873727936.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:24:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 00:42:37 -0700, Ping-Xiang Chen wrote:
> This patch fix a comment typo in block-core.c.
> 
> 

Applied, thanks!

[1/1] block: fix comment typo in submit_bio of block-core.c.
      commit: e88480871b8d5a6bd14be2817063363202d282b9

Best regards,
-- 
Jens Axboe


