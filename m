Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A470E257
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjEWQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbjEWQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:44:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD29196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:44:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d247a023aso4278737b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684860262; x=1687452262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9iP1ZVb5yqMQbzkFbXlAZweX7OqrHaDEWkJHs5lGVQ=;
        b=ntFQNonFSdidYKpES2RkJ39j44/LM+NMO0LxTwaAQig4V8Avhkp579EAxvp69JQolW
         bMpaPjNXCNJH1TsBHnTC9YdHFofv9KHiHg5AQoGw84dhBrNaYKX1EGcjScDwfbUtifj8
         RucUpo604PEzUZDSWfBZcsx29hrKDyWkVM1XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860262; x=1687452262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9iP1ZVb5yqMQbzkFbXlAZweX7OqrHaDEWkJHs5lGVQ=;
        b=VIkPW+jnE16XKimSHVIRD6bHHBSACoxyRfVbWHczBbLGUyqtBKtlGIBeQ8rvSa/hD1
         Yd/OCRNsNRkCLHah7CNun6EEGTZGkecUf9XO/y684CF3XSWKsjbv+aqCtVFCGB94bMla
         k6eFmqtaucGCKSDPa9sXtqfahPk2huLaCdMHbaEueUApQ3fWyiCYprcEM+34PmHnY0rC
         7kUBbenBfIbhfCZUqq0KTMoGaup9c/QECh7sQ8m7gakELBBq3yi8rDECgFM9sD7AjoFP
         zlRRiAUGSQG0Cdlmcqwb06oniuTU5LJWz7tQiLvH9+9Y8nYhkIikpxnfcmwEeosfoQkK
         5d0g==
X-Gm-Message-State: AC+VfDyqXrnoNOhjQDyhmK5teWcrkYdpO4gONXntWc7SGUbUK2nmzdL0
        mBsJY6zOCADM83sHFhf+dSUEmw==
X-Google-Smtp-Source: ACHHUZ4/+01CYAGjUnIF41KOaeHL0XqDcUQVOFVd0foSRmpyDh7GX/XjdRymM50XqVjzfoB85asBeQ==
X-Received: by 2002:a17:902:e848:b0:1ac:b144:c796 with SMTP id t8-20020a170902e84800b001acb144c796mr17400127plg.34.1684860261893;
        Tue, 23 May 2023 09:44:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001a9bfd4c5dfsm7001000plb.147.2023.05.23.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:44:21 -0700 (PDT)
Date:   Tue, 23 May 2023 09:44:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: Replace struct acpi_table_slit 1-element array
 with flex-array
Message-ID: <202305230943.0B7B2F73F@keescook>
References: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523161815.3083-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 04:18:15PM +0000, Wyes Karny wrote:
> struct acpi_table_slit is used for copying System Locality Information
> Table data from ACPI tables. Here `entry` is a flex array but it was
> using ancient 1-element fake flexible array, which has been deprecated.
> Replace it with a C99 flexible array.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Eek, thanks. I missed one! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
