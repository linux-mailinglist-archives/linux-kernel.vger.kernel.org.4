Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C167200D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjAROrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjAROq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:46:56 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575AC11E80
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:39:38 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id u8so17117735ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RbrfYpTsB5Gdv1tFjCVf0tX4IIPKE7pjcU8y4J3trI=;
        b=cNEjzeCiE1lLElvTzWfgP/zBRRGU/b+PP2WFw5jto+lw/ZZQxn4ZYaDE8AAIK/0QhO
         8MhGqSxlddXbOpmt1GCbssCDRalZrI8/4JxNN8OLgaUlKwYWkE5IyaMynVYR/WKsQQfV
         jOIIEcSM468A8Yo/p3UhZdpsaIAdAdN+5laIQHCO2l5c56rSEJ9cfTbX7QCD+8RxIVi1
         iGpVaPm+FSzxjhvlwoYKYPIqt9zMuADr3+PbEMVt6kbfi/kHnwUKlLTLgZ3pUNbzZPLz
         kecdmPuPLJJXQqm/O06rXUNxmSuBdvLw+51OLeZZk/o//igAKHvUb6e74yYkpqilOvdh
         u40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RbrfYpTsB5Gdv1tFjCVf0tX4IIPKE7pjcU8y4J3trI=;
        b=dDapJOF8o20UKj4KiIJXM2S+AoWgJXFEOoPyKCTfea170MzyJ+r1y8qzDh4bHXgiSW
         1r241OeIbv5Y4ytWSoEUTwP1gA202ij/ZETRiZpj92Jouv05qNMLXEV3/K8Bt0Y2FvSa
         uBtxKY0NoZ179KamVajQAkiTRS6CCURXGdvGYIeRMaDREpQiZm+RmoHHjmokX0+L4qfo
         vEs7JSNbZqgd68RTNuTt5M2PCkSQUQjIhVKsITG+dB3lw6DLMr2YdQj30Xw7OGbe+GSn
         38+DhHALTWv5O8P+6Ompk1KnTppqc1FWDPs3A1xTT1RYBqIGqs+RVRv8mbVbFwUjgmmR
         19Fg==
X-Gm-Message-State: AFqh2krjf06Nn4C8qRUk0mPDqhSuV7quwsTG//bSdfWx/b9E/RViXUfO
        uvorIsZynmuWLgJA2wM6LPKyvg==
X-Google-Smtp-Source: AMrXdXsEDNwTglSypvAYmMnk0+QJxEhtr9E07S6m3PYDu0to0zeckpI+rKolYcTZulbtx+JjfmpFhg==
X-Received: by 2002:a05:6e02:be7:b0:30e:f0e7:dddb with SMTP id d7-20020a056e020be700b0030ef0e7dddbmr1165192ilu.1.1674052777721;
        Wed, 18 Jan 2023 06:39:37 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k8-20020a056e02134800b0030dc530050dsm5936282ilr.85.2023.01.18.06.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:39:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, dylany@meta.com, io-uring@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230112144411.2624698-1-leitao@debian.org>
References: <20230112144411.2624698-1-leitao@debian.org>
Subject: Re: [PATCH 1/2] io_uring: Rename struct io_op_def
Message-Id: <167405277695.132004.11895027913107306037.b4-ty@kernel.dk>
Date:   Wed, 18 Jan 2023 07:39:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jan 2023 06:44:10 -0800, Breno Leitao wrote:
> The current io_op_def struct is becoming huge and the name is a bit
> generic.
> 
> The goal of this patch is to rename this struct to `io_issue_def`. This
> struct will contain the hot functions associated with the issue code
> path.
> 
> [...]

Applied, thanks!

[1/2] io_uring: Rename struct io_op_def
      commit: 4e61c603ba6abca16888f1a319845048f8e17317
[2/2] io_uring: Split io_issue_def struct
      commit: b64775c649e984f8faf8a3956937d1a5e99b45f6

Best regards,
-- 
Jens Axboe



