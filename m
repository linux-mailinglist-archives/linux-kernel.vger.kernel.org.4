Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293F63E6AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLAApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLAApx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:45:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABF26105;
        Wed, 30 Nov 2022 16:45:51 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id r8so162273ljn.8;
        Wed, 30 Nov 2022 16:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzfV/blg/Ga/fe54PrNu5hR73CGPMYQ1vTju1IYxRMo=;
        b=Pj9Nt5dQ+Ly5gcWlBA9pYDNkOfBlQ/CZ+m1Mwn+EVF3Br++Ki5hIWbxy0HgxVxPLpr
         QsNeK3m90nafRA24+mfcwWUoUNZKE8Jv0Fo/S1KaEs2LABvd0u+dw/oAYwb+bDS/nVu3
         HsqASUc6BCJA4N8V5rBtDKNNPVpoS53p+UN9tZgHKV8rHFtbwpY4wMWL6VurUA5SHn3H
         JlpyT7g8T0RiDlRMizunD0vzQnmVHipp2wEStVgPqpQZ8bqdThxM5IhGA+sdmEAmreS1
         QzHzAvEXBClaprcFg9kPYYzIm25kcmz2vLojS2N6xWYXRZmdEFIz7xN3kolprf9Wz7ZZ
         nzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzfV/blg/Ga/fe54PrNu5hR73CGPMYQ1vTju1IYxRMo=;
        b=IDHiu5L1dQSZTR6wXdGMW3OH6Ha/9K6UJMWWOKSWdGaOXotSeEe4zgqqw3FDZoaWyq
         ZY+LF2JmdrH00R7ZsQDATqw4InItVuZ2dkPeU1zatuLU2w/is10RTwYsccWKhIb6kMqe
         4Gsr0qLyhn8H2gGdbXXr3HmhlJo4Jv0wNKovCWsRwD0Dum/gjour+SoRbjtlJRcx7M+7
         YYRXuBgZ8QLYfpVzO4L8friMF52nRVyo7on5UECtJ/huMdT++Moa+jvmkvVrQ9p4ogW/
         Bc7CQZhkOyY5DlaawUoWJeBMZ8JHSrSQGo8dqbp8MRLPAZGCmSNp/OxojOS7snlueB7a
         XOsQ==
X-Gm-Message-State: ANoB5pkjBI6TFooqw/QnBd7UKD6PePvsZumvD6DPYTvKKcnaVriXkKDf
        NkXucTmSliYQ0EoyZZmq3kWajekUklNC7ba/BA==
X-Google-Smtp-Source: AA0mqf6x9TbVvip+dmiyyml448Gcmw04gNAGpi3Xgkt5G5y3saUtbwwqCQMksVo0MsANTjwJd/IihgiLai98eKNvZ9E=
X-Received: by 2002:a2e:b984:0:b0:279:ba98:62b1 with SMTP id
 p4-20020a2eb984000000b00279ba9862b1mr2746062ljp.307.1669855549712; Wed, 30
 Nov 2022 16:45:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669850856.git.quic_asutoshd@quicinc.com> <c166e46a1fff4662f7b3677dcbf0b814eaa98ae0.1669850856.git.quic_asutoshd@quicinc.com>
In-Reply-To: <c166e46a1fff4662f7b3677dcbf0b814eaa98ae0.1669850856.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 1 Dec 2022 08:45:34 +0800
Message-ID: <CAGaU9a98ZP329dpp1N9tkU-pVdh_UVvSLOuuu_6YbDuKu28uHw@mail.gmail.com>
Subject: Re: [PATCH v9 01/16] ufs: core: Optimize duplicate code to read
 extended feature
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
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

On Thu, Dec 1, 2022 at 8:03 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> The code to parse the extended feature is duplicated twice
> in the ufs core. Replace the duplicated code with a
> function.
>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
