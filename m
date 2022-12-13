Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83864ACDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiLMBNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiLMBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:13:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B4EB;
        Mon, 12 Dec 2022 17:13:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z26so2448876lfu.8;
        Mon, 12 Dec 2022 17:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EKDJvcddAYwbAW0mH7+IQB9ua0CLyFoaLjvLSx1u/ZA=;
        b=YdDNgMeg7uqDlxuuIdmBC3boBUMsKD29rz+wZxxl8r3ws1RyZpw/KvrwkVoatQfcm1
         Sl+NZuT9aTf8uMsoXq5ivIwqbgcGgsF0ayx+W3A6O+1TnHm2Y36GBtcvxJPmWy+p6Hb/
         xAZSgJ+5dHVCZ6mdygn+zEp60PjW5Y8ynIlZDEbaiR+BRgYIv4D8/GJPlz/VM1bJAZuW
         /4HgR/bkuj0WbBozcR6zWuzHZIOTKkwNy1199HalbkLfeArLmhitR1nILYbMZgU0veq7
         GXc+UN2sc6QeWkNyab8DZ85M0rkaRoUgc316JpXVAbw5DrA5n/0Cwx6GCHyECwmPZ2gM
         /Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKDJvcddAYwbAW0mH7+IQB9ua0CLyFoaLjvLSx1u/ZA=;
        b=bqqUvqSGHKtWJcclzoAuzKV0lIQchBBEBq+GbosWMxF33OKKPvwXUS/BGbZH/aMhqB
         XC+lYwwYXRFFhbsjD2HFhql002uIzzJTwLYfzOz+2Rwwj1eZObpVupGBM6Ti19txiJja
         oY8ehcqKVorNK8zlxPVjMC2/1VTJhlNNiDxPWfu8vB9CAXahmm4FWzf+AhpMxi7U9H0E
         MZ9gBwqwyWQUlm3KbqgWWqpt7ZR5SQ9jVm9WomhQB1pKhdIYO8dAFDLZiCUbLo3O1O1t
         Lq6q2zHlfdyCePqzGwzTLPy3WIJwME/sf4LRnjHLsKTolDnlyxe5rmXK1lrRpdCk+wfy
         33Xw==
X-Gm-Message-State: ANoB5plofR7pjzDVqgMu05x8aWGh1bCByi/aLPLARSYfN8HaYXse/2SM
        mphGG87DHF8MTKcTppaRkgY37ppJKWqN/6CAgQ==
X-Google-Smtp-Source: AA0mqf7Nnn7C3m9Wu6Wj9Miucmzcl5jnAUisCV/GR9Nvk00rerYfzP6+3kP/1yc/pjxqkBgn7ke2NvAEWT4qd8MHYxs=
X-Received: by 2002:a05:6512:3da9:b0:4b6:ee79:63ab with SMTP id
 k41-20020a0565123da900b004b6ee7963abmr247034lfv.662.1670893989730; Mon, 12
 Dec 2022 17:13:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <e1410d416fcea75e7f96d0ed2c4df8708798ca94.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <e1410d416fcea75e7f96d0ed2c4df8708798ca94.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:12:57 +0800
Message-ID: <CAGaU9a-uQW9a=oZS2zwGb3XTsfx54zOyM0+459_nH8BOE0pzdw@mail.gmail.com>
Subject: Re: [PATCH v11 07/16] ufs: core: mcq: Calculate queue depth
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 7:25 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> The ufs device defines the supported queuedepth by
> bqueuedepth which has a max value of 256.
> The HC defines MAC (Max Active Commands) that define
> the max number of commands that in flight to the ufs
> device.
> Calculate and configure the nutrs based on both these
> values.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
