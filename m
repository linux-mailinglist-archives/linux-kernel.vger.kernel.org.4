Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11E66AF6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCGU2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCGU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:28:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C143C32
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:27:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s17so8365307pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678220874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chEH0KNzrBuloEROXjZiSoXhQsMFVM7sy6f+QKt1R+M=;
        b=Cxx2e5Om+/JU6xnjHrLu/LLpcHm4CrHFFpL/hkI/hIygvlFl3O282SQeTSM9DKxd67
         tFUXnskfDcHZa3llmZ8srtrvCWgqt7ei2BgBxf6B94eqw2e3QG+VkA74CGShJr9mAMQB
         xQU5e6/s1iiQuPUiFMX9lTakxHUPHl1FuY3ieNs/V+6Rcj83ATP7L/GVsTNaGTQiTnaG
         PLquYfnfv/Hkz5CC0SSCVyJFhSD0ha2z64wkpDnzoV3oWrm3LrPEFjH0e8BuXOneOBLI
         TkysZVIdzjNAaAz2qlnc1ahbgabERONj+zhSAV2u+3ifVbhPYUXu6kLs6toM80728i4V
         3S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678220874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chEH0KNzrBuloEROXjZiSoXhQsMFVM7sy6f+QKt1R+M=;
        b=Ebpr48RiczJG4tiML9mahsGEehHc4/r5K3fYGjxlSARFM1obMAji3E7xNl3Uermx14
         M55MCsY/WK9RPNOvZF/AlD9Rg7bhuCKXlYOz0cdjWxbjfbQ52E4GIBL5sn0C3j+Kq1kE
         mun77yImzDpIbeoA5n0l0g6gq+/0MOw/w9/KV7chfYsKiRAg/RfovJ0O1NQ8gqfh/aCx
         GjOxZeEHuqzoMTkU6r+GMJFKAd4peLkwRb3tjqeCpVr1QCJ7kt1mhGhU5Ewx6T7FNpjD
         3ozuY9/JvVfl+6fQxvNiDHMsZcKl/vny+EufXGIZNnUqUcmkPEAdfjFgnPhJ/Mlvg2/I
         Oc3Q==
X-Gm-Message-State: AO0yUKXERUii8pGErxDPdRxB8oVF5Rl3vXeUOhEqhltiV3Ji7/VMoBOT
        o6euNXBo2uZ4DHyhcURfl7sPnfOiUPW8x3pG9nz7gDWmKvwGMuboato=
X-Google-Smtp-Source: AK7set+9pDs0ZFsuVXAGl6BXAyTVyDFGxn4N+j3GphqyC9WCb47N2cOGoWCjaCLDbR8bCBL0/Uf4b45+2yV46m3aEfE=
X-Received: by 2002:a63:9319:0:b0:503:7bdf:df4b with SMTP id
 b25-20020a639319000000b005037bdfdf4bmr5783096pge.3.1678220874310; Tue, 07 Mar
 2023 12:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20230307192449.24732-1-bp@alien8.de> <20230307192449.24732-10-bp@alien8.de>
In-Reply-To: <20230307192449.24732-10-bp@alien8.de>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 7 Mar 2023 12:27:42 -0800
Message-ID: <CAAH4kHbaiBOxJZbZv+fvnstGknugjvhR5uWKK8aBXM2rDBGdRQ@mail.gmail.com>
Subject: Re: [PATCH -v3 09/11] virt/coco/sev-guest: Add throttling awareness
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -320,7 +323,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>
>  static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
>  {
> -       unsigned long err, override_err = 0;
> +       unsigned long err = 0xff, override_err = 0;
> +       unsigned long req_start = jiffies;
>         unsigned int override_npages = 0;
>         int rc;
>

Not blocking, but I do think in the previous version we discussed
changing this to the SEV_RET_NO_FW_CALL value instead of 0xff. I agree
that should be a later cleanup.

--
-Dionna Glaze, PhD (she/her)
