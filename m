Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F345E88A6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiIXGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:01:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94411E11D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 23:01:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v4so2046512pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=frtRJO9aYCNdmGoP3UvlNSZ/JjwEc5weswdq+XzluEM=;
        b=EkYsLXgVhlax+Y7RIe87hesf6zrDCoj91bVE89Vr49KRen4ED+B0kqBuiVtV/N2V53
         rzN1qH1DBJOJVU1n6DmTtv/iKftufggXj85BP/NJHw3E3l1EUdbqDjgIxxpDJ8n05Oup
         fm9mqJHPRJzoqKlwYvB6u0EY72TREpeeVIs+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=frtRJO9aYCNdmGoP3UvlNSZ/JjwEc5weswdq+XzluEM=;
        b=PntfbnDmA9Ts1Kuf83hD5hwqbhvKQ1EmHH9OX/eTYGw3uqLAmjIIZA87D9FmRbvFY6
         ZL5QeDCZUZLgcB6gKND6DoGmlIMPpeYymOUs6wGBEByQzJDqqIwW7lF+6BkhTyZaI7Mp
         7ivp9g5Y1ahgCQxfvLdAkZ5T5xTnI0YelymEaZHXJmGQOB6DjaE4bApx/rR9MqdgW3ml
         q7U0L0kg/Me8nTJwIhRfccNoMIRhqp46ic4F0+8CLo4boz65cSUvqqyOWslsa5ElVdfW
         2GI+NQRcuWNFtnqWDjd0i+cF0NdH7mcvlQPiEbx2tmqj9WQ9mQL6n/3DQltpkGM4BX4d
         Qhlw==
X-Gm-Message-State: ACrzQf0sEZhvwKBD8TPZaANJCCuxTcdOeD3bHZf91RjpVyaWKT5h8V1j
        kTO9HI4XmVac1iVqbRcttbwdDA==
X-Google-Smtp-Source: AMsMyM7Iur1TwmY1pIh1BeWHPMeCtSQWW+RntK8sDmsWsEVr03e2wF5I3VilxEd1HsrZKIzyVSMEmg==
X-Received: by 2002:a63:e417:0:b0:43c:2fc6:d60c with SMTP id a23-20020a63e417000000b0043c2fc6d60cmr7643869pgi.436.1663999308097;
        Fri, 23 Sep 2022 23:01:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902904c00b00170d34cf7f3sm6795390plz.257.2022.09.23.23.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 23:01:47 -0700 (PDT)
Date:   Fri, 23 Sep 2022 23:01:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: hptiop: Replace one-element array with
 flexible-array member
Message-ID: <202209232240.747B2B5FCC@keescook>
References: <cover.1663865333.git.gustavoars@kernel.org>
 <6238ccf37798e36d783f5ce5e483e6837e98be79.1663865333.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6238ccf37798e36d783f5ce5e483e6837e98be79.1663865333.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:53:23AM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct hpt_iop_request_scsi_command and refactor the rest of the
> code, accordingly.
> 
> The following pieces of code suggest that the one element of array sg_list
> in struct hpt_iop_request_scsi_command is not taken into account when
> calculating the total size for both struct hpt_iop_request_scsi_command
> and the maximum number of elements sg_list will contain:
> 
> 1047         req->header.size = cpu_to_le32(
> 1048                                 sizeof(struct hpt_iop_request_scsi_command)
> 1049                                  - sizeof(struct hpt_iopsg)
> 1050                                  + sg_count * sizeof(struct hpt_iopsg));
> 
> 1400         req_size = sizeof(struct hpt_iop_request_scsi_command)                            1401                 + sizeof(struct hpt_iopsg) * (hba->max_sg_descriptors - 1);

Accidentally merge line above ("1401" should start a new line).

> So it's safe to replace the one-element array with a flexible-array
> member and update the code above, accordingly: now we don't need to
> subtract sizeof(struct hpt_iopsg) from sizeof(struct hpt_iop_request_scsi_command)
> because this is implicitly done by the flex-array transformation.

The only binary output change I see is from the line numbers changing
from the patch, as the argument to __might_sleep() is adjusted:

...
│       call   d1 <hptiop_reset+0x74>
│   R_X86_64_PLT32      __x86_indirect_thunk_rax-0x4
│ -     mov    $0x434,%esi
│ +     mov    $0x433,%esi
│       mov    $0x0,%rdi
│   R_X86_64_32S        .rodata.str1.1
│       call   e2 <hptiop_reset+0x85>
│   R_X86_64_PLT32      __might_sleep-0x4
...

So this looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
