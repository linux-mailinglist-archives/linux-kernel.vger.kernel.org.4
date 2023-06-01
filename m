Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81171A24F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjFAPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjFAPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:17:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362961AB;
        Thu,  1 Jun 2023 08:17:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af2db78b38so13284861fa.3;
        Thu, 01 Jun 2023 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632631; x=1688224631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2pCEbqH+14CMqhY4u8fIfAeE2FyTCTYtbFveWojOZw=;
        b=pXKZ+aK2QcySADgKiZ3DnLEeTsechjGzp3eHquG9UyuocMv+jxeAi9ZJo0bk6znqpD
         h+Lm34Lgs67GgUjFJerWCDYN3aHWFib+wyaV+IUiTd/qJYFJGLpuCBnaYMwwEHtrX01y
         pRg6owQc/m1fY8gDYpW4zpCts7oqciYYHWIUptqH3Sv174FRHOZU9jx+myPM+GDWz4mx
         rAqpguUYiqYeMQSrWwHrVdDFEvmBDv2QtxoROWIyk5XH7PPArSz5L/x311jD2cfcs0au
         qQxV6d9eHJcU+xoJ5KYqsHXkE5n1Z/TTeLpIcMKkSLY0Kc5tgwNzUikyyAee8rendfss
         NBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632631; x=1688224631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2pCEbqH+14CMqhY4u8fIfAeE2FyTCTYtbFveWojOZw=;
        b=UfqmVJ1SN/AD14mHxFA/NRIdJANJqa4InALW40GB9mUwOBb5unC/t9c3zNJPwZq+MB
         pHmwmhm5nua+pLHzJ+QDrrNy9oaqdRZ33r72EYcDi3Uy5mEcwDQcIRP2PGrOz/y3U0PC
         LM0qhlLQP8Gx/esTF8ASJgxsZ2DDIakDYA/WZsbsBLnMWg/5vIljqiM4N0LtxXb+h21R
         vypZmrPGpsJXo2yFgLmuVvRaL5kDJhBNLTT5fHL3Sjnfuap9ksMRqc/5Tw2N+TGwt70S
         0SpVfCE4pNllisR2Y/oxWX5HjddcbO2GHO+NIpJNpVAgYiih+15ru5peWfpLb8HYH4j/
         uL1g==
X-Gm-Message-State: AC+VfDwD7xSyKUY7LV5Ai21mbSNNxchr+xyoLnhY8f9ZQtiN38wFb8CO
        +ZKR/IlX6X+z15jnJ3sFF3ESlJormFBLQAIeaA==
X-Google-Smtp-Source: ACHHUZ7AFR7UMvY7EHl/YGXghW/KhzjglfD8/F9PeuM8gFPOl0Bdm8sWVBEHQWbAA94dU2dDIoeapv2wQZYCrXFlI5U=
X-Received: by 2002:a2e:9457:0:b0:2af:1a67:d55 with SMTP id
 o23-20020a2e9457000000b002af1a670d55mr4541173ljh.10.1685632630842; Thu, 01
 Jun 2023 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230601090202.27035-1-stanley.chu@mediatek.com> <4f092b70-bfaf-8c6a-9f30-cd7b797ba2db@acm.org>
In-Reply-To: <4f092b70-bfaf-8c6a-9f30-cd7b797ba2db@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 1 Jun 2023 23:16:59 +0800
Message-ID: <CAGaU9a-pNNpP+CTib_CSv5C9HFJW_tyQHMTapfEKHYhNi4qObg@mail.gmail.com>
Subject: Re: [PATCH v1] ufs: core: Remove the nolock version of ufshcd_mcq_poll_cqe()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 10:41=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 6/1/23 02:02, Stanley Chu wrote:
> > Since ufshcd_mcq_poll_cqe_nolock() is no longer used by any users,
> > it should be removed.
>
> This description is not correct. ufshcd_mcq_poll_cqe_nolock() is called
> by ufshcd_mcq_poll_cqe_lock().

You are right. Let me fix the commit message in the next version.

Stanley
