Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BF6FBCB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjEIBvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjEIBvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:51:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F61D056;
        Mon,  8 May 2023 18:50:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso3751484a91.2;
        Mon, 08 May 2023 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597049; x=1686189049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zbQywKsauWYv9va8GGE0qTax/82YpmoRVj80/h7hkk=;
        b=icIui2MU1ql4m1vL7wZDdh6SMZWysVDcJbhMsSWpo47t5+z6KVN5QjRLsl8++RgXEX
         QytsjgSlOqeiS0dOcUDXXhgQ2GcBZjo4IbmvKGAwultCY5E6kDmPWJHpV4mgjrChdJkw
         D8/PZX3aZLhD8/EldHVTewAmdEZKRqOaT4KFTBEW0EvdCCBgUkBjUDtiOCWzBqBuUM3z
         YAg1TAA/AYE/WE2gjJU22YD7MOC3d/ugB7lVEzkZ9wHQ73K8GjHJoJv7hQU+r7BMhuZB
         iwBMUSX/LQvSg/3TMfyJHTYvq1nqfJEos3laRYtfXOaKAxEZOI+2s9uRQmoS6S+0Cne8
         rFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597049; x=1686189049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zbQywKsauWYv9va8GGE0qTax/82YpmoRVj80/h7hkk=;
        b=KFIHu7vLkOrBbrxy772MEYj8+ctnAXxG4t3e6Y1BRRhMtMi6x3SWP7zm8y2NQelrnC
         gh5pKVWlRG6hIxBeFAUtwr5l81PksAF9eq7fi60+CLsPQ2pmtiPaLG1vBLVQTtbiGHTU
         s/NRWj8hlOv7xORN+cVlzYUxJiPdfK6FGjLOYjNi41aXMcRjoDbOW51iOWKStKHfs/Sh
         T5KmJZ/cUNeyJrgKPMmi/aF/unKZ4XshMBfSkj93WDuBmZ60JRAGqPP/roww0eGkPfEo
         kmsudEF/Pt0T+50RFwABlSmTkTMx6+Pu5BHjkor408PfFbt89KmYTKKef3diiHfDZXfb
         L5eA==
X-Gm-Message-State: AC+VfDxRk6ArawSjStZkp1WSrjU+WA6WGMrmgG9doRwvpMyUT5Revu1C
        RsoVl/JaKuzgoA9f2R7fnEsOdGMmHSE=
X-Google-Smtp-Source: ACHHUZ6UcRMVOXU+tk33UckIX6pbPixOyob16tpaXiEiNzYSyb2UY9DfiamVgG+1Yf+N91PkCyAYIQ==
X-Received: by 2002:a17:90a:4611:b0:23d:3549:82b7 with SMTP id w17-20020a17090a461100b0023d354982b7mr12078229pjg.46.1683597049162;
        Mon, 08 May 2023 18:50:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m7-20020a654387000000b0052873a7cecesm160074pgp.0.2023.05.08.18.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 07/13] soc: qcom: qmi: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:26 -1000
Message-Id: <20230509015032.3768622-8-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/soc/qcom/qmi_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 820bdd9f8e46..78d7361fdcf2 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -650,7 +650,7 @@ int qmi_handle_init(struct qmi_handle *qmi, size_t recv_buf_size,
 	if (!qmi->recv_buf)
 		return -ENOMEM;
 
-	qmi->wq = alloc_workqueue("qmi_msg_handler", WQ_UNBOUND, 1);
+	qmi->wq = alloc_ordered_workqueue("qmi_msg_handler", 0);
 	if (!qmi->wq) {
 		ret = -ENOMEM;
 		goto err_free_recv_buf;
-- 
2.40.1

