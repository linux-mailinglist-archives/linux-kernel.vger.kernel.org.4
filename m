Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1556DC9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDJRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjDJRPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:15:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD02125
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:15:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e11so7146099lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681146899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=refaldnRWRXVIagG/kiigNl9L5Qr3WA3N3K9r8I7Qew=;
        b=JOZZ6sGNZEcvep9VW/UfBqlheOsM2lwaD1CRX84UkeMSuPvGwUo8V9Sa/5gRKPjWxp
         +P3zu1gcvh8LxeC1ZsHRAOj7Kq/NJc5G8LEaOWUEpFwVmsjnY4+3XeP2E4PJfkALkoye
         N0ap6HA6TqC7ctfeVy+dKZcnCNwqhfMvYCBswCq9gHuv2yGu04khyp/yWPEavK0k5Ij8
         aL0ZaqX5RW8Conj31bgyxq1MjipMv7Zh9ib8xO/URUeI1z0k5H/u6EiWVz/0ihf74isK
         ylkifBpl9+HwIqT00YUr+yGfyfJY4JomJmgaEspJhmJSl0+c70ZwohHaL2EPBKP9vQkM
         L8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=refaldnRWRXVIagG/kiigNl9L5Qr3WA3N3K9r8I7Qew=;
        b=IttlTw3bpgDXnhapF/hl/DpSWO0VzssfLDfuTvOa0YA/h+AJT+WZlFWHZIS/lTDGV2
         M8xSLIbZus7MGKYuPH42xIzLqsV04DPFE0j851+4PzAHzZnpb6bGrSgS0UUeZzwvhYyi
         yu+0JBaGU76M1gyhtWM1UQQW0TNIJhvNdg6SbnoFBnsgAVwmkgs64NOBu+/41Ek7zxBf
         rYslGXuPlryQzdsJc+7vOFpadGUc+tmelvYTuemrOs7z6aA3804GUHjRX9g5jGmUxDzE
         rFwAYVv5SpuuDkJt7OrhdY5m3v+mE6qWQJiY6bC6Umd7zKT2DGuH8b7dvX/cTE0GRUNo
         Rvtw==
X-Gm-Message-State: AAQBX9f+3iy/YXwlhumd6U2GXlYrbi2/qYFPxB6lmYZpnJkhLm6IT5O+
        /602w8IlwRnykQ7cP1pBp6cyl3LwAZr0AcB0MkwSV4W1+Pu1i+QtHx4OVg==
X-Google-Smtp-Source: AKy350ZraTUPzAz8G44kGeoDG5OoCpaJYxXg90vQzclY8VJumWuembahNcNf8NVNb7ofQRSk66WmQ+uukwrq3pT214I=
X-Received: by 2002:ac2:51c7:0:b0:4eb:c44:ed50 with SMTP id
 u7-20020ac251c7000000b004eb0c44ed50mr3042507lfm.9.1681146898639; Mon, 10 Apr
 2023 10:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230326144701.3039598-1-nikunj@amd.com> <20230326144701.3039598-9-nikunj@amd.com>
In-Reply-To: <20230326144701.3039598-9-nikunj@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 10 Apr 2023 11:14:47 -0600
Message-ID: <CAMkAt6rqsg6=Sx6Fqnf7KNOUB9YPMU6TUriZYZXbXQTvcoKzNw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, dionnaglaze@google.com, seanjc@google.com,
        pbonzini@redhat.com, michael.roth@amd.com, ketanch@iitk.ac.in
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>         struct ghcb ghcb_page;
> @@ -1107,7 +1111,7 @@ static void *alloc_shared_pages(size_t sz)
>         return page_address(page);
>  }
>
> -static int snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
> +static int __init snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
>  {
>         u64 gpa;
>         int ret;
> @@ -1406,6 +1410,80 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>  }
>  EXPORT_SYMBOL_GPL(snp_assign_vmpck);
>
> +static int __init snp_get_tsc_info(void)
> +{
> +       u8 buf[SNP_TSC_INFO_REQ_SZ + AUTHTAG_LEN];
> +       struct snp_tsc_info_resp tsc_resp = {0};
> +       struct snp_tsc_info_req tsc_req;
> +       struct snp_guest_req req;
> +       struct snp_guest_dev dev;
> +       int rc, resp_len;
> +
> +       /*
> +        * The intermediate response buffer is used while decrypting the
> +        * response payload. Make sure that it has enough space to cover the
> +        * authtag.
> +        */
> +       resp_len = sizeof(tsc_resp) + AUTHTAG_LEN;
> +       if (sizeof(buf) < resp_len)
> +               return -EINVAL;
> +
> +       /* Zero the tsc_info_req */
> +       memzero_explicit(&tsc_req, sizeof(tsc_req));
> +       memzero_explicit(&req, sizeof(req));

Whats the guidance on when we should use memzero_explicit() vs just
something like: `snp_tsc_info_resp tsc_resp = {0};`?

> +
> +       dev.pdata = platform_data;
> +       if (!snp_assign_vmpck(&dev, 0))
> +               return -EINVAL;
> +
> +       req.msg_version = MSG_HDR_VER;
> +       req.msg_type = SNP_MSG_TSC_INFO_REQ;
> +       req.req_buf = &tsc_req;
> +       req.req_sz = sizeof(tsc_req);
> +       req.resp_buf = buf;
> +       req.resp_sz = resp_len;
> +       req.fw_err = NULL;

Why do we not want the FW error code?

> +       req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
> +       rc = snp_send_guest_request(&dev, &req);
> +       if (rc)
> +               goto err_req;
> +
> +       memcpy(&tsc_resp, buf, sizeof(tsc_resp));
> +       pr_debug("%s: Valid response status %x scale %llx offset %llx factor %llx\n",
> +                __func__, tsc_resp.status, tsc_resp.tsc_scale, tsc_resp.tsc_offset,
> +                tsc_resp.tsc_factor);
> +
> +       guest_tsc_scale = tsc_resp.tsc_scale;
> +       guest_tsc_offset = tsc_resp.tsc_offset;
> +
> +err_req:
> +       /* The response buffer contains the sensitive data, explicitly clear it. */
> +       memzero_explicit(buf, sizeof(buf));
> +       memzero_explicit(&tsc_resp, sizeof(tsc_resp));
> +       memzero_explicit(&req, sizeof(req));
> +
> +       return rc;
> +}
> +
