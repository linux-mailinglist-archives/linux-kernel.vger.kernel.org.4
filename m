Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C546FC7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjEIN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEINZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:25:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B23A9E;
        Tue,  9 May 2023 06:25:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so9090670a12.2;
        Tue, 09 May 2023 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683638756; x=1686230756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxNZhYmFEaJqtUTo9wQLUCL/RgshP6WY7TNYd/ukvKU=;
        b=ZJRI1t+cYl7tz72VjJBwFQGixlrxxddnkk+WSxZ5pK5sBDba24zyi7GeSRipR49wKK
         QtkQ77I2NuLS1ujx0WU/bsBf1GGdIoJxzFsrdNpQ5548xyhKP7EIcOrvYms8N9HtPqa1
         v2ne7i0ZIGZ2KYAYprB8C/mTnKfwWlxZkaRqkV5hvR157UAu6aU3RZnkvgfWlxSYrpSF
         zPZs6C5KHOGpt3FTJO0AuwXw7l+xzj+fYqoBQqWMo3ty1fDy55/gKyIpqAbjgJysSS7Q
         uIl8JuSq3oKWvYIpzhXbpmglrAemzuJ/IxtsOZajcxulV/G0rWtvDEYdgiA3JCcTWr6z
         h2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683638756; x=1686230756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxNZhYmFEaJqtUTo9wQLUCL/RgshP6WY7TNYd/ukvKU=;
        b=I4+mKF8a9sS+MXrxYIVTbfr2SAFPTvFvBwAQjRMDKtoWvrEaCHplTObGQMswq/RUGq
         ibjCX47uKGV40A2agB+MQakUaPePN/GgPRiIP8DtO9BeqpZHCFEi74R950WVAIglxLw6
         y7fnXd8QS8qGYx5fLUEr58An75iHTVJLrds9VKxekzrcW3jHTQH0ZKkaUnCJbqcGwtlE
         bCYRlHinQOvRKos2RHKOb/AKCSILQbrmjlT1LpI8wfxJuwXxzTcmxvqYSY7glE9n3CKn
         LDvjo6NyX9oCwvJw1WPf+AwYbilIdVz4v6HsEP1bshmKf31O9Ud+EjAH7TIU6NbW8/+Q
         xvbw==
X-Gm-Message-State: AC+VfDwSIsjbtkS8P16C7xyOo1WoLlJuOzkqT85r9Z5FJzuItK7CMjuW
        jaHpxFYhhYi30HAoZD4lCEUbFgYVsIQxSGuF4bk=
X-Google-Smtp-Source: ACHHUZ5B2MTV3MMMwCj2/JgH46LjHIUzm3k+mekYn5oXNoBPwAEa57Iv4NXm3tR4O4eRvzj98VoVlfvbr9K1v4x0aM0=
X-Received: by 2002:aa7:d945:0:b0:50b:d26d:c57e with SMTP id
 l5-20020aa7d945000000b0050bd26dc57emr10432054eds.12.1683638755891; Tue, 09
 May 2023 06:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230410023041.49857-1-kerneljasonxing@gmail.com> <87y1lxzmc1.ffs@tglx>
In-Reply-To: <87y1lxzmc1.ffs@tglx>
From:   Jason Xing <kerneljasonxing@gmail.com>
Date:   Tue, 9 May 2023 21:25:19 +0800
Message-ID: <CAL+tcoDyCYjdW1E7gs0EsKGAN1Esv524EeA_=ORt+Chyd5Sj5w@mail.gmail.com>
Subject: Re: [PATCH] softirq: let the userside tune the SOFTIRQ_NOW_MASK with sysctl
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
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

On Tue, May 9, 2023 at 9:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Apr 10 2023 at 10:30, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Currently we have two exceptions which could avoid ksoftirqd when
> > invoking softirqs: HI_SOFTIRQ and TASKLET_SOFTIRQ. They were introduced
> > in the commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")
> > which says if we don't mask them, it will cause excessive latencies in
> > some cases.
>
> As we are ripping this out, I'll ignore this patch.

Sure, please ignore this heuristic patch. Paolo and I have already
tested that revert patch in the production environment before and
verified its usefulness, please take that one if you could.

Thanks,
Jason
