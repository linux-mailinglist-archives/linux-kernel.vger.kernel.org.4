Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C480264ACE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiLMBQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLMBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:16:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFD6245;
        Mon, 12 Dec 2022 17:16:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so2472642lfv.5;
        Mon, 12 Dec 2022 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=052YErEpfseSbbbIa1CuWn9La97d7y6nfjZnmXFnEcY=;
        b=mEw7RfIrt4yDx7nh9FQltOF4wmI6zHehlsOoqYNSk8/YpoXP4XqeqXQct41JWeramP
         St8LOPANC0+AEyldvpMOVZaIwff07n8oEVVbUv+Ja3Lbp94NVTdRZ273WgGFMtbO3HgJ
         WvA9u02DDuCr6GhEWEexHTDfUZIp+yTMo/49gCLiK4300yR4FvNOqTW/npdERR2bfi94
         hxR4/leaE4HxQTkvWvpqVK3AUXph1pOv50gKUVP5bhTvcZCwlWGdL/X0sBD00xSohYwd
         dDSim97AOgCLYHCQ+wK8cUt2V/kEzt28rB8DqlXV2poOd1HQT3bSCqN0on75R4I9Cqou
         ekAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=052YErEpfseSbbbIa1CuWn9La97d7y6nfjZnmXFnEcY=;
        b=2jB97x1Fzz4lugQd27890pRuDehyzJztkzxHASAjCuu7ezqVyjOkqRuLQDNDD0Otvs
         VZHCmRAGIlD84UdZvDXq3dEgUwRx484oqA7ubYd7I2bFY386s7zfByeHXoVTSIyn5DjE
         D9XFO9ZCcrAATfiqA9KToQsemErMPF0tyrpNNZqkXkVdWXvXEMhc9S0Ujuwp8myuHCDP
         Fw+6h4Ckhe1weDYr/xSfCgVTXMIWpiYiN098/fc1DLG4cxg1ppA9lqD1Inml/ty0Mrsl
         F8lOXPxLb72rG7d13DjzKuHTgMiL9xsHPjsJU2C4ZXZhLp9+qGc7Jv9Rpt5qOGk9M99y
         33Tw==
X-Gm-Message-State: ANoB5pn3+TWQx66D3T48cneAoUjuOAHmRbS4hk1KasSqhjXUPrS0JvLr
        dhIm9aS6sAm2WWksAtLRicBwXTWsrOPXmLd3lA==
X-Google-Smtp-Source: AA0mqf7Eh6HbIsS47wLP6mV5hVGworN/gd/HJVZBV0u9G4rZQhEck+ImCqQIYdNVrCclC0WgmnK1+1kJcB7O6GPpCDE=
X-Received: by 2002:a05:6512:3fa4:b0:4a7:66ba:df18 with SMTP id
 x36-20020a0565123fa400b004a766badf18mr32093680lfa.208.1670894169576; Mon, 12
 Dec 2022 17:16:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <c96a91460214a023b4ad1150829d351149d7a292.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <c96a91460214a023b4ad1150829d351149d7a292.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:15:57 +0800
Message-ID: <CAGaU9a-sH=pYrR-tD-4L3L+iOmYx095u5R=a1ccf3VRfBLM6tw@mail.gmail.com>
Subject: Re: [PATCH v11 10/16] ufs: core: mcq: Use shared tags for MCQ mode
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

On Fri, Dec 9, 2022 at 7:27 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Enable shared tags for MCQ. For UFS, this should
> not have a huge performance impact. It however
> simplifies the MCQ implementation and reuses most of
> the existing code in the issue and completion path.
> Also add multiple queue mapping to map_queue().
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
