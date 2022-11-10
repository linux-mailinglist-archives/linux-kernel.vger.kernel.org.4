Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB762456A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKJPSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKJPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689021F603
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668093426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7JBMRlhf9SKM85chgVsRyacqS8HRqg/wt0F6XTSTiUc=;
        b=PoS7cdSoPGBjXaIoBfpa8RORfTEsjgyvcLRzqMhJRSXr25rXhXr95NOKGKWEHoojjOfQbX
        UwZgv8vzOkiJXs6sH0PT5b72vrz+Frwv0AEYFSC+NyD4Yu2D0bMrzPiSltHa1YBp+lSX+a
        tXTIn0ntfFDCCnqhZsEsCNDjsOW15pU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98--oy63Y1sMxGpnJToral-LA-1; Thu, 10 Nov 2022 10:17:05 -0500
X-MC-Unique: -oy63Y1sMxGpnJToral-LA-1
Received: by mail-qv1-f72.google.com with SMTP id mi12-20020a056214558c00b004bb63393567so1659100qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JBMRlhf9SKM85chgVsRyacqS8HRqg/wt0F6XTSTiUc=;
        b=aNO4Pf9K02LAArxADzPbtygXhj35FriENZq9xh1Q/nzwb0cvm19kApjFUTHvfXzc8D
         ywvJFInOYo+c/kvUYU+W53KCjmhBp19ZbBhZ1LHndl3O6iUmPnceUc1p3HmjOU1mYACH
         GnE+PeUrtXLqm0LtI8XWWkSO+OIU5Booxl9d28P7yEzErpif/DbhUg0S7ZC1CEHpmrIr
         rPVW+3z/5wxNC5fhqaE5atQlEMsJxvYXDb+LRo+LE481gL+yzFNKR2MEBFttKl7BJXTz
         dlxID15Raw58KnFuW8vsDHF1xtqOhNZCcMyFlaPbroxEO9FCBrE7MBC3dPjJz3Z+04dG
         ej8w==
X-Gm-Message-State: ACrzQf3a5GdLBiSjVTCCwUeEdDoUg0iazAxeXbr3DNnDC2qKAw1QDlmi
        nJBAnwgBy+c/TQ4Pt14QpKfqkAai7+zmngtbnGBYZgWU1TtkAgBVMrHhK4h+6eUsiu6BagFIkh1
        4SRco7euPNKL+QcypZxM6cUsF
X-Received: by 2002:a37:5384:0:b0:6f7:ee90:1618 with SMTP id h126-20020a375384000000b006f7ee901618mr48361039qkb.117.1668093424724;
        Thu, 10 Nov 2022 07:17:04 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4O0+0VOGYj/08gkBDb27xu1rPPMTTYo3xEiPt8asxX1C2xn5XiYCUAcd1upnf574Te4SkDLA==
X-Received: by 2002:a37:5384:0:b0:6f7:ee90:1618 with SMTP id h126-20020a375384000000b006f7ee901618mr48361002qkb.117.1668093424292;
        Thu, 10 Nov 2022 07:17:04 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006ec771d8f89sm13621596qkp.112.2022.11.10.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:17:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>
Subject: [PATCH 0/2] mm/migrate: Fix writable pte for read migration entry
Date:   Thu, 10 Nov 2022 10:17:00 -0500
Message-Id: <20221110151702.1478763-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
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

This comes from a report from Ives on using uffd-wp on shmem.  More
information can be found in patch 1 commit message.

Patch 2 added some more sanity check when walking pgtables and when we
convert the ptes into other forms e.g. for migration and swap.  It will
make the error trigger even earlier than the user could notice, meanwhile
nail down the case if it's a wrong pgtable setup.

Ives, I only attached the reported-by tag for you but not tested-by because
the fix patch (patch 1) has a slight change compared to what I sent you
before, but hopefully it should also work for you.  If you want, feel free
to reply directly here if the patch also works for you.

We probably need patch 1 for stable (5.19+).  Please have a look, thanks.

Peter Xu (2):
  mm/migrate: Fix read-only page got writable when recover pte
  mm/uffd: Sanity check write bit for uffd-wp protected ptes

 arch/x86/include/asm/pgtable.h | 16 +++++++++++++++-
 mm/migrate.c                   |  8 +++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.37.3

