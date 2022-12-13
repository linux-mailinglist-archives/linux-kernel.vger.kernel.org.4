Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7C64AD27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiLMBgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiLMBgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:36:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B651D642;
        Mon, 12 Dec 2022 17:36:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z26so2515172lfu.8;
        Mon, 12 Dec 2022 17:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gkXRGTeYk3totrxjicy/YMmtCnEnptDqd4J8k9vI8nY=;
        b=jtzJPT36io9O+jtDg+i02EFBIsisrizM6g9Wcksnq3ss1gwhzHkqhwxZidqcIAzTGa
         eB/n80jEOnOmEekXkVpirjTJ65wxlZTfcFRoAk8b0ak2aWR9Hb8KOprrjBQBeBTOFnr4
         JBd5/JAUXtmGgyX+t5J8KyipwZYK0BPbTiQ4093rvLtRZ/PqVyxjn9jLJMX5/RMH1QZm
         L+U/NMOVUOmqilghc/5tQ1Z73MvxtZRF7zAx9q1IDRYBPCPYacp/dLD/NEaOZy4xai9f
         FRFoN6AR8bqk3zvytCFLKeXYXSTpsU3LIEsRg5SGXxbSczTYWGXB9KRv5eQviCHJBu2V
         5HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkXRGTeYk3totrxjicy/YMmtCnEnptDqd4J8k9vI8nY=;
        b=R/oKdbVhsjVXSSjTrRFkFakdAxv9KyByp39xY4vB8DXYFhX+ScXL75Un5uSVPMNJ9G
         wDUvQo4vFW7B9M2dPxWKgAt9MVQRilBs0PQdckU9NXntoLkGc9+chZpJqmCvZXhJ7eNI
         x08RYa4LI++Vi0FQb729tbabi7fLieEPNwPrH9QeU/BQRkpFrXL4HjtJsDcqd3MC1oo+
         VJmD+vBJbreLBhGL3TwNyZFQKGEf+cdubZIxeLT2mWycMVo9L6EbxyZ5OT4whsfQXFsT
         NL67NAcwBDRfleDhoZnebe1OSK6Lbr7jvlKg9+j8PKcRLWxneEZVMeV9HTNkqRHv0ijp
         CGWg==
X-Gm-Message-State: ANoB5plKMUnK0pnmg4BEEnqY0X1599+7Q+2bKayR4ukQr7+gb0U6v2LU
        BibXTILXuePfagmsrhQ6fiZoeWNu/t9PTXI7eg==
X-Google-Smtp-Source: AA0mqf4VT4kUSse4hGyGngXID4CFSPgFNvw0mlASJB2/gRLS9q54bJwO6ectd11va4JINTv+9LAWMOhTTJHLhKvgZ+w=
X-Received: by 2002:a05:6512:104a:b0:4b5:6683:795c with SMTP id
 c10-20020a056512104a00b004b56683795cmr7038881lfb.101.1670895393221; Mon, 12
 Dec 2022 17:36:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <2d0824aaad6624aba41b3b5546e7473033c6b920.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <2d0824aaad6624aba41b3b5546e7473033c6b920.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:36:21 +0800
Message-ID: <CAGaU9a-R6CbEZBW5x1_+eMYhORHLya-5CRFv+LCKSTi-7xeqwQ@mail.gmail.com>
Subject: Re: [PATCH v11 15/16] ufs: core: mcq: Add completion support in poll
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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

On Fri, Dec 9, 2022 at 7:32 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Complete cqe requests in poll. Assumption is that
> several poll completion may happen in different CPUs
> for the same completion queue. Hence a spin lock
> protection is added.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
