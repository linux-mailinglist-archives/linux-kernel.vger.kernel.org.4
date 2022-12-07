Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7ED6450AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGBCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:02:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29754EC1E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:02:20 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o18-20020a17090aac1200b00219ca917708so7254692pjq.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMPVlgS6pxpUcA8VfsiIl4y+WqNXbQ8tMsHTw45HE5M=;
        b=jIJi1SrPO4NwswTp8ZLHA7dBiWHzZ4KDFjaZmeJD8k4jldzLl+btAcOTtDLvzNF8m3
         fd0Qvy/9R0IaY/gSqAS9UI/PUQJkF3gk7lUDUgnM5DmucgV50sLwKbsjglVh2ln8ggcx
         HboxZghEWujvk0PP+61UwVagxk3lRVa+eJzo9hVKVWLfWaZqFxk8kcFw+WHPd9KR33XT
         hz3jIxFRB7IbyC35113dJTh0M1/naMdVWyePMODppx90CqZCtdRPICH43l95O+xotzzJ
         QZdQjQ8ZCnnHOb/Js52UEY5iTqD8wIAyktu3qDNl6ZL1SHHda9fNVl/T9EguKtahxngv
         w2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMPVlgS6pxpUcA8VfsiIl4y+WqNXbQ8tMsHTw45HE5M=;
        b=V5Hyn1weBfd3cXbVjyH+FUU3L98Z9xkFBXECvrtmIdhUvuUTDkDYaE/BhvjpcZ5b3T
         V09slC3BxOKgTFY0wsUC/JyzjHBGSjwhToBxRojDBlqVzGgSg0C30JEL5L3aqmOZb2qG
         QoZ2Wln8PciwUbJBeaRROv/UiAs6OOFQzRk0bAZjeG2OmOGtw7g4XtkRLvP3ppdnVsXL
         msezf2qaoL0bbl2FxKJjohamT2jgVmIN/6SwMMNF796lX+qYTA4KRkxINFMvbWMlev18
         DSCzp4fvXJSLWL9tvko6WwFAIxMatzY7/bCiEK1j22p4MWO+v+YFk9b5hJFAriPPeHmX
         CGqA==
X-Gm-Message-State: ANoB5plgqA3Hgh97ux/XzoOPxYd0dc7twGCuDi0k9pNPaAtJw5V+pw2v
        fKHp5UJrrmbR8NsfCvNYpggPgMl5n0atUyj9V/JOaiIHCswu0yDGl8f1BdwYZfX7g9RnUunkthI
        aAldgRjv63EIoFNWa2ojajDet576bmXetTUIIGXS1mcUnjCn1H8MKtACmp0rF2DJ+IlgiqcR7Q6
        MmnrWVeVY=
X-Google-Smtp-Source: AA0mqf493bvVRsnknvS/YnaKOWmNWZAMmrqTmsY+gcvWsu3GB4COSqdka2Z7aPpZkrNlRP2GHKVWJZoLeQr7QXMGOQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:2396:b0:572:698b:5fa9 with
 SMTP id f22-20020a056a00239600b00572698b5fa9mr70619809pfc.28.1670374940234;
 Tue, 06 Dec 2022 17:02:20 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:02:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207010210.2563293-1-dionnaglaze@google.com>
Subject: [PATCH v9 0/4] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest request synchronous API from SEV-SNP VMs to the host's security
processor consumes a global resource. For this reason, AMD's docs
recommend that the host implements a throttling mechanism. In order for
the guest to know it's been throttled and should try its request again,
we need some good-faith communication from the host that the request
has been throttled.

These patches work with the existing /dev/sev-guest ABI to detect a
throttling code.

Changes from v8:
  * Added documentation changes.
  * Changed commit messages to use passive voice.
  * Simplified control flow for __sev_platform_init_locked.
Changes from v7:
  * Replaced handle_guest_request arguments msg_ver and fw_err with a
    pointer to the snp_guest_request_ioctl argument struct.
Changes from v6:
  * Rebased on the IV reuse fix patch
  * renamed rate_hz to rate_s and fixed its MODULE_PARM_DESC to use the
    correct variable name.
  * Changed sleep_timeout_interrutible (not defined) to
    schedule_timeout_interruptible.
Changes from v5:
  * Fixed commit prefix text
  * Added all get_maintainers.pl folks to commits' Cc tags
  * Changed SET_RET_NO_FW_CALL commit's metadata to show pgonda signs
    off and is the author.
Changes from v4:
  * Clarified comment on SEV_RET_NO_FW_CALL
  * Changed ratelimit loop to use sleep_timeout_interruptible
Changes from v3:
  * sev-guest ratelimits itself to one request twice a second.
  * Fixed a type signature to use u64 instead of unsigned int
  * Set *exitinfo2 unconditionally after the ghcb_hv_call.
Changes from v2:
  * Codified the non-firmware-call firmware error code as (u32)-1.
  * Changed sev_issue_guest_request unsigned long *fw_err argument to
    u64 *exitinfo2 to more accurately and type-safely describe the
    value that it outputs.
  * Changed sev_issue_guest_request to always set its exitinfo2
    argument to either the non-firmware-call error code, the
    EXIT_INFO_2 returned from the VMM if the request failed, or 0 on
    success. This fixes a bug that returned uninitialized kernel stack
    memory to the user when there is no error.
  * Changed the throttle behavior to retry in the driver instead of
    returning -EAGAIN, due to possible message sequence number reuse
    on different message contents.

Changes from v1:
  * Changed throttle error code to 2

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>


Dionna Glaze (3):
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: Remove err in handle_guest_request
  virt: sev-guest: interpret VMM errors from guest request

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   | 21 ++++---
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 ++--
 drivers/crypto/ccp/sev-dev.c            | 22 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 76 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++-
 7 files changed, 112 insertions(+), 46 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

