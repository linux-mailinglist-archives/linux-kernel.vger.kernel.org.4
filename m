Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07C6FE3F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjEJSUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:20:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8ED9EE2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:18:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115eef620so52172547b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683742721; x=1686334721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxNNeUlKb2mEb7+tC4au3XdhlwF/tDkvv1YeFKn3c7Y=;
        b=n5a6hSvCr1y5VjAamauHZ709dncmRtqSN7cvPA59jqOLcEr4HmcNQQVZOcrcj9PaAk
         c7ixJ6QXq1PTiEvH3P8NgZ0juhIPoX4oV24jULi20FAaqAmaw01jFUcX/Vu6FnO6gwgc
         BeJRZ8XCoRYpzSFJF7Ssu/O8OZH0X7isU8oXVm6piyQEAwE1luoxSqHxO179fIERp4bR
         sFGC/vD2O31U9RyAILJWRumIBiqs+2ME95LCU0EsqopxhKlrLF61/fTnZ0CfFOu7CXOc
         +cC15Dmr4i3kDITU1i+ARZ0SHKTGjJaqFx0PVAQU8ks0GKJVSI+QPmkoo2ujJwLJ8Jpe
         CbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683742721; x=1686334721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxNNeUlKb2mEb7+tC4au3XdhlwF/tDkvv1YeFKn3c7Y=;
        b=DaUl3Uaw0Sx1k8HK6snDue1fG0FCI6g+SLU0EOiIIUlOzamP87+N3FHUtClBpmRIzj
         iF8FKOa56mdxFybhIWM5Po2X+ZcD9UPaS8GxxzayoTGRcR6c5vDYInTbF0wPIeb22PLt
         Hsz8l9Lz8fO2WtFEsu4P9MCZUBkiCmBB1UO6AwtAMahOfNtLVTDO9hwi6Hc1nYlvt8R/
         zjPUoZkFI5az1zLkzdFTpMQd3tIGZFqC6IvyVKPs1Ttp3DlxjZmi+n06EDQjCdivyWEK
         G6sF/fE1gY8hPDJ0CHRAcb8uIl/6K0O5mQ3jwwZbBfA4eeF/1VBh+VxnDoAm1ahAjILD
         VisQ==
X-Gm-Message-State: AC+VfDyMUIFXjJeKx7GvfItsAdon+sO6izbHQ5pcLk0Flp1nWEVVlMsy
        xgeQ0C4/vNDQZpeW6G4D6Tc=
X-Google-Smtp-Source: ACHHUZ6BrfuP6JLTyFBueEHrabOYi57cQU9R21n/k1mzM3ac7v2HhCAKCATDnCtBraemNnBQyw79Lw==
X-Received: by 2002:a17:902:b195:b0:1a0:76e8:a4d with SMTP id s21-20020a170902b19500b001a076e80a4dmr21127802plr.14.1683742720606;
        Wed, 10 May 2023 11:18:40 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001ac2c3e54adsm4105512pls.118.2023.05.10.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:18:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 08:18:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/6] workqueue: Move worker_set/clr_flags() upwards
Message-ID: <ZFvf_1i82w2Czi9t@slm.duckdns.org>
References: <20230510030752.542340-1-tj@kernel.org>
 <20230510030752.542340-4-tj@kernel.org>
 <CAHk-=wiu5vwNeiDbwueHtpnTp1Be7r3_ssG07Qsv2N=V9K454Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiu5vwNeiDbwueHtpnTp1Be7r3_ssG07Qsv2N=V9K454Q@mail.gmail.com>
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

On Wed, May 10, 2023 at 09:30:55AM -0500, Linus Torvalds wrote:
> On Tue, May 9, 2023 at 10:08 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > They're gonna be used wq_worker_stopping(). Move them upwards.
> 
> I got points deducted in fifth grade for using "gonna" instead of
> "going to". Here I am, 40+ years later, and I still feel it.
> 
> Please use "going to". And add the missing "in" while at it.
> 
>              Linus "scarred for life" Torvalds

Aye, Aye, imma update.

Thanks.

-- 
tejun
