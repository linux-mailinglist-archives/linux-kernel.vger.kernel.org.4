Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B57307B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFNTCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjFNTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:02:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3651FC7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:02:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b512309d18so2352975ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686769348; x=1689361348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YCZowOEZlyDvPFb00vEd70o77BSACcS6VLpIzsJZfs=;
        b=UL1esWWehBszKXIe8ACxXGNCnSPB/ARM1o1PbG0kVkV4nemWgox+TZaJYs9cpXwBEG
         0h98gqsB4/z9r4Nw7DjfLdCbyHyqk+L7nxIJn3QAQY99DdH+dOzfYBYK9rBT6k2Bcm8r
         bYtdfgVnSA3wMgKBWkyV1x2vHFzdRyoIOMt0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769348; x=1689361348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YCZowOEZlyDvPFb00vEd70o77BSACcS6VLpIzsJZfs=;
        b=jJoLUC/l+Xvo3L5JsCODpa9JFonaK9vLawW4BLiTvXFEhUNf/eEGu2Qplv3Mqd7pn4
         O5ZcjFnqLunL435Xa77004UVQDWRiKDiJA5RdPo12UidT16AQmsjZjeHom6LQ8xtbT7D
         re9jPgw8FEOuU+cfxa17zDwpBDH5iI4sm22hzaql3ItkKwjIi3xa2u6hq9fFEMyvILRd
         e4UXXo8faFFmJ/87FiWbDXhTYtOrlFEoI4ngichmaM8G/o6ocV42ww6VRzVUxRW0t3PM
         AuhsEk08KywdFiyWFDa3cMCK29b0FtSfIyms/gNJAWAtOGKF36Pfn99/7RDkxGK1Ld3a
         X6zg==
X-Gm-Message-State: AC+VfDxcMePZ1w0t1QVTVIkOm/0OAtRXSXP3cYo0zL+eWMSidElRHStK
        CELFUl72euphmQHQ9R+qiCss6Q==
X-Google-Smtp-Source: ACHHUZ5iJkud3crTR0HfcCGIrOI7RlnMqsNoWMWE3yB+liApSlR7CMUhT1lB2PDhQl1Imd3thY8NHQ==
X-Received: by 2002:a17:902:900b:b0:1b1:787d:1e47 with SMTP id a11-20020a170902900b00b001b1787d1e47mr10405803plp.41.1686769347821;
        Wed, 14 Jun 2023 12:02:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902bd9100b001a6dc4f4a8csm6080516pls.73.2023.06.14.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:02:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>, gpiccoli@igalia.com,
        jiasheng@iscas.ac.cn
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add check for kstrdup
Date:   Wed, 14 Jun 2023 12:02:22 -0700
Message-Id: <168676933413.1964902.10975046622666156359.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614093733.36048-1-jiasheng@iscas.ac.cn>
References: <20230614093733.36048-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 17:37:33 +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Add check for kstrdup
      https://git.kernel.org/kees/c/d97038d5ec20

-- 
Kees Cook

