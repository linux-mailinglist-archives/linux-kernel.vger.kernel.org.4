Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804145E7155
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIWBTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiIWBSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:18:48 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A32116C04
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:18:46 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1279948d93dso16344856fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wauY9icRcEzEDbhLIuBAjc38+zIZU9tq0CBry9g6Ooc=;
        b=slE4TJt9/dXDYfy+rMRKeN5k8cMVUfrps+7LGvGQhlqHE6ERCjN/lfbKJ4KjF9nXeo
         6AJfMTUFZk/R3ITkRAB/Iu6XNtGdRXBPvSyxmSSN46t4/ltDu6V8cBEYShJL5X92F18m
         G47uf8YuxIn+QgNPctzUMP3X6nCwc3O2N7GYJfAX+lJn8dMhfM1Fs9wWxlcxmEFakRjg
         FhXSZXSyWPYguhFhFLJaTPt3Tkf8N/sWD6l6MqxIPratLG/PZSTYa5OdrMZZxjtYgoFG
         Yr38vg6UpQ7rqJipbno3wA0356WdNtTAe8GeHQaSCsCsZefmQgqMzuM5E1DiycXT6Um/
         qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wauY9icRcEzEDbhLIuBAjc38+zIZU9tq0CBry9g6Ooc=;
        b=ee5eWc2kpb2tSsegWjk/icm3RLFthIIscbvjun4VHIcnwAA6JAn2qgASDrZvjxRLP4
         zjFQhZaDPSp+gsFjDGsQkBGi0oGGRxYBps3RbqRYrNiUSVIsZm1V0nspc4ZwpQIsU+8e
         6BbSq6rKE0IJjWdWOZBdz9U7PECcoo1iaTXtnvbxcK3Bc18QRczp4j0sOcHsHzQHlN/2
         SgqrQcU06lfDC3e3/14y9Pqxo/PnU3At54uqDgWx5s3YnzrA3fUvQwclm7wqw3BX3FWb
         31C4IsQ2jOKhZIlGenpXOhuixzQ15uImHAVr/FXSD0zmsOZyLlxYlInr14RWOy++yKag
         RUXw==
X-Gm-Message-State: ACrzQf0Qp0adBVEnD10/1Vg8dzuTvMrkgrkOlB6htRXFt77P/BXxrgA+
        U3mnPgZ5OJ4i3JO3ohhWHQGpzhSxsf/WkwsXgRoe
X-Google-Smtp-Source: AMsMyM7nqnRFdhUa3AKhiMDrdqfkMkNMtS+CAPxM0mIQs/OrjYyKafG9iMOvWz5ktyQ7ZfkZNj8lp2r17TUOYM734bw=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr3740124oaa.172.1663895925469; Thu, 22
 Sep 2022 18:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220922193817.106041-1-nathanl@linux.ibm.com> <20220922193817.106041-2-nathanl@linux.ibm.com>
In-Reply-To: <20220922193817.106041-2-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 21:18:34 -0400
Message-ID: <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/pseries: block untrusted device tree changes
 when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The /proc/powerpc/ofdt interface allows the root user to freely alter
> the in-kernel device tree, enabling arbitrary physical address writes
> via drivers that could bind to malicious device nodes, thus making it
> possible to disable lockdown.
>
> Historically this interface has been used on the pseries platform to
> facilitate the runtime addition and removal of processor, memory, and
> device resources (aka Dynamic Logical Partitioning or DLPAR). Years
> ago, the processor and memory use cases were migrated to designs that
> happen to be lockdown-friendly: device tree updates are communicated
> directly to the kernel from firmware without passing through untrusted
> user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
> remains the sole legitimate user of /proc/powerpc/ofdt, but it is
> already broken in lockdown since it uses /dev/mem to allocate argument
> buffers for the rtas syscall. So only illegitimate uses of the
> interface should see a behavior change when running on a locked down
> kernel.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
>  include/linux/security.h                  | 1 +
>  security/security.c                       | 1 +
>  3 files changed, 7 insertions(+)

A couple of small nits below, but in general this seems reasonable.
However, as we are currently at -rc6 I would like us to wait to merge
this until after the upcoming merge window closes (I don't like
merging new functionality into -next at -rc6).

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README.md

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..1ca8dbacd3cc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -122,6 +122,7 @@ enum lockdown_reason {
>         LOCKDOWN_XMON_WR,
>         LOCKDOWN_BPF_WRITE_USER,
>         LOCKDOWN_DBG_WRITE_KERNEL,
> +       LOCKDOWN_DEVICE_TREE,

I would suggest moving LOCKDOWN_DEVICE_TREE to be next to
LOCKDOWN_ACPI_TABLES.  It's not a hard requirement, but it seems like
a nice idea to group similar things when we can.

>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_KCORE,
>         LOCKDOWN_KPROBES,
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..2863fc31eec6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -60,6 +60,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_XMON_WR] = "xmon write access",
>         [LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
>         [LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
> +       [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",

Might as well move this one too.

>         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
>         [LOCKDOWN_KCORE] = "/proc/kcore access",
>         [LOCKDOWN_KPROBES] = "use of kprobes",
> --
> 2.37.3

-- 
paul-moore.com
