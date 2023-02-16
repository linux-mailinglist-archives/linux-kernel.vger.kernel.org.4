Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C69699A68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBPQoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBPQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:44:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADCB4ECCA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:44:06 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id y186so1645052pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lHEKGS4iAA2QjgfeM820tUu9WLfVn1gYRbv1+5aM4M=;
        b=lfgL8akf+l1IdK7B0oyQVNXkjGVpQ1U6iWgYVHJ5I2CbIR/dCbXqNMUFpsAG+el8oM
         f4j7ODaCfEDTlgno5HpMaLafyw5RPYHq17+/sHX+W5mNbyHMnAlG86Qx6edhXLp9uCw7
         9JFG/jjuWQKRzjuAylIoyUxHfnH3uRfbDyMz/0lI2lFPBVgEe+psJsDUp4xtlwHd48x2
         bwFqOid7zZvmR1gxgodJPuDe2QOaQ7nd99wBvS89oUrRTCtbaP4O0NPwKQUubYA8QEfE
         bzMI/+b9RCrcSg1yb7ZZXKEZdbBxivAlLjlIdWgOy+G4IeKljDsG3hzLlX5GzO9o3ANw
         2Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lHEKGS4iAA2QjgfeM820tUu9WLfVn1gYRbv1+5aM4M=;
        b=TzLwzsolIT1mxvDafAMmYlmuVljg+t65WxF8JSYb+qYK6eR+7o7Q4/z4A3o3F3VB0a
         KsrW0WzNCcstbI35Dy7/5m+JaMD8bn6T2xURIzVOwlsNCC/xQi05XbGfObPdA+n4dnLS
         /c73DLTjdUK1mJ2AJvYbayAMp8u6wRaqon6pROTM702yr76bR4O+Kb1XmbOk9dRHMhLx
         S+bnb6ua+KYzlU2vCAByu29MwUiDxj0Tv4Z16H0UEDAXCGrcTrHAezvg2TeIFSWf7d4J
         qlkI2REPUNXxlkW5YQ47vLGUc83xCVqZ3uNBWykaTYWRClAZSLAbQRPAfgj2+yq/VU+g
         Tjbg==
X-Gm-Message-State: AO0yUKXPTx1sVxoqlB1EwvUTWUGAQV0BAGP98OMaX6f0E98KGg1BXnkB
        wLe9AAFtXZqrZsPvNKvxkm44sVO69Z1ogDWEtK8BOQ==
X-Google-Smtp-Source: AK7set9juCzR2gBDo9sZT2TLPvY3/0nr5aw3pAHAYvA83KCk1K/596XCybO9frGI5Wk0y6bL8g7uuJnPs9/OO+nhlCE=
X-Received: by 2002:a63:360c:0:b0:4fb:c9e6:87ed with SMTP id
 d12-20020a63360c000000b004fbc9e687edmr934345pga.3.1676565845697; Thu, 16 Feb
 2023 08:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20230216124120.26578-1-bp@alien8.de> <20230216124120.26578-4-bp@alien8.de>
In-Reply-To: <20230216124120.26578-4-bp@alien8.de>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 16 Feb 2023 08:43:54 -0800
Message-ID: <CAAH4kHaMCP0-=D1-QnsXa7wAtt22ZdTJD999hphKTpEQuM18aA@mail.gmail.com>
Subject: Re: [PATCH 03/11] virt/coco/sev-guest: Simplify extended guest
 request handling
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

>         if (ghcb->save.sw_exit_info_2) {
>                 /* Number of expected pages are returned in RBX */
>                 if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> -                   ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
> +                   ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN) {
>                         input->data_npages = ghcb_get_rbx(ghcb);
> +                       ret = -ENOSPC;
> +               } else {
> +                       ret = -EIO;
> +               }
>
>                 *fw_err = ghcb->save.sw_exit_info_2;
> -
> -               ret = -EIO;
>         }

I think *fw_err still needs to be hoisted out of this if block so that
a 0 fw_err gets written back to user space rather than the 0xff
placeholder. The 0 would more correctly indicate the lack of an error.


-- 
-Dionna Glaze, PhD (she/her)
