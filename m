Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABF71EFE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFAQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjFAQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:57:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A5E54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:57:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-256712e2be3so869310a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638652; x=1688230652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+pr6mlvTApyiKkbVHDanPXS/dQX3RLJfgRaODr8lBU=;
        b=DmhdF08EAAqn3dYc2MIfdQSzT08RSo4NONk8DZ3MZGu4VFAv4jnZzeq4nhEX377KuQ
         Uqpg3ojyXVchaFjngBrxyVVNR8DbajCT6C6rAzd/zg5yPSPO0cRdQKITE20GOJiTcfqn
         Jb3ix2Ncl6iH/gmLTqH19bKIoIF4e2i+llomw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638652; x=1688230652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+pr6mlvTApyiKkbVHDanPXS/dQX3RLJfgRaODr8lBU=;
        b=LU3oZWFnM4WrZKnr7LWSju+7ly9o7Uye6NRN4luqey2EuQ1BCeaHrIRbMDqowr7EaN
         umF8ebOCtS777qvth3zHdeRBV3xrrsv33dIPNV85+xv3mc3NphxRwjz1K6WjGWlX4IIc
         JBJ9TUulEs/ghWkyUD0ashayenHpkxL1XHYaYRIsCifAQjNIsrtXbyla3hOdaWtnR0Dh
         fimY2SP/I0AORQUvAXW18rNueJNnwz9h8A2YzmSEyzAUigpCkYGqkSs7+8R9rRAA3On8
         MIF+UMJA4zhsDb1//BUXBFxUwrDR4RtuDrS7yVDaOZh73URleCXfbEXs4BdAp12uqtXp
         5tQQ==
X-Gm-Message-State: AC+VfDwQegMmykAsjVb6ZXTpYxMZ3zV8ltMRIm1wm02QFDKdAcG5SqEo
        kLzY7RubLHYFenwgAAALl+RPyQ==
X-Google-Smtp-Source: ACHHUZ4QYrC8WPBmJ4WPNAQOXcGjTUM/oNsB15VuyS7gwI0YNNPRmFQUQ2GxCWaecnRlxGY9S5L0cg==
X-Received: by 2002:a17:90a:346:b0:258:6e0d:26e3 with SMTP id 6-20020a17090a034600b002586e0d26e3mr5312981pjf.48.1685638652432;
        Thu, 01 Jun 2023 09:57:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a65644d000000b0053fbacdaf59sm3108357pgv.69.2023.06.01.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:57:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     lenb@kernel.org, rafael@kernel.org, wyes.karny@amd.com,
        robert.moore@intel.com
Cc:     Kees Cook <keescook@chromium.org>,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi: Replace struct acpi_table_slit 1-element array with flex-array
Date:   Thu,  1 Jun 2023 09:56:42 -0700
Message-Id: <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523161815.3083-1-wyes.karny@amd.com>
References: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 16:18:15 +0000, Wyes Karny wrote:
> struct acpi_table_slit is used for copying System Locality Information
> Table data from ACPI tables. Here `entry` is a flex array but it was
> using ancient 1-element fake flexible array, which has been deprecated.
> Replace it with a C99 flexible array.
> 
> 

Since this is a fix for -fstrict-flex-arrays=3, I can carry this in the
hardening tree until it shows up in upstream ACPICA.

Applied to for-next/hardening, thanks!

[1/1] acpi: Replace struct acpi_table_slit 1-element array with flex-array
      https://git.kernel.org/kees/c/0233ca593eba

-- 
Kees Cook

