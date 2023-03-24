Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE666C800B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCXOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:39:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A45FD6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:38:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E559933777;
        Fri, 24 Mar 2023 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679668731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKJTT114awypObJqVoyD5FQgq8SxHGNI6Q09/lVH1qA=;
        b=hAn7g8TKmj+IBZrk6WaTtKymuISuCtlh2WoDU//bvhZtlBOHLxeRm7kC8mEokCIQ5u1+6L
        Dmhtd6aOdH9xvvjFKY0LI0GbZ+U0giA68rNyxbKdUVa15bXY+SNz9uMMM166eGYNc00t7c
        lA26pdz6vnqiieHMThSB1TQh8oBod+o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7439138ED;
        Fri, 24 Mar 2023 14:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pt+gLfu1HWQeUgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 24 Mar 2023 14:38:51 +0000
Date:   Fri, 24 Mar 2023 15:38:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON in move_normal_pmd
Message-ID: <ZB21+05jScCIK/rz@dhcp22.suse.cz>
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
 <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-03-23 09:43:10, Joel Fernandes wrote:
[...]
> Michal, would you also mind providing the full stack you are seeing
> just so we know it is the same issue (i.e. triggered via exec)?

Yes, it is the exec path
[  544.236782][T20518] Call Trace:
[  544.237467][T20518]  <TASK>
[  544.238034][T20518]  move_page_tables+0x8e4/0x930
[  544.238039][T20518]  shift_arg_pages+0xb5/0x180
[  544.238044][T20518]  ? mprotect_fixup+0x1ce/0x2e0
[  544.238046][T20518]  setup_arg_pages+0x256/0x2b0
[  544.238049][T20518]  load_elf_binary+0x375/0x15d0
[  544.238052][T20518]  ? __kernel_read+0x2e8/0x310
[  544.238056][T20518]  ? __kernel_read+0x2e8/0x310
[  544.238059][T20518]  bprm_execve+0x2ec/0x650
[  544.238062][T20518]  do_execveat_common.isra.42+0x1ed/0x230
[  544.238064][T20518]  __x64_sys_execve+0x32/0x40
[  544.238067][T20518]  do_syscall_64+0x5b/0x80
[  544.238072][T20518]  ? __SCT__preempt_schedule_notrace+0x8/0x8
[  544.238075][T20518]  ? __SCT__preempt_schedule_notrace+0x8/0x8
[  544.238076][T20518]  ? exit_to_user_mode_prepare+0xfc/0x230
[  544.250270][T20518]  ? syscall_exit_to_user_mode+0x18/0x40
[  544.250292][T20518]  ? do_syscall_64+0x67/0x80
[  544.250294][T20518]  ? exc_page_fault+0x67/0x150
[  544.250297][T20518]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
-- 
Michal Hocko
SUSE Labs
