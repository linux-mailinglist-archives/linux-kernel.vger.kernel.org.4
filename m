Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4164AD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiLMBf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiLMBfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:35:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C671D334;
        Mon, 12 Dec 2022 17:35:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so2488743lfa.12;
        Mon, 12 Dec 2022 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30U9RseqGKfwyGVXa0b/Q1IAyRMAB0Es1Wq7/iCU9Wg=;
        b=o9juF837/EiQLtFz9n2pD0pRgQb6NB8Ve4n25hehNtG99jcMdZUmeOp0kQ0tbip+Un
         xTKy3zLMVbpwFDOC+o7yrUM6PMogCq/UYCrJr/QbXMp+nR3/N5C7r/ZPymCT4P4Y59x7
         LXuQTyJe7QCYhQ9cFWXjUeUMJei/q1uPoN9PuunQ9lIBjT4yqHqYkNUjIF1eFaU3Bc5u
         d3GsqILZ4tW7odLyzq6xRZD4WvZS3opwlsYcGDBj2iaVkN0xf02UXlH96UuNCh/pAJol
         DPuYjtTjjqM80DiRhmdl4CePTGksOuv9QH9oPPDYnKPv0nO2tiORQ41XHUb8fvBaiXqg
         ZL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30U9RseqGKfwyGVXa0b/Q1IAyRMAB0Es1Wq7/iCU9Wg=;
        b=DBnjMkYP8SaQDiK8l93aFeYfyTzj+EOYkHSt9xHYGUAjvP9JntZGvJUf86DmiCa3RQ
         bt0x5wYCttR7cpP+OIxmx6b+7EXJKIekhJDvtL9MZGOoLabYIU6E+UVA1ouCSUYjlSKx
         qmyGOQ9Xf85PmEd6YDDove4ta7KET4ceOCaArvBCGc13Kdo84iQd24dz8VZDBmFMEe76
         JHoh0KxtSf85abckpQvlpwK4sIX4O4w/9GM72e+iytPlI/LVCgOVw5aCofz4h2CDILg4
         kqbVx+H8kUKQMzVncZycQOpJD9v3K/E/FCWNBQ7dIgUb4aNGURvFNZ1WoeyA4L6GKnBg
         srhA==
X-Gm-Message-State: ANoB5pkReGvzeiJpQaIU+K1grX81rJ/zQUtf+zXrMA7HyYHzxRVjDxKp
        baVCefnXbXihYkk2qS4TL84UcM5d3vsxCZaRsg==
X-Google-Smtp-Source: AA0mqf5sGCmOeRTT5bapPst5F9cgZvwXmhZZldMvOEPDGzDoFADAQC0MATqlzFDmAV6OwEVcdrKbrh5DjcqCaKfNUd0=
X-Received: by 2002:a05:6512:3da9:b0:4b6:ee79:63ab with SMTP id
 k41-20020a0565123da900b004b6ee7963abmr250256lfv.662.1670895349526; Mon, 12
 Dec 2022 17:35:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <a6ef5951dbefd6e8cc9a670cc48ad1ae70fd61f9.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <a6ef5951dbefd6e8cc9a670cc48ad1ae70fd61f9.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:35:37 +0800
Message-ID: <CAGaU9a-3r-mhSLmU6MxmvxgQT+TC6szScn7orv2wvNvsrg=rJQ@mail.gmail.com>
Subject: Re: [PATCH v11 14/16] ufs: mcq: Add completion support of a cqe
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Keoseong Park <keosung.park@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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

On Fri, Dec 9, 2022 at 7:33 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Add support for completing requests from Completion Queue.
> Some host controllers support vendor specific registers
> that provide a bitmap of all CQ's which have at least one
> completed CQE. Add this support.
> The MCQ specification doesn't provide the Task Tag or its
> equivalent in the Completion Queue Entry.
> So use an indirect method to find the Task Tag from the
> Completion Queue Entry.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
