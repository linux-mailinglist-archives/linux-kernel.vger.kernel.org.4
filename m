Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46371885B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEaRW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEaRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:22:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100E135;
        Wed, 31 May 2023 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGUR/TbmUq/QOPcnqlHyd2HvHlg6/E2JQhG0B++doWA=; b=Y6xTF1SvB2B0O/e41dOK0iA2BX
        yv7/nZXFJbt/tyo/kaRPLaadCaBmC7d2rG1bG9XR1RNHcuDWrZrekzvXJ3dE+R4kU7tj9zHO5jQwl
        sCg+7dVi0tVXXGpU6Sj75qvFoW6/Px9dSKXMP2fX5gYYV/zYdp3vS6ZIwHPnK6O3WOBHoqPNfcUPa
        dx9jJji7G4Wfvnfyk8qsCmkhTL1+mszFGZH4jUCiEBDZFsRmkfjfqb1XLlbbTRJVo/vV11jrayncp
        TuC6JOJaVVsmwX3KggaVFlkOUySIvF4zrxpgK+z3DuK0EXTA++pvHnLZ6n1gRAhf2PS8T14zDZz0v
        C3BvZJcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4PWP-000bpl-15;
        Wed, 31 May 2023 17:22:05 +0000
Date:   Wed, 31 May 2023 10:22:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, thunder.leizhen@huawei.com, boqun.feng@gmail.com,
        vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
        brauner@kernel.org, michael.christie@oracle.com,
        samitolvanen@google.com, glider@google.com, peterz@infradead.org,
        keescook@chromium.org, stephen.s.brennan@oracle.com,
        alan.maguire@oracle.com, pmladek@suse.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH v2 1/2] bpf: make defination of bpf_dump_raw_ok based on
 CONFIG_KALLSYMS
Message-ID: <ZHeCPYcq23gp1hRa@bombadil.infradead.org>
References: <CGME20230531084800epcas5p1c02d5a7ffcef2bb7cf626bf52beb0eee@epcas5p1.samsung.com>
 <20230531084745.877337-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531084745.877337-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 02:17:44PM +0530, Maninder Singh wrote:
> No functional change with this commit.
> 
> As of now bpf_dump_raw_ok() is dependent on kallsyms_show_value().
> Rearranging the code to return false directly in defination of
> bpf_dump_raw_ok() based on CONFIG_KALLSYMS.
> 
> @reason: next patch will make kallsyms_show_value() defination
> generic and bpf_dump_raw_ok() will return true otherwise.

This reads a bit funny and the split here doesn't help the patch
reviewier, so you can help with that a bit with the commit log
and be a bit clearer to throw in the few pieces of nuggets the
reader should be aware of when reviewing your patch right away.
So how about instaed:

bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
have a false definition for the !CONFIG_KALLSYMS case. But we'll
soon expand on kallsyms_show_value() and so to make the code
easier to follow just provide a direct !CONFIG_KALLSYMS definition
for bpf_dump_raw_ok() as well.

This makes it easier to read and makes it clear bpf_dump_raw_ok()
will immediately return false when !CONFIG_KALLSYMS, making it
easier to understand what happens for heavy users such as bfp.

With this you can add:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
