Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5869F4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBVMkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBVMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:40:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0057327D7F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:40:33 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id o3so7816045qvr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H+J7csv9d0zQxAb8tY6wlt0M8ymU6BQrT3Z560sOxYY=;
        b=aJKU4pHi8S+qc/GwJhn5RC7a3akluPcUv+J0afviPBtwoxPUYvXdUH5ahBuCvdVXSj
         XNopNQ3GVHoXDKWQIDKzhBXeIYBqqdCsL6vk8MQ3f9Fca5rXFxbo2HsGpiEhess0qhD/
         Mu4geppG4vjCDe6TqMpNHOes1MYV+XjAFRn/J/PfPKsSwOfIG0OyFA76kv0qH+j3W7Fw
         acBFOIEx9MYP+Wn0ooJUlWIh4wzo0zb7ZmR/EE1UNJLvgWMsHwUPxaTDZUGfioI0FDIo
         6c5T2sM+oLpfVyuHwIQkj7XdhuI4qlHQVScH1zMyXhYhfMo4v3mgcB1rpsH5e9l/CM30
         YNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J7csv9d0zQxAb8tY6wlt0M8ymU6BQrT3Z560sOxYY=;
        b=sL7X65ppG9NcAGCiMvI2A7p51L35rLDxCQhwh0amj8he5NJDAgCfsCNnLCOUH/1aXx
         4+0w/jw6RKEf759rr1pAEyPXMVUuCMBd+iAqFK/t3ajEtOC7nzelhql3F5R5ZCLWlDq9
         1twaWln2nUC0vsOGCC0MVsSq1oo3McgVDt1BwOul0gv7SeqHZVdtBxjhoTOQ56siGtKg
         Ox51h5xfPUHESIj6Mojx7F2yRZRpDFcjjvSjgVJK9gjDfxymcBs/RjiXylbdnLLA1IKG
         qYp/Slb21KofNnQZH+rYIabCN3s/aEwJSBANKfCvJv2PsfqJE00lq6CcX2NM+oMo0jH6
         bK2g==
X-Gm-Message-State: AO0yUKWpjsPLf7NVzxiWxoUGzl3j7F2sGBUajGZNVYfMUgAuCzjbilaH
        Dp+r3ZKZgx9ojiXZaLBX+xXitBUgKA==
X-Google-Smtp-Source: AK7set/ZIRxqvGdxyTZwn5bY1BYVK9pRmyYORHlYi3gekvW2n1ZgEgd+Xsbr3UauedlOzLXNAQJLbg==
X-Received: by 2002:a05:6214:2429:b0:56e:f05c:9c70 with SMTP id gy9-20020a056214242900b0056ef05c9c70mr13981872qvb.44.1677069632915;
        Wed, 22 Feb 2023 04:40:32 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id t71-20020a37aa4a000000b00741d87eb5d1sm2711962qke.105.2023.02.22.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:40:32 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ffd5:a2e0:f643:870f])
        by serve.minyard.net (Postfix) with ESMTPSA id A5C141800BA;
        Wed, 22 Feb 2023 12:40:30 +0000 (UTC)
Date:   Wed, 22 Feb 2023 06:40:29 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.3
Message-ID: <Y/YNPWfyZE4KteG2@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 041fae9c105ae342a4245cf1e0dc56a23fbb9d3c:

  Merge tag 'f2fs-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2022-12-14 15:27:57 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.3-1

for you to fetch changes up to befb28f2676a65a5a4cc4626ae224461d8785af6:

  ipmi: ipmb: Fix the MODULE_PARM_DESC associated to 'retry_time_ms' (2023-02-10 07:38:18 -0600)

----------------------------------------------------------------
Small fixes to the SMBus IPMI and IPMB driver

Nothing big, cleanups, fixing names, and one small deviation from the
specification fixed.

----------------------------------------------------------------
Christophe JAILLET (1):
      ipmi: ipmb: Fix the MODULE_PARM_DESC associated to 'retry_time_ms'

Corey Minyard (4):
      ipmi:ssif: resend_msg() cannot fail
      ipmi_ssif: Rename idle state and check
      ipmi:ssif: Remove rtc_us_timer
      ipmi:ssif: Add a timer between request retries

 drivers/char/ipmi/ipmi_ipmb.c |   2 +-
 drivers/char/ipmi/ipmi_ssif.c | 113 ++++++++++++++++++++----------------------
 2 files changed, 56 insertions(+), 59 deletions(-)

