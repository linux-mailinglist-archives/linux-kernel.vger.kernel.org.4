Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0578A7029CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbjEOKAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbjEOJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:59:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05939A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:59:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f22908a082so11323099e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684144789; x=1686736789;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0ivAg1G8aOfOn1nfdfMCi0CyiXRaTClwJeVAOyJXks=;
        b=TrDCMkwVHEiwQk2HO/9g53R5gO2Lnqa6kgYNeF1l5tIcyUjeWLlRwk+h8hnV2FH5DO
         SQPeaEdPa8XDC4w2cTM8pgv/fEevucl2A1JTA316cxCvjrxQ+TqBKg1CEBDsts2yV4jZ
         v2nEUnXjIGwq1qqY7U4tFdijWSE94YXaX38y96hGIzVPjYRj4H3UuNTSFSQT7TeliL4L
         sHZMNqtEh2PjegX55o0kYFoaBXkZoe0K2BwymyEW8BLdJq/ssvvnHY2Z3MJBIblfrqU0
         z10M5EN08mjm0qDYFO5drphxNneT3YdcfYPKeNk5/nDqGW8WfTpsGz7BW2NSXwa/E8/E
         K6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144789; x=1686736789;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0ivAg1G8aOfOn1nfdfMCi0CyiXRaTClwJeVAOyJXks=;
        b=jV4M7dx5T5AtR7yXpswWG0G9yhiMpj4oeBz8TAQHJ+d6PXVTPA0EEY0Wud9JuuSiBP
         YB//sYR1wLSv4wVlEFERheBQj9A3uRwlT5VqjCSnA6u0H1D2WxZsLxbXDis+Rq71hsix
         LhTR+soAJBH2Jga4L1y+VBMLkvEBwyAowDHmIZDXz+adxN3F3U7fqfS7P/IYJg3u8tsG
         QRdKKVJcAIyH/yNxnR9xJuJxs4tNSaeBBlr3bdOWHOgG0ViiFcP0OYIPH8AIhwF3OiEm
         JLBrH3TVjsfR75qeI5Ss6rGWGbUHoxPtfSPxY+zUVioZ17GpHOUyP01tEuUtZWO7tjiX
         irNA==
X-Gm-Message-State: AC+VfDyY8wf50hktDlSp9Jm5jFdPClPylG6okc2mBGnxvTLAIAubtDav
        waoAmNS3Z7dhWoAMqyqAPEVzx7B5cqwRdISkhRT5aIUyVhE=
X-Google-Smtp-Source: ACHHUZ4r4bCgh87NMLiwfsvN+JmKr3WFBhW7aR/Tf8hm68VtGiLJ+Rqxv8t75o3Eglics5Jp8I/rSGo+MkbCoYYfx04=
X-Received: by 2002:ac2:424b:0:b0:4ef:f1f7:eb8f with SMTP id
 m11-20020ac2424b000000b004eff1f7eb8fmr5640768lfl.42.1684144788982; Mon, 15
 May 2023 02:59:48 -0700 (PDT)
MIME-Version: 1.0
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Mon, 15 May 2023 19:59:37 +1000
Message-ID: <CANpxKHEb2ZWT-bBkZa0+XKS49d9iUEcXztQd+Wh+VC9Vh2=w3w@mail.gmail.com>
Subject: How to debug high sysload in 2,3 seconds
To:     kernel derkeiler <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

My system during idle sometimes has high sysload in 2,3 seconds
(around 70% sysload) and then come back to normal after that. I see it
happen in some conditions and try to use top commands to debug and see
one of processes in my system consume CPU.

I would like to investigate more what code causes CPU high. However
the spike only happens 2,3 seconds so I have no ideas to continue
debugging. I thought about perf tool, but I am not sure how to profile
with perf to identify exactly what happens in 2,3 seconds during high
CPU. Because I can reproduce the issue to see it, but only during 3 or
4 minutes, I can see CPU increase in 2,3 seconds. So I worry that
using perf to profile in 3,4 minutes cannot identify the code causing
CPU increase in a short time.

Could you help to advise how I can debug in this case?

Thanks,
Brs,
Naruto
