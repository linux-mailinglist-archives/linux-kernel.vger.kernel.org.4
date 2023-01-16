Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACB66B670
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAPDx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAPDxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:53:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6F83CA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:53:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y1so29059685plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeL2aMm/FlBSF1QP/YxXM0H+2tWA4RrG/z4nLNj/C5A=;
        b=Nm6l1cDkz2vKYpYch7neC71ii3Ml4A0/rJ0KvUmcnWfdFsSMdtGXrTzG1/moOYv8TK
         iWmbHXm3dqOaO2vRzYj/4hXl9g5NrIJUb0FO2TT8Pbp5ptAoadGB5kUxcaW7jUhPIgKG
         PRV5Y4mkwxImAB2LaNRbOljmMaoIJ07SeqDdWqX979SvzmpCEKSuLVG6UF3KsEWUejne
         eL8Yf4ZgKHMkunkjP2JjMIqY7woGKaaf+2WBxb9EuIXafNBxjibsOUyU3ahj84Bbl+9i
         yVxqB7uo70jIKu7kQfXMAYreaiMbZ/SkmYBbVAWgHpeoz2usqc11XDCygHZz17mSGfuP
         VIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeL2aMm/FlBSF1QP/YxXM0H+2tWA4RrG/z4nLNj/C5A=;
        b=jCfPPH36Z4KLO0v7ehVSJkuqMTHO33/Q5EbJPRUJlNaQk6AMYDirevb4ROpzPUa8TZ
         NAfIAi+qsL5XG5fmJc2fDeaY/JUjpPpJ3j403A+wyDUj2T9PO8hRk66usYyUgd8YtyWk
         0K+7LDwbfFTvESpHfQ2QAjo9Fpz9SdMlDGBEoRaKeuRzKXbSmxZfTLL15Gz/WMbzLuga
         BGDaEfsezrZ6i/2X7MsOqaNdO645gGtzxMoNeXF9NPYDT2CYuqAb8QzN7VDesJgK6M2+
         XPq2mpH+YEOF8jZxicRYHeUESJiDv2OIDZ9/Sj8Mk73oKanZCdHFlrmgZWxOxHHf5TAm
         kmHQ==
X-Gm-Message-State: AFqh2kpbgWAiOTiY6nRxU1lFQM8aB9ar/tHcgLyysexmuNaEIsknOynI
        lp2fpv2rmQ2sEIdrgfQzIdDOOIz6ASsLwz3a
X-Google-Smtp-Source: AMrXdXtJkUkxD2XGU3GP1AMcajSPxDY0bC3EiVPGlzcexk5O5DtAyG2PJsrGWwdv5HGdgyw4Phq0Ww==
X-Received: by 2002:a05:6a20:1455:b0:aa:512:82fc with SMTP id a21-20020a056a20145500b000aa051282fcmr31630673pzi.1.1673841231379;
        Sun, 15 Jan 2023 19:53:51 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79f08000000b0058d928374f2sm1975504pfr.20.2023.01.15.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 19:53:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
References: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: switch 'bfqg->ref' to use atomic refcount
 apis
Message-Id: <167384123010.165459.4491550988140898321.b4-ty@kernel.dk>
Date:   Sun, 15 Jan 2023 20:53:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Jan 2023 16:47:55 +0800, Yu Kuai wrote:
> The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
> during code review, we found that bfq_pd_free() update 'bfqg->ref'
> without holding the lock, which is problematic:
> 
> 1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
> 2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
> which can concurrent with 1).
> 
> [...]

Applied, thanks!

[1/1] block, bfq: switch 'bfqg->ref' to use atomic refcount apis
      commit: 216f764716f34fe68cedc7296ae2043a7727e640

Best regards,
-- 
Jens Axboe



