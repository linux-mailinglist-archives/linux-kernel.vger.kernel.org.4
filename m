Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137A46B88FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCNDbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:31:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52E8C5AD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:31:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x11so15181446pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678764670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpiFaB+K7/rSciue0aoQ02gjIA1Iec+auL3NUFn+pcQ=;
        b=fE2wKEiJNSeeqAiSUojv3ZHU9twxqm/7zs23p74XSTcSHnnBWt+XbjkuHkN85yzDL7
         FmYskuYu6boolWHtVp95zV8+t8z60FFoHLPdDZsPTuP9x5T5rGeoUA3O7lZrfbQTZOFf
         C6Ugp/1Q+SsN/B+5qCKWYhg4wSXkZD2o3CxGkZWiTrCAPSwSvNR+T3TKGO9uv9AVoNE+
         Nnbod+CTnJNnwPWl5RPhEgPdvRMu3RdQQLnfWbrD5z0Eo2KvAAgUonACi0reueN+/Kmx
         CAhHMbDUuUPFyT7YfFdUk1c/5FPsWFrvqFjh0y/BRzx0sl/FZuRro+whgkUHYfmwHaYk
         NoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678764670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpiFaB+K7/rSciue0aoQ02gjIA1Iec+auL3NUFn+pcQ=;
        b=lOTF1PFTVSF70OtN10JO7OQ3ISyjlnttyNNIEHxNAsBc8pEJwMpo/Tyi3PXAF9ybpo
         og8K9GQvCSGzPTFGkBNYFBySLd1cRbAzwYYGx2iKCHJoBoAXIbKopwmSrObzz9ow/cGj
         t6pVguZcHBOy6dD2LOzBIHHFtIHZ8XqcaihIInob/HYvkiTvyFoI2iDzhgu3m+i+pbqo
         DvAcyb59zOBgrSw0iFpSENBT0gkgaiBa85LLJl2TVtsK9WKVKrRAd4MtifNoNqemgVNE
         7nPRUC/0enCzIYRvT6U3LYdgeTkUOHEs+jRCIEhLYL9DqwyUVozYkrQy8jMcpMRkh8eV
         g/5g==
X-Gm-Message-State: AO0yUKV1gHftBbOy1hHqAzVV4Hf/gBKk7OxGs7A4wrjR3gaErszf50QC
        CYSYlOY0CayXwJ4sJAFIYlo=
X-Google-Smtp-Source: AK7set//LMm/Any6LFvyLZrlWTc1JUqfALv7vGJE0Azur5iGmVUaPqlb//ncRzc7OnSXDk8057QVdA==
X-Received: by 2002:a17:90a:55cd:b0:23b:5190:6a4f with SMTP id o13-20020a17090a55cd00b0023b51906a4fmr7459856pjm.47.1678764670035;
        Mon, 13 Mar 2023 20:31:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090ab01500b0023cfdb24874sm573728pjq.5.2023.03.13.20.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 20:31:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Mar 2023 17:31:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 08/36] workqueue: move to use bus_get_dev_root()
Message-ID: <ZA/qewUCrDFGfdQP@slm.duckdns.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-8-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:28:50PM +0100, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Tejun Heo <tj@kernel.org>

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

Please feel free to route as you see fit.

Thanks.

-- 
tejun
