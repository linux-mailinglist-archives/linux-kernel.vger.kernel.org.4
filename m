Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1257166880C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALX7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjALX7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:59:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED45D8AB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:59:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso338550pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOxGu9TF0QtV9czLWlRoi8MtO/LfBf5pI1clFeTOj3o=;
        b=sWx4RBoGeV3nGFYmL0SgAWnfFH7s/pPAka7EdFUbaGzvI+oz9UpEJ/MkQDEtTuwnN9
         ED2OZlG8Oc1Y/tAlmxByk1osBkmYbNDZFMdEVgbMyQt++/iBLJ77u1urNxwq5OA8Qe2C
         ZaPFXwFSFeUAQdG0JVNbeWX1KowNmelNcdauSM80Wz6HXNDh+eHXCIADwF/s4SBEtZsg
         NB8JEcUHOPgT6O1QpfqYNDcgT2v43qEUqY5N7+Ik5R11fF8nqgZdH87rpoLAmOLaJgVJ
         Nd/bapu4YRQuYRTFv9grs7qrkxl9l4oxvL0f+tLxHwetZL0cliCw/l+jxF5dUthWAxKr
         Sc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOxGu9TF0QtV9czLWlRoi8MtO/LfBf5pI1clFeTOj3o=;
        b=c8GYA1nwC25tbCc63JHEVowVWFxHpElasaHmvjzmUuXo/z4jHCcWLSDib7WRXdteOc
         CRhOPmoEb68/uBpUImrN9UzHVQQ9WAzj2s3ssD7RQn0PZ9LDfpqklPFNL5F9zT6zj2Z7
         iTtgorTxFFoBmCAJ8PSJJYvtu3m+EFmhX6WGeyYeAq329d6jj+Rt3Ig5NGjEafLpXXhZ
         LoN+TAKtVthLx7BQbZOyH1K2fw/ja4qthTD/4yVgQZEcgePUNGKu/kQwPHa907iFQwHe
         kWsKizIiChSplOJcthKZqsBXMnmKxQ7TTAa+tL1O2eNB69vsFbM39SZ8FIMLIA23N+id
         gydQ==
X-Gm-Message-State: AFqh2kprAMVYY0yt6W8xSzEJFSpESk3AWsLuIpTDnonNMmlTOLqjDdC+
        9EYoadkZSO86sNH0pcIRffkgyw==
X-Google-Smtp-Source: AMrXdXtscQ7xEgomCamqZcZazKq6mWA71lXLjuymhU8awjVGmi4jnbBHrzR/XzGQnLoGXa4o7sltYw==
X-Received: by 2002:a05:6a20:4284:b0:9d:b8e6:d8e5 with SMTP id o4-20020a056a20428400b0009db8e6d8e5mr1410949pzj.2.1673567978825;
        Thu, 12 Jan 2023 15:59:38 -0800 (PST)
Received: from [2620:15c:29:203:1f3b:d48c:199c:9f57] ([2620:15c:29:203:1f3b:d48c:199c:9f57])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a8d8400b001fd6066284dsm11340564pjo.6.2023.01.12.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:59:38 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:59:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] crypto: ccp: Sanitize sev_platform_init() error
 messages
In-Reply-To: <20230110191201.29666-1-jarkko@profian.com>
Message-ID: <1a78beb1-bd63-ca70-6b05-bff45de842e5@google.com>
References: <20230110191201.29666-1-jarkko@profian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Jarkko Sakkinen wrote:

> The following functions end up calling sev_platform_init() or
> __sev_platform_init_locked():
> 
> * sev_guest_init()
> * sev_ioctl_do_pek_csr
> * sev_ioctl_do_pdh_export()
> * sev_ioctl_do_pek_import()
> * sev_ioctl_do_pek_pdh_gen()
> * sev_pci_init()
> 
> However, only sev_pci_init() prints out the failed command error code, and
> even there, the error message does not specify which SEV command failed.
> 
> Address this by printing out the SEV command errors inside
> __sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
> INIT_EX commands.  As a side-effect, @error can be removed from the
> parameter list.
> 
> This extra information is particularly useful if firmware loading and/or
> initialization is going to be made more robust, e.g. by allowing firmware
> loading to be postponed.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>

Acked-by: David Rientjes <rientjes@google.com>
