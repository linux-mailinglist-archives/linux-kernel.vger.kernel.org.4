Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F86FFE50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjELBPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:15:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA1B558B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:15:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a20a56a01so166574897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683854101; x=1686446101;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmgiL3YYms4pueox3E/9WSDCVvorY3CYCoareNN8U+Y=;
        b=acnZG17EHJKzJ7LIGLMb/VPxDjPDvQXgCnTEaUxlCti+GjJ6Le6+b3JepCZes0SvoZ
         pFD4nWt6mPWP0b0ZhVdRIlVLUIenTxCboVzZNA7uPgfe4JviSaqmkXeMGBzeDgI29W4v
         q09Wc0WITh7/E9NOkXIfC2/NN5l6InNGAPHR1QcfF43dbUxjxv01CQiuWkc5JsebgGGe
         soxPsTi5Abyv/UFTMHP440wRrKhEzp/MUVg9tqEppg1+Jxaj7g22T1KrJCm3S4RDKpiZ
         +jWtx/qRQk0FLy1JTdjBCt0W4aHb6KtjWKLtKnVVYeoSm6HSManmtSEl1S7lxr6GFa0U
         mB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683854101; x=1686446101;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmgiL3YYms4pueox3E/9WSDCVvorY3CYCoareNN8U+Y=;
        b=bJu4VOgYGDqGaJRAtTY9Ny3uXB6qERommEKJfSVqqCnJCUxRNGour/J506e2NvT7JZ
         yvLDo2fNTwnp4Su26EXYVEYEhIUDbLO3gxSDJkY2nkXJwkOiyWC+8oejtLpPPpnoUJxE
         THy31MOD8hVTijUkXP+yCmDo0dPP5De5N4jELa3oWm+EEhyp3vIrmE8Lb3pP9qZaTGHa
         zqNRw0PD+37eBIM7IQn3SncMurGsZ+Co0zWxDdunbmz0tvKx9nm4mkhQD1Nbk2NXZmJn
         4/2AMhplw2PV5XerZs/zoPcAjpdo2vgEoGUW96MRZEvto59sVKh62rLu7Trpt089qBX+
         2LBA==
X-Gm-Message-State: AC+VfDxea/sC1qLaz7MT1ISvyFoUVv0UlCJ1Ik9/9cIXarRwyjMVH1D6
        y6gNZvrYvM5nnADFY3bFEaZid49vLjGx7hDIQ6oGkGC22uA=
X-Google-Smtp-Source: ACHHUZ6CPdMJ3IPSOFrDUIpdROZYtd8vxPl8FrWeNYBSu8NEgIvWOrJ4iN2eFF2hiV/zGLsiNwR2xQcU7IBj+9xRwd0=
X-Received: by 2002:a0d:e648:0:b0:55a:c6c:bef0 with SMTP id
 p69-20020a0de648000000b0055a0c6cbef0mr22469558ywe.23.1683854101272; Thu, 11
 May 2023 18:15:01 -0700 (PDT)
MIME-Version: 1.0
From:   Sijie Lan <sijielan@gmail.com>
Date:   Thu, 11 May 2023 21:10:36 -0400
Message-ID: <CAGAHmYC8AR_iw=nXQc6s29T3SkSoz9Ajd0N39Nv87orJJHMLGQ@mail.gmail.com>
Subject: Is compression available under direct-io mode?
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys,

When I do some specific test scenarios, I want to do some direct write
after data have been compressed in F2FS, but when I track the internal
functions, it seems F2FS forces my direct-io request to buffer-io
mode. Does it mean we can not do the write direct-io if we applied the
compression feature? In other words, must f2fs use an inside buffer to
provide compression functions?
