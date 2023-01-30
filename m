Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0468198E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjA3Spr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjA3Spn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:45:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ECB1E5E9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:45:42 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 36so8298126pgp.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=855Ds+m2aw4MOsNx2+ct/lLQrG0zRsetWGZVBJaSfIA=;
        b=JbStCpfJ1mho61CP/GXuiYrXztnCDKQmS+Fctj+wVuR6WDfnjAQnmYjTKFYpCbeEz5
         wcJU1q1zhr24o/6NOxUo2rexWtiO7NcId5XFqHYuKYSjKJwqb4deYiXQ5CSpELxO/nmO
         d7/bPQWm3J+Wmsx6RFbtcVU3ZEYqY57ziNqjXQ+C67XH6i75jnO4j3hWuILkVbENQmzY
         0EVr+EX7eL+nN4Gn8ntp7U67ROEtyj29RFB4IyolLHIRhJNIidHL6Dwf95uOdR09veaq
         4freJROOBl/yaGME9x1/2VQtZygaHMZzJ73xoF0nXs69JTMiO/+gznb9RA+n6PGjUiWn
         NplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=855Ds+m2aw4MOsNx2+ct/lLQrG0zRsetWGZVBJaSfIA=;
        b=C+4ZKNZ6loKkAeQOB7N8pKoiVp31RLZq2e9ZhywuiyjKugi+fmn3bF05c8qUkxdRkg
         G1SKPHZM/llI/WhX4vqAfU2tflEKR4jTYim2Ol98jnDozA8TjAw8HYIhXY+g1nl0gkwa
         JjceONIAsG2IE4gM0ViYU5WdjtP6ewl6Z0ADQmnovQIVmTFGSrljSvZwxBuzl9netbGz
         qKi9DfAMKhKn6FEmjSEuZORP/TScYRp3yvkmJTRdo42/jS3OF3Kk0xqvW117Q/4SIIy4
         UH/YvS0e1P0OK+8C10AUtbxjPZuobR6opJUjxoLnq+tKsziOkjw5pTjdp57tx/dMtaAo
         Q45g==
X-Gm-Message-State: AO0yUKXysjt9DAEOcFXBQcq8PIPLd/kPwC7FfXBSrtziv9DbBvVAofyh
        2xviKKyWLp8bCHP0eYxaX0PnVyzmN8SDFcD+r29KIQ==
X-Google-Smtp-Source: AK7set9DXPKK0sk7Axi4OqGOUChH2dOymFdpXOfbmZ0vUvZ7zbEPw09Dkl5GC/Ex9p9Ek3d2Uy6Q+eX+tjKtdgrDkeg=
X-Received: by 2002:a62:8445:0:b0:593:bcc4:11ec with SMTP id
 k66-20020a628445000000b00593bcc411ecmr928676pfd.6.1675104341826; Mon, 30 Jan
 2023 10:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20230130120327.977460-1-nikunj@amd.com> <20230130120327.977460-4-nikunj@amd.com>
In-Reply-To: <20230130120327.977460-4-nikunj@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 30 Jan 2023 10:45:30 -0800
Message-ID: <CAAH4kHbJEcg9p=mXi2aQZFs1bopZgeqWKiwGWu2V4YsgmwHmmw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/11] virt: sev-guest: Add snp_guest_req structure
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, pgonda@google.com, jroedel@suse.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
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

> +static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>  {
>         unsigned long err;
>         u64 seqno;
>         int rc;
>
> +       if (!snp_dev || !req)
> +               return -ENODEV;
> +
>         /* Get message sequence and verify that its a non-zero */
>         seqno = snp_get_msg_seqno(snp_dev);
>         if (!seqno)
> @@ -261,7 +253,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>         memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>
>         /* Encrypt the userspace provided payload */
> -       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +       rc = enc_payload(snp_dev, seqno, req, vmpck_id);
>         if (rc)
>                 return rc;
>
> @@ -271,7 +263,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>          * sequence number must be incremented or the VMPCK must be deleted to
>          * prevent reuse of the IV.
>          */
> -       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +       rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>
>         /*
>          * If the extended guest request fails due to having too small of a
> @@ -279,11 +271,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>          * extended data request in order to increment the sequence number
>          * and thus avoid IV reuse.
>          */
> -       if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> +       if (req->exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
>             err == SNP_GUEST_REQ_INVALID_LEN) {
>                 const unsigned int certs_npages = snp_dev->input.data_npages;
>
> -               exit_code = SVM_VMGEXIT_GUEST_REQUEST;
> +               req->exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>
>                 /*
>                  * If this call to the firmware succeeds, the sequence number can
> @@ -293,7 +285,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>                  * of the VMPCK and the error code being propagated back to the
>                  * user as an ioctl() return code.
>                  */
> -               rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +               rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>

This is going to have a merge conflict with "[PATCH v13 1/4]
virt/coco/sev-guest: Add throttling awareness", which is an important
fix to ensure hosts are allowed to throttle guest requests and guests
are able to retry instead of disabling the vmpck. I think that set of
patches, or at least the first patch, is going to be going in before
this series. Please be aware.

-- 
-Dionna Glaze, PhD (she/her)
