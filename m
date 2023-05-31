Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA4D71893E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjEaSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjEaSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:18:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60917191
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:18:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659a7d4c38so109080857b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685557091; x=1688149091;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAk1RiKqkTKrC23R1t+mTVEMvilBdAxNYBLizWlCue4=;
        b=6IqC6SoLLpWT2u770N8HdTzqlU/BpMAnPKxmzty75aNe/vOnDN1rMpyZodrgCwGhvh
         93wL7H6qWi3v6PzNadie4t3ibN61daXgrBx2UqWstYQBdc4vssJWYwFcKzaSUlzsVVdk
         BhHHUhq4ub0DMZiTPhZuh/GFt+o9HRAHPVhOgcdkCyt8buA1O22Ved1xnJCbU/OO6fTW
         z/yNvs2mD/El1YXMeb4wQ2NcC4Rk+b4+Wgs5Iozlh9PJ3UPzd3MNQuSr9wD+zjE4fXOv
         aaxLlooOv5OdYBGDEfVdiA+AdXkyyC+I2GkaG6RQXgA2MLdMyLCAId0pv8Iyvd4JKCml
         sMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557091; x=1688149091;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAk1RiKqkTKrC23R1t+mTVEMvilBdAxNYBLizWlCue4=;
        b=LN9tv1MUfHw4yuN6rgmBfzD6ExoBjkSbxGJDUlI7i5N1EkOmcLnUw+iPl1nPknzGSx
         wT4UHIHQU7RbaJKGX8LKQfJGKtw3w7RWjiS75+DoTxzWu3zp1QOzm57Vx8gOM5WCZTkP
         s6TJylpvDvnfHZviyhR+HGViysJu7kVnvpIZhxhH2r3Mnl8CFGrepZEfMxge1n0OMrhT
         +/WtSKskL2fnX3/XgLVKzscSmcW6Z/nPFF76BnY5+fF0PJ/RSrf94+LLoYNC8pczNZo6
         jXBH96S3O2SjMFdXI3gdjj/QeNRAZBtz8rLhVyMj+O/ccka7br29pqI5Q7sdPDih2aMp
         mlWw==
X-Gm-Message-State: AC+VfDxA6rLEu+xw9yByYkUnhoYEPqq2OkGK6yneFAU9QIfZsB+KV7rF
        jEMKLM3aXnBX2VEnmMfELYNEkGSRr7k=
X-Google-Smtp-Source: ACHHUZ7MC3ttWW4eV900JW4t54kKSQLJKK7tF3KssyoTnSiMNqD+53ceNNxHQ3KzfCs67RAptWy1HqsCX+U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af10:0:b0:559:c032:eb5e with SMTP id
 n16-20020a81af10000000b00559c032eb5emr3739362ywh.1.1685557091525; Wed, 31 May
 2023 11:18:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 May 2023 11:18:01 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230531181800.457521-2-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Notes - 2023.05.31 - guest_memfd()
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone who joined this morning, or evening/afternoon depending on where
you are!  The slides and recording are available on Drive (see bottom), though
unfortunately non-Google people will need to request access as our corporate
settings don't provide a way to share with literally everyone.  This *should* be
a one-time pain though, and I'll do my best to grant access immediately.

Key Takeaways:
 - No objections to pursuing a KVM ioctl(), e.g. KVM_CREATE_GUEST_MEMFD.
 - A KVM ioctl() is cleaner than a generic syscall for pKVM and SNP, and at
   worst a wash for TDX.

Next Steps:
 - Vitaly to follow-up with Hyper-V folks to see if "Linux as the root partition"
   needs/wants a generic syscall for managing guest memory.
 - Sean to post KVM_CREATE_GUEST_MEMFD implementation as v11, and to coordinate
   with owners of dependent series to sort out how to iterate efficiently.

Future Schedule:
June 7th  - pKVM on x86 (Google + Intel)
June 14th - Available!
June 21st - No Meeting (Sean OOO)
June 28th - Available!
July 5th  - No Meeting (Sean OOO)

Calendar:
https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20

Drive:
https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link
