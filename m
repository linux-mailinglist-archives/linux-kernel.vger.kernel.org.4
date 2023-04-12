Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157446DFB89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDLQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDLQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38E65A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5yugiaVpJpS0wWKD2pcIMAyJ75fmPDFVn927vHr9+E=;
        b=WgkLcxA6Y1Jj3D7o8ueoQB9ncfjX4iUBWTW6/enRg2Pnknf+2O17Y90/EDXFayb2zNiZBI
        oXcp7Q1H6pIYNFazD12k4vEeGIQCDyrimbOQaoUmLuNKjFpllkjQM3aEj3iPjROXxeaEKj
        7JBE2eiogDJdgFiYQaDaM8JZjmG4Xaw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-vT4JTqURPv-Owv7_JHLZRw-1; Wed, 12 Apr 2023 12:41:19 -0400
X-MC-Unique: vT4JTqURPv-Owv7_JHLZRw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74a90355636so62093285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317677; x=1683909677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5yugiaVpJpS0wWKD2pcIMAyJ75fmPDFVn927vHr9+E=;
        b=gwG/DUZCHUXeYO76dCE2jvseAKraoJmOdKA61mj65Vfot+Ni48B9NOUnCnAQX3c57k
         I6Y4Tnl7Qv4uY5ZmIz/qUqvn932KF8EwayDk1LJ5ayUyMvtPCk5KkDO5U5Z6uH16R7d7
         HabnUbQRrLV9iOA8AkkPeyPlwlTOBNSJGAaMHboC/zqiV0FfLsxJoNYeemodtrb8ut0X
         sfl3bxtkjQhdYLfv2yxJEcsazY0AnagSpiUO47HODlOGNkI6QQqmYN+OTmKvvOy1gKqY
         CGvrybWT7qURvZ1mAnVz0bA34o6VzhYENPuOherWKJMz3oNotkqmmnLbEc9RhWqVuhDz
         MR9A==
X-Gm-Message-State: AAQBX9cgbAqBBRVSwRzDQfNhGysMp3qrujwRnxzusiSmX+vGbtk4QefD
        0Ydx3UTsti45/n/t29svT0gz/0VPLFJwGsSAyZzkdco6TepQuaFvCmHNYMlYE6LBrBmKdVDXLMA
        mEmMFhDikQdZgus1OcBW0VRMg4ABL+HboVL13O46re2/ldBo5kdLhD2DD0EefBfsPxBGsQpi4tj
        +tY4lTkg==
X-Received: by 2002:a05:622a:1a90:b0:3e6:3af1:de7a with SMTP id s16-20020a05622a1a9000b003e63af1de7amr29098350qtc.4.1681317677642;
        Wed, 12 Apr 2023 09:41:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bD6Pmxf/AxQhIwMuyaltxKV9vhvPtNoQ3AUSJK9HVNe+thswQyIiI14+qGQAnxvBEVwKx7FA==
X-Received: by 2002:a05:622a:1a90:b0:3e6:3af1:de7a with SMTP id s16-20020a05622a1a9000b003e63af1de7amr29098310qtc.4.1681317677196;
        Wed, 12 Apr 2023 09:41:17 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a22e900b007486d9fa1d7sm4785768qki.95.2023.04.12.09.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:41:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 02/31] selftests/mm: Update .gitignore with two missing tests
Date:   Wed, 12 Apr 2023 12:41:14 -0400
Message-Id: <20230412164114.327709-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 1f8c36a9fa10..347277f2adc3 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -36,3 +36,5 @@ split_huge_page_test
 ksm_tests
 local_config.h
 local_config.mk
+ksm_functional_tests
+mdwe_test
-- 
2.39.1

