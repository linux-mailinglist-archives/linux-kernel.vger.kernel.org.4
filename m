Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5A69ED62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjBVDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjBVDQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:16:57 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00030B22;
        Tue, 21 Feb 2023 19:16:56 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i9so8135072lfc.6;
        Tue, 21 Feb 2023 19:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjix5hHmRg1gnpTeSvqiWXkay4LiEwf0MpYeRg42JtU=;
        b=jsfRdr+kWUxp+JSuWOhyMf2DgmTyC81KmIi94ElAmd4jVlFb1ItgeZ5toC4vejyhFM
         KLDOefgUya0UG3F8aw64bx4lmoMYk1tD8mW2I0HCSputvZkRa4gJltI5ssLQK6Th3HN5
         lphga6gcPXm6v6v4Go7HxAnpnWU+8dGfLt6A8vugqjpCpL570WtyMUfoaENpDyYtW8ya
         tiwzVcEmqSp4CyKiMOVFpgNoGNwnA2BE1o94h3NyyuAg27KkAljAUiYToOILf/KLJAbi
         u4sUXiKPcARYizm++3kiLaGyJA5vTv3Alsa/5bs+tEz/96o3hCiCA8Mz90x81Y8DvbBo
         CnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjix5hHmRg1gnpTeSvqiWXkay4LiEwf0MpYeRg42JtU=;
        b=1lr17SCh99mQrx+3XmpoIbx7Zc6a3XELo85iTKXsMj8Mz9Tr+r8OxXnKitBFSK0lq2
         Qtz2XEnR5XrBW1sw8DPSwYHJ+IOP05nk4PUQjV5+m0Sf2yK+coqZDxnNiFkOEEmlpanw
         rH0IpcegNfr6zkZjV3Ceu3kU22exCVkPiWA7z4QJJYezZMWNFzIr2yZFcpMBO/9mJHnH
         qyZt3mUL0clXCBXE8W34wbNxCzblz+pplbDziirL1bSupCAya/cdZGMPc021NswSnyhS
         dAz92tWZpmG4/FRUr9WQPdWDJhGa7ra5aAJIKZV8HIpA/G38RbzsYLLvfjCmgzDKQ5+X
         e3yQ==
X-Gm-Message-State: AO0yUKXicod4pNfJXFebjFidTFSEyqhRJFa5Y/sqaM6rxDRosjp1tWgA
        Lhf4BnqWWHyYAXGj+22xw1KQi3IE41QVh4Rdzw==
X-Google-Smtp-Source: AK7set/3OD7E1WKxGGmZLHWOzKUAYuvDvrVESkKv/Ae9by3eSpTZN/UJX08073sf6Ku8mTNdE+Qroaj2UXoEaJwqcSM=
X-Received: by 2002:ac2:53a7:0:b0:4d5:ca32:689b with SMTP id
 j7-20020ac253a7000000b004d5ca32689bmr2302409lfh.0.1677035814323; Tue, 21 Feb
 2023 19:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20230222030427.957-1-powen.kao@mediatek.com> <20230222030427.957-4-powen.kao@mediatek.com>
In-Reply-To: <20230222030427.957-4-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 22 Feb 2023 11:16:30 +0800
Message-ID: <CAGaU9a-X5JYKGp-jjKV8MRxoBnD=ffHa3iBshemRikpOHynitQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] scsi: ufs: core: Fix mcq nr_hw_queues
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
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

On Wed, Feb 22, 2023 at 11:05 AM Po-Wen Kao <powen.kao@mediatek.com> wrote:
>
> Need to add one to MAXQ to obtain number of hardware queue.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
