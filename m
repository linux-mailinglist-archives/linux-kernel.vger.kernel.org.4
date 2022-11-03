Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F36182B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKCP0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiKCP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:26:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C922C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:26:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g12so3429517lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BY5DlnsfoABFbnnT81rilsRCXBmtf9PtWjig5RggbE=;
        b=M7nGiTqL926h/Ktu8OtWtVTXpJKPnauTw61CX04DN3Hk7Ss0Bp551cMO6RkDoo7rt+
         6TibphBd25K77+q3h9/8C4NaZqLoFDqXDeyE3XRSuETE7/4M/xYWAyH6/5Kd74v+612U
         n9c3idSlWQfLSY50tVaYomcS7oJBX7oKle0U9unBSu8CpameiDJ90mEwqJ39msySonyu
         TpO/id/OpTwSXVCsVG8ZJHrwDLY8PGvNMQEN85MIhxDkHfNJ72CkVzmJnNk/4KZgRmmq
         ooinN6rKLj4Bxf0naw8AqmDU0Bs3TwvfeqBr2ILPQApin5V2oTjjSYhHUiW3Co8fF7+v
         TQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BY5DlnsfoABFbnnT81rilsRCXBmtf9PtWjig5RggbE=;
        b=S7COo2H9EYQ3u+4BwKvOxDx2S2P4rIuVckfO3Xlo4nz4KMwBP7iFl9iuHNPqvvIe+s
         mqnj1E+O2gAgLCEvvcCOS8v/JBe4Ls6zesz95qe1peam5/ZDfz7rKxULqKhRAaF52YTo
         GoTcjeVsqf8MnGjuN5Uvl5nMXROmkDDC0NGFzc+F3FPcTBJzjD2m+Q5puMBg1d0KHFRF
         JV84RYsTLTyJvRxci/8otjejKoQ4k++6Jf50H0kEHRPdBoAIA8DvNwfcLWDbBiJSU5k5
         mKTBsnijKT9SXI60WqPMVPwooM+OtEp1tqnsBegFxi8ReIIzjGt8UK1YM8Tcw/e9rDOu
         t9zA==
X-Gm-Message-State: ACrzQf0WQ6wL7IFmps6OK43Ul1ES5nd4CHtyAX71FlT3f2bfqLQGhhLy
        beZs7RO685ghPdn5ofOd3weztU1JpXnXN0BWRaY97Q==
X-Google-Smtp-Source: AMsMyM5OO+W/JZcPKaiMpUFr3K8yO1nPpxMY9y/oXY5m224klhfDtpBTBRLZTnBBDjg+6zFjYOo/5Vz57ZC4ptlFeQg=
X-Received: by 2002:a05:6512:138d:b0:4ae:5116:8ddb with SMTP id
 p13-20020a056512138d00b004ae51168ddbmr12581568lfa.558.1667489178099; Thu, 03
 Nov 2022 08:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com>
In-Reply-To: <20221102151836.1310509-1-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 3 Nov 2022 09:26:06 -0600
Message-ID: <CAMkAt6pRVnx3vHkeBeJuf5kHgTF+c3Ydir+r9MRCPMAXic5eog@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add throttling detection to sev-guest
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Wed, Nov 2, 2022 at 9:18 AM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The guest request synchronous API from SEV-SNP VMs to the host's security
> processor consumes a global resource. For this reason, AMD's docs
> recommend that the host implements a throttling mechanism. In order for
> the guest to know it's been throttled and should try its request again,
> we need some good-faith communication from the host that the request
> has been throttled.
>
> These patches work with the existing /dev/sev-guest ABI to detect a
> throttling code.
>
> Changes from v4:
>   * Clarified comment on SEV_RET_NO_FW_CALL
>   * Changed ratelimit loop to use sleep_timeout_interruptible
> Changes from v3:
>   * sev-guest ratelimits itself to one request twice a second.
>   * Fixed a type signature to use u64 instead of unsigned int
>   * Set *exitinfo2 unconditionally after the ghcb_hv_call.
> Changes from v2:
>   * Codified the non-firmware-call firmware error code as (u32)-1.
>   * Changed sev_issue_guest_request unsigned long *fw_err argument to
>     u64 *exitinfo2 to more accurately and type-safely describe the
>     value that it outputs.
>   * Changed sev_issue_guest_request to always set its exitinfo2
>     argument to either the non-firmware-call error code, the
>     EXIT_INFO_2 returned from the VMM if the request failed, or 0 on
>     success. This fixes a bug that returned uninitialized kernel stack
>     memory to the user when there is no error.
>   * Changed the throttle behavior to retry in the driver instead of
>     returning -EAGAIN, due to possible message sequence number reuse
>     on different message contents.
>
> Changes from v1:
>   * Changed throttle error code to 2
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Should this change be rebased on top of the 'virt: sev: Prevent IV
reuse in SNP guest driver'?
https://lore.kernel.org/lkml/20221103152318.88354-1-pgonda@google.com/

Since that change is a security fix?
