Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7786489C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLIU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:59:02 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295E4AC6D2;
        Fri,  9 Dec 2022 12:59:02 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id q18-20020a056830441200b006704633f258so3554769otv.0;
        Fri, 09 Dec 2022 12:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGTdK+VfJnonpBESmz4+ySkzMEO/TSQtM1pNjoYjQQM=;
        b=XPuJ1wrvV9cocVoLqUkF+8cuD7nKXIN7PdFi+MP1EvUBk66X6P4c3mDlB4qbRBedaa
         EFbi3DqOoI3mgk88SY+uUhBkAR3J2DXw/cVM05/2gJ4f/XtQtrqI/KCvw3K1MhpWbp2R
         geK2CRtoTl1Vg+1xUXrEg5nB8EKvhNpq2yop8m/YfNdG6tm23UAC4VTFYtTc1oOyTPfN
         ZBEW6/NgZ/gbR0sfeyp0BqAhmPHrG4AcqESFGPxQCuUv0f+n2DltCpML6U3NRbt30u6M
         xDwzXJRXZ7nVyo8o2/NLFXSqWV2UTgOdUBkKBVnNci2BnpKLov7LZLe7dSfuVw4ZR47z
         VsxA==
X-Gm-Message-State: ANoB5pnIJfsqMPdwVg7OJyTA1srZSNTi5J2rjrt8iH4+V6gpNusTRWO2
        2nmL/FnH2zbaJmIJzqCT1IHlxIGmxg==
X-Google-Smtp-Source: AA0mqf7mXhC8lyMFV8kDY/PdmkSOjVF0bMOsRL+SRSrIEQpj4nhFDXpxu4GkobjjOUeCQE1ob8aGBQ==
X-Received: by 2002:a05:6830:2a06:b0:66d:334d:b8a7 with SMTP id y6-20020a0568302a0600b0066d334db8a7mr3577801otu.17.1670619541357;
        Fri, 09 Dec 2022 12:59:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l24-20020a9d4c18000000b0066db09fb1b5sm972211otf.66.2022.12.09.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 12:59:00 -0800 (PST)
Received: (nullmailer pid 3837169 invoked by uid 1000);
        Fri, 09 Dec 2022 20:59:00 -0000
Date:   Fri, 9 Dec 2022 14:59:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: overlay: fix null pointer dereferencing in
 find_dup_cset_node_entry() and find_dup_cset_prop()
Message-ID: <20221209205900.GA3808024-robh@kernel.org>
References: <20221206083657.3202856-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206083657.3202856-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 04:36:57PM +0800, ruanjinjie wrote:
> when kmalloc() fail to allocate memory in kasprintf(), fn_1 or fn_2 will
> be NULL, strcmp() will cause null pointer dereference.
> 
> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/of/overlay.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index bd8ff4df723d..49c066b51148 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -545,6 +545,11 @@ static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
>  
>  		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>  		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> +		if (!fn_1 || !fn_2) {
> +			kfree(fn_1);
> +			kfree(fn_2);
> +			return -ENOMEM;
> +		}
>  		node_path_match = !strcmp(fn_1, fn_2);

We don't actually care what the return code is, so just change this to:

node_path_match = !fn_1 || !fn_2 || !strcmp(fn_1, fn_2);

>  		kfree(fn_1);
>  		kfree(fn_2);
> @@ -580,6 +585,11 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
>  
>  		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>  		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> +		if (!fn_1 || !fn_2) {
> +			kfree(fn_1);
> +			kfree(fn_2);
> +			return -ENOMEM;
> +		}
>  		node_path_match = !strcmp(fn_1, fn_2);
>  		kfree(fn_1);
>  		kfree(fn_2);
> -- 
> 2.25.1
> 
> 
