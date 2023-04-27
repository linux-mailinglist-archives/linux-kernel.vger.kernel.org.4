Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD786F0CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjD0UMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjD0UMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B343AB1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682626277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AhZUeHYpeOBAxV0IzIBwDv//tE17MPSk4ZjZmgXSJWI=;
        b=H0033ZNHD+GDaqWZVeb59pAKw4dl4F2sMvrSMvaechkQl4N2iMiQs4Lx2p8cBf9a8yFsC1
        2mnuqbhxQB3yWYzhPdm10ADoj4BfTRDhm7Xv+4hU+J0kjXjfJMnDIWNRHkL9WCUTWJiriR
        oCxDgNqoFYKDhPNcA2L0u7aaqMXvDZ4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-lQs8M8yMPkK3ZUqZJLcURw-1; Thu, 27 Apr 2023 16:11:16 -0400
X-MC-Unique: lQs8M8yMPkK3ZUqZJLcURw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ed767b30easo19370041cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626275; x=1685218275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhZUeHYpeOBAxV0IzIBwDv//tE17MPSk4ZjZmgXSJWI=;
        b=DTWAga6wakGlHS4N8FH8dBogQqEeygvWgLS0DERZRY2z49yFQyEKjpi6258kxhlffW
         k1TtmHioXmcfC3rY6fVSbZLD/KZsmXIjCgSeDj1NyMb+EGC1d9cQOV3GXeg59LczykmT
         1VnigrUZUOoqeMoAHXZUx5sxQ6dD9d5wY+6FAjV6RU7YhvegkVilVD/eSkJi1TdvhqnW
         tp9zLN5yZqnnaPax0AWsSS/64oOzICaH/QGClVHQ6SFzSz+MNKFXoXzY/0cLsI25fFHB
         MFSPejtVX8CqSKvEbK1oQZeakenotewN3OyB8arL58M+JFVqrmnh/kK1iGnGzS+8j1a4
         p/bw==
X-Gm-Message-State: AC+VfDxnhKfS4oU1Ba1x0svSMDaJer1HAkGdFV7TasZq5AyJb9sjmu5a
        rfJtqcq4nAWZdyQO9CMzgqESU19XTDX7JbpXJ5TMYnYZ4UgIXXPWfo1hm/um6RBdyEO8ZSvR4P1
        eeoAvwMh4P7dQdK0v2+l9XUkxyAeGSXX08H9Bhwek7oZptHDKavJKWtp+4ChQ0VZRlKo+pT7uoV
        Ipld+DqQ==
X-Received: by 2002:a05:622a:11d3:b0:3ea:ef5:5b8c with SMTP id n19-20020a05622a11d300b003ea0ef55b8cmr5145336qtk.3.1682626274778;
        Thu, 27 Apr 2023 13:11:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VhE7QH8N5ots5VW8DKCbhdRPJyfLcsNh6MOOG1ylNSxk/alsE/WyTGIrq2TqNMWsuuXaC5A==
X-Received: by 2002:a05:622a:11d3:b0:3ea:ef5:5b8c with SMTP id n19-20020a05622a11d300b003ea0ef55b8cmr5145287qtk.3.1682626274390;
        Thu, 27 Apr 2023 13:11:14 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b0074fb065bde4sm3444283qkn.18.2023.04.27.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:11:13 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Anish Moorthy <amoorthy@google.com>
Subject: [PATCH 0/2] selftests/kvm: Fixes for demand paging test
Date:   Thu, 27 Apr 2023 16:11:10 -0400
Message-Id: <20230427201112.2164776-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two trivial fixes per subject, please see each patch, thanks.

Peter Xu (2):
  selftests/kvm: Setup vcpu_alias only for minor mode test
  selftests/kvm: Allow dump per-vcpu info for uffd threads

 .../testing/selftests/kvm/demand_paging_test.c  | 17 +++++++++--------
 .../selftests/kvm/lib/userfaultfd_util.c        |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.39.1

