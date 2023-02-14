Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B3696CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjBNSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjBNSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:23:47 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950232BF02
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676399020; bh=WKNP+ZNMgiPRAt20UgQCPKI7q8zlNbwFG0h2qpmMNko=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=nHz/10fsSH6fbCLh3dFj1yMFY0la78TuOH98UXR0DktA3M99NgAkJ9h4KS3e0Qwzh
         fQU5HqkPcPWgjIe8NAXtspCDV9T83VZZZM6Dz8bc2MDLfRX8PgxDkUfMoEiSCFzSpP
         EvIgX+ALN98G4czUytMXQEL41x2D94yDnnrBvwpQ=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 14 Feb 2023 19:23:40 +0100 (CET)
X-EA-Auth: MmEnkdIFfZXN1qaVwBxVGi/qZ48H/g4c2rx9/UYh24o7WKz8xflKgib4yk86vAWiHUZYnn6nefKyy+epHBzLP4rXbOqcCx+S
Date:   Tue, 14 Feb 2023 23:53:34 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Query on mm/folio-compat: pagecache_get_page
Message-ID: <Y+vRpvwNgwDB4MS0@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Could someone comment if it is safe to access the page member variable as
written on line #100 when folio is NULL as returned from the
__filemap_get_folio() function call? Is this kind of intentional page-fault
trigger for the system to handle a new/fresh page allocation?

	  2         folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
	  1         if (!folio || xa_is_value(folio))
	100                 return &folio->page;
	  1         return folio_file_page(folio, index);

The code is part of commit ID c5255b421fd04

Thank you,
./drv


