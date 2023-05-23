Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B170E308
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjEWRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEWRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:13:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D090
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:55 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3357fc32a31so1332565ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862034; x=1687454034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHqkW47AY8QARjZ5sy2gHsO5riEq31n+nVihbrRMHeg=;
        b=eYmYusKwHer1Vddz3pPV7eYUdrCDXog4GbnNmTtVn6yjEa5nW+iLa4GHdG/+5J9Jtq
         vQQrEo+AbKTYqOkM081VcPtdOP4uTwol/9BWtYm0THz/MCQPrRBOT29fRaspDpoJzNDf
         TnEvF+e/w1115/oI2u6MJ6I/SJoXuxb8Mco/v9TUerlWvYy8EyTRs2zKSOSc/zza3cAd
         R/KQgtfcR1IbkLiYvMCFqSoSW5G+9jWmcoCSHLsZN/DPMp2v3BsJ0CgrQ6yU/WceRx7h
         sapeU3+G0pBWIblX1cgB+DnnUBThOhBmT7kYFYAisuOMqZMAA1l/Y0ZYCmkR35O+oAqU
         acbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862034; x=1687454034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHqkW47AY8QARjZ5sy2gHsO5riEq31n+nVihbrRMHeg=;
        b=QKUwdgxwB1lpqO+y0c4+DD86HtbttzJnhWp6p9lbY0R6quSu90yKG/7YUK6zQeSexI
         fpdIudjpsOKhGUnrUWuoWv8LjI7BMpMrkq5oJVuX5KcCxdePe4Z+7HKf/d9Nbxx/1b5Q
         bGcwVTQ5Zl1ZqJ6QG1U8yrlQm4FbYxFGNTuNPmaHQZjVB2c4WOzz1SiDtc/A04/S53Rf
         aTbqYQuPnq2MvDyRsIhCtgDTdJrGOA91UZvn3oxwCBGrzzsG67R+XBzXjUM0ObbjX48n
         EgzR7Y0CBc1Qwu9JjW8PH0hCtoa7OIxWzT46h1xeHeO875PQcnkAdQraaRi7+KC2FhoM
         xs1A==
X-Gm-Message-State: AC+VfDzgB3KVCpf6N8l3NKfNPuNRsBPwGY9zOU22yuApG/Aks0D2orCH
        sHZ3vcRGxyG58j0exwO0bEqlhw==
X-Google-Smtp-Source: ACHHUZ5np/5g+AjvJUk/rzK1gJys/RTdgbLu8FCkGoLJWbSCHJ8ovlR92Aj/dzoTfL5zkPflb+jbwA==
X-Received: by 2002:a6b:5817:0:b0:76c:883c:60a2 with SMTP id m23-20020a6b5817000000b0076c883c60a2mr7078214iob.0.1684862034386;
        Tue, 23 May 2023 10:13:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     regressions@leemhuis.info, chengming.zhou@linux.dev, hch@lst.de,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
References: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH RESEND] blk-wbt: fix that wbt can't be disabled by
 default
Message-Id: <168486203336.398377.14105222183209089058.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 20:18:54 +0800, Yu Kuai wrote:
> commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
> mistake, which is used to control enable or disable wbt by default.
> 
> Fix the problem by adding back the checking. This patch also do a litter
> cleanup to make related code more readable.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: fix that wbt can't be disabled by default
      (no commit info)

Best regards,
-- 
Jens Axboe



