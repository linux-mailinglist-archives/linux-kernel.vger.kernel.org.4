Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877B57360E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFTA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjFTA5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:57:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506910C4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3fde1b83890so33270041cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687222635; x=1689814635;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLZ1rrSAjCioF7E6D5kKLsWm28oZ1qPFQ2kV8xR8pf8=;
        b=skpqvQs1Gh01iJEVOu7e4HH3IM6ewHFmqp2XfWV7tV0tfjPwuPn8VvnX1qvfR4sja8
         e8Y+SMsRdBIrTjj/TK0yeOurvNHVDUBn/4aj1HWj1m1nb1q2clueLXsV+BLkwCOIk0Vz
         MextXGzUic0ExbphFhNEIYIDi5l1DgaDruw2svq1S0no7IoGbd8dIABVkKz52FS4R8Df
         +t32LC2CCE3dSW33rtbYso40XkT96dVojnRuVOcnEQqKDYUciB3O5Mnw7olU78/oIhJA
         qpI07OVTH7kN3t8rTV3W3LJ7VlNs8WquhjWW+tP3Jt/mZY4CX8VHglSW85ewrBart+2P
         nEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687222635; x=1689814635;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLZ1rrSAjCioF7E6D5kKLsWm28oZ1qPFQ2kV8xR8pf8=;
        b=iLwIK2L9frZ0/1g9ICOLQS4H7a2bCwdl5uKk4I7bvOB557chM+uVYXYChMie2qbngz
         +Bi2Fv1abH0mOrwVgmkVHmPRNipONVe8mntY2QTqXEsqlK5Vub8Z/nSkdB5Gdg9KvzCz
         nuaSlTZB/qL18qG5hQxfYPfbS1QqRK5EBS0d3cZ2BumpGlgAED95gvKG5SE004xPzK31
         QKkVWtEkW00wkj+oWh+LJiZ7yML7ZbsCW7R8ZYJvA/RHBeBwHISGhKQjMNhRTpewFnCi
         fEKFX8Td4qdXOUgfGVPZUab9tKMhxyOoSr1IC/cdVKRmQDdYfEZGD/f4gzTvuxoFjU7C
         DhHA==
X-Gm-Message-State: AC+VfDzyUqwKGKbUbYwmTFKuwWroitgWQqF4Oo4pL+LPafJSdf3Rj3da
        xgcuQDgHhLiFxPa3YpEDeT3DUQ==
X-Google-Smtp-Source: ACHHUZ4sNWlosakuG86D5S9uKAqq10e6+UXGV18yICFf8Mt4a2tQt7KsoR18rLmfVp0Kh+lMSRJvAA==
X-Received: by 2002:a05:622a:1a97:b0:3f3:8ee7:483 with SMTP id s23-20020a05622a1a9700b003f38ee70483mr3013625qtc.53.1687222634876;
        Mon, 19 Jun 2023 17:57:14 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b00666e17004a4sm220172pfn.58.2023.06.19.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:57:14 -0700 (PDT)
In-Reply-To: <20230509152641.805-1-jszhang@kernel.org>
References: <20230509152641.805-1-jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: mm: stub extable related functions/macros
 for !MMU
Message-Id: <168721242540.30028.15321347837329883104.b4-ty@rivosinc.com>
Date:   Mon, 19 Jun 2023 15:07:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 09 May 2023 23:26:41 +0800, Jisheng Zhang wrote:
> extable relies on the MMU to work properly, so it's useless to
> include __ex_table sections and build extable related functions for
> !MMU case.
> 
> 

Applied, thanks!

[1/1] riscv: mm: stub extable related functions/macros for !MMU
      https://git.kernel.org/palmer/c/de658bcf0333

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

