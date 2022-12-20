Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E56529E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiLTXb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiLTXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:31:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060741FF8F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:31:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so383699pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNvwx1f2Fh9J2I3ow+8tnVvZQ5g3r2kgzwtdsL7kVXU=;
        b=oWguqbs4iid3zUKQbiLJ8Pywmc14jtVoWF+gl/hsbMUrxll/0vAhbU7/XcJo4y1XFr
         3YaGiddbcxU9ha/qQDrQymW9M461agfVdQFv0sKy86Z/X8AWCI/ut/XnkdNyce2mirg/
         s3I9gvTQMuS4Ksat8ZW4edrFpu8ADFEyvYHoUFzLIiiyheCXkb7/nz2+QB+vjTo4cJTc
         C/uhH9B8TfAFznkvg27CgaUj0JzDhfMGkF9yPcSqYGm7ugypHmdKxTg3rwCEvAHZYRGO
         2ZLHg8poJlUUrVKsJW2kaSKSgDeT0M2fKm4oRhn2yoWrjaqSIVCHE1wqGRJMvBxTV8sU
         MCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNvwx1f2Fh9J2I3ow+8tnVvZQ5g3r2kgzwtdsL7kVXU=;
        b=7sTyDbuyHP4j5Jmf0cI80FJQekzNzKz4xZXA2sdf7ygynzF0nCnSHI8wqrOrUy8ijh
         JXbavXP2SiO0ttNeVPOB8FvIJ2eGy6u9Vo3LmdgjuKGBvE8BCEgbZzxJfxZnDJZQ0nG3
         gqpWjjfpe0aRo40Pzp4mNGK5sA4kpiq11oG9FITDF9AkXJLG+JhFP8ts+tWM4ge1YHih
         ccua8Wyc70VFDmX8gIEtR5kB1ln7LqzIWt53mRu2grBFtxVHHnkz2zm6WrQ53zlfpNVs
         GNCQpnKEPpbufFh+YTg5bmxogrdpTFe6+491nH23kjbQOFOJ22+JmKACf9P/s+0IFIZs
         O3oQ==
X-Gm-Message-State: AFqh2kqepdEcE5fd5WZQ40HO4mK5rmhLV8N16IOG826aNdmPj+5kvYXB
        gUyeAoByXBc6VUQCKWXhAzLDXBHCB8SDX4AdFzyw
X-Google-Smtp-Source: AMrXdXvBpq9QnNE8Y4rIAjEUbNiQzoI2AuEU1LAlXJlJ3cXz5EoaZFQzreLaQrZb/OX0AgiBktAoy1GSdjW3Et+zoLw=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr2001291pjj.147.1671579114449; Tue, 20
 Dec 2022 15:31:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670606054.git.rgb@redhat.com> <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
In-Reply-To: <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Dec 2022 18:31:43 -0500
Message-ID: <CAHC9VhQont7=S9pvTpLUmxVSj-g-j2ZhVCLiUki69vtp8rf-9A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 9:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full response so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record.
>
> Currently the only type of fanotify info that is defined is an audit
> rule number, but convert it to hex encoding to future-proof the field.
> Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
>
> Sample records:
>   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
>   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.c |  3 ++-
>  include/linux/audit.h         |  9 +++++----
>  kernel/auditsc.c              | 25 ++++++++++++++++++++++---
>  3 files changed, 29 insertions(+), 8 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1fb821de104..8d523066d81f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -64,6 +64,7 @@
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
>  #include <uapi/linux/openat2.h> // struct open_how
> +#include <uapi/linux/fanotify.h>
>
>  #include "audit.h"
>
> @@ -2877,10 +2878,28 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(u32 response)
> +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       struct audit_context *ctx = audit_context();
> +       struct audit_buffer *ab;
> +       char numbuf[12];
> +
> +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> +                         response, FAN_RESPONSE_INFO_NONE);

The fan_info, subj_trust, and obj_trust constant values used here are
awfully magic-numbery and not the usual sentinel values one might
expect for a "none" operation, e.g. zeros/INT_MAX/etc. I believe a
comment here explaining the values would be a good idea.

> +               return;
> +       }
> +       ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> +       if (ab) {
> +               audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> +                                response, friar->hdr.type);
> +               snprintf(numbuf, sizeof(numbuf), "%u", friar->rule_number);
> +               audit_log_n_hex(ab, numbuf, sizeof(numbuf));

It looks like the kernel's printf format string parsing supports %X so
why not just use that for now, we can always complicate it later if
needed.  It would probably also remove the need for the @ab, @numbuf,
and @ctx variables.  For example:

audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
  "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
  response, friar->hdr.type, friar->rule_number,
  friar->subj_trust, friar->obj_trust);

Am I missing something?

> +               audit_log_format(ab, " subj_trust=%u obj_trust=%u",
> +                                friar->subj_trust, friar->obj_trust);
> +               audit_log_end(ab);
> +       }
>  }
>
>  void __audit_tk_injoffset(struct timespec64 offset)
> --
> 2.27.0

-- 
paul-moore.com
