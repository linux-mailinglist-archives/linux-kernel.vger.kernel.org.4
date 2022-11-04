Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361161A395
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKDVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDVvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:51:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241448775
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:51:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b9so8206052ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pa65f3EVWPDK3gXuV13Z8E/RlAKepG37iKNQszOHXmE=;
        b=h2qRPQNW44UqK4R9ZZHoscEZ+Q0TuIGikJauUhnH+UGxwQciUD7ISzNI0aooPyfWCf
         35an79dN4wjJntjBfqkL09jZIjJ2KewCEJ62SIVIPYHvTAk6eNRvGlpkU5bolDqlmJIy
         qBgHE7viPQ+XydWKPTie2BXXEwYgGJWAlVlUBiuUDDGQ0Y0QaRgG73exB0+QOFZxieSH
         b2COEd3vbLKvNKWxufk83JznK3zku6HcwVgki32b3lUysqI516+ISxI3/hF5l9VdEmDo
         ZwNLwDpG7UdttMvZpxNtaZqq/IDDm689fGS8StZUc2f8soqQGTPqaO9r/xzwUr1kd3O9
         +tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pa65f3EVWPDK3gXuV13Z8E/RlAKepG37iKNQszOHXmE=;
        b=pO3hIsrh1aFT+UhgNDkKlsPMcVCg+ZFd8a5wdjq5JC4oGSDb3IGILAKeOaKGtaJTpk
         LWa5qL2HS9M9nZMgrfO5f/apdmKRO1xHi0iDVIzYkBht406aXmcmYzgmSPWBKiEd0ogR
         cgQEykW1kON/101DoxuOJkoJolcpkpmJhfss8l8zlB69wDCdv8Ma0owitEBPqs4gYoaM
         DL1Mm5LM+9DXs+rAXJjXGJIAlB0W9yKRCzXhzpb1qBod0VOe4CRgVYTD3QhtDi3dojH5
         CAad985xI+AufiTqB9re/xuASsPQQl7iRF/BMhtuNpWZX0hEqxKb478Kt2wVpG343fq6
         9UgA==
X-Gm-Message-State: ACrzQf26AJoUC+8JWXV2CMLHGvlt8nU1zG2VEJTrRhBgxZtYmPBshK5d
        GiGWmqXUkCbcN75aoZPutqNdUEFKoNnNLchBx/LzLg==
X-Google-Smtp-Source: AMsMyM7XS+Y1g6B10HJ3EsjrUJ7s26Qi5wzvW34TY1PD7H87fsIKYIESIsb9NDOOclLLyHdHb3FdOwzCBu+NPjGj0Uc=
X-Received: by 2002:a2e:a163:0:b0:277:159b:4da2 with SMTP id
 u3-20020a2ea163000000b00277159b4da2mr13821370ljl.502.1667598662147; Fri, 04
 Nov 2022 14:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com> <20221104201616.2268815-5-dionnaglaze@google.com>
In-Reply-To: <20221104201616.2268815-5-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 15:50:49 -0600
Message-ID: <CAMkAt6qmgOTqLOy5V4=zLuqjVusCRtGD0AeXndYO4mkAVgu1oA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] virt: sev-guest: interpret VMM errors from guest request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
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

> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 256aaeff7e65..8e4144aa78c9 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -52,8 +52,15 @@ struct snp_guest_request_ioctl {
>         __u64 req_data;
>         __u64 resp_data;
>
> -       /* firmware error code on failure (see psp-sev.h) */
> -       __u64 fw_err;
> +       /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
> +       union {
> +               __u64 exitinfo2;
> +               __u64 fw_err; /* Name deprecated in favor of others */
> +               struct {
> +                       __u32 fw_error;
> +                       __u32 vmm_error;
> +               };
> +       };
>  };

LGTM, especially with feedback on the last path for just passing
snp_guest_request_ioctl. But thats a nit.

>
>  struct snp_ext_report_req {
> @@ -77,4 +84,11 @@ struct snp_ext_report_req {
>  /* Get SNP extended report as defined in the GHCB specification version 2. */
>  #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
>
> +/* Guest message request EXIT_INFO_2 constants */
> +#define SNP_GUEST_FW_ERR_MASK          GENMASK_ULL(31, 0)
> +#define SNP_GUEST_VMM_ERR_SHIFT                32
> +
> +#define SNP_GUEST_VMM_ERR_INVALID_LEN  1
> +#define SNP_GUEST_VMM_ERR_BUSY         2
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> --
> 2.38.1.431.g37b22c650d-goog
>
