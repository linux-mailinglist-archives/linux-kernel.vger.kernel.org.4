Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F86787A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAWUYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjAWUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:24:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189792684
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:24:30 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F23E1EC067E;
        Mon, 23 Jan 2023 21:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674505467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U/QO3131od64ZCwBRO2JYIkPCBf039IF+tyw8XVxKdM=;
        b=qdqefipmnbcTGyvLutbxZjr0qG87cKyoDGCTMT+ASSPbq8UiUc9+yPK3O12czjiuxSEWaU
        9+SS6b+xXpKnUtOzEJxMujWj8aul7m7+M3IHRPzt1TfH55XQOSMqkbbCs4ZHPm85DQXsTE
        2Tj2OXSbR1r8n69s6uTtYqF4n0YgDr8=
Date:   Mon, 23 Jan 2023 21:24:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v12 2/3] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y87s95WNc0QLZ7fn@zn.tnic>
References: <20230120214857.835931-1-dionnaglaze@google.com>
 <20230120214857.835931-3-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120214857.835931-3-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:48:55PM +0000, Dionna Glaze wrote:
> Since the "fw_err" field is really exitinfo2 split into the upper bits'
> vmm error code and lower bits' firmware error code, sev-guest.h is
> updated to represent the 64 bit value as a union.

Yah, documentation needs update too:

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 4f0dcc1d16e8..4f9df24b829f 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -57,9 +57,16 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 __u64 req_data;
                 __u64 resp_data;
 
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
-        };
+                /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+                union {
+                        __u64 exitinfo2;
+                        struct {
+                                __u32 fw_error;
+                                __u32 vmm_error;
+                        };
+                };
+	};
+
 
 2.1 SNP_GET_REPORT
 ------------------

/me goes and looks at patch 3...

Yap, that change adding the union should all belong together in a single patch.

> @@ -366,24 +367,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>  		 * of the VMPCK and the error code being propagated back to the
>  		 * user as an ioctl() return code.
>  		 */
> -		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
> +					     &arg->exitinfo2);
>  
>  		/*
>  		 * Override the error to inform callers the given extended
>  		 * request buffer size was too small and give the caller the
>  		 * required buffer size.
>  		 */
> -		err = SNP_GUEST_REQ_INVALID_LEN;
> +		arg->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
>  		snp_dev->input.data_npages = certs_npages;
>  	}
>  
> -	if (fw_err)
> -		*fw_err = err;
> -
>  	if (rc) {
>  		dev_alert(snp_dev->dev,
> -			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> -			  rc, *fw_err);
> +			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
> +			  rc, arg->exitinfo2);

I guess that's better off dumped in binary now:

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d4973d2dbc24..a5d6ea3eebe9 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -380,7 +380,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			  "Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
 			  rc, arg->exitinfo2);
 		goto disable_vmpck;
 	}

Anyway, that's a lot of changes for a fix which needs to go to stable. I don't
mind them but not in a minimal fix.

So how is this for a minimal fix to go in now, ontop of your first patch? The
cleanups can then go later...

---
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..20b560a45bc1 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -322,7 +322,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err = SEV_RET_NO_FW_CALL;
 	u64 seqno;
 	int rc;
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
